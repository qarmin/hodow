// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/mesh_shader/vktMeshShaderMiscTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders each family formats at run time are written out in the manifest by
// scripts/gen_mesh_shader_nv_misc.py. `MeshShaderMiscCase`/`MeshShaderMiscInstance` become one drawing function (`draw_misc`) that
// returns the image, and each family supplies its reference image, as in misc_tests.rs.
//
// Families in this file so far: complex_task_data, single_point, single_line, single_triangle, max_points, max_lines, max_triangles,
// many_task_work_groups, many_mesh_work_groups, many_task_mesh_work_groups, no_points/lines/triangles (with and without extra
// writes), barrier_in_task/mesh, the memory_barrier_shared/group_memory_barrier cases, custom_attributes, push_constant and
// maximize_*. Not ported yet: mixed_pipelines (in_out is in_out_nv_tests.rs).

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::NvMeshShaderExtensionDeviceCommands;

use crate::generated::shaders::mesh_shader_nv_misc::{
    NV_MISC_BARRIER_IN_MESH, NV_MISC_BARRIER_IN_TASK, NV_MISC_COMPLEX_TASK_DATA, NV_MISC_CUSTOM_ATTRIBUTES,
    NV_MISC_CUSTOM_ATTRIBUTES_AND_TASK_SHADER, NV_MISC_GROUP_MEMORY_BARRIER_IN_MESH,
    NV_MISC_GROUP_MEMORY_BARRIER_IN_TASK, NV_MISC_MANY_MESH_WORK_GROUPS, NV_MISC_MANY_TASK_MESH_WORK_GROUPS,
    NV_MISC_MANY_TASK_WORK_GROUPS, NV_MISC_MAX_LINES, NV_MISC_MAX_POINTS, NV_MISC_MAX_TRIANGLES,
    NV_MISC_MAXIMIZE_INVOCATIONS_32, NV_MISC_MAXIMIZE_INVOCATIONS_64, NV_MISC_MAXIMIZE_INVOCATIONS_128,
    NV_MISC_MAXIMIZE_INVOCATIONS_256, NV_MISC_MAXIMIZE_PRIMITIVES, NV_MISC_MAXIMIZE_VERTICES,
    NV_MISC_MEMORY_BARRIER_SHARED_IN_MESH, NV_MISC_MEMORY_BARRIER_SHARED_IN_TASK, NV_MISC_NO_LINES,
    NV_MISC_NO_LINES_EXTRA_WRITES, NV_MISC_NO_POINTS, NV_MISC_NO_POINTS_EXTRA_WRITES, NV_MISC_NO_TRIANGLES,
    NV_MISC_NO_TRIANGLES_EXTRA_WRITES, NV_MISC_PUSH_CONSTANT, NV_MISC_PUSH_CONSTANT_AND_TASK_SHADER,
    NV_MISC_SINGLE_LINE, NV_MISC_SINGLE_POINT, NV_MISC_SINGLE_TRIANGLE,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_framebuffer, make_memory_barrier, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_value_color, create_draw_pipeline, rect_2d, viewport};
use crate::vkt::tests::mesh_shader::misc_tests::custom_attributes_data;
use crate::vkt::tests::mesh_shader::util::{check_task_mesh_shader_support_nv, mesh_shader_properties_nv};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

type Color = [f32; 4];

const OUTPUT_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

fn to_bytes(color: Color) -> [u8; 4] {
    color.map(|c| (c * 255.0 + 0.5).floor() as u8)
}

/// `MiscTestParams`
#[derive(Clone, Copy)]
struct MiscParams {
    task_count: Option<u32>,
    mesh_count: u32,
    width: u32,
    height: u32,
    push_constants: bool,
    custom_attributes: bool,
    /// `MaximizeThreadsParams`: the local size, the number of vertices and the number of primitives
    maximize: Option<(u32, u32, u32)>,
}

impl MiscParams {
    fn new(task_count: Option<u32>, mesh_count: u32, width: u32, height: u32) -> Self {
        Self {
            task_count,
            mesh_count,
            width,
            height,
            push_constants: false,
            custom_attributes: false,
            maximize: None,
        }
    }

    fn with_push_constants(mut self) -> Self {
        self.push_constants = true;
        self
    }

    fn with_custom_attributes(mut self) -> Self {
        self.custom_attributes = true;
        self
    }

    fn with_maximize(mut self, local_size: u32, num_vertices: u32, num_primitives: u32) -> Self {
        self.maximize = Some((local_size, num_vertices, num_primitives));
        self
    }

    fn needs_task_shader(&self) -> bool {
        self.task_count.is_some()
    }

    fn draw_count(&self) -> u32 {
        self.task_count.unwrap_or(self.mesh_count)
    }
}

/// `genericCheckSupport`
fn generic_check_support(
    context: &Context<'_>,
    require_task_shader: bool,
    require_vertex_stores: bool,
) -> Result<(), TestError> {
    check_task_mesh_shader_support_nv(context, require_task_shader, true)?;

    if require_vertex_stores && context.get_device_features().vertex_pipeline_stores_and_atomics == vk::FALSE {
        return Err(TestError::NotSupported(
            "Requested core feature is not supported: vertexPipelineStoresAndAtomics".to_string(),
        ));
    }

    Ok(())
}

/// The image `generateReferenceLevel` builds, as unorm bytes.
enum Reference {
    Solid(Color),
    Image(Vec<[u8; 4]>),
    /// Any of these is a valid result (`MemoryBarrierInstance::verifyResult`).
    AnyOf(Vec<Reference>),
}

impl Reference {
    /// `MeshShaderMiscInstance::verifyResult`: floatThresholdCompare with a threshold of 0.005, i.e. one step of the 8-bit format.
    fn verify(&self, result: &[u8]) -> Result<(), TestError> {
        let matches = |pixel: &[u8], expected: [u8; 4]| {
            pixel
                .iter()
                .zip(expected)
                .all(|(&value, want)| (i32::from(value) - i32::from(want)).abs() <= 1)
        };

        let ok = match self {
            Reference::Solid(color) => {
                let expected = to_bytes(*color);
                result.chunks_exact(4).all(|pixel| matches(pixel, expected))
            }
            Reference::Image(expected) => result
                .chunks_exact(4)
                .zip(expected)
                .all(|(pixel, &expected)| matches(pixel, expected)),
            Reference::AnyOf(references) => references.iter().any(|reference| reference.verify(result).is_ok()),
        };

        if ok {
            Ok(())
        } else {
            Err(TestError::Fail(
                "Result does not match reference; check log for details".to_string(),
            ))
        }
    }
}

/// `MeshShaderMiscInstance::iterate`: draws with additive blending over a transparent black clear and returns the image.
fn draw_misc(context: &Context<'_>, params: &MiscParams) -> Result<Vec<u8>, TestError> {
    let device = context.get_device();
    let alloc = context.get_default_allocator();

    let image_format = OUTPUT_FORMAT;
    let image_extent = vk::Extent3D {
        width: params.width,
        height: params.height,
        depth: 1,
    };
    let image_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;

    let color_buffer_info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(image_format)
        .extent(image_extent)
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(image_usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    let color_image = ImageWithMemory::new(device, alloc, color_buffer_info, MemoryRequirement::ANY)?;
    let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let color_srl = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1);
    let color_view = make_image_view(
        device,
        color_image.get(),
        vk::ImageViewType::_2D,
        image_format,
        color_srr,
    )?;

    let binaries = context.get_binary_collection();
    let has_task = binaries.contains("task");

    // Create a memory buffer for verification.
    let verification_buffer_size = (params.width * params.height * 4) as vk::DeviceSize;
    let verification_buffer = BufferWithMemory::new(
        device,
        alloc,
        make_buffer_create_info(verification_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    // Per-vertex (storage) and per-primitive (uniform) data of the custom attributes case.
    let custom = params.custom_attributes;
    let buffer_stages = if params.needs_task_shader() {
        vk::ShaderStageFlags::TASK_EXT
    } else {
        vk::ShaderStageFlags::MESH_EXT
    };
    let (pvd_bytes, ppd_bytes) = custom_attributes_data(true);
    let pvd_buffer = if custom {
        Some(BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(pvd_bytes.len() as vk::DeviceSize, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?)
    } else {
        None
    };
    let ppd_buffer = if custom {
        Some(BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(ppd_bytes.len() as vk::DeviceSize, vk::BufferUsageFlags::UNIFORM_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?)
    } else {
        None
    };
    for (buffer, bytes) in [(&pvd_buffer, &pvd_bytes), (&ppd_buffer, &ppd_bytes)] {
        if let Some(buffer) = buffer {
            unsafe {
                std::ptr::copy_nonoverlapping(bytes.as_ptr(), buffer.get_allocation().get_host_ptr(), bytes.len())
            };
            flush_alloc(device, buffer.get_allocation())?;
        }
    }

    // Descriptor set layout, pool and set of the custom attributes buffers.
    let set_layout = if custom {
        Some(
            DescriptorSetLayoutBuilder::new()
                .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, buffer_stages)
                .add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, buffer_stages)
                .build(device)?,
        )
    } else {
        None
    };
    let descriptor_pool = if custom {
        Some(
            DescriptorPoolBuilder::new()
                .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
                .add_type(vk::DescriptorType::UNIFORM_BUFFER, 1)
                .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?,
        )
    } else {
        None
    };
    let descriptor_set = match (&descriptor_pool, &set_layout, &pvd_buffer, &ppd_buffer) {
        (Some(pool), Some(layout), Some(pvd), Some(ppd)) => {
            let set = make_descriptor_set(device, **pool, layout.get())?;
            let storage_buffer_info = [make_descriptor_buffer_info(
                pvd.get(),
                0,
                pvd_bytes.len() as vk::DeviceSize,
            )];
            let uniform_buffer_info = [make_descriptor_buffer_info(
                ppd.get(),
                0,
                ppd_bytes.len() as vk::DeviceSize,
            )];
            let writes = [
                vk::WriteDescriptorSet::builder()
                    .dst_set(set.get())
                    .dst_binding(0)
                    .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                    .buffer_info(&storage_buffer_info),
                vk::WriteDescriptorSet::builder()
                    .dst_set(set.get())
                    .dst_binding(1)
                    .descriptor_type(vk::DescriptorType::UNIFORM_BUFFER)
                    .buffer_info(&uniform_buffer_info),
            ];
            unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };
            Some(set)
        }
        _ => None,
    };

    // Pipeline layout.
    let set_layouts: Vec<vk::DescriptorSetLayout> = set_layout.iter().map(|layout| layout.get()).collect();
    let pc_data: [f32; 4] = [0.25, 0.25, 0.75, 0.75];
    let pc_bytes: Vec<u8> = pc_data.iter().flat_map(|value| value.to_ne_bytes()).collect();
    let pc_half_size = pc_bytes.len() as u32 / 2;
    let pc_ranges: Vec<vk::PushConstantRange> = if !params.push_constants {
        Vec::new()
    } else if has_task {
        vec![
            vk::PushConstantRange {
                stage_flags: vk::ShaderStageFlags::MESH_EXT,
                offset: 0,
                size: pc_half_size,
            },
            vk::PushConstantRange {
                stage_flags: vk::ShaderStageFlags::TASK_EXT,
                offset: pc_half_size,
                size: pc_half_size,
            },
        ]
    } else {
        vec![vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::MESH_EXT,
            offset: 0,
            size: pc_bytes.len() as u32,
        }]
    };
    let layout_info = vk::PipelineLayoutCreateInfo::builder()
        .set_layouts(&set_layouts)
        .push_constant_ranges(&pc_ranges);
    let pipeline_layout = Unique::new(
        device,
        unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
    );

    // Shader modules.
    let mesh_shader = create_shader_module(device, binaries.get("mesh")?)?;
    let frag_shader = create_shader_module(device, binaries.get("frag")?)?;
    let task_shader = if has_task {
        Some(create_shader_module(device, binaries.get("task")?)?)
    } else {
        None
    };

    // Render pass and framebuffer.
    let render_pass = make_render_pass(device, image_format)?;
    let framebuffer = make_framebuffer(
        device,
        *render_pass,
        &[*color_view],
        image_extent.width,
        image_extent.height,
        1,
    )?;

    // Color blending: additive.
    let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST)
        .with_full_viewport(image_extent.width, image_extent.height);
    state.color_blend_attachment = Some(vk::PipelineColorBlendAttachmentState {
        blend_enable: vk::TRUE,
        src_color_blend_factor: vk::BlendFactor::ONE,
        dst_color_blend_factor: vk::BlendFactor::ONE,
        color_blend_op: vk::BlendOp::ADD,
        src_alpha_blend_factor: vk::BlendFactor::ONE,
        dst_alpha_blend_factor: vk::BlendFactor::ONE,
        alpha_blend_op: vk::BlendOp::ADD,
        color_write_mask: vk::ColorComponentFlags::all(),
    });
    state.rasterization.depth_bias_enable = vk::FALSE;
    if custom {
        let top_half = viewport(
            0.0,
            0.0,
            image_extent.width as f32,
            (image_extent.height / 2) as f32,
            0.0,
            1.0,
        );
        state.viewports.push(top_half);
        state.scissors.push(rect_2d(image_extent.width, image_extent.height));
        state.viewport_count = 2;
    }
    let mut stages = Vec::new();
    if let Some(task) = &task_shader {
        stages.push((vk::ShaderStageFlags::TASK_EXT, **task));
    }
    stages.push((vk::ShaderStageFlags::MESH_EXT, *mesh_shader));
    stages.push((vk::ShaderStageFlags::FRAGMENT, *frag_shader));
    let pipeline = create_draw_pipeline(device, *pipeline_layout, *render_pass, &stages, &state)?;

    // Command pool and buffer.
    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;

    // Run pipeline.
    let clear_values = [clear_value_color([0.0, 0.0, 0.0, 0.0])];
    let begin_info = vk::RenderPassBeginInfo::builder()
        .render_pass(*render_pass)
        .framebuffer(*framebuffer)
        .render_area(rect_2d(image_extent.width, image_extent.height))
        .clear_values(&clear_values);
    unsafe {
        device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
        if let Some(set) = &descriptor_set {
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[set.get()],
                &[] as &[u32],
            );
        }
        for range in &pc_ranges {
            let values = &pc_bytes[range.offset as usize..(range.offset + range.size) as usize];
            device.cmd_push_constants(cmd, *pipeline_layout, range.stage_flags, range.offset, values);
        }
        device.cmd_draw_mesh_tasks_nv(cmd, params.draw_count(), 0);
        device.cmd_end_render_pass(cmd);
    }

    // Copy color buffer to verification buffer.
    let color_access = vk::AccessFlags::COLOR_ATTACHMENT_WRITE | vk::AccessFlags::COLOR_ATTACHMENT_READ;
    let pre_copy_barrier = make_image_memory_barrier(
        color_access,
        vk::AccessFlags::TRANSFER_READ,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        color_image.get(),
        color_srr,
    );
    let post_copy_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
    let copy_region = make_buffer_image_copy(image_extent, color_srl);
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[pre_copy_barrier],
        );
        device.cmd_copy_image_to_buffer(
            cmd,
            color_image.get(),
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            verification_buffer.get(),
            &[copy_region],
        );
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[post_copy_barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    invalidate_alloc(device, verification_buffer.get_allocation())?;
    Ok(unsafe {
        std::slice::from_raw_parts(
            verification_buffer.get_allocation().get_host_ptr().cast_const(),
            verification_buffer_size as usize,
        )
    }
    .to_vec())
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum PrimitiveType {
    Points,
    Lines,
    Triangles,
}

impl PrimitiveType {
    /// `primitiveTypeName`
    fn name(self) -> &'static str {
        match self {
            PrimitiveType::Points => "points",
            PrimitiveType::Lines => "lines",
            PrimitiveType::Triangles => "triangles",
        }
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum MemoryBarrierType {
    Shared,
    Group,
}

/// The case each upstream class covers.
#[derive(Clone, Copy)]
enum Family {
    ComplexTaskData,
    SinglePoint,
    SingleLine,
    SingleTriangle,
    MaxPoints,
    MaxLines,
    MaxTriangles,
    LargeWorkGroup {
        which: LargeWorkGroup,
    },
    NoPrimitives {
        primitive_type: PrimitiveType,
        extra_writes: bool,
    },
    SimpleBarrier,
    MemoryBarrier {
        barrier_type: MemoryBarrierType,
    },
    CustomAttributes,
    PushConstant,
    MaximizePrimitives,
    MaximizeVertices,
    MaximizeInvocations,
}

#[derive(Clone, Copy)]
enum LargeWorkGroup {
    Task,
    Mesh,
    TaskAndMesh,
}

const SOLID_BLUE: Color = [0.0, 0.0, 1.0, 1.0];
const CYAN: Color = [0.0, 1.0, 1.0, 1.0];
const TRANSPARENT: Color = [0.0, 0.0, 0.0, 0.0];

impl Family {
    fn programs(self, params: &MiscParams) -> BinaryCollection {
        match self {
            Family::ComplexTaskData => NV_MISC_COMPLEX_TASK_DATA.programs,
            Family::SinglePoint => NV_MISC_SINGLE_POINT.programs,
            Family::SingleLine => NV_MISC_SINGLE_LINE.programs,
            Family::SingleTriangle => NV_MISC_SINGLE_TRIANGLE.programs,
            Family::MaxPoints => NV_MISC_MAX_POINTS.programs,
            Family::MaxLines => NV_MISC_MAX_LINES.programs,
            Family::MaxTriangles => NV_MISC_MAX_TRIANGLES.programs,
            Family::LargeWorkGroup {
                which: LargeWorkGroup::Task,
            } => NV_MISC_MANY_TASK_WORK_GROUPS.programs,
            Family::LargeWorkGroup {
                which: LargeWorkGroup::Mesh,
            } => NV_MISC_MANY_MESH_WORK_GROUPS.programs,
            Family::LargeWorkGroup {
                which: LargeWorkGroup::TaskAndMesh,
            } => NV_MISC_MANY_TASK_MESH_WORK_GROUPS.programs,
            Family::NoPrimitives {
                primitive_type: PrimitiveType::Points,
                extra_writes: false,
            } => NV_MISC_NO_POINTS.programs,
            Family::NoPrimitives {
                primitive_type: PrimitiveType::Lines,
                extra_writes: false,
            } => NV_MISC_NO_LINES.programs,
            Family::NoPrimitives {
                primitive_type: PrimitiveType::Triangles,
                extra_writes: false,
            } => NV_MISC_NO_TRIANGLES.programs,
            Family::NoPrimitives {
                primitive_type: PrimitiveType::Points,
                extra_writes: true,
            } => NV_MISC_NO_POINTS_EXTRA_WRITES.programs,
            Family::NoPrimitives {
                primitive_type: PrimitiveType::Lines,
                extra_writes: true,
            } => NV_MISC_NO_LINES_EXTRA_WRITES.programs,
            Family::NoPrimitives {
                primitive_type: PrimitiveType::Triangles,
                extra_writes: true,
            } => NV_MISC_NO_TRIANGLES_EXTRA_WRITES.programs,
            Family::SimpleBarrier => {
                if params.needs_task_shader() {
                    NV_MISC_BARRIER_IN_TASK.programs
                } else {
                    NV_MISC_BARRIER_IN_MESH.programs
                }
            }
            Family::MemoryBarrier {
                barrier_type: MemoryBarrierType::Shared,
            } => {
                if params.needs_task_shader() {
                    NV_MISC_MEMORY_BARRIER_SHARED_IN_TASK.programs
                } else {
                    NV_MISC_MEMORY_BARRIER_SHARED_IN_MESH.programs
                }
            }
            Family::MemoryBarrier {
                barrier_type: MemoryBarrierType::Group,
            } => {
                if params.needs_task_shader() {
                    NV_MISC_GROUP_MEMORY_BARRIER_IN_TASK.programs
                } else {
                    NV_MISC_GROUP_MEMORY_BARRIER_IN_MESH.programs
                }
            }
            Family::CustomAttributes => {
                if params.needs_task_shader() {
                    NV_MISC_CUSTOM_ATTRIBUTES_AND_TASK_SHADER.programs
                } else {
                    NV_MISC_CUSTOM_ATTRIBUTES.programs
                }
            }
            Family::PushConstant => {
                if params.needs_task_shader() {
                    NV_MISC_PUSH_CONSTANT_AND_TASK_SHADER.programs
                } else {
                    NV_MISC_PUSH_CONSTANT.programs
                }
            }
            Family::MaximizePrimitives => NV_MISC_MAXIMIZE_PRIMITIVES.programs,
            Family::MaximizeVertices => NV_MISC_MAXIMIZE_VERTICES.programs,
            Family::MaximizeInvocations => match params.maximize.map(|(local_size, _, _)| local_size) {
                Some(32) => NV_MISC_MAXIMIZE_INVOCATIONS_32.programs,
                Some(64) => NV_MISC_MAXIMIZE_INVOCATIONS_64.programs,
                Some(128) => NV_MISC_MAXIMIZE_INVOCATIONS_128.programs,
                _ => NV_MISC_MAXIMIZE_INVOCATIONS_256.programs,
            },
        }
    }

    /// `generateReferenceLevel`
    fn reference(self, params: &MiscParams) -> Reference {
        let (width, height) = (params.width, params.height);
        let image = |fill: &dyn Fn(u32, u32) -> Color| -> Reference {
            let mut pixels = Vec::with_capacity((width * height) as usize);
            for y in 0..height {
                for x in 0..width {
                    pixels.push(to_bytes(fill(x, y)));
                }
            }
            Reference::Image(pixels)
        };

        match self {
            Family::ComplexTaskData => {
                let (half_width, half_height) = (width / 2, height / 2);
                // Each image quadrant gets a different color.
                image(&|x, y| {
                    [
                        if y < half_height { 0.0 } else { 1.0 },
                        if x < half_width { 0.0 } else { 1.0 },
                        1.0,
                        1.0,
                    ]
                })
            }
            Family::SinglePoint | Family::SingleTriangle => {
                let (half_width, half_height) = (width / 2, height / 2);
                image(&|x, y| {
                    if x == half_width && y == half_height {
                        CYAN
                    } else {
                        TRANSPARENT
                    }
                })
            }
            Family::SingleLine => {
                let half_height = height / 2;
                // Center row.
                image(&|_, y| if y == half_height { CYAN } else { TRANSPARENT })
            }
            Family::MaxPoints => {
                let (f_width, f_height) = (width as f32, height as f32);
                // Fill with gradient like the shader does.
                image(&|x, y| [(x as f32 + 0.5) / f_width, (y as f32 + 0.5) / f_height, 0.0, 1.0])
            }
            Family::MaxLines => {
                // Fill lines, 4 pixels per line.
                const NUM_LINES: u32 = 255;
                const LINE_HEIGHT: u32 = 4;
                image(&|_, y| {
                    let line = y / LINE_HEIGHT;
                    if line < NUM_LINES {
                        [0.0, 1.0, line as f32 / NUM_LINES as f32, 1.0]
                    } else {
                        TRANSPARENT
                    }
                })
            }
            Family::CustomAttributes => {
                let (half_width, half_height) = (width / 2, height / 2);
                // Fill the top left quarter.
                image(&|x, y| {
                    if y < half_width && x < half_height {
                        SOLID_BLUE
                    } else {
                        TRANSPARENT
                    }
                })
            }
            Family::MaximizePrimitives => Reference::Solid([1.0, 0.0, 1.0, 1.0]),
            Family::MaxTriangles
            | Family::LargeWorkGroup { .. }
            | Family::SimpleBarrier
            | Family::PushConstant
            | Family::MaximizeVertices
            | Family::MaximizeInvocations => Reference::Solid(SOLID_BLUE),
            // No primitives: clear color.
            Family::NoPrimitives { .. } => Reference::Solid(TRANSPARENT),
            // Allow two possible outcomes.
            Family::MemoryBarrier { .. } => Reference::AnyOf(vec![
                Reference::Solid(SOLID_BLUE),
                Reference::Solid([0.0, 0.0, 0.0, 1.0]),
            ]),
        }
    }

    fn check_support(self, context: &Context<'_>, params: &MiscParams) -> Result<(), TestError> {
        generic_check_support(context, params.needs_task_shader(), false)?;

        if let Family::CustomAttributes = self {
            let features = context.get_device_features();
            if features.multi_viewport == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Requested core feature is not supported: multiViewport".to_string(),
                ));
            }
            if features.shader_clip_distance == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Requested core feature is not supported: shaderClipDistance".to_string(),
                ));
            }
        }

        // `MaximizeThreadsParams::checkSupport`
        if let Some((local_size, num_vertices, num_primitives)) = params.maximize {
            let properties = mesh_shader_properties_nv(context);

            if local_size > properties.max_mesh_work_group_size[0] {
                return Err(TestError::NotSupported("Required local size not supported".to_string()));
            }

            if num_vertices > properties.max_mesh_output_vertices {
                return Err(TestError::NotSupported(
                    "Required number of output vertices not supported".to_string(),
                ));
            }

            if num_primitives > properties.max_mesh_output_primitives {
                return Err(TestError::NotSupported(
                    "Required number of output primitives not supported".to_string(),
                ));
            }
        }

        Ok(())
    }
}

struct MeshShaderMiscCase {
    name: String,
    family: Family,
    params: MiscParams,
}

impl TestCase for MeshShaderMiscCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        self.family.check_support(context, &self.params)
    }

    fn programs(&self) -> BinaryCollection {
        self.family.programs(&self.params)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MeshShaderMiscInstance {
            context,
            family: self.family,
            params: self.params,
        })
    }
}

struct MeshShaderMiscInstance<'a> {
    context: &'a Context<'a>,
    family: Family,
    params: MiscParams,
}

impl TestInstance for MeshShaderMiscInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let result = draw_misc(self.context, &self.params)?;
        self.family.reference(&self.params).verify(&result)?;
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createMeshShaderMiscTests`
pub fn create_mesh_shader_misc_tests() -> TestCaseGroup {
    let mut misc_tests = TestCaseGroup::new("misc");

    let mut add = |name: &str, family: Family, params: MiscParams| {
        misc_tests.add_child(Box::new(MeshShaderMiscCase {
            name: name.to_string(),
            family,
            params,
        }) as Box<dyn TestCase>);
    };

    // Pass a complex structure from the task to the mesh shader
    add(
        "complex_task_data",
        Family::ComplexTaskData,
        MiscParams::new(Some(2), 2, 8, 8),
    );

    // Draw a single point. Use an odd size so there's a pixel in the exact center.
    add("single_point", Family::SinglePoint, MiscParams::new(None, 1, 5, 7));

    // Draw a single line. Use an odd height so there's a center line.
    add("single_line", Family::SingleLine, MiscParams::new(None, 1, 8, 5));

    // Draw a single triangle
    add(
        "single_triangle",
        Family::SingleTriangle,
        MiscParams::new(None, 1, 5, 7),
    );

    // Draw the maximum number of points
    add("max_points", Family::MaxPoints, MiscParams::new(None, 1, 16, 16));

    // Draw the maximum number of lines
    add("max_lines", Family::MaxLines, MiscParams::new(None, 1, 1, 1020));

    // Draw the maximum number of triangles
    add(
        "max_triangles",
        Family::MaxTriangles,
        MiscParams::new(None, 1, 512, 512),
    );

    // Generate a large number of task work groups
    add(
        "many_task_work_groups",
        Family::LargeWorkGroup {
            which: LargeWorkGroup::Task,
        },
        MiscParams::new(Some(65535), 1, 1360, 1542),
    );

    // Generate a large number of mesh work groups
    add(
        "many_mesh_work_groups",
        Family::LargeWorkGroup {
            which: LargeWorkGroup::Mesh,
        },
        MiscParams::new(None, 65535, 1360, 1542),
    );

    // Generate a large number of task and mesh work groups
    add(
        "many_task_mesh_work_groups",
        Family::LargeWorkGroup {
            which: LargeWorkGroup::TaskAndMesh,
        },
        MiscParams::new(Some(512), 512, 4096, 2048),
    );

    for extra_writes in [false, true] {
        for primitive_type in [PrimitiveType::Points, PrimitiveType::Lines, PrimitiveType::Triangles] {
            let name = format!(
                "no_{}{}",
                primitive_type.name(),
                if extra_writes { "_extra_writes" } else { "" }
            );
            add(
                &name,
                Family::NoPrimitives {
                    primitive_type,
                    extra_writes,
                },
                MiscParams::new(if extra_writes { Some(1) } else { None }, 1, 16, 16),
            );
        }
    }

    for use_task_shader in [true, false] {
        let name = format!("barrier_in_{}", if use_task_shader { "task" } else { "mesh" });
        add(
            &name,
            Family::SimpleBarrier,
            MiscParams::new(if use_task_shader { Some(1) } else { None }, 1, 1, 1),
        );
    }

    for (barrier_type, case_name) in [
        (MemoryBarrierType::Shared, "memory_barrier_shared"),
        (MemoryBarrierType::Group, "group_memory_barrier"),
    ] {
        for use_task_shader in [true, false] {
            let name = format!("{case_name}_in_{}", if use_task_shader { "task" } else { "mesh" });
            add(
                &name,
                Family::MemoryBarrier { barrier_type },
                MiscParams::new(if use_task_shader { Some(1) } else { None }, 1, 1, 1),
            );
        }
    }

    for use_task_shader in [false, true] {
        let name = format!(
            "custom_attributes{}",
            if use_task_shader { "_and_task_shader" } else { "" }
        );
        add(
            &name,
            Family::CustomAttributes,
            MiscParams::new(if use_task_shader { Some(1) } else { None }, 1, 32, 32).with_custom_attributes(),
        );
    }

    for use_task_shader in [false, true] {
        let name = format!("push_constant{}", if use_task_shader { "_and_task_shader" } else { "" });
        add(
            &name,
            Family::PushConstant,
            MiscParams::new(if use_task_shader { Some(1) } else { None }, 1, 16, 16).with_push_constants(),
        );
    }

    // Use a large number of primitives compared to other sizes
    add(
        "maximize_primitives",
        Family::MaximizePrimitives,
        MiscParams::new(None, 1, 128, 1).with_maximize(32, 128, 256),
    );

    // Use a large number of vertices compared to other sizes
    add(
        "maximize_vertices",
        Family::MaximizeVertices,
        MiscParams::new(None, 1, 64, 1).with_maximize(32, 256, 128),
    );

    // Use a large number of invocations compared to other sizes
    for invocation_case in [32u32, 64, 128, 256] {
        let num_pixels = invocation_case / 2;
        add(
            &format!("maximize_invocations_{invocation_case}"),
            Family::MaximizeInvocations,
            MiscParams::new(None, 1, num_pixels, 1).with_maximize(invocation_case, num_pixels, num_pixels),
        );
    }

    misc_tests
}
