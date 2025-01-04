// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelinePushConstantTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Imagination Technologies Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Monolithic pipelines only. The graphics shaders upstream generates from the case
// parameters are pre-expanded into shaders/src/pipeline/push_constant/graphics/ (the `_command2` variants share their case's
// programs). Upstream compares against `ReferenceRenderer`'s rendering of the two flat-coloured triangles; here the same two
// triangles are rasterised by pixel centre and compared with `tcu::intThresholdPositionDeviationCompare`'s rule (threshold 2, a match
// within one pixel, out of bounds accepted).
//
// `push_constant`: graphics_pipeline (disjoint and overlapping ranges over every shader stage), compute_pipeline and lifetime.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{InstanceV1_1, KhrMaintenance6ExtensionDeviceCommands};

use crate::generated::shaders::pipeline_push_constant::*;
use crate::tcu::{Random, TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_layers, make_image_subresource_range,
    make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_framebuffer, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline, rect_2d};
use crate::vkt::tests::pipeline::shader_object_draw::{begin_draw, end_draw, make_shader_objects_stages_specialized};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const TRIANGLE_COUNT: usize = 2;
const RENDER_SIZE: u32 = 32;
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
/// `defaultClearColorUnorm`
const CLEAR_COLOR: [f32; 4] = [0.39, 0.58, 0.93, 1.0];

// These values will be loaded from push constants and used as an index
const DYNAMIC_VEC_INDEX: u32 = 2;
const DYNAMIC_MAT_INDEX: u32 = 0;
const DYNAMIC_ARR_INDEX: u32 = 3;

// These reference values will be compared in the shader to ensure the correct index was read
const DYNAMIC_VEC_CONSTANT: f32 = 0.25;
const DYNAMIC_MAT_CONSTANT: f32 = 0.50;
const DYNAMIC_ARR_CONSTANT: f32 = 0.75;

const STAGE_V: vk::ShaderStageFlags = vk::ShaderStageFlags::VERTEX;
const STAGE_C: vk::ShaderStageFlags = vk::ShaderStageFlags::TESSELLATION_CONTROL;
const STAGE_E: vk::ShaderStageFlags = vk::ShaderStageFlags::TESSELLATION_EVALUATION;
const STAGE_G: vk::ShaderStageFlags = vk::ShaderStageFlags::GEOMETRY;
const STAGE_F: vk::ShaderStageFlags = vk::ShaderStageFlags::FRAGMENT;
const STAGE_COMPUTE: vk::ShaderStageFlags = vk::ShaderStageFlags::COMPUTE;

#[derive(Clone, Copy, PartialEq, Eq)]
enum IndexType {
    ConstLiteral,
    DynamicallyUniformExpr,
}

/// `PushConstantData`: the range of the pipeline layout and the part of it that gets updated.
#[derive(Clone, Copy)]
struct PushConstantData {
    stage_flags: vk::ShaderStageFlags,
    offset: u32,
    size: u32,
    long_vec: bool,
    update_offset: u32,
    update_size: u32,
}

/// A range whose whole extent is updated.
fn full(stage_flags: vk::ShaderStageFlags, offset: u32, size: u32) -> PushConstantData {
    PushConstantData {
        stage_flags,
        offset,
        size,
        long_vec: false,
        update_offset: offset,
        update_size: size,
    }
}

fn partial(
    stage_flags: vk::ShaderStageFlags,
    offset: u32,
    size: u32,
    update_offset: u32,
    update_size: u32,
) -> PushConstantData {
    PushConstantData {
        stage_flags,
        offset,
        size,
        long_vec: false,
        update_offset,
        update_size,
    }
}

fn as_bytes<T: Copy>(values: &[T]) -> &[u8] {
    unsafe { std::slice::from_raw_parts(values.as_ptr().cast::<u8>(), std::mem::size_of_val(values)) }
}

/// `pushConstants`: `vkCmdPushConstants`, or `vkCmdPushConstants2KHR` for the `_command2` cases.
#[allow(clippy::too_many_arguments)]
fn push_constants(
    device: &Device,
    cmd: vk::CommandBuffer,
    layout: vk::PipelineLayout,
    stage_flags: vk::ShaderStageFlags,
    offset: u32,
    size: u32,
    values: &[u8],
    push_constant2: bool,
) {
    let values = &values[..size as usize];
    unsafe {
        if push_constant2 {
            let info = vk::PushConstantsInfo {
                s_type: vk::StructureType::PUSH_CONSTANTS_INFO,
                next: std::ptr::null(),
                layout,
                stage_flags,
                offset,
                size,
                values: values.as_ptr().cast(),
            };
            device.cmd_push_constants2_khr(cmd, &info);
        } else {
            device.cmd_push_constants(cmd, layout, stage_flags, offset, values);
        }
    }
}

/// A vertex of `Vertex4RGBA`: a position and a colour.
type Vertex4Rgba = [f32; 8];

/// `createQuad`
fn create_quad(size: f32, color: [f32; 4]) -> Vec<Vertex4Rgba> {
    let vertex = |x: f32, y: f32| -> Vertex4Rgba { [x, y, 0.0, 1.0, color[0], color[1], color[2], color[3]] };
    let lower_left = vertex(-size, -size);
    let lower_right = vertex(size, -size);
    let upper_left = vertex(-size, size);
    let upper_right = vertex(size, size);
    vec![
        lower_left,
        lower_right,
        upper_left,
        upper_left,
        lower_right,
        upper_right,
    ]
}

fn vertex_input_state(mut state: DrawPipelineState) -> DrawPipelineState {
    state.bindings = vec![vk::VertexInputBindingDescription {
        binding: 0,
        stride: std::mem::size_of::<Vertex4Rgba>() as u32,
        input_rate: vk::VertexInputRate::VERTEX,
    }];
    state.attributes = vec![
        vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: 0,
        },
        vk::VertexInputAttributeDescription {
            location: 1,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: 16,
        },
    ];
    state
}

fn make_color_image<'a>(context: &'a Context<'a>) -> Result<ImageWithMemory<'a>, TestError> {
    let info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(COLOR_FORMAT)
        .extent(vk::Extent3D {
            width: RENDER_SIZE,
            height: RENDER_SIZE,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    ImageWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        info,
        MemoryRequirement::ANY,
    )
}

fn color_subresource_range() -> vk::ImageSubresourceRange {
    make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1)
}

/// `readColorAttachment`: the image is read back from COLOR_ATTACHMENT_OPTIMAL.
fn read_color_attachment(context: &Context<'_>, image: vk::Image) -> Result<Vec<u8>, TestError> {
    let device = context.get_device();
    let size = (RENDER_SIZE * RENDER_SIZE * 4) as vk::DeviceSize;
    let buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(size, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;
    let image_barrier = make_image_memory_barrier(
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        image,
        color_subresource_range(),
    );
    let region = vk::BufferImageCopy {
        buffer_offset: 0,
        buffer_row_length: 0,
        buffer_image_height: 0,
        image_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
        image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
        image_extent: vk::Extent3D {
            width: RENDER_SIZE,
            height: RENDER_SIZE,
            depth: 1,
        },
    };
    let buffer_barrier = make_buffer_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::HOST_READ,
        buffer.get(),
        0,
        vk::WHOLE_SIZE,
    );
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[image_barrier],
        );
        device.cmd_copy_image_to_buffer(
            cmd,
            image,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            buffer.get(),
            &[region],
        );
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[buffer_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    invalidate_alloc(device, buffer.get_allocation())?;
    Ok(unsafe { std::slice::from_raw_parts(buffer.get_allocation().get_host_ptr(), size as usize) }.to_vec())
}

fn quantize(color: [f32; 4]) -> [u8; 4] {
    color.map(|c| (c.clamp(0.0, 1.0) * 255.0).round() as u8)
}

/// What `ReferenceRenderer` draws for the two triangles of a `size` quad: each pixel whose centre is inside the quad takes the colour
/// of the triangle it is in, the rest is the clear colour.
fn render_reference(quad_size: f32, triangle_colors: [[f32; 4]; TRIANGLE_COUNT]) -> Vec<u8> {
    let clear = quantize(CLEAR_COLOR);
    let colors = triangle_colors.map(quantize);
    let half = RENDER_SIZE as f32 / 2.0;
    let mut image = Vec::with_capacity((RENDER_SIZE * RENDER_SIZE * 4) as usize);
    for y in 0..RENDER_SIZE {
        for x in 0..RENDER_SIZE {
            let u = (x as f32 + 0.5) / half - 1.0;
            let v = (y as f32 + 0.5) / half - 1.0;
            let color = if u.abs() <= quad_size && v.abs() <= quad_size {
                if u + v <= 0.0 { colors[0] } else { colors[1] }
            } else {
                clear
            };
            image.extend_from_slice(&color);
        }
    }
    image
}

/// `tcu::intThresholdPositionDeviationCompare` with a threshold of 2, a deviation of (1, 1, 0) and out of bounds accepted as any value.
fn matches_with_position_deviation(result: &[u8], reference: &[u8]) -> bool {
    let size = RENDER_SIZE as i32;
    for y in 0..size {
        for x in 0..size {
            let pixel = &result[((y * size + x) * 4) as usize..][..4];
            let mut found = false;
            'search: for dy in -1..=1 {
                for dx in -1..=1 {
                    let (nx, ny) = (x + dx, y + dy);
                    if nx < 0 || ny < 0 || nx >= size || ny >= size {
                        found = true;
                        break 'search;
                    }
                    let want = &reference[((ny * size + nx) * 4) as usize..][..4];
                    if pixel.iter().zip(want).all(|(&got, &want)| got.abs_diff(want) <= 2) {
                        found = true;
                        break 'search;
                    }
                }
            }
            if !found {
                return false;
            }
        }
    }
    true
}

// =================================================================================
// Graphics: PushConstantGraphicsDisjointTest / PushConstantGraphicsOverlapTest
// =================================================================================

#[derive(Clone)]
struct GraphicsCase {
    ranges: Vec<PushConstantData>,
    multiple_update: bool,
    index_type: IndexType,
    push_constant2: bool,
    pc_used_stage: vk::ShaderStageFlags,
    size_queried_from_device: bool,
    overlap: bool,
}

fn long_vector_supported(context: &Context<'_>) -> bool {
    let mut long_vector = vk::PhysicalDeviceShaderLongVectorFeaturesEXT::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut long_vector);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };
    long_vector.long_vector != vk::FALSE
}

impl GraphicsCase {
    /// `PushConstantGraphicsTest::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.push_constant2 {
            context.require_device_functionality("VK_KHR_maintenance6")?;
        }

        let limits = &context.get_device_properties().limits;

        if !self.size_queried_from_device {
            for range in &self.ranges {
                if range.size > limits.max_push_constants_size {
                    return Err(TestError::NotSupported(format!(
                        "PushConstant size {} exceeds device limit {}",
                        range.size, limits.max_push_constants_size
                    )));
                }
                if range.long_vec && !long_vector_supported(context) {
                    return Err(TestError::NotSupported("longVector not supported".to_string()));
                }
            }
        }

        let requires_tessellation = self
            .ranges
            .iter()
            .any(|range| range.stage_flags.intersects(STAGE_C | STAGE_E));
        let requires_geometry = self.ranges.iter().any(|range| range.stage_flags.intersects(STAGE_G));

        let features = context.get_device_features();
        if requires_tessellation && features.tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported("Tessellation Not Supported".to_string()));
        }
        if requires_geometry && features.geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported("Geometry Not Supported".to_string()));
        }
        Ok(())
    }
}

/// `PushConstantGraphicsDisjointInstance::updatePushConstants`
fn update_push_constants_disjoint(
    device: &Device,
    cmd: vk::CommandBuffer,
    layout: vk::PipelineLayout,
    case: &GraphicsCase,
    ranges: &[PushConstantData],
) {
    let color_count = if case.size_queried_from_device {
        ((ranges[0].size + 12) / 16) as usize
    } else {
        16
    };
    let mut color = vec![[1.0f32, 0.0, 0.0, 1.0]; color_count];
    let all_ones = vec![[1.0f32; 4]; 8];

    if case.index_type == IndexType::DynamicallyUniformExpr {
        // Stick our dynamic index at the beginning of a vector
        color[0] = [
            DYNAMIC_VEC_INDEX as f32,
            DYNAMIC_MAT_INDEX as f32,
            DYNAMIC_ARR_INDEX as f32,
            1.0,
        ];

        // Place our reference values at each type offset

        // vec4[i]
        color[1] = [0.0, 0.0, 0.0, 1.0];
        color[1][DYNAMIC_VEC_INDEX as usize] = DYNAMIC_VEC_CONSTANT;

        // mat2[i][0]
        color[2] = [0.0, 0.0, 0.0, 1.0];
        color[2][(DYNAMIC_MAT_INDEX * 2) as usize] = DYNAMIC_MAT_CONSTANT;

        // float[i]
        color[3] = [0.0, 0.0, 0.0, 1.0];
        color[3][DYNAMIC_ARR_INDEX as usize] = DYNAMIC_ARR_CONSTANT;
    }

    let kind_bytes = 2u32.to_ne_bytes();
    for range in ranges {
        let value: &[u8] = if range.size == 4 { &kind_bytes } else { as_bytes(&color) };
        push_constants(
            device,
            cmd,
            layout,
            range.stage_flags,
            range.offset,
            range.size,
            value,
            case.push_constant2,
        );

        if range.update_size < range.size {
            push_constants(
                device,
                cmd,
                layout,
                range.stage_flags,
                range.update_offset,
                range.update_size,
                as_bytes(&all_ones),
                case.push_constant2,
            );
        }
    }
}

/// `PushConstantGraphicsOverlapTestInstance::getPushConstantRanges`: one range per shader stage, spanning every range the stage is in.
fn overlap_push_constant_ranges(ranges: &[PushConstantData]) -> Vec<vk::PushConstantRange> {
    let mut push_constant_ranges = Vec::new();
    for stage in [STAGE_V, STAGE_C, STAGE_E, STAGE_G, STAGE_F] {
        let mut first_byte = !0u32;
        let mut last_byte = 0u32;

        for range in ranges {
            if range.stage_flags.intersects(stage) {
                first_byte = first_byte.min(range.offset);
                last_byte = last_byte.max(range.offset + range.size);
            }
        }

        if first_byte != !0u32 {
            push_constant_ranges.push(vk::PushConstantRange {
                stage_flags: stage,
                offset: first_byte,
                size: last_byte - first_byte,
            });
        }
    }
    push_constant_ranges
}

/// `PushConstantGraphicsOverlapTestInstance::getPushConstantUpdates`
fn overlap_push_constant_updates(ranges: &[PushConstantData]) -> Vec<vk::PushConstantRange> {
    let mut last_stage_flags: Option<vk::ShaderStageFlags> = None;
    let mut updates: Vec<vk::PushConstantRange> = Vec::new();

    // Find matching shader stages for every 4 byte chunk
    for offset in (0..128u32).step_by(4) {
        let mut stage_flags = vk::ShaderStageFlags::empty();
        let mut update_range = false;

        // For each byte in the range specified by offset and size and for each push constant range that overlaps that byte,
        // stageFlags must include all stages in that push constant range's VkPushConstantRange::stageFlags
        for range in ranges {
            let range_start = range.offset;
            let range_end = range_start + range.size;

            let update_start = range.update_offset;
            let update_end = update_start + range.update_size;

            update_range |= update_start <= offset && update_end >= offset + 4;

            if range_start <= offset && range_end >= offset + 4 {
                stage_flags |= range.stage_flags;
            }
        }

        // Skip chunks with no updates
        if stage_flags.is_empty() || !update_range {
            continue;
        }

        if Some(stage_flags) != last_stage_flags {
            // Add new update entry
            updates.push(vk::PushConstantRange {
                stage_flags,
                offset,
                size: 4,
            });
            last_stage_flags = Some(stage_flags);
        } else if let Some(last) = updates.last_mut() {
            // Increase current update entry size
            last.size += 4;
        }
    }

    updates
}

/// `generateColorData`
fn generate_color_data(num_bytes: u32) -> Vec<f32> {
    let mut random = Random::new(num_bytes);
    (0..num_bytes / 4).map(|_| random.get_float()).collect()
}

/// `PushConstantGraphicsOverlapTestInstance::updatePushConstants`: returns the reference data, the values the stages in use read.
fn update_push_constants_overlap(
    device: &Device,
    cmd: vk::CommandBuffer,
    layout: vk::PipelineLayout,
    case: &GraphicsCase,
    ranges: &[PushConstantData],
    color_data: &[f32],
) -> Vec<f32> {
    let updates = overlap_push_constant_updates(ranges);
    let mut reference_data = vec![0.0f32; color_data.len()];

    for update in &updates {
        let source = (update.offset / 2) as usize;
        push_constants(
            device,
            cmd,
            layout,
            update.stage_flags,
            update.offset,
            update.size,
            as_bytes(&color_data[source..]),
            case.push_constant2,
        );

        // Copy push constant values to reference buffer
        if case.pc_used_stage.intersects(update.stage_flags) {
            let count = (update.size / 4) as usize;
            let destination = (update.offset / 4) as usize;
            reference_data[destination..destination + count].copy_from_slice(&color_data[source..source + count]);
        }
    }

    reference_data
}

/// `PushConstantGraphicsOverlapTestInstance::setReferenceColor`
fn overlap_reference_color(
    case: &GraphicsCase,
    ranges: &[PushConstantData],
    reference_data: &[f32],
    init_color: [f32; 4],
) -> [f32; 4] {
    let mut expected_color = init_color;

    // Calculate reference color
    for range in ranges {
        let offset = (range.offset / 4) as usize;
        let size = (range.size / 4) as usize;

        if case.pc_used_stage.intersects(range.stage_flags) {
            let num_components = size.min(4);
            let color_ndx = offset + size - num_components;

            for component_ndx in 0..num_components {
                expected_color[component_ndx] += reference_data[color_ndx + component_ndx];
            }
        }
    }

    // tcu::min(tcu::mod(c, 2), 2 - tcu::mod(c, 2))
    expected_color.map(|c| {
        let modulo = c - 2.0 * (c / 2.0).floor();
        modulo.min(2.0 - modulo)
    })
}

/// `PushConstantGraphicsTestInstance` (`init`, `iterate` and `verifyImage`)
fn run_graphics<'a>(context: &'a Context<'a>, case: &GraphicsCase) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let allocator = context.get_default_allocator();

    let mut ranges = case.ranges.clone();
    if case.size_queried_from_device {
        let limits = &context.get_device_properties().limits;
        ranges[0].size = limits.max_push_constants_size;
        ranges[0].update_size = limits.max_push_constants_size;
    }
    let push_constant_ranges: Vec<vk::PushConstantRange> = if case.overlap {
        overlap_push_constant_ranges(&ranges)
    } else {
        ranges
            .iter()
            .map(|range| vk::PushConstantRange {
                stage_flags: range.stage_flags,
                offset: range.offset,
                size: range.size,
            })
            .collect()
    };

    // Create color image, its view, the render pass and the framebuffer
    let color_image = make_color_image(context)?;
    let color_attachment_view = make_image_view(
        device,
        color_image.get(),
        vk::ImageViewType::_2D,
        COLOR_FORMAT,
        color_subresource_range(),
    )?;
    let render_pass = make_render_pass(device, COLOR_FORMAT)?;
    let framebuffer = make_framebuffer(
        device,
        *render_pass,
        &[*color_attachment_view],
        RENDER_SIZE,
        RENDER_SIZE,
        1,
    )?;

    // Create pipeline layout
    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, vk::ShaderStageFlags::VERTEX)
        .build(device)?;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::UNIFORM_BUFFER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

    let uniform_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(16, vk::BufferUsageFlags::UNIFORM_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let uniform_value = [1.0f32, 0.0, 0.0, 1.0];
    unsafe {
        std::ptr::copy_nonoverlapping(
            as_bytes(&uniform_value).as_ptr(),
            uniform_buffer.get_allocation().get_host_ptr(),
            16,
        )
    };
    flush_alloc(device, uniform_buffer.get_allocation())?;

    let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
    let descriptor_info = [vk::DescriptorBufferInfo {
        buffer: uniform_buffer.get(),
        offset: 0,
        range: 16,
    }];
    let write = vk::WriteDescriptorSet::builder()
        .dst_set(descriptor_set.get())
        .dst_binding(0)
        .descriptor_type(vk::DescriptorType::UNIFORM_BUFFER)
        .buffer_info(&descriptor_info)
        .build();
    unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

    let set_layouts = [*descriptor_set_layout];
    let layout_info = vk::PipelineLayoutCreateInfo::builder()
        .set_layouts(&set_layouts)
        .push_constant_ranges(&push_constant_ranges);
    let pipeline_layout = Unique::new(
        device,
        unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
    );

    // Create shaders
    let mut shader_flags = STAGE_V | STAGE_F;
    for range in &ranges {
        shader_flags |= range.stage_flags & (STAGE_G | STAGE_C | STAGE_E);
    }

    let binaries = context.get_binary_collection();
    let vertex_module = create_shader_module(device, binaries.get("color_vert")?)?;
    let use_tessellation = shader_flags.intersects(STAGE_C | STAGE_E);
    let (tess_control_module, tess_evaluation_module) = if use_tessellation {
        (
            Some(create_shader_module(device, binaries.get("color_tesc")?)?),
            Some(create_shader_module(device, binaries.get("color_tese")?)?),
        )
    } else {
        (None, None)
    };
    let geometry_module = if shader_flags.intersects(STAGE_G) {
        Some(create_shader_module(device, binaries.get("color_geom")?)?)
    } else {
        None
    };
    let fragment_module = create_shader_module(device, binaries.get("color_frag")?)?;

    // Create pipeline
    let topology = if shader_flags.intersects(STAGE_C) {
        vk::PrimitiveTopology::PATCH_LIST
    } else {
        vk::PrimitiveTopology::TRIANGLE_LIST
    };
    let mut state = vertex_input_state(DrawPipelineState::new(topology).with_full_viewport(RENDER_SIZE, RENDER_SIZE));
    if use_tessellation {
        state.patch_control_points = Some(3);
    }
    if case.size_queried_from_device {
        state.vertex_specialization_u32 = Some(ranges[0].size);
    }
    let mut stages = vec![(STAGE_V, *vertex_module)];
    if let (Some(tess_control), Some(tess_evaluation)) = (&tess_control_module, &tess_evaluation_module) {
        stages.push((STAGE_C, **tess_control));
        stages.push((STAGE_E, **tess_evaluation));
    }
    if let Some(geometry) = &geometry_module {
        stages.push((STAGE_G, **geometry));
    }
    stages.push((STAGE_F, *fragment_module));
    let mut stage_names = vec![(STAGE_V, "color_vert")];
    if use_tessellation {
        stage_names.push((STAGE_C, "color_tesc"));
        stage_names.push((STAGE_E, "color_tese"));
    }
    if shader_flags.intersects(STAGE_G) {
        stage_names.push((STAGE_G, "color_geom"));
    }
    stage_names.push((STAGE_F, "color_frag"));
    let specialization_entries = [vk::SpecializationMapEntry {
        constant_id: 0,
        offset: 0,
        size: 4,
    }];
    let specialization_data = ranges[0].size.to_ne_bytes();
    let shader_objects = make_shader_objects_stages_specialized(
        context,
        &stage_names,
        &set_layouts,
        &push_constant_ranges,
        case.size_queried_from_device
            .then_some((&specialization_entries[..], &specialization_data[..])),
    )?;
    let pipeline = if shader_objects.is_some() {
        None
    } else {
        Some(create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &stages,
            &state,
        )?)
    };

    // Create vertex buffer
    let uses_geometry_quad = shader_flags.intersects(STAGE_G);
    let quad_size = if uses_geometry_quad && case.pc_used_stage.intersects(STAGE_G) {
        0.5
    } else {
        1.0
    };
    let vertices = create_quad(1.0, [1.0, 0.0, 0.0, 1.0]);
    let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

    // Create command buffer
    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;
    let color_data = generate_color_data(256);
    let mut reference_data = Vec::new();

    begin_command_buffer(device, cmd)?;

    let clear_values = [vk::ClearValue {
        color: vk::ClearColorValue { float32: CLEAR_COLOR },
    }];
    begin_draw(
        device,
        cmd,
        shader_objects.as_ref(),
        &state,
        pipeline.as_ref().map(|pipeline| pipeline.get()),
        *render_pass,
        *framebuffer,
        rect_2d(RENDER_SIZE, RENDER_SIZE),
        &clear_values,
        &[(color_image.get(), *color_attachment_view)],
    );

    // Update push constant values
    if case.overlap {
        reference_data = update_push_constants_overlap(device, cmd, *pipeline_layout, case, &ranges, &color_data);
    } else {
        update_push_constants_disjoint(device, cmd, *pipeline_layout, case, &ranges);
    }

    // draw quad
    let triangle_offset = ((vertices.len() / TRIANGLE_COUNT) * std::mem::size_of::<Vertex4Rgba>()) as vk::DeviceSize;
    for triangle_ndx in 0..TRIANGLE_COUNT {
        let vertex_buffer_offset = triangle_offset * triangle_ndx as vk::DeviceSize;

        if case.multiple_update {
            push_constants(
                device,
                cmd,
                *pipeline_layout,
                ranges[0].stage_flags,
                ranges[0].offset,
                ranges[0].size,
                &(triangle_ndx as i32).to_ne_bytes(),
                case.push_constant2,
            );
        }

        unsafe {
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[vertex_buffer_offset]);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_draw(cmd, (vertices.len() / TRIANGLE_COUNT) as u32, 1, 0, 0);
        }
    }

    end_draw(device, cmd, shader_objects.is_some());
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    // verifyImage: the reference colours of the two triangles
    let red = [1.0f32, 0.0, 0.0, 1.0];
    let mut triangle_colors = [red; TRIANGLE_COUNT];
    if case.overlap {
        triangle_colors = [overlap_reference_color(case, &ranges, &reference_data, red); TRIANGLE_COUNT];
    } else if ranges.iter().any(|range| range.update_size < range.size) {
        triangle_colors = [[1.0; 4]; TRIANGLE_COUNT];
    }
    if case.multiple_update {
        triangle_colors[0] = [0.0, 1.0, 0.0, triangle_colors[0][3]];
        triangle_colors[1] = [0.0, 0.0, 1.0, triangle_colors[1][3]];
    }

    let reference = render_reference(quad_size, triangle_colors);
    let result = read_color_attachment(context, color_image.get())?;

    if matches_with_position_deviation(&result, &reference) {
        Ok(TestStatus::pass("Result image matches reference"))
    } else {
        Ok(TestStatus::fail("Image mismatch"))
    }
}

// =================================================================================
// Compute: PushConstantComputeTest
// =================================================================================

fn make_storage_buffer_descriptor<'a>(
    device: &'a Device,
    allocator: &crate::vk::mem_util::SimpleAllocator,
    size: vk::DeviceSize,
) -> Result<
    (
        BufferWithMemory<'a>,
        Unique<'a, vk::DescriptorSetLayout>,
        Unique<'a, vk::DescriptorPool>,
        crate::vk::ref_util::UniqueDescriptorSet<'a>,
    ),
    TestError,
> {
    let out_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(size, vk::BufferUsageFlags::STORAGE_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .build(device)?;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

    let descriptor_info = [vk::DescriptorBufferInfo {
        buffer: out_buffer.get(),
        offset: 0,
        range: size,
    }];
    let write = vk::WriteDescriptorSet::builder()
        .dst_set(descriptor_set.get())
        .dst_binding(0)
        .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
        .buffer_info(&descriptor_info)
        .build();
    unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
    Ok((out_buffer, descriptor_set_layout, descriptor_pool, descriptor_set))
}

fn make_push_constant_layout<'a>(
    device: &'a Device,
    set_layout: vk::DescriptorSetLayout,
    range: vk::PushConstantRange,
) -> Result<Unique<'a, vk::PipelineLayout>, TestError> {
    let set_layouts = [set_layout];
    let ranges = [range];
    let info = vk::PipelineLayoutCreateInfo::builder()
        .set_layouts(&set_layouts)
        .push_constant_ranges(&ranges);
    Ok(Unique::new(
        device,
        unsafe { device.create_pipeline_layout(&info, None) }.vk_check("vkCreatePipelineLayout")?,
    ))
}

fn make_compute_pipeline_for<'a>(
    device: &'a Device,
    layout: vk::PipelineLayout,
    module: vk::ShaderModule,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let stage = vk::PipelineShaderStageCreateInfo::builder()
        .stage(vk::ShaderStageFlags::COMPUTE)
        .module(module)
        .name(b"main\0")
        .build();
    let info = vk::ComputePipelineCreateInfo::builder()
        .stage(stage)
        .layout(layout)
        .base_pipeline_index(0)
        .build();
    Ok(Unique::new(
        device,
        unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[info], None) }
            .vk_check("vkCreateComputePipelines")?
            .0[0],
    ))
}

fn storage_buffer_barrier(buffer: vk::Buffer) -> vk::BufferMemoryBarrier {
    make_buffer_memory_barrier(
        vk::AccessFlags::SHADER_WRITE,
        vk::AccessFlags::HOST_READ,
        buffer,
        0,
        vk::WHOLE_SIZE,
    )
}

fn compute_to_host_barrier(device: &Device, cmd: vk::CommandBuffer, buffer: vk::Buffer) {
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::COMPUTE_SHADER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[storage_buffer_barrier(buffer)],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

/// `PushConstantComputeTestInstance`
fn run_compute(context: &Context<'_>, uninitialized: bool) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let range = full(STAGE_COMPUTE, 0, 16);

    let buffer_size = (std::mem::size_of::<[f32; 4]>() * 8) as vk::DeviceSize;
    let (out_buffer, descriptor_set_layout, _descriptor_pool, descriptor_set) =
        make_storage_buffer_descriptor(device, context.get_default_allocator(), buffer_size)?;
    let pipeline_layout = make_push_constant_layout(
        device,
        *descriptor_set_layout,
        vk::PushConstantRange {
            stage_flags: range.stage_flags,
            offset: range.offset,
            size: range.size,
        },
    )?;

    let compute_module = create_shader_module(device, context.get_binary_collection().get("compute")?)?;
    let pipeline = make_compute_pipeline_for(device, *pipeline_layout, *compute_module)?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;
    unsafe {
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, pipeline.get());
        device.cmd_bind_descriptor_sets(
            cmd,
            vk::PipelineBindPoint::COMPUTE,
            *pipeline_layout,
            0,
            &[descriptor_set.get()],
            &[] as &[u32],
        );
    }

    // update push constant
    let value = [1.0f32, 0.0, 0.0, 1.0];
    if !uninitialized {
        push_constants(
            device,
            cmd,
            *pipeline_layout,
            range.stage_flags,
            range.offset,
            range.size,
            as_bytes(&value),
            false,
        );
    }

    unsafe { device.cmd_dispatch(cmd, 8, 1, 1) };
    compute_to_host_barrier(device, cmd, out_buffer.get());
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    // The test should run without crashing when reading that undefined value. The actual value is not important, test just shouldn't
    // crash.
    if uninitialized {
        return Ok(TestStatus::pass("pass"));
    }

    invalidate_alloc(device, out_buffer.get_allocation())?;

    // verify result
    let expect_value = [value; 8];
    let result =
        unsafe { std::slice::from_raw_parts(out_buffer.get_allocation().get_host_ptr(), buffer_size as usize) };
    if result != as_bytes(&expect_value) {
        return Ok(TestStatus::fail("Image mismatch"));
    }
    Ok(TestStatus::pass("result image matches with reference"))
}

// =================================================================================
// Overwrite: OverwriteTestCase
// =================================================================================

/// `OverwritePushConstants`, laid out as std430 reads it.
#[repr(C)]
#[derive(Clone, Copy)]
struct OverwritePushConstants {
    coords: [i32; 4],
    base_color: [u32; 4],
    multiplier: [u32; 4],
    color_offsets: [u32; 4],
    transparent_green: [u32; 4],
}

const OVERWRITE_COORDS_OFFSET: usize = 0;
const OVERWRITE_BASE_COLOR_OFFSET: usize = 16;
const OVERWRITE_MULTIPLIER_OFFSET: usize = 32;
const OVERWRITE_COLOR_OFFSETS_OFFSET: usize = 48;
const OVERWRITE_TRANSPARENT_GREEN_OFFSET: usize = 64;

/// The values `addOverwriteCase` pushes, one set per pixel of the 2x2 image.
fn overwrite_push_constants() -> [OverwritePushConstants; 4] {
    [
        OverwritePushConstants {
            coords: [0, 0, 0, 0],
            base_color: [1, 0, 0, 0],
            multiplier: [2, 2, 2, 2],
            color_offsets: [128, 129, 130, 131],
            transparent_green: [0, 1, 0, 0],
        },
        OverwritePushConstants {
            coords: [0, 1, 0, 0],
            base_color: [0, 1, 0, 0],
            multiplier: [4, 4, 4, 4],
            color_offsets: [132, 133, 134, 135],
            transparent_green: [0, 1, 0, 0],
        },
        OverwritePushConstants {
            coords: [1, 0, 0, 0],
            base_color: [0, 0, 1, 0],
            multiplier: [8, 8, 8, 8],
            color_offsets: [136, 137, 138, 139],
            transparent_green: [0, 1, 0, 0],
        },
        OverwritePushConstants {
            coords: [1, 1, 0, 0],
            base_color: [0, 0, 0, 1],
            multiplier: [16, 16, 16, 16],
            color_offsets: [140, 141, 142, 143],
            transparent_green: [0, 1, 0, 0],
        },
    ]
}

/// `OverwriteTestInstance::iterate`
#[allow(unused_assignments)]
fn run_overwrite(context: &Context<'_>, is_comp: bool) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let allocator = context.get_default_allocator();

    let stage_flags = if is_comp {
        vk::ShaderStageFlags::COMPUTE
    } else {
        vk::ShaderStageFlags::FRAGMENT
    };
    let write_stages = if is_comp {
        vk::PipelineStageFlags::COMPUTE_SHADER
    } else {
        vk::PipelineStageFlags::FRAGMENT_SHADER
    };
    let bind_point = if is_comp {
        vk::PipelineBindPoint::COMPUTE
    } else {
        vk::PipelineBindPoint::GRAPHICS
    };
    let image_format = vk::Format::R8G8B8A8_UINT;
    let image_extent = vk::Extent3D {
        width: 2,
        height: 2,
        depth: 1,
    };

    // Storage image.
    let image_info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(image_format)
        .extent(image_extent)
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_SRC)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    let storage_image = ImageWithMemory::new(device, allocator, image_info, MemoryRequirement::ANY)?;
    let subresource_range = color_subresource_range();
    let storage_image_view = make_image_view(
        device,
        storage_image.get(),
        vk::ImageViewType::_2D,
        image_format,
        subresource_range,
    )?;

    // Buffer to copy output pixels to.
    let buffer_size = (4 * image_extent.width * image_extent.height * image_extent.depth) as vk::DeviceSize;
    let transfer_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    // Descriptor set layout and pipeline layout.
    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, stage_flags)
        .build(device)?;
    let pipeline_layout = make_push_constant_layout(
        device,
        *descriptor_set_layout,
        vk::PushConstantRange {
            stage_flags,
            offset: 0,
            size: std::mem::size_of::<OverwritePushConstants>() as u32,
        },
    )?;

    // Descriptor pool and set.
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
    let descriptor_image_info = [vk::DescriptorImageInfo::builder()
        .sampler(vk::Sampler::null())
        .image_view(*storage_image_view)
        .image_layout(vk::ImageLayout::GENERAL)
        .build()];
    let write = vk::WriteDescriptorSet::builder()
        .dst_set(descriptor_set.get())
        .dst_binding(0)
        .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
        .image_info(&descriptor_image_info)
        .build();
    unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

    // Command pool and set.
    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    // Pipeline.
    let binaries = context.get_binary_collection();
    let (compute_module, _vertex_module, _fragment_module);
    let mut render_pass = None;
    let mut framebuffer = None;
    let pipeline;
    if is_comp {
        compute_module = Some(create_shader_module(device, binaries.get("comp")?)?);
        _vertex_module = None;
        _fragment_module = None;
        pipeline = make_compute_pipeline_for(device, *pipeline_layout, **compute_module.as_ref().unwrap())?;
    } else {
        compute_module = None;
        let vertex = create_shader_module(device, binaries.get("vert")?)?;
        let fragment = create_shader_module(device, binaries.get("frag")?)?;

        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .build()];
        let render_pass_info = vk::RenderPassCreateInfo::builder().subpasses(&subpasses);
        let created_render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );
        framebuffer = Some(make_framebuffer(
            device,
            *created_render_pass,
            &[],
            image_extent.width,
            image_extent.height,
            1,
        )?);

        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP)
            .with_full_viewport(image_extent.width, image_extent.height);
        state.color_attachment_count = 0;
        pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            *created_render_pass,
            &[(STAGE_V, *vertex), (STAGE_F, *fragment)],
            &state,
        )?;
        render_pass = Some(created_render_pass);
        _vertex_module = Some(vertex);
        _fragment_module = Some(fragment);
    }

    // Offsets and sizes: push members doing some back-and-forth in the range.
    let push_members = [
        (OVERWRITE_BASE_COLOR_OFFSET, 16usize),
        (OVERWRITE_COORDS_OFFSET, 16),
        (OVERWRITE_COLOR_OFFSETS_OFFSET, 16),
        (OVERWRITE_MULTIPLIER_OFFSET, 16),
        (OVERWRITE_TRANSPARENT_GREEN_OFFSET, 16),
    ];

    begin_command_buffer(device, cmd)?;

    // Transition layout for storage image.
    let pre_image_barrier = make_image_memory_barrier(
        vk::AccessFlags::empty(),
        vk::AccessFlags::SHADER_WRITE,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::GENERAL,
        storage_image.get(),
        subresource_range,
    );
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            write_stages,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[pre_image_barrier],
        );
        device.cmd_bind_descriptor_sets(
            cmd,
            bind_point,
            *pipeline_layout,
            0,
            &[descriptor_set.get()],
            &[] as &[u32],
        );
        device.cmd_bind_pipeline(cmd, bind_point, pipeline.get());
    }

    if let (Some(render_pass), Some(framebuffer)) = (&render_pass, &framebuffer) {
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(**render_pass)
            .framebuffer(**framebuffer)
            .render_area(rect_2d(image_extent.width, image_extent.height));
        unsafe { device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE) };
    }

    let push_constant_values = overwrite_push_constants();
    for pc in &push_constant_values {
        // Push all structure members separately.
        let pc_bytes = as_bytes(std::slice::from_ref(pc));
        for &(offset, size) in &push_members {
            unsafe {
                device.cmd_push_constants(
                    cmd,
                    *pipeline_layout,
                    stage_flags,
                    offset as u32,
                    &pc_bytes[offset..offset + size],
                )
            };
        }

        // Draw or dispatch.
        unsafe {
            if is_comp {
                device.cmd_dispatch(cmd, 1, 1, 1);
            } else {
                device.cmd_draw(cmd, 4, 1, 0, 0);
            }
        }
    }

    if !is_comp {
        unsafe { device.cmd_end_render_pass(cmd) };
    }

    // Copy storage image to output buffer.
    let post_image_barrier = make_image_memory_barrier(
        vk::AccessFlags::SHADER_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        vk::ImageLayout::GENERAL,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        storage_image.get(),
        subresource_range,
    );
    let copy_region = vk::BufferImageCopy {
        buffer_offset: 0,
        buffer_row_length: 0,
        buffer_image_height: 0,
        image_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
        image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
        image_extent,
    };
    let buffer_barrier = make_buffer_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::HOST_READ,
        transfer_buffer.get(),
        0,
        buffer_size,
    );
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            write_stages,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[post_image_barrier],
        );
        device.cmd_copy_image_to_buffer(
            cmd,
            storage_image.get(),
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            transfer_buffer.get(),
            &[copy_region],
        );
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[buffer_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    // Verify output colors match.
    invalidate_alloc(device, transfer_buffer.get_allocation())?;
    let output =
        unsafe { std::slice::from_raw_parts(transfer_buffer.get_allocation().get_host_ptr(), buffer_size as usize) };

    for pc in &push_constant_values {
        let expected_value: [u32; 4] = std::array::from_fn(|i| {
            pc.base_color[i] * pc.multiplier[i] + pc.color_offsets[i] + pc.transparent_green[i]
        });
        let pixel_offset = (pc.coords[1] as usize * image_extent.width as usize + pc.coords[0] as usize) * 4;
        let output_value: [u32; 4] = std::array::from_fn(|i| output[pixel_offset + i] as u32);

        if expected_value != output_value {
            return Err(TestError::Fail(format!(
                "Unexpected value in output image at coords ({}, {}): found {:?} and expected {:?}",
                pc.coords[0], pc.coords[1], output_value, expected_value
            )));
        }
    }

    Ok(TestStatus::pass("Pass"))
}

// =================================================================================
// Lifetime: PushConstantLifetimeTest
// =================================================================================

#[derive(Clone, Copy, PartialEq, Eq)]
enum Cmd {
    BindPipelineGraphics,
    BindPipelineCompute,
    PushConstant,
    Draw,
    Dispatch,
}

#[derive(Clone)]
struct LifetimeCase {
    ranges: [PushConstantData; 2],
    cmd_list: Vec<(Cmd, usize)>,
}

/// `PushConstantLifetimeTestInstance::init` and `iterate`
fn run_lifetime(context: &Context<'_>, case: &LifetimeCase) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let allocator = context.get_default_allocator();
    let queue_family_index = context.get_universal_queue_family_index();

    // Create color image, its view, the render pass and the framebuffer
    let color_image = make_color_image(context)?;
    let color_attachment_view = make_image_view(
        device,
        color_image.get(),
        vk::ImageViewType::_2D,
        COLOR_FORMAT,
        color_subresource_range(),
    )?;
    let attachment = vk::AttachmentDescription::builder()
        .format(COLOR_FORMAT)
        .samples(vk::SampleCountFlags::_1)
        .load_op(vk::AttachmentLoadOp::CLEAR)
        .store_op(vk::AttachmentStoreOp::STORE)
        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
        .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
        .initial_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .build();
    let attachments = [attachment];
    let attachment_reference = [vk::AttachmentReference {
        attachment: 0,
        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    }];
    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&attachment_reference)
        .build()];
    let render_pass_info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses);
    let render_pass = Unique::new(
        device,
        unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
    );
    let framebuffer = make_framebuffer(
        device,
        *render_pass,
        &[*color_attachment_view],
        RENDER_SIZE,
        RENDER_SIZE,
        1,
    )?;

    // Create data for pipeline layout
    let buffer_size = (std::mem::size_of::<[f32; 4]>() * 8) as vk::DeviceSize;
    let (out_buffer, descriptor_set_layout, _descriptor_pool, descriptor_set) =
        make_storage_buffer_descriptor(device, allocator, buffer_size)?;

    let pipeline_layouts = [
        make_push_constant_layout(
            device,
            *descriptor_set_layout,
            vk::PushConstantRange {
                stage_flags: case.ranges[0].stage_flags,
                offset: case.ranges[0].offset,
                size: case.ranges[0].size,
            },
        )?,
        make_push_constant_layout(
            device,
            *descriptor_set_layout,
            vk::PushConstantRange {
                stage_flags: case.ranges[1].stage_flags,
                offset: case.ranges[1].offset,
                size: case.ranges[1].size,
            },
        )?,
    ];

    let binaries = context.get_binary_collection();
    let vertex_module = create_shader_module(device, binaries.get("color_vert_lt")?)?;
    let fragment_module = create_shader_module(device, binaries.get("color_frag_lt")?)?;

    // Create graphics pipelines
    let state = vertex_input_state(
        DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(RENDER_SIZE, RENDER_SIZE),
    );
    let graphics_pipelines = [
        create_draw_pipeline(
            device,
            *pipeline_layouts[0],
            *render_pass,
            &[(STAGE_V, *vertex_module), (STAGE_F, *fragment_module)],
            &state,
        )?,
        create_draw_pipeline(
            device,
            *pipeline_layouts[1],
            *render_pass,
            &[(STAGE_V, *vertex_module), (STAGE_F, *fragment_module)],
            &state,
        )?,
    ];

    // Create vertex buffer
    let vertices = create_quad(1.0, [1.0, 0.0, 1.0, 1.0]);
    let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

    // Create compute pipelines
    let compute_module = create_shader_module(device, binaries.get("compute_lt")?)?;
    let mut compute_pipelines: [Option<Unique<'_, vk::Pipeline>>; 2] = [None, None];
    for (ndx, compute_pipeline) in compute_pipelines.iter_mut().enumerate() {
        if case.ranges[ndx].stage_flags.intersects(STAGE_COMPUTE) {
            *compute_pipeline = Some(make_compute_pipeline_for(
                device,
                *pipeline_layouts[ndx],
                *compute_module,
            )?);
        }
    }

    // Create command buffer
    let cmd_pool = make_command_pool(device, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let mut verify_graphics = false;
    let mut verify_compute = false;

    // Set push constant value
    let value = [[0.25f32, 0.75, 0.75, 1.0], [0.25, 0.75, 0.75, 1.0]];
    let clear_values = [vk::ClearValue {
        color: vk::ClearColorValue { float32: CLEAR_COLOR },
    }];

    begin_command_buffer(device, cmd)?;

    let mut in_proper_layout = false;
    for &(cmd_type, range_ndx) in &case.cmd_list {
        match cmd_type {
            Cmd::PushConstant => {
                let range = &case.ranges[range_ndx];
                push_constants(
                    device,
                    cmd,
                    *pipeline_layouts[range_ndx],
                    range.stage_flags,
                    range.offset,
                    range.size,
                    as_bytes(&value),
                    false,
                );
            }
            Cmd::BindPipelineCompute => unsafe {
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::COMPUTE,
                    *pipeline_layouts[range_ndx],
                    0,
                    &[descriptor_set.get()],
                    &[] as &[u32],
                );
                device.cmd_bind_pipeline(
                    cmd,
                    vk::PipelineBindPoint::COMPUTE,
                    compute_pipelines[range_ndx]
                        .as_ref()
                        .map_or(vk::Pipeline::null(), |pipeline| pipeline.get()),
                );
            },
            Cmd::BindPipelineGraphics => unsafe {
                device.cmd_bind_pipeline(
                    cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    graphics_pipelines[range_ndx].get(),
                );
            },
            Cmd::Draw => {
                let (src_access_mask, old_layout, src_stage) = if in_proper_layout {
                    (
                        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    )
                } else {
                    (
                        vk::AccessFlags::empty(),
                        vk::ImageLayout::UNDEFINED,
                        vk::PipelineStageFlags::TOP_OF_PIPE,
                    )
                };

                let pre_pass_barrier = make_image_memory_barrier(
                    src_access_mask,
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    old_layout,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    color_image.get(),
                    color_subresource_range(),
                );
                unsafe {
                    device.cmd_pipeline_barrier(
                        cmd,
                        src_stage,
                        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[pre_pass_barrier],
                    );
                }

                in_proper_layout = true;

                let begin_info = vk::RenderPassBeginInfo::builder()
                    .render_pass(*render_pass)
                    .framebuffer(*framebuffer)
                    .render_area(rect_2d(RENDER_SIZE, RENDER_SIZE))
                    .clear_values(&clear_values);
                unsafe {
                    device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
                    device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
                    device.cmd_draw(cmd, vertices.len() as u32, 1, 0, 0);
                    device.cmd_end_render_pass(cmd);
                }

                let post_pass_barrier = make_image_memory_barrier(
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    color_image.get(),
                    color_subresource_range(),
                );
                unsafe {
                    device.cmd_pipeline_barrier(
                        cmd,
                        vk::PipelineStageFlags::ALL_GRAPHICS,
                        vk::PipelineStageFlags::TRANSFER,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[post_pass_barrier],
                    );
                }

                verify_graphics = true;
            }
            Cmd::Dispatch => {
                unsafe { device.cmd_dispatch(cmd, 8, 1, 1) };
                compute_to_host_barrier(device, cmd, out_buffer.get());
                verify_compute = true;
            }
        }
    }

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    // verify: the reference is the quad's own colour, which the push constants leave unchanged once clamped
    let mut graphics_ok = !verify_graphics;
    let mut compute_ok = !verify_compute;

    if verify_graphics {
        let reference = render_reference(1.0, [[1.0, 0.0, 1.0, 1.0]; TRIANGLE_COUNT]);
        let result = read_color_attachment(context, color_image.get())?;
        graphics_ok = matches_with_position_deviation(&result, &reference);
    }

    if verify_compute {
        invalidate_alloc(device, out_buffer.get_allocation())?;
        let expect_value = [value[0]; 8];
        let result =
            unsafe { std::slice::from_raw_parts(out_buffer.get_allocation().get_host_ptr(), buffer_size as usize) };
        compute_ok = result == as_bytes(&expect_value);
    }

    if !graphics_ok {
        return Ok(TestStatus::fail("Image mismatch"));
    }

    if !compute_ok {
        return Ok(TestStatus::fail("Wrong output value"));
    }

    Ok(TestStatus::pass("Result image matches reference"))
}

// =================================================================================
// Registration
// =================================================================================

enum Kind {
    Graphics(GraphicsCase),
    Compute { uninitialized: bool },
    Overwrite { compute: bool },
    Lifetime(LifetimeCase),
}

struct PushConstantCase {
    name: String,
    kind: Kind,
    programs: BinaryCollection,
}

impl TestCase for PushConstantCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        match &self.kind {
            Kind::Graphics(case) => case.check_support(context),
            // `PushConstantComputeTest::checkSupport`
            Kind::Compute { uninitialized: true } => context.require_device_functionality("VK_KHR_maintenance4"),
            Kind::Compute { uninitialized: false } | Kind::Overwrite { .. } | Kind::Lifetime(_) => Ok(()),
        }
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(PushConstantInstance { context, case: self })
    }
}

struct PushConstantInstance<'a> {
    context: &'a Context<'a>,
    case: &'a PushConstantCase,
}

impl TestInstance for PushConstantInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match &self.case.kind {
            Kind::Graphics(case) => run_graphics(self.context, case),
            Kind::Compute { uninitialized } => run_compute(self.context, *uninitialized),
            Kind::Overwrite { compute } => run_overwrite(self.context, *compute),
            Kind::Lifetime(case) => run_lifetime(self.context, case),
        }
    }
}

/// The programs of the graphics case with this name; the `_command2` variants share them.
fn graphics_programs(name: &str) -> BinaryCollection {
    match name {
        "range_size_4" => PC_RANGE_SIZE_4.programs,
        "range_size_16" => PC_RANGE_SIZE_16.programs,
        "range_size_128" => PC_RANGE_SIZE_128.programs,
        "range_size_256" => PC_RANGE_SIZE_256.programs,
        "range_size_128_longvec" => PC_RANGE_SIZE_128_LONGVEC.programs,
        "range_size_256_longvec" => PC_RANGE_SIZE_256_LONGVEC.programs,
        "range_size_max" => PC_RANGE_SIZE_MAX.programs,
        "count_2_shaders_vert_frag" => PC_COUNT_2_SHADERS_VERT_FRAG.programs,
        "count_3_shaders_vert_geom_frag" => PC_COUNT_3_SHADERS_VERT_GEOM_FRAG.programs,
        "count_5_shaders_vert_tess_geom_frag" => PC_COUNT_5_SHADERS_VERT_TESS_GEOM_FRAG.programs,
        "count_1_shader_vert_frag" => PC_COUNT_1_SHADER_VERT_FRAG.programs,
        "data_update_partial_1" => PC_DATA_UPDATE_PARTIAL_1.programs,
        "data_update_partial_2" => PC_DATA_UPDATE_PARTIAL_2.programs,
        "data_update_multiple" => PC_DATA_UPDATE_MULTIPLE.programs,
        "dynamic_index_vert" => PC_DYNAMIC_INDEX_VERT.programs,
        "dynamic_index_frag" => PC_DYNAMIC_INDEX_FRAG.programs,
        "overlap_2_shaders_vert_frag" => PC_OVERLAP_2_SHADERS_VERT_FRAG.programs,
        "overlap_3_shaders_vert_geom_frag" => PC_OVERLAP_3_SHADERS_VERT_GEOM_FRAG.programs,
        "overlap_4_shaders_vert_tess_frag" => PC_OVERLAP_4_SHADERS_VERT_TESS_FRAG.programs,
        "overlap_5_shaders_vert_tess_geom_frag" => PC_OVERLAP_5_SHADERS_VERT_TESS_GEOM_FRAG.programs,
        "unused_disjoint_1" => PC_UNUSED_DISJOINT_1.programs,
        "unused_disjoint_2" => PC_UNUSED_DISJOINT_2.programs,
        "unused_disjoint_3" => PC_UNUSED_DISJOINT_3.programs,
        "unused_disjoint_4" => PC_UNUSED_DISJOINT_4.programs,
        "unused_disjoint_5" => PC_UNUSED_DISJOINT_5.programs,
        "unused_disjoint_6" => PC_UNUSED_DISJOINT_6.programs,
        "unused_overlap_1" => PC_UNUSED_OVERLAP_1.programs,
        "unused_overlap_2" => PC_UNUSED_OVERLAP_2.programs,
        "unused_overlap_3" => PC_UNUSED_OVERLAP_3.programs,
        "unused_overlap_4" => PC_UNUSED_OVERLAP_4.programs,
        "unused_overlap_5" => PC_UNUSED_OVERLAP_5.programs,
        _ => PC_UNUSED_OVERLAP_6.programs,
    }
}

fn graphics_case(base_name: &str, name: String, case: GraphicsCase) -> Box<dyn TestCase> {
    Box::new(PushConstantCase {
        name,
        kind: Kind::Graphics(case),
        programs: graphics_programs(base_name),
    })
}

fn disjoint(
    ranges: Vec<PushConstantData>,
    multiple_update: bool,
    index_type: IndexType,
    push_constant2: bool,
    pc_used_stage: vk::ShaderStageFlags,
) -> GraphicsCase {
    let size_queried_from_device = ranges[0].size == 0xFFFF;
    GraphicsCase {
        ranges,
        multiple_update,
        index_type,
        push_constant2,
        pc_used_stage,
        size_queried_from_device,
        overlap: false,
    }
}

fn overlap(ranges: Vec<PushConstantData>, push_constant2: bool, pc_used_stage: vk::ShaderStageFlags) -> GraphicsCase {
    GraphicsCase {
        ranges,
        multiple_update: false,
        index_type: IndexType::ConstLiteral,
        push_constant2,
        pc_used_stage,
        size_queried_from_device: false,
        overlap: true,
    }
}

/// `graphicsParams`
fn disjoint_graphics_params() -> Vec<(&'static str, Vec<PushConstantData>, bool, IndexType)> {
    let const_literal = IndexType::ConstLiteral;
    let dynamic = IndexType::DynamicallyUniformExpr;
    let long_vec = |size: u32| PushConstantData {
        long_vec: true,
        ..full(STAGE_V, 0, size)
    };
    vec![
        // test range size is 4 bytes(minimum valid size)
        ("range_size_4", vec![full(STAGE_V, 0, 4)], false, const_literal),
        // test range size is 16 bytes, and together with a normal uniform
        ("range_size_16", vec![full(STAGE_V, 0, 16)], false, const_literal),
        // test range size is 128 bytes(maximum valid size in Vulkan 1.3)
        ("range_size_128", vec![full(STAGE_V, 0, 128)], false, const_literal),
        // test range size is 256 bytes(maximum valid size in Vulkan 1.4)
        ("range_size_256", vec![full(STAGE_V, 0, 256)], false, const_literal),
        // the same two sizes with the long vector type
        ("range_size_128_longvec", vec![long_vec(128)], false, const_literal),
        ("range_size_256_longvec", vec![long_vec(256)], false, const_literal),
        // test range size is max bytes queried from driver and will be overwritten
        ("range_size_max", vec![full(STAGE_V, 0, 0xFFFF)], false, const_literal),
        // test range count, including all valid shader stage in graphics pipeline, and also multiple shader stages share one single range
        (
            "count_2_shaders_vert_frag",
            vec![full(STAGE_V, 0, 16), full(STAGE_F, 16, 4)],
            false,
            const_literal,
        ),
        // test range count is 3, use vertex, geometry and fragment shaders
        (
            "count_3_shaders_vert_geom_frag",
            vec![full(STAGE_V, 0, 16), full(STAGE_F, 16, 4), full(STAGE_G, 20, 4)],
            false,
            const_literal,
        ),
        // test range count is 5, use vertex, tessellation, geometry and fragment shaders
        (
            "count_5_shaders_vert_tess_geom_frag",
            vec![
                full(STAGE_V, 0, 16),
                full(STAGE_F, 16, 4),
                full(STAGE_G, 20, 4),
                full(STAGE_C, 24, 4),
                full(STAGE_E, 32, 16),
            ],
            false,
            const_literal,
        ),
        // test range count is 1, vertex and fragment shaders share one range
        (
            "count_1_shader_vert_frag",
            vec![full(STAGE_V | STAGE_F, 0, 4)],
            false,
            const_literal,
        ),
        // test data partial update and multiple times update
        (
            "data_update_partial_1",
            vec![partial(STAGE_V, 0, 32, 4, 24)],
            false,
            const_literal,
        ),
        // test partial update of the values
        (
            "data_update_partial_2",
            vec![partial(STAGE_V, 0, 48, 32, 16)],
            false,
            const_literal,
        ),
        // test multiple times update of the values
        ("data_update_multiple", vec![full(STAGE_V, 0, 4)], true, const_literal),
        // dynamically uniform indexing of vertex, matrix, and array in vertex shader
        ("dynamic_index_vert", vec![full(STAGE_V, 0, 64)], false, dynamic),
        // dynamically uniform indexing of vertex, matrix, and array in fragment shader
        (
            "dynamic_index_frag",
            vec![full(STAGE_V | STAGE_F, 0, 64)],
            false,
            dynamic,
        ),
    ]
}

fn overlap_2_ranges() -> Vec<PushConstantData> {
    vec![full(STAGE_V, 0, 16), full(STAGE_F, 12, 36)]
}

fn overlap_3_ranges() -> Vec<PushConstantData> {
    vec![
        full(STAGE_V, 12, 36),
        partial(STAGE_G, 0, 32, 16, 16),
        full(STAGE_F, 20, 4),
    ]
}

fn overlap_4_ranges() -> Vec<PushConstantData> {
    vec![
        full(STAGE_V, 8, 4),
        partial(STAGE_C, 0, 128, 52, 76),
        full(STAGE_E, 56, 8),
        full(STAGE_F, 60, 36),
    ]
}

fn overlap_5_ranges() -> Vec<PushConstantData> {
    vec![
        full(STAGE_V, 40, 8),
        full(STAGE_C, 32, 12),
        full(STAGE_E, 48, 16),
        full(STAGE_G, 28, 36),
        partial(STAGE_F, 56, 8, 60, 4),
    ]
}

/// `overlapGraphicsParams`
fn overlap_graphics_params() -> Vec<(&'static str, Vec<PushConstantData>)> {
    vec![
        // overlapping range count is 2, use vertex and fragment shaders
        ("overlap_2_shaders_vert_frag", overlap_2_ranges()),
        // overlapping range count is 3, use vertex, geometry and fragment shaders
        ("overlap_3_shaders_vert_geom_frag", overlap_3_ranges()),
        // overlapping range count is 4, use vertex, tessellation and fragment shaders
        ("overlap_4_shaders_vert_tess_frag", overlap_4_ranges()),
        // overlapping range count is 5, use vertex, tessellation, geometry and fragment shaders
        ("overlap_5_shaders_vert_tess_geom_frag", overlap_5_ranges()),
    ]
}

/// `unusedDisjointPCTestParams`: push constants that are specified in the pipeline layout but not used in the shaders.
fn unused_disjoint_params() -> Vec<(&'static str, Vec<PushConstantData>, vk::ShaderStageFlags)> {
    let vfg = || vec![full(STAGE_V, 0, 16), full(STAGE_F, 16, 4), full(STAGE_G, 20, 4)];
    let vfgce = || {
        vec![
            full(STAGE_V, 0, 16),
            full(STAGE_F, 16, 4),
            full(STAGE_G, 20, 4),
            full(STAGE_C, 24, 4),
            full(STAGE_E, 32, 16),
        ]
    };
    vec![
        // no shader stage using push constants
        (
            "unused_disjoint_1",
            vec![full(STAGE_V, 0, 4)],
            vk::ShaderStageFlags::empty(),
        ),
        // vertex shader using push constants, fragment shader not using push constants
        (
            "unused_disjoint_2",
            vec![full(STAGE_V, 0, 16), full(STAGE_F, 16, 4)],
            STAGE_V,
        ),
        // no shader stage using push constants
        ("unused_disjoint_3", vfg(), vk::ShaderStageFlags::empty()),
        // geometry shader using push constants, vertex and fragment shader not using push constants
        ("unused_disjoint_4", vfg(), STAGE_G),
        // no shader stage using push constants
        ("unused_disjoint_5", vfgce(), vk::ShaderStageFlags::empty()),
        // tess shader stages using push constants, vertex, geometry and fragment shader not using push constants
        ("unused_disjoint_6", vfgce(), STAGE_C | STAGE_E),
    ]
}

/// `unusedOverlapPCTestParams`
fn unused_overlap_params() -> Vec<(&'static str, Vec<PushConstantData>, vk::ShaderStageFlags)> {
    vec![
        ("unused_overlap_1", overlap_2_ranges(), vk::ShaderStageFlags::empty()),
        ("unused_overlap_2", overlap_2_ranges(), STAGE_V),
        ("unused_overlap_3", overlap_3_ranges(), vk::ShaderStageFlags::empty()),
        ("unused_overlap_4", overlap_3_ranges(), STAGE_G),
        ("unused_overlap_5", overlap_5_ranges(), vk::ShaderStageFlags::empty()),
        ("unused_overlap_6", overlap_5_ranges(), STAGE_C | STAGE_E),
    ]
}

/// `lifetimeParams`
fn lifetime_params() -> Vec<(&'static str, [PushConstantData; 2], Vec<(Cmd, usize)>)> {
    let same_range = [full(STAGE_V, 0, 32), full(STAGE_V, 0, 32)];
    let overlapping_ranges = [full(STAGE_V, 0, 32), full(STAGE_V, 16, 32)];
    let vert_and_comp_same = [
        full(STAGE_V | STAGE_COMPUTE, 0, 32),
        full(STAGE_V | STAGE_COMPUTE, 0, 32),
    ];
    let vert_and_comp_overlapping = [
        full(STAGE_V | STAGE_COMPUTE, 0, 32),
        full(STAGE_V | STAGE_COMPUTE, 16, 32),
    ];
    vec![
        // bind different layout with the same range
        (
            "push_range0_bind_layout1",
            same_range,
            vec![(Cmd::PushConstant, 0), (Cmd::BindPipelineGraphics, 1), (Cmd::Draw, 0)],
        ),
        // bind layout with same range then push different range
        (
            "push_range1_bind_layout1_push_range0",
            same_range,
            vec![
                (Cmd::PushConstant, 1),
                (Cmd::BindPipelineGraphics, 1),
                (Cmd::Draw, 0),
                (Cmd::PushConstant, 0),
                (Cmd::Draw, 0),
            ],
        ),
        // same range same layout then same range from a different layout and same range from the same layout
        (
            "push_range0_bind_layout0_push_range1_push_range0",
            same_range,
            vec![
                (Cmd::PushConstant, 0),
                (Cmd::BindPipelineGraphics, 0),
                (Cmd::PushConstant, 1),
                (Cmd::PushConstant, 0),
                (Cmd::Draw, 0),
            ],
        ),
        // same range same layout then diff range and same range update
        (
            "push_range0_bind_layout0_push_diff_overlapping_range1_push_range0",
            overlapping_ranges,
            vec![
                (Cmd::PushConstant, 0),
                (Cmd::BindPipelineGraphics, 0),
                (Cmd::PushConstant, 1),
                (Cmd::PushConstant, 0),
                (Cmd::Draw, 0),
            ],
        ),
        // update push constant bind different layout with the same range then bind correct layout
        (
            "push_range0_bind_layout1_bind_layout0",
            same_range,
            vec![
                (Cmd::PushConstant, 0),
                (Cmd::BindPipelineGraphics, 1),
                (Cmd::BindPipelineGraphics, 0),
                (Cmd::Draw, 0),
            ],
        ),
        // update push constant then bind different layout with overlapping range then bind correct layout
        (
            "push_range0_bind_layout1_overlapping_range_bind_layout0",
            overlapping_ranges,
            vec![
                (Cmd::PushConstant, 0),
                (Cmd::BindPipelineGraphics, 1),
                (Cmd::BindPipelineGraphics, 0),
                (Cmd::Draw, 0),
            ],
        ),
        // bind different layout with different range then update push constant and bind correct layout
        (
            "bind_layout1_push_range0_bind_layout0",
            overlapping_ranges,
            vec![
                (Cmd::BindPipelineGraphics, 1),
                (Cmd::PushConstant, 0),
                (Cmd::BindPipelineGraphics, 0),
                (Cmd::Draw, 0),
            ],
        ),
        // change pipeline same range, bind then push, stages vertex and compute
        (
            "pipeline_change_same_range_bind_push_vert_and_comp",
            vert_and_comp_same,
            vec![
                (Cmd::BindPipelineGraphics, 0),
                (Cmd::BindPipelineCompute, 1),
                (Cmd::PushConstant, 0),
                (Cmd::Draw, 0),
                (Cmd::PushConstant, 1),
                (Cmd::Dispatch, 0),
            ],
        ),
        // change pipeline different range overlapping, bind then push, stages vertex and compute
        (
            "pipeline_change_diff_range_bind_push_vert_and_comp",
            vert_and_comp_overlapping,
            vec![
                (Cmd::BindPipelineGraphics, 0),
                (Cmd::BindPipelineCompute, 1),
                (Cmd::PushConstant, 0),
                (Cmd::Draw, 0),
                (Cmd::PushConstant, 1),
                (Cmd::Dispatch, 0),
            ],
        ),
    ]
}

/// `createPushConstantTests`
pub fn create_push_constant_tests() -> TestCaseGroup {
    create_push_constant_tests_for(false)
}

/// The shader object types have the graphics group without `overwrite` (no colour attachment) and no compute or lifetime group.
pub fn create_push_constant_tests_for(shader_object: bool) -> TestCaseGroup {
    let mut push_constant_tests = TestCaseGroup::new("push_constant");

    let mut graphics_tests = TestCaseGroup::new("graphics_pipeline");
    for push_constant2 in [false, true] {
        let suffix = if push_constant2 { "_command2" } else { "" };
        for (name, ranges, multiple_update, index_type) in disjoint_graphics_params() {
            graphics_tests.add_child(graphics_case(
                name,
                format!("{name}{suffix}"),
                disjoint(
                    ranges,
                    multiple_update,
                    index_type,
                    push_constant2,
                    vk::ShaderStageFlags::ALL,
                ),
            ));
        }

        for (name, ranges) in overlap_graphics_params() {
            graphics_tests.add_child(graphics_case(
                name,
                format!("{name}{suffix}"),
                overlap(ranges, push_constant2, vk::ShaderStageFlags::ALL),
            ));
        }
    }
    if !shader_object {
        graphics_tests.add_child(Box::new(PushConstantCase {
            name: "overwrite".to_string(),
            kind: Kind::Overwrite { compute: false },
            programs: PC_OVERWRITE_GRAPHICS.programs,
        }) as Box<dyn TestCase>);
    }

    // tests for unused push constants: push constants that are specified in pipeline layout but not used in shaders
    for (name, ranges, pc_used_stages) in unused_disjoint_params() {
        graphics_tests.add_child(graphics_case(
            name,
            name.to_string(),
            disjoint(ranges, false, IndexType::ConstLiteral, false, pc_used_stages),
        ));
    }
    for (name, ranges, pc_used_stages) in unused_overlap_params() {
        graphics_tests.add_child(graphics_case(
            name,
            name.to_string(),
            overlap(ranges, false, pc_used_stages),
        ));
    }
    push_constant_tests.add_child(graphics_tests);
    if shader_object {
        return push_constant_tests;
    }

    let mut compute_tests = TestCaseGroup::new("compute_pipeline");
    // test compute pipeline
    compute_tests.add_child(Box::new(PushConstantCase {
        name: "simple_test".to_string(),
        kind: Kind::Compute { uninitialized: false },
        programs: PC_COMPUTE.programs,
    }) as Box<dyn TestCase>);
    // test push constant that is dynamically unused
    compute_tests.add_child(Box::new(PushConstantCase {
        name: "uninitialized".to_string(),
        kind: Kind::Compute { uninitialized: true },
        programs: PC_COMPUTE.programs,
    }) as Box<dyn TestCase>);
    compute_tests.add_child(Box::new(PushConstantCase {
        name: "overwrite".to_string(),
        kind: Kind::Overwrite { compute: true },
        programs: PC_OVERWRITE_COMPUTE.programs,
    }) as Box<dyn TestCase>);
    push_constant_tests.add_child(compute_tests);

    let mut lifetime_tests = TestCaseGroup::new("lifetime");
    for (name, ranges, cmd_list) in lifetime_params() {
        lifetime_tests.add_child(Box::new(PushConstantCase {
            name: name.to_string(),
            kind: Kind::Lifetime(LifetimeCase { ranges, cmd_list }),
            programs: PC_LIFETIME.programs,
        }) as Box<dyn TestCase>);
    }
    push_constant_tests.add_child(lifetime_tests);

    push_constant_tests
}
