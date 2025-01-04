// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/tessellation/vktTessellationInvarianceTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Android Open Source Project
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The log lines of a failing comparison are not produced; the verdict is the
// same. Upstream's `TessCoordComponent` test constructs a failing `TestStatus` and drops it, so it can never fail; that is kept.
//
// These tests correspond to dEQP-GLES31.functional.tessellation.invariance.*
// Original OpenGL ES tests used transform feedback to get vertices in primitive order. To emulate this behavior we have to use geometry shader,
// which allows us to intercept vertices of final output primitives. This can't be done with tessellation shaders alone as number and order of
// invocation is undefined.

use std::cmp::Ordering;
use std::collections::BTreeSet;

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::tessellation_invariance::ALL_SHARED_PROGRAM;
use crate::tcu::random::Random;
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
use crate::vk::ref_util::{Unique, UniqueCommandBuffer, UniqueDescriptorSet};
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline, rect_2d};
use crate::vkt::tests::tessellation::util::{
    SpacingMode, TessLevels, TessPrimitiveType, Winding, make_render_pass_without_attachments,
    num_vertices_per_primitive, reference_primitive_count, reference_vertex_count,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// Need to set this value properly to allocate enough memory to store vertices data.
const NUM_EXTRA_TESS_GEOM_INVOCATIONS: usize = 4;
/// Two inner and four outer levels.
const NUM_TESS_LEVELS: usize = 6;
const RESULT_BUFFER_DATA_OFFSET: usize = 4 * std::mem::size_of::<i32>();

const SINGLE_OUTER_EDGE_LEVELS: [f32; 12] = [1.0, 1.2, 1.9, 2.3, 2.8, 3.3, 3.8, 10.2, 1.6, 24.4, 24.7, 63.0];

type Vec3 = [f32; 3];

/// `getProgramName("tese", winding, usePointMode)`, with names that say what they are.
fn tese_program_name(winding: Winding, use_point_mode: bool) -> String {
    format!(
        "tese_{}{}",
        winding.shader_name(),
        if use_point_mode { "_point_mode" } else { "" }
    )
}

/// `getProgramName("geom", usePointMode, writePointSize)`
fn geom_program_name(use_point_mode: bool, write_point_size: bool) -> String {
    format!(
        "geom{}{}",
        if use_point_mode { "_point_mode" } else { "" },
        if write_point_size { "_write_point_size" } else { "" }
    )
}

/// Data captured in the shader per output primitive (in geometry stage).
#[repr(C)]
#[derive(Clone, Copy)]
#[allow(dead_code)]
struct PerPrimitive {
    /// `gl_PrimitiveID` in tessellation evaluation shader
    patch_primitive_id: i32,
    /// ID of an output primitive in geometry shader (user-defined)
    primitive_id: i32,
    unused_padding: [i32; 2],
    /// 3 coords for triangles/quads, 2 for isolines, 1 for point mode. Vec4 due to alignment.
    tess_coord: [[f32; 4]; 3],
}

impl PerPrimitive {
    fn coord(&self, index: usize) -> Vec3 {
        [
            self.tess_coord[index][0],
            self.tess_coord[index][1],
            self.tess_coord[index][2],
        ]
    }
}

/// A `tcu::Vec3` as a set key: `VecLexLessThan<3>`.
#[derive(Clone, Copy)]
struct Vec3Key(Vec3);

impl PartialEq for Vec3Key {
    fn eq(&self, other: &Self) -> bool {
        self.0 == other.0
    }
}

impl Eq for Vec3Key {}

impl PartialOrd for Vec3Key {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl Ord for Vec3Key {
    fn cmp(&self, other: &Self) -> Ordering {
        lex_compare_vec3(&self.0, &other.0)
    }
}

fn lex_compare_vec3(a: &Vec3, b: &Vec3) -> Ordering {
    for i in 0..3 {
        if a[i] < b[i] {
            return Ordering::Less;
        }
        if b[i] < a[i] {
            return Ordering::Greater;
        }
    }
    Ordering::Equal
}

type Vec3Set = BTreeSet<Vec3Key>;

/// A `tcu::Vector<tcu::Vec3, 3>` as a set key: `LexCompare<Triangle, 3, VecLexLessThan<3>>`.
#[derive(Clone, Copy)]
struct TriangleKey([Vec3; 3]);

impl PartialEq for TriangleKey {
    fn eq(&self, other: &Self) -> bool {
        self.0 == other.0
    }
}

impl Eq for TriangleKey {}

impl PartialOrd for TriangleKey {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl Ord for TriangleKey {
    fn cmp(&self, other: &Self) -> Ordering {
        for i in 0..3 {
            let ordering = lex_compare_vec3(&self.0[i], &other.0[i]);
            if ordering != Ordering::Equal {
                return ordering;
            }
        }
        Ordering::Equal
    }
}

/// A description of an outer edge of a triangle, quad or isolines.
/// An outer edge can be described by the index of a u/v/w coordinate and the coordinate's value along that edge.
struct OuterEdgeDescription {
    constant_coordinate_index: usize,
    constant_coordinate_value_choices: Vec<f32>,
}

impl OuterEdgeDescription {
    fn new(constant_coordinate_index: usize, constant_coordinate_value_choices: &[f32]) -> Self {
        Self {
            constant_coordinate_index,
            constant_coordinate_value_choices: constant_coordinate_value_choices.to_vec(),
        }
    }

    fn contains(&self, v: Vec3) -> bool {
        self.constant_coordinate_value_choices
            .iter()
            .any(|&choice| v[self.constant_coordinate_index] == choice)
    }
}

/// `outerEdgeDescriptions`
fn outer_edge_descriptions(primitive_type: TessPrimitiveType) -> Vec<OuterEdgeDescription> {
    match primitive_type {
        TessPrimitiveType::Triangles => vec![
            OuterEdgeDescription::new(0, &[0.0]),
            OuterEdgeDescription::new(1, &[0.0]),
            OuterEdgeDescription::new(2, &[0.0]),
        ],
        TessPrimitiveType::Quads => {
            vec![
                OuterEdgeDescription::new(0, &[0.0]),
                OuterEdgeDescription::new(1, &[0.0]),
                OuterEdgeDescription::new(0, &[1.0]),
                OuterEdgeDescription::new(1, &[1.0]),
            ]
        }
        TessPrimitiveType::Isolines => vec![OuterEdgeDescription::new(0, &[0.0, 1.0])],
    }
}

/// `singleTrueMask`
fn single_true_mask<const N: usize>(index: usize) -> [bool; N] {
    let mut result = [false; N];
    result[index] = true;
    result
}

/// `tcu::select` - `true_vec` where the mask is set, `false_vec` elsewhere.
fn select<const N: usize>(true_vec: [f32; N], false_vec: [f32; N], mask: [bool; N]) -> [f32; N] {
    let mut result = false_vec;
    for i in 0..N {
        if mask[i] {
            result[i] = true_vec[i];
        }
    }
    result
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum CaseKind {
    OuterEdgeDivision,
    OuterEdgeIndexIndependence,
    SymmetricOuterEdge,
    InvariantPrimitiveSet,
    InvariantTriangleSet,
    InvariantOuterTriangleSet,
    InvariantInnerTriangleSet,
    TessCoordRange,
    OneMinusTessCoord,
}

impl CaseKind {
    fn is_tess_coord_component(self) -> bool {
        matches!(self, CaseKind::TessCoordRange | CaseKind::OneMinusTessCoord)
    }
}

#[derive(Clone, Copy)]
struct CaseDefinition {
    kind: CaseKind,
    primitive_type: TessPrimitiveType,
    spacing_mode: SpacingMode,
    winding: Winding,
    /// `WINDING_USAGE_VARY`: the programs of both windings are compared.
    vary_winding: bool,
    use_point_mode: bool,
}

/// `getWindingCases`
fn winding_cases(case_def: &CaseDefinition) -> Vec<Winding> {
    if case_def.vary_winding {
        vec![Winding::Ccw, Winding::Cw]
    } else {
        vec![case_def.winding]
    }
}

fn as_bytes<T: Copy>(values: &[T]) -> &[u8] {
    unsafe { std::slice::from_raw_parts(values.as_ptr().cast::<u8>(), std::mem::size_of_val(values)) }
}

fn read_i32(ptr: *const u8) -> i32 {
    unsafe { std::ptr::read_unaligned(ptr.cast::<i32>()) }
}

/// `generateRandomPatchTessLevels`
fn generate_random_patch_tess_levels(
    num_patches: usize,
    constant_outer_level_index: i32,
    constant_outer_level: f32,
    rnd: &mut Random,
) -> Vec<f32> {
    let mut tess_levels = vec![0.0f32; num_patches * NUM_TESS_LEVELS];

    for patch_ndx in 0..num_patches {
        let patch_levels = &mut tess_levels[patch_ndx * NUM_TESS_LEVELS..(patch_ndx + 1) * NUM_TESS_LEVELS];
        let (inner, outer) = patch_levels.split_at_mut(2);

        for level in inner.iter_mut() {
            *level = rnd.get_float_range(1.0, 62.0);
        }
        for (j, level) in outer.iter_mut().enumerate() {
            *level = if j as i32 == constant_outer_level_index {
                constant_outer_level
            } else {
                rnd.get_float_range(1.0, 62.0)
            };
        }
    }

    tess_levels
}

/// `generatePatchTessLevels`
fn generate_patch_tess_levels(
    num_patches: usize,
    constant_outer_level_index: i32,
    constant_outer_level: f32,
) -> Vec<f32> {
    let mut rnd = Random::new(123);
    generate_random_patch_tess_levels(num_patches, constant_outer_level_index, constant_outer_level, &mut rnd)
}

/// `multiplePatchReferencePrimitiveCount`
fn multiple_patch_reference_primitive_count(
    primitive_type: TessPrimitiveType,
    spacing_mode: SpacingMode,
    use_point_mode: bool,
    levels: &[f32],
    num_patches: usize,
) -> i32 {
    (0..num_patches)
        .map(|patch_ndx| {
            let patch_levels = &levels[NUM_TESS_LEVELS * patch_ndx..NUM_TESS_LEVELS * (patch_ndx + 1)];
            reference_primitive_count(
                primitive_type,
                spacing_mode,
                use_point_mode,
                &patch_levels[0..2],
                &patch_levels[2..6],
            )
        })
        .sum()
}

/// `computeMaxPrimitiveCount`
fn compute_max_primitive_count(
    num_patches_to_draw: usize,
    primitive_type: TessPrimitiveType,
    spacing_mode: SpacingMode,
    use_point_mode: bool,
    single_outer_edge_levels: &[f32],
) -> i32 {
    let outer_edge_index = 0; // outer-edge index doesn't affect vertex count
    let max_level = single_outer_edge_levels.iter().copied().fold(f32::MIN, f32::max);
    let patch_tess_levels = generate_patch_tess_levels(num_patches_to_draw, outer_edge_index, max_level);
    multiple_patch_reference_primitive_count(
        primitive_type,
        spacing_mode,
        use_point_mode,
        &patch_tess_levels,
        num_patches_to_draw,
    )
}

struct DrawResult {
    success: bool,
    num_primitive_vertices: usize,
    num_primitives: usize,
    primitives: Vec<PerPrimitive>,
}

/// `BaseTestInstance` and the resources `InvarianceTestInstance::iterate` creates in the same shape.
#[allow(dead_code)]
struct DrawResources<'a> {
    context: &'a Context<'a>,
    case_def: CaseDefinition,
    num_patches_to_draw: usize,
    max_num_primitives_in_draw_call: usize,
    result_buffer_size_bytes: vk::DeviceSize,
    cmd_buffer: UniqueCommandBuffer<'a>,
    cmd_pool: Unique<'a, vk::CommandPool>,
    pipeline_layout: Unique<'a, vk::PipelineLayout>,
    framebuffer: Unique<'a, vk::Framebuffer>,
    render_pass: Unique<'a, vk::RenderPass>,
    descriptor_set: UniqueDescriptorSet<'a>,
    descriptor_pool: Unique<'a, vk::DescriptorPool>,
    descriptor_set_layout: Unique<'a, vk::DescriptorSetLayout>,
    result_buffer: BufferWithMemory<'a>,
    vertex_buffer: BufferWithMemory<'a>,
}

impl<'a> DrawResources<'a> {
    fn new(
        context: &'a Context<'a>,
        case_def: CaseDefinition,
        num_patches_to_draw: usize,
        max_num_primitives_in_draw_call: usize,
    ) -> Result<Self, TestError> {
        let device = context.get_device();
        let alloc = context.get_default_allocator();

        let vertex_data_size_bytes =
            (NUM_TESS_LEVELS * num_patches_to_draw * std::mem::size_of::<f32>()) as vk::DeviceSize;
        let vertex_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(vertex_data_size_bytes, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let result_buffer_size_bytes = (RESULT_BUFFER_DATA_OFFSET
            + max_num_primitives_in_draw_call * std::mem::size_of::<PerPrimitive>())
            as vk::DeviceSize;
        let result_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(result_buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::GEOMETRY)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let render_pass = make_render_pass_without_attachments(device)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[], 1, 1, 1)?;
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

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
                &result_buffer_info,
            )
            .update(device);

        Ok(Self {
            context,
            case_def,
            num_patches_to_draw,
            max_num_primitives_in_draw_call,
            result_buffer_size_bytes,
            cmd_buffer,
            cmd_pool,
            pipeline_layout,
            framebuffer,
            render_pass,
            descriptor_set,
            descriptor_pool,
            descriptor_set_layout,
            result_buffer,
            vertex_buffer,
        })
    }

    /// `BaseTestInstance::uploadVertexAttributes`
    fn upload_vertex_attributes(&self, vertex_data: &[f32]) -> Result<(), TestError> {
        let alloc = self.vertex_buffer.get_allocation();
        unsafe {
            std::ptr::copy_nonoverlapping(
                as_bytes(vertex_data).as_ptr(),
                alloc.get_host_ptr(),
                std::mem::size_of_val(vertex_data),
            )
        };
        flush_alloc(self.context.get_device(), alloc)
    }

    /// The draw and read-back of `BaseTestInstance::draw` and of `InvarianceTestInstance::iterate`: the number of
    /// primitives the geometry shader wrote and the primitives, sorted by the patch they came from.
    fn draw_raw(
        &self,
        vertex_count: u32,
        winding: Winding,
        use_point_mode: bool,
    ) -> Result<(i32, Vec<PerPrimitive>), TestError> {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();

        let geom_point_size = context
            .get_device_features()
            .shader_tessellation_and_geometry_point_size
            != vk::FALSE;

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let tesc_module = create_shader_module(device, binaries.get("tesc")?)?;
        let tese_module = create_shader_module(device, binaries.get(&tese_program_name(winding, use_point_mode))?)?;
        let geom_module = create_shader_module(
            device,
            binaries.get(&geom_program_name(use_point_mode, geom_point_size))?,
        )?;

        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::PATCH_LIST).with_full_viewport(1, 1);
        state.bindings = vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: std::mem::size_of::<f32>() as u32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        state.attributes = vec![vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32_SFLOAT,
            offset: 0,
        }];
        state.patch_control_points = Some(NUM_TESS_LEVELS as u32);
        state.rasterization.rasterizer_discard_enable = vk::TRUE;
        state.color_attachment_count = 0;
        let pipeline = create_draw_pipeline(
            device,
            *self.pipeline_layout,
            *self.render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vert_module),
                (vk::ShaderStageFlags::TESSELLATION_CONTROL, *tesc_module),
                (vk::ShaderStageFlags::TESSELLATION_EVALUATION, *tese_module),
                (vk::ShaderStageFlags::GEOMETRY, *geom_module),
            ],
            &state,
        )?;

        {
            let alloc = self.result_buffer.get_allocation();
            unsafe { std::ptr::write_bytes(alloc.get_host_ptr(), 0, self.result_buffer_size_bytes as usize) };
            flush_alloc(device, alloc)?;
        }

        begin_command_buffer(device, *self.cmd_buffer)?;
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*self.render_pass)
            .framebuffer(*self.framebuffer)
            .render_area(rect_2d(1, 1));
        unsafe {
            device.cmd_begin_render_pass(*self.cmd_buffer, &begin_info, vk::SubpassContents::INLINE);

            device.cmd_bind_pipeline(*self.cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_descriptor_sets(
                *self.cmd_buffer,
                vk::PipelineBindPoint::GRAPHICS,
                *self.pipeline_layout,
                0,
                &[self.descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_bind_vertex_buffers(*self.cmd_buffer, 0, &[self.vertex_buffer.get()], &[0]);

            device.cmd_draw(*self.cmd_buffer, vertex_count, 1, 0, 0);
            device.cmd_end_render_pass(*self.cmd_buffer);

            let shader_write_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::HOST_READ,
                self.result_buffer.get(),
                0,
                self.result_buffer_size_bytes,
            );
            device.cmd_pipeline_barrier(
                *self.cmd_buffer,
                vk::PipelineStageFlags::ALL_GRAPHICS,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[shader_write_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, *self.cmd_buffer)?;
        submit_commands_and_wait(device, queue, *self.cmd_buffer)?;

        let result_alloc = self.result_buffer.get_allocation();
        invalidate_alloc(device, result_alloc)?;

        let host_ptr = result_alloc.get_host_ptr();
        let num_primitives = read_i32(host_ptr);
        // A count beyond the buffer would mean the shader wrote past its end; only what fits can be read back.
        let readable_primitives = (num_primitives.max(0) as usize).min(self.max_num_primitives_in_draw_call);
        let mut primitives: Vec<PerPrimitive> = (0..readable_primitives)
            .map(|i| unsafe {
                std::ptr::read_unaligned(
                    host_ptr
                        .add(RESULT_BUFFER_DATA_OFFSET + i * std::mem::size_of::<PerPrimitive>())
                        .cast::<PerPrimitive>(),
                )
            })
            .collect();
        primitives.sort_by_key(|primitive| primitive.patch_primitive_id);
        Ok((num_primitives, primitives))
    }

    /// `BaseTestInstance::draw` - `patch_tess_levels` are tessellation levels for all drawn patches.
    fn draw(
        &self,
        vertex_count: u32,
        patch_tess_levels: &[f32],
        winding: Winding,
        use_point_mode: bool,
    ) -> Result<DrawResult, TestError> {
        let (num_primitives, primitives) = self.draw_raw(vertex_count, winding, use_point_mode)?;

        let ref_num_primitives = multiple_patch_reference_primitive_count(
            self.case_def.primitive_type,
            self.case_def.spacing_mode,
            use_point_mode,
            patch_tess_levels,
            self.num_patches_to_draw,
        );

        Ok(DrawResult {
            success: num_primitives >= ref_num_primitives,
            num_primitive_vertices: num_vertices_per_primitive(self.case_def.primitive_type, use_point_mode) as usize,
            num_primitives: primitives.len(),
            primitives,
        })
    }
}

/// The tessellation coordinates of every vertex of every primitive of `result`.
fn result_coords(result: &DrawResult) -> impl Iterator<Item = Vec3> + '_ {
    result
        .primitives
        .iter()
        .take(result.num_primitives)
        .flat_map(move |primitive| (0..result.num_primitive_vertices).map(move |i| primitive.coord(i)))
}

/// `OuterEdgeDivisionTestInstance::iterate` - test invariance rule #2.
///
/// Test that the set of vertices along an outer edge of a quad or triangle only depends on that edge's tessellation level, and spacing.
///
/// For each (outer) edge in the quad or triangle, draw multiple patches with identical tessellation levels for that outer edge but with
/// different values for the other outer edges; compare, among the primitives, the vertices generated for that outer edge. Repeat with
/// different programs, using different winding etc. settings. Compare the edge's vertices between different programs.
fn iterate_outer_edge_division<'a>(context: &'a Context<'a>, case_def: CaseDefinition) -> TestOutcome {
    const NUM_PATCHES_TO_DRAW: usize = 10;
    let max_primitives = NUM_EXTRA_TESS_GEOM_INVOCATIONS
        * compute_max_primitive_count(
            NUM_PATCHES_TO_DRAW,
            case_def.primitive_type,
            case_def.spacing_mode,
            case_def.use_point_mode,
            &SINGLE_OUTER_EDGE_LEVELS,
        ) as usize;
    let resources = DrawResources::new(context, case_def, NUM_PATCHES_TO_DRAW, max_primitives)?;
    let edge_descriptions = outer_edge_descriptions(case_def.primitive_type);

    let mut any_subtest_failed = false;

    for (outer_edge_index, edge_desc) in edge_descriptions.iter().enumerate() {
        for &outer_edge_level in &SINGLE_OUTER_EDGE_LEVELS {
            let patch_tess_levels =
                generate_patch_tess_levels(NUM_PATCHES_TO_DRAW, outer_edge_index as i32, outer_edge_level);

            // Vertices of the outer edge of the first patch of the first program's draw call; used for comparison with other patches.
            let mut first_outer_edge_vertices = Vec3Set::new();

            resources.upload_vertex_attributes(&patch_tess_levels)?;

            for winding in Winding::ALL {
                for use_point_mode in [false, true] {
                    let is_first_program = winding == Winding::Ccw && !use_point_mode;

                    let result = resources.draw(
                        patch_tess_levels.len() as u32,
                        &patch_tess_levels,
                        winding,
                        use_point_mode,
                    )?;

                    if !result.success {
                        any_subtest_failed = true;
                        continue;
                    }

                    // Check the vertices of each patch.
                    let mut primitive_ndx = 0;
                    for patch_ndx in 0..NUM_PATCHES_TO_DRAW {
                        let mut outer_edge_vertices = Vec3Set::new();

                        // We're interested in just the vertices on the current outer edge.
                        while primitive_ndx < result.num_primitives
                            && result.primitives[primitive_ndx].patch_primitive_id == patch_ndx as i32
                        {
                            for i in 0..result.num_primitive_vertices {
                                let coord = result.primitives[primitive_ndx].coord(i);
                                if edge_desc.contains(coord) {
                                    outer_edge_vertices.insert(Vec3Key(coord));
                                }
                            }
                            primitive_ndx += 1;
                        }

                        // Compare the vertices to those of the first patch (unless this is the first patch).
                        if is_first_program && patch_ndx == 0 {
                            first_outer_edge_vertices = outer_edge_vertices;
                        } else if first_outer_edge_vertices != outer_edge_vertices {
                            any_subtest_failed = true;
                        }
                    }
                    debug_assert!(primitive_ndx == result.num_primitives);
                }
            }
        }
    }

    Ok(if any_subtest_failed {
        TestStatus::fail("Invalid set of vertices")
    } else {
        TestStatus::pass("OK")
    })
}

/// `OuterEdgeIndexIndependenceTestInstance::iterate` - test invariance rule #4.
///
/// Test that the vertices on an outer edge don't depend on which of the edges it is, other than with respect to component order.
fn iterate_outer_edge_index_independence<'a>(context: &'a Context<'a>, case_def: CaseDefinition) -> TestOutcome {
    const NUM_PATCHES_TO_DRAW: usize = 1;
    let max_primitives = NUM_EXTRA_TESS_GEOM_INVOCATIONS
        * compute_max_primitive_count(
            NUM_PATCHES_TO_DRAW,
            case_def.primitive_type,
            case_def.spacing_mode,
            case_def.use_point_mode,
            &SINGLE_OUTER_EDGE_LEVELS,
        ) as usize;
    let resources = DrawResources::new(context, case_def, NUM_PATCHES_TO_DRAW, max_primitives)?;
    let edge_descriptions = outer_edge_descriptions(case_def.primitive_type);

    let mut any_subtest_failed = false;

    for &outer_edge_level in &SINGLE_OUTER_EDGE_LEVELS {
        let mut first_edge_vertices = Vec3Set::new();

        for (outer_edge_index, edge_desc) in edge_descriptions.iter().enumerate() {
            let patch_tess_levels =
                generate_patch_tess_levels(NUM_PATCHES_TO_DRAW, outer_edge_index as i32, outer_edge_level);

            resources.upload_vertex_attributes(&patch_tess_levels)?;
            let result = resources.draw(
                patch_tess_levels.len() as u32,
                &patch_tess_levels,
                case_def.winding,
                case_def.use_point_mode,
            )?;

            // Verify case result
            if !result.success {
                any_subtest_failed = true;
                continue;
            }

            let mut current_edge_vertices = Vec3Set::new();

            // Get the vertices on the current outer edge.
            for coord in result_coords(&result) {
                if edge_desc.contains(coord) {
                    // Swizzle components to match the order of the first edge.
                    if case_def.primitive_type == TessPrimitiveType::Triangles {
                        current_edge_vertices.insert(Vec3Key(match outer_edge_index {
                            0 => coord,
                            1 => [coord[1], coord[0], coord[2]],
                            2 => [coord[2], coord[1], coord[0]],
                            _ => [-1.0; 3],
                        }));
                    } else if case_def.primitive_type == TessPrimitiveType::Quads {
                        current_edge_vertices.insert(Vec3Key([
                            match outer_edge_index {
                                0 => coord[1],
                                1 => coord[0],
                                2 => coord[1],
                                3 => coord[0],
                                _ => -1.0,
                            },
                            0.0,
                            0.0,
                        ]));
                    } else {
                        unreachable!();
                    }
                }
            }

            if outer_edge_index == 0 {
                first_edge_vertices = current_edge_vertices;
            } else if current_edge_vertices != first_edge_vertices {
                // Compare vertices of this edge to those of the first edge.
                any_subtest_failed = true;
            }
        }
    }

    Ok(if any_subtest_failed {
        TestStatus::fail("Invalid set of vertices")
    } else {
        TestStatus::pass("OK")
    })
}

/// `SymmetricOuterEdgeTestInstance::iterate` - test invariance rule #3.
///
/// Test that the vertices along an outer edge are placed symmetrically.
///
/// Draw multiple patches with different tessellation levels and different point_mode, winding etc. Before outputting tesscoords from
/// shader, mirror the vertices in the TES such that every vertex on an outer edge - except the possible middle vertex - should be
/// duplicated in the output. Check that appropriate duplicates exist.
fn iterate_symmetric_outer_edge<'a>(context: &'a Context<'a>, case_def: CaseDefinition) -> TestOutcome {
    const NUM_PATCHES_TO_DRAW: usize = 1;
    let max_primitives = NUM_EXTRA_TESS_GEOM_INVOCATIONS
        * compute_max_primitive_count(
            NUM_PATCHES_TO_DRAW,
            case_def.primitive_type,
            case_def.spacing_mode,
            case_def.use_point_mode,
            &SINGLE_OUTER_EDGE_LEVELS,
        ) as usize;
    let resources = DrawResources::new(context, case_def, NUM_PATCHES_TO_DRAW, max_primitives)?;
    let edge_descriptions = outer_edge_descriptions(case_def.primitive_type);

    let mut any_subtest_failed = false;

    for (outer_edge_index, edge_desc) in edge_descriptions.iter().enumerate() {
        for &outer_edge_level in &SINGLE_OUTER_EDGE_LEVELS {
            let patch_tess_levels =
                generate_patch_tess_levels(NUM_PATCHES_TO_DRAW, outer_edge_index as i32, outer_edge_level);

            resources.upload_vertex_attributes(&patch_tess_levels)?;
            let result = resources.draw(
                patch_tess_levels.len() as u32,
                &patch_tess_levels,
                case_def.winding,
                case_def.use_point_mode,
            )?;

            // Verify case result
            if !result.success {
                any_subtest_failed = true;
                continue;
            }

            let constant_index = edge_desc.constant_coordinate_index;
            let constant_value = edge_desc.constant_coordinate_value_choices[0];

            let mut non_mirrored_edge_vertices = Vec3Set::new();
            let mut mirrored_edge_vertices = Vec3Set::new();

            // Get the vertices on the current outer edge.
            for primitive in result.primitives.iter().take(result.num_primitives) {
                for i in 0..result.num_primitive_vertices {
                    let coord = primitive.coord(i);
                    if !edge_desc.contains(coord) {
                        continue;
                    }

                    // Ignore the middle vertex of the outer edge, as it's exactly at the mirroring point;
                    // for isolines, also ignore (0, 0) and (1, 0) because there's no mirrored counterpart for them.
                    if case_def.primitive_type == TessPrimitiveType::Triangles
                        && coord == select([0.0; 3], [0.5; 3], single_true_mask::<3>(constant_index))
                    {
                        continue;
                    }
                    if case_def.primitive_type == TessPrimitiveType::Quads
                        && [coord[0], coord[1]]
                            == select([constant_value; 2], [0.5; 2], single_true_mask::<2>(constant_index))
                    {
                        continue;
                    }
                    if case_def.primitive_type == TessPrimitiveType::Isolines
                        && (coord == [0.0, 0.5, 0.0]
                            || coord == [1.0, 0.5, 0.0]
                            || coord == [0.0, 0.0, 0.0]
                            || coord == [1.0, 0.0, 0.0])
                    {
                        continue;
                    }

                    let is_mirrored = primitive.tess_coord[i][3] > 0.5;
                    if is_mirrored {
                        mirrored_edge_vertices.insert(Vec3Key(coord));
                    } else {
                        non_mirrored_edge_vertices.insert(Vec3Key(coord));
                    }
                }
            }

            if case_def.primitive_type != TessPrimitiveType::Isolines {
                // Check that both endpoints are present. Note that endpoints aren't mirrored by the shader, since they belong to more than one edge.
                let (endpoint_a, endpoint_b): (Vec3, Vec3) = if case_def.primitive_type == TessPrimitiveType::Triangles
                {
                    (
                        select([1.0; 3], [0.0; 3], single_true_mask::<3>((constant_index + 1) % 3)),
                        select([1.0; 3], [0.0; 3], single_true_mask::<3>((constant_index + 2) % 3)),
                    )
                } else {
                    let a = select([constant_value; 2], [0.0; 2], single_true_mask::<2>(constant_index));
                    let b = select([constant_value; 2], [1.0; 2], single_true_mask::<2>(constant_index));
                    ([a[0], a[1], 0.0], [b[0], b[1], 0.0])
                };

                if !non_mirrored_edge_vertices.contains(&Vec3Key(endpoint_a))
                    || !non_mirrored_edge_vertices.contains(&Vec3Key(endpoint_b))
                {
                    any_subtest_failed = true;
                    continue;
                }
                non_mirrored_edge_vertices.remove(&Vec3Key(endpoint_a));
                non_mirrored_edge_vertices.remove(&Vec3Key(endpoint_b));
            }

            if non_mirrored_edge_vertices != mirrored_edge_vertices {
                any_subtest_failed = true;
            }
        }
    }

    Ok(if any_subtest_failed {
        TestStatus::fail("Invalid set of vertices")
    } else {
        TestStatus::pass("OK")
    })
}

struct LevelCase {
    levels: Vec<TessLevels>,
    /// Subclass-defined arbitrary piece of data, for type of the levelcase, if needed.
    mem: usize,
}

type Triangle = [Vec3; 3];

/// `makeTriangle`
fn make_triangle(primitive: &PerPrimitive) -> Triangle {
    [primitive.coord(0), primitive.coord(1), primitive.coord(2)]
}

/// `compareTriangleSets` - compare triangle sets, ignoring triangle order and vertex order within triangle, and possibly exclude some triangles too.
fn compare_triangle_sets(
    primitives_a: &[PerPrimitive],
    primitives_b: &[PerPrimitive],
    is_triangle_relevant: &dyn Fn(&Triangle) -> bool,
) -> bool {
    let collect = |primitives: &[PerPrimitive]| -> BTreeSet<TriangleKey> {
        let mut triangles = BTreeSet::new();
        for primitive in primitives {
            let mut triangle = make_triangle(primitive);

            if is_triangle_relevant(&triangle) {
                triangle.sort_by(lex_compare_vec3);
                triangles.insert(TriangleKey(triangle));
            }
        }
        triangles
    };

    collect(primitives_a) == collect(primitives_b)
}

/// `comparePrimitivesExact` - compare two sets of primitives. Order of primitives in each set is undefined, but within each primitive
/// vertex order and coordinates are expected to match exactly.
fn compare_primitives_exact(
    primitives_a: &[PerPrimitive],
    primitives_b: &[PerPrimitive],
    num_primitives_per_patch: usize,
) -> bool {
    if primitives_a.len() < num_primitives_per_patch || primitives_b.len() < num_primitives_per_patch {
        return false;
    }

    let mut ndx_b = 0;
    for primitive_a in &primitives_a[..num_primitives_per_patch] {
        let coords_a = &primitive_a.tess_coord;
        let mut matched = false;

        // Actually both sets are usually somewhat sorted, so don't reset ndxB after each match. Instead, continue from the next index.
        for _ in 0..num_primitives_per_patch {
            let coords_b = &primitives_b[ndx_b].tess_coord;
            ndx_b = (ndx_b + 1) % num_primitives_per_patch;

            if coords_a[0] == coords_b[0] && coords_a[1] == coords_b[1] && coords_a[2] == coords_b[2] {
                matched = true;
                break;
            }
        }

        if !matched {
            return false;
        }
    }
    true
}

/// `InvarianceTestInstance::genTessLevelCases`
fn gen_basic_tess_level_cases() -> Vec<LevelCase> {
    let basic_tess_level_cases = [
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

    let mut result: Vec<LevelCase> = basic_tess_level_cases
        .iter()
        .map(|levels| LevelCase {
            levels: vec![*levels],
            mem: 0,
        })
        .collect();

    let mut rnd = Random::new(123);
    for _ in 0..10 {
        let mut levels = TessLevels {
            inner: [0.0; 2],
            outer: [0.0; 4],
        };
        for level in levels.inner.iter_mut() {
            *level = rnd.get_float_range(1.0, 16.0);
        }
        for level in levels.outer.iter_mut() {
            *level = rnd.get_float_range(1.0, 16.0);
        }
        result.push(LevelCase {
            levels: vec![levels],
            mem: 0,
        });
    }

    result
}

/// `InvariantInnerTriangleSetTestInstance::genTessLevelCases` - variants with different values for irrelevant levels.
fn gen_inner_triangle_set_tess_level_cases(primitive_type: TessPrimitiveType) -> Vec<LevelCase> {
    const NUM_SUB_CASES: usize = 4;
    let base_results = gen_basic_tess_level_cases();
    let mut result = Vec::new();
    let mut rnd = Random::new(123);

    for base_result in &base_results {
        let mut levels = base_result.levels[0];
        let mut level_case = LevelCase {
            levels: Vec::new(),
            mem: 0,
        };

        for _ in 0..NUM_SUB_CASES {
            level_case.levels.push(levels);

            for level in levels.outer.iter_mut() {
                *level = rnd.get_float_range(2.0, 16.0);
            }
            if primitive_type == TessPrimitiveType::Triangles {
                levels.inner[1] = rnd.get_float_range(2.0, 16.0);
            }
        }

        result.push(level_case);
    }

    result
}

/// `InvariantOuterTriangleSetTestInstance::genTessLevelCases` - variants with different values for irrelevant levels.
fn gen_outer_triangle_set_tess_level_cases(primitive_type: TessPrimitiveType) -> Vec<LevelCase> {
    const NUM_SUB_CASES_PER_EDGE: usize = 4;
    let num_edges = match primitive_type {
        TessPrimitiveType::Triangles => 3,
        TessPrimitiveType::Quads => 4,
        TessPrimitiveType::Isolines => 0,
    };
    let base_result = gen_basic_tess_level_cases();
    let mut result = Vec::new();
    let mut rnd = Random::new(123);

    for base_case in &base_result {
        let base = base_case.levels[0];
        if base.inner[0] == 1.0 || (primitive_type == TessPrimitiveType::Quads && base.inner[1] == 1.0) {
            continue;
        }

        for edge_ndx in 0..num_edges {
            let mut levels = base;
            let mut level_case = LevelCase {
                levels: Vec::new(),
                mem: edge_ndx,
            };

            for _ in 0..NUM_SUB_CASES_PER_EDGE {
                level_case.levels.push(levels);

                for (i, level) in levels.outer.iter_mut().enumerate() {
                    if i != edge_ndx {
                        *level = rnd.get_float_range(2.0, 16.0);
                    }
                }

                if primitive_type == TessPrimitiveType::Triangles {
                    levels.inner[1] = rnd.get_float_range(2.0, 16.0);
                }
            }

            result.push(level_case);
        }
    }

    result
}

/// `IsInnerTriangleTriangle`
fn is_inner_triangle_triangle(vertices: &Triangle) -> bool {
    vertices
        .iter()
        .all(|vertex| vertex.iter().all(|&component| component != 0.0))
}

/// `IsInnerQuadTriangle`
fn is_inner_quad_triangle(vertices: &Triangle) -> bool {
    vertices.iter().all(|vertex| {
        vertex[..2]
            .iter()
            .all(|&component| component != 0.0 && component != 1.0)
    })
}

/// `IsTriangleTriangleOnOuterEdge`
fn is_triangle_triangle_on_outer_edge(edge_ndx: usize, vertices: &Triangle) -> bool {
    let touches_appropriate_edge = vertices.iter().any(|vertex| vertex[edge_ndx] == 0.0);

    if touches_appropriate_edge {
        let avg: Vec3 = [
            (vertices[0][0] + vertices[1][0] + vertices[2][0]) / 3.0,
            (vertices[0][1] + vertices[1][1] + vertices[2][1]) / 3.0,
            (vertices[0][2] + vertices[1][2] + vertices[2][2]) / 3.0,
        ];
        return avg[edge_ndx] < avg[(edge_ndx + 1) % 3] && avg[edge_ndx] < avg[(edge_ndx + 2) % 3];
    }
    false
}

/// `IsQuadTriangleOnOuterEdge::onEdge`
fn quad_vertex_on_edge(edge_ndx: usize, v: &Vec3) -> bool {
    v[edge_ndx % 2] == if edge_ndx <= 1 { 0.0 } else { 1.0 }
}

/// `IsQuadTriangleOnOuterEdge::onAnyEdge`
fn quad_vertex_on_any_edge(v: &Vec3) -> bool {
    v[0] == 0.0 || v[0] == 1.0 || v[1] == 0.0 || v[1] == 1.0
}

/// `IsQuadTriangleOnOuterEdge`
fn is_quad_triangle_on_outer_edge(edge_ndx: usize, vertices: &Triangle) -> bool {
    for v in 0..3 {
        let a = &vertices[v];
        let b = &vertices[(v + 1) % 3];
        let c = &vertices[(v + 2) % 3];
        if quad_vertex_on_edge(edge_ndx, a) && quad_vertex_on_edge(edge_ndx, b) {
            return true;
        }
        if quad_vertex_on_edge(edge_ndx, c)
            && !quad_vertex_on_any_edge(a)
            && !quad_vertex_on_any_edge(b)
            && a[edge_ndx % 2] == b[edge_ndx % 2]
        {
            return true;
        }
    }

    false
}

/// The `compare` of the `InvarianceTestInstance` subclass for `case_def.kind`.
fn compare_primitive_sets(
    case_def: &CaseDefinition,
    primitives_a: &[PerPrimitive],
    primitives_b: &[PerPrimitive],
    level_case_mem: usize,
) -> bool {
    match case_def.kind {
        // Test invariance rule #1: the sequence of primitives input to the TES only depends on the tessellation levels, tessellation
        // mode, spacing mode, winding, and point mode.
        CaseKind::InvariantPrimitiveSet => compare_primitives_exact(primitives_a, primitives_b, primitives_a.len()),
        // Test invariance rule #5: the set of triangles input to the TES only depends on the tessellation levels, tessellation mode
        // and spacing mode. Specifically, winding doesn't change the set of triangles, though it can change the order in which they are
        // input to TES, and can (and will) change the vertex order within a triangle.
        CaseKind::InvariantTriangleSet => compare_triangle_sets(primitives_a, primitives_b, &|_| true),
        // Test invariance rule #6: the set of inner triangles input to the TES only depends on the inner tessellation levels,
        // tessellation mode and spacing mode.
        CaseKind::InvariantInnerTriangleSet => match case_def.primitive_type {
            TessPrimitiveType::Triangles => {
                compare_triangle_sets(primitives_a, primitives_b, &is_inner_triangle_triangle)
            }
            TessPrimitiveType::Quads => compare_triangle_sets(primitives_a, primitives_b, &is_inner_quad_triangle),
            TessPrimitiveType::Isolines => false,
        },
        // Test invariance rule #7: the set of outer triangles input to the TES only depends on tessellation mode, spacing mode and the
        // inner and outer tessellation levels corresponding to the inner and outer edges relevant to that triangle.
        CaseKind::InvariantOuterTriangleSet => match case_def.primitive_type {
            TessPrimitiveType::Triangles => compare_triangle_sets(primitives_a, primitives_b, &|triangle| {
                is_triangle_triangle_on_outer_edge(level_case_mem, triangle)
            }),
            TessPrimitiveType::Quads => compare_triangle_sets(primitives_a, primitives_b, &|triangle| {
                is_quad_triangle_on_outer_edge(level_case_mem, triangle)
            }),
            TessPrimitiveType::Isolines => true,
        },
        _ => unreachable!(),
    }
}

/// `InvarianceTestInstance::iterate` - base class for testing invariance of entire primitive set.
///
/// Draws two patches with identical tessellation levels and compares the results. Repeats the same with other programs that are only
/// different in irrelevant ways; compares the results between these two programs. Also potentially compares to results produced by
/// different tessellation levels (see e.g. invariance rule #6). Furthermore, repeats the above with multiple different tessellation
/// value sets.
fn iterate_invariance<'a>(context: &'a Context<'a>, case_def: CaseDefinition) -> TestOutcome {
    const NUM_PATCHES_PER_DRAW_CALL: usize = 2;

    let tess_level_cases = match case_def.kind {
        CaseKind::InvariantInnerTriangleSet => gen_inner_triangle_set_tess_level_cases(case_def.primitive_type),
        CaseKind::InvariantOuterTriangleSet => gen_outer_triangle_set_tess_level_cases(case_def.primitive_type),
        _ => gen_basic_tess_level_cases(),
    };
    let mut max_num_primitives_per_patch = 0i32; // computed below
    let mut primitive_counts: Vec<Vec<i32>> = Vec::new();

    for tess_level_case in &tess_level_cases {
        primitive_counts.push(Vec::new());
        for levels in &tess_level_case.levels {
            let primitive_count = reference_primitive_count(
                case_def.primitive_type,
                case_def.spacing_mode,
                case_def.use_point_mode,
                &levels.inner,
                &levels.outer,
            );
            primitive_counts.last_mut().unwrap().push(primitive_count);
            max_num_primitives_per_patch = max_num_primitives_per_patch.max(primitive_count);
        }
    }

    // Allow for more primitives in case tessellation/geometry has extra invocations
    let max_num_primitives_per_patch = max_num_primitives_per_patch as usize * NUM_EXTRA_TESS_GEOM_INVOCATIONS;

    // Output buffer: number of primitives and an array of PerPrimitive structures
    let result_buffer_max_vertices = NUM_PATCHES_PER_DRAW_CALL
        * max_num_primitives_per_patch
        * num_vertices_per_primitive(case_def.primitive_type, case_def.use_point_mode) as usize;
    let resources = DrawResources::new(context, case_def, NUM_PATCHES_PER_DRAW_CALL, result_buffer_max_vertices)?;

    for (tess_level_case_ndx, level_case) in tess_level_cases.iter().enumerate() {
        let mut first_prim: Vec<PerPrimitive> = Vec::new();

        for (sub_tess_level_case_ndx, tess_levels) in level_case.levels.iter().enumerate() {
            {
                let data = [*tess_levels, *tess_levels];
                let mut flat = Vec::with_capacity(NUM_PATCHES_PER_DRAW_CALL * NUM_TESS_LEVELS);
                for levels in &data {
                    flat.extend_from_slice(&levels.inner);
                    flat.extend_from_slice(&levels.outer);
                }
                resources.upload_vertex_attributes(&flat)?;
            }

            let mut any_subtest_failed = false;
            for (program_ndx, winding) in winding_cases(&case_def).into_iter().enumerate() {
                let (num_primitives, primitives) = resources.draw_raw(
                    (NUM_PATCHES_PER_DRAW_CALL * NUM_TESS_LEVELS) as u32,
                    winding,
                    case_def.use_point_mode,
                )?;

                // Verify case result
                let ref_num_primitives =
                    NUM_PATCHES_PER_DRAW_CALL as i32 * primitive_counts[tess_level_case_ndx][sub_tess_level_case_ndx];

                if num_primitives < ref_num_primitives {
                    any_subtest_failed = true;
                    continue;
                }

                let half = primitives.len() / 2;
                let prim0 = &primitives[..half];
                let prim1 = &primitives[half..];

                if !compare_primitives_exact(prim0, prim1, half) {
                    any_subtest_failed = true;
                    continue;
                }

                if program_ndx == 0 && sub_tess_level_case_ndx == 0 {
                    first_prim = prim0.to_vec();
                } else if !compare_primitive_sets(&case_def, &first_prim, prim0, level_case.mem) {
                    any_subtest_failed = true;
                    continue;
                }
            }

            if any_subtest_failed {
                return Ok(TestStatus::fail("Invalid set of primitives"));
            }
        }
    }
    Ok(TestStatus::pass("OK"))
}

/// `TessCoordComponent::genTessLevelCases`
fn gen_tess_coord_level_cases(num_cases: usize) -> Vec<TessLevels> {
    let mut rnd = Random::new(123);
    let mut result = Vec::with_capacity(num_cases);

    for _ in 0..num_cases {
        let inner0 = rnd.get_float_range(1.0, 63.0);
        let inner1 = rnd.get_float_range(1.0, 63.0);
        let outer0 = rnd.get_float_range(1.0, 63.0);
        let outer1 = rnd.get_float_range(1.0, 63.0);
        let outer2 = rnd.get_float_range(1.0, 63.0);
        let outer3 = rnd.get_float_range(1.0, 63.0);
        result.push(TessLevels {
            inner: [inner0, inner1],
            outer: [outer0, outer1, outer2, outer3],
        });
    }

    result
}

/// `compareTessCoordRange`
fn compare_tess_coord_range(value: f32) -> bool {
    (0.0..=1.0).contains(&value)
}

/// `compareOneMinusTessCoord`
fn compare_one_minus_tess_coord(value: f32) -> bool {
    value == 1.0
}

/// `TessCoordComponent::test`
fn iterate_tess_coord_component<'a>(context: &'a Context<'a>, case_def: CaseDefinition) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let queue_family_index = context.get_universal_queue_family_index();
    let alloc = context.get_default_allocator();

    let tess_point_size = context
        .get_device_features()
        .shader_tessellation_and_geometry_point_size
        != vk::FALSE;

    const NUM_TESS_LEVEL_CASES: usize = 32;
    let tess_level_cases = gen_tess_coord_level_cases(NUM_TESS_LEVEL_CASES);

    let mut max_num_vertices_in_draw_call = 0i32;
    for levels in &tess_level_cases {
        max_num_vertices_in_draw_call = max_num_vertices_in_draw_call.max(reference_vertex_count(
            case_def.primitive_type,
            case_def.spacing_mode,
            case_def.use_point_mode,
            &levels.inner,
            &levels.outer,
        ));
    }

    // We may get more invocations than expected, so add some more space (arbitrary number).
    let max_num_vertices_in_draw_call = max_num_vertices_in_draw_call as usize + 4;

    // Vertex input attributes buffer: to pass tessellation levels
    let vertex_stride = std::mem::size_of::<f32>() as u32;
    let vertex_data_size_bytes = (NUM_TESS_LEVELS as u32 * vertex_stride) as vk::DeviceSize;
    let vertex_buffer = BufferWithMemory::new(
        device,
        alloc,
        make_buffer_create_info(vertex_data_size_bytes, vk::BufferUsageFlags::VERTEX_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    debug_assert!(vertex_data_size_bytes as usize == std::mem::size_of::<TessLevels>());

    // Output buffer: number of invocations and array of tess coords
    let result_buffer_size_bytes = (RESULT_BUFFER_DATA_OFFSET + max_num_vertices_in_draw_call * 16) as vk::DeviceSize;
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
            vk::ShaderStageFlags::TESSELLATION_EVALUATION,
        )
        .build(device)?;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
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
            &result_buffer_info,
        )
        .update(device);

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
        binaries.get(if tess_point_size {
            "tese_write_point_size"
        } else {
            "tese"
        })?,
    )?;

    let mut state = DrawPipelineState::new(vk::PrimitiveTopology::PATCH_LIST).with_full_viewport(1, 1);
    state.bindings = vec![vk::VertexInputBindingDescription {
        binding: 0,
        stride: vertex_stride,
        input_rate: vk::VertexInputRate::VERTEX,
    }];
    state.attributes = vec![vk::VertexInputAttributeDescription {
        location: 0,
        binding: 0,
        format: vk::Format::R32_SFLOAT,
        offset: 0,
    }];
    state.patch_control_points = Some(NUM_TESS_LEVELS as u32);
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

    for tess_levels in &tess_level_cases {
        {
            let buffer_alloc = vertex_buffer.get_allocation();
            unsafe { std::ptr::write_unaligned(buffer_alloc.get_host_ptr().cast::<TessLevels>(), *tess_levels) };
            flush_alloc(device, buffer_alloc)?;
        }
        {
            let buffer_alloc = result_buffer.get_allocation();
            unsafe { std::ptr::write_bytes(buffer_alloc.get_host_ptr(), 0, result_buffer_size_bytes as usize) };
            flush_alloc(device, buffer_alloc)?;
        }

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
            device.cmd_bind_vertex_buffers(*cmd_buffer, 0, &[vertex_buffer.get()], &[0]);

            device.cmd_draw(*cmd_buffer, NUM_TESS_LEVELS as u32, 1, 0, 0);
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

        // Verify case result
        {
            let result_alloc = result_buffer.get_allocation();
            invalidate_alloc(device, result_alloc)?;

            let host_ptr = result_alloc.get_host_ptr();
            let num_vertices = read_i32(host_ptr);
            // If this fails then we didn't read all vertices from shader and test must be changed to allow more.
            debug_assert!(num_vertices as usize <= max_num_vertices_in_draw_call);
            let readable_vertices = (num_vertices.max(0) as usize).min(max_num_vertices_in_draw_call);
            let vertices: Vec<Vec3> = (0..readable_vertices)
                .map(|i| {
                    let base = unsafe { host_ptr.add(RESULT_BUFFER_DATA_OFFSET + i * 16) }.cast::<f32>();
                    unsafe {
                        [
                            std::ptr::read_unaligned(base),
                            std::ptr::read_unaligned(base.add(1)),
                            std::ptr::read_unaligned(base.add(2)),
                        ]
                    }
                })
                .collect();

            let num_components = if case_def.primitive_type == TessPrimitiveType::Triangles {
                3
            } else {
                2
            };
            let compare: fn(f32) -> bool = if case_def.kind == CaseKind::TessCoordRange {
                compare_tess_coord_range
            } else {
                compare_one_minus_tess_coord
            };

            for vertex in &vertices {
                for &component in &vertex[..num_components] {
                    if !compare(component) {
                        // Upstream constructs this status and drops it, so a wrong coordinate never fails the case.
                        let _dropped_upstream = TestStatus::fail("Invalid tessellation coordinate component");
                    }
                }
            }
        }
    }
    Ok(TestStatus::pass("OK"))
}

struct InvarianceCase {
    name: String,
    /// The name of the case in the shader manifest.
    program_set: String,
    case_def: CaseDefinition,
}

impl TestCase for InvarianceCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `requireFeatures` of `BaseTestInstance` / `InvarianceTestInstance` / `TessCoordComponent::test`.
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let features = context.get_device_features();
        if features.tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported("Tessellation shader not supported".to_string()));
        }
        if !self.case_def.kind.is_tess_coord_component() && features.geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported("Geometry shader not supported".to_string()));
        }
        if features.vertex_pipeline_stores_and_atomics == vk::FALSE {
            return Err(TestError::NotSupported(
                "SSBO and image writes not supported in vertex pipeline".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == self.program_set)
            .unwrap_or_else(|| panic!("the shader manifest has no case named {}", self.program_set))
            .programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(InvarianceInstance {
            context,
            case_def: self.case_def,
        })
    }
}

struct InvarianceInstance<'a> {
    context: &'a Context<'a>,
    case_def: CaseDefinition,
}

impl TestInstance for InvarianceInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        match self.case_def.kind {
            CaseKind::OuterEdgeDivision => iterate_outer_edge_division(context, self.case_def),
            CaseKind::OuterEdgeIndexIndependence => iterate_outer_edge_index_independence(context, self.case_def),
            CaseKind::SymmetricOuterEdge => iterate_symmetric_outer_edge(context, self.case_def),
            CaseKind::InvariantPrimitiveSet
            | CaseKind::InvariantTriangleSet
            | CaseKind::InvariantOuterTriangleSet
            | CaseKind::InvariantInnerTriangleSet => iterate_invariance(context, self.case_def),
            CaseKind::TessCoordRange | CaseKind::OneMinusTessCoord => {
                iterate_tess_coord_component(context, self.case_def)
            }
        }
    }
}

fn make_case(name: &str, program_set: String, case_def: CaseDefinition) -> Box<dyn TestCase> {
    Box::new(InvarianceCase {
        name: name.to_string(),
        program_set,
        case_def,
    })
}

fn case_def(
    kind: CaseKind,
    primitive_type: TessPrimitiveType,
    spacing_mode: SpacingMode,
    winding: Winding,
    vary_winding: bool,
    use_point_mode: bool,
) -> CaseDefinition {
    CaseDefinition {
        kind,
        primitive_type,
        spacing_mode,
        winding,
        vary_winding,
        use_point_mode,
    }
}

/// `createInvarianceTests`
pub fn create_invariance_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("invariance");

    let mut invariant_primitive_set_group = TestCaseGroup::new("primitive_set");
    let mut invariant_outer_edge_group = TestCaseGroup::new("outer_edge_division");
    let mut symmetric_outer_edge_group = TestCaseGroup::new("outer_edge_symmetry");
    let mut outer_edge_vertex_set_index_independence_group = TestCaseGroup::new("outer_edge_index_independence");
    let mut invariant_triangle_set_group = TestCaseGroup::new("triangle_set");
    let mut invariant_inner_triangle_set_group = TestCaseGroup::new("inner_triangle_set");
    let mut invariant_outer_triangle_set_group = TestCaseGroup::new("outer_triangle_set");
    let mut tess_coord_component_range_group = TestCaseGroup::new("tess_coord_component_range");
    let mut one_minus_tess_coord_component_group = TestCaseGroup::new("one_minus_tess_coord_component");

    for primitive_type in TessPrimitiveType::ALL {
        for spacing_mode in SpacingMode::ALL {
            let tri_or_quad =
                primitive_type == TessPrimitiveType::Triangles || primitive_type == TessPrimitiveType::Quads;
            let prim_name = primitive_type.shader_name();
            let prim_spac_name = format!("{}_{}", prim_name, spacing_mode.shader_name());

            if tri_or_quad {
                let division = format!("division_{prim_spac_name}");
                let vary = format!("vary_{prim_spac_name}");
                // winding is ignored by the division test
                invariant_outer_edge_group.add_child(make_case(
                    &prim_spac_name,
                    division,
                    case_def(
                        CaseKind::OuterEdgeDivision,
                        primitive_type,
                        spacing_mode,
                        Winding::Ccw,
                        true,
                        false,
                    ),
                ));
                invariant_triangle_set_group.add_child(make_case(
                    &prim_spac_name,
                    vary.clone(),
                    case_def(
                        CaseKind::InvariantTriangleSet,
                        primitive_type,
                        spacing_mode,
                        Winding::Ccw,
                        true,
                        false,
                    ),
                ));
                invariant_inner_triangle_set_group.add_child(make_case(
                    &prim_spac_name,
                    vary.clone(),
                    case_def(
                        CaseKind::InvariantInnerTriangleSet,
                        primitive_type,
                        spacing_mode,
                        Winding::Ccw,
                        true,
                        false,
                    ),
                ));
                invariant_outer_triangle_set_group.add_child(make_case(
                    &prim_spac_name,
                    vary,
                    case_def(
                        CaseKind::InvariantOuterTriangleSet,
                        primitive_type,
                        spacing_mode,
                        Winding::Ccw,
                        true,
                        false,
                    ),
                ));
            }

            for winding in Winding::ALL {
                for use_point_mode in [false, true] {
                    let prim_spac_wind_point_name = format!(
                        "{}_{}{}",
                        prim_spac_name,
                        winding.shader_name(),
                        if use_point_mode { "_point_mode" } else { "" }
                    );
                    let name = prim_spac_wind_point_name.as_str();

                    invariant_primitive_set_group.add_child(make_case(
                        name,
                        format!("single_{name}"),
                        case_def(
                            CaseKind::InvariantPrimitiveSet,
                            primitive_type,
                            spacing_mode,
                            winding,
                            false,
                            use_point_mode,
                        ),
                    ));
                    tess_coord_component_range_group.add_child(make_case(
                        name,
                        format!("range_{name}"),
                        case_def(
                            CaseKind::TessCoordRange,
                            primitive_type,
                            spacing_mode,
                            winding,
                            false,
                            use_point_mode,
                        ),
                    ));
                    one_minus_tess_coord_component_group.add_child(make_case(
                        name,
                        format!("oneminus_{name}"),
                        case_def(
                            CaseKind::OneMinusTessCoord,
                            primitive_type,
                            spacing_mode,
                            winding,
                            false,
                            use_point_mode,
                        ),
                    ));
                    symmetric_outer_edge_group.add_child(make_case(
                        name,
                        format!("mirror_{name}"),
                        case_def(
                            CaseKind::SymmetricOuterEdge,
                            primitive_type,
                            spacing_mode,
                            winding,
                            false,
                            use_point_mode,
                        ),
                    ));

                    if tri_or_quad {
                        outer_edge_vertex_set_index_independence_group.add_child(make_case(
                            name,
                            format!("single_{name}"),
                            case_def(
                                CaseKind::OuterEdgeIndexIndependence,
                                primitive_type,
                                spacing_mode,
                                winding,
                                false,
                                use_point_mode,
                            ),
                        ));
                    }
                }
            }
        }
    }

    group.add_child(invariant_primitive_set_group);
    group.add_child(invariant_outer_edge_group);
    group.add_child(symmetric_outer_edge_group);
    group.add_child(outer_edge_vertex_set_index_independence_group);
    group.add_child(invariant_triangle_set_group);
    group.add_child(invariant_inner_triangle_set_group);
    group.add_child(invariant_outer_triangle_set_group);
    group.add_child(tess_coord_component_range_group);
    group.add_child(one_minus_tess_coord_component_group);

    group
}
