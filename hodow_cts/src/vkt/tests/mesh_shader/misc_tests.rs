// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/mesh_shader/vktMeshShaderMiscTestsEXT.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders each family formats at run time are pre-expanded in the manifest by
// tmp/gen_mesh_misc.py. `MeshShaderMiscCase`/`MeshShaderMiscInstance` become one drawing function (`draw_misc`) that returns the image,
// and each family supplies its reference image and, where upstream overrides it, its own check.
//
// Families in this file so far: complex_task_data, single_point(_default_size), single_line, single_triangle, max_points, max_lines,
// max_triangles_workgroupsize_*, many_task_work_groups_*, many_mesh_work_groups_*, many_task_mesh_work_groups_*, no_points/lines/triangles,
// barrier_in_task/mesh, memory_barrier_shared/group_memory_barrier_in_task/mesh_*, payload_read, maximize_primitives/vertices/invocations_*,
// first_invocation_task/mesh, multiple_outputs_vertices, per_prim_block_output, push_constant*, custom_attributes*, clip_*, payload_not_accessed,
// emit_in_control_flow*, mixed_pipelines*, rebind_sets, and vertex_state_* (in vertex_state_tests.rs). local_size_id_*. work_group_ordering is in work_group_ordering_tests.rs.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    ExtExtendedDynamicStateExtensionDeviceCommands, ExtMeshShaderExtensionDeviceCommands, InstanceV1_1,
};

use crate::generated::shaders::mesh_shader_misc::{
    MISC_BARRIER_IN_MESH, MISC_BARRIER_IN_TASK, MISC_CLIP_GEOM, MISC_CLIP_GEOM_AND_TASK_SHADER,
    MISC_CLIP_GEOM_AND_TASK_SHADER_PROVOKING_LAST, MISC_CLIP_GEOM_PROVOKING_LAST, MISC_CLIP_PLANE,
    MISC_CLIP_PLANE_AND_TASK_SHADER, MISC_CLIP_PLANE_AND_TASK_SHADER_PROVOKING_LAST, MISC_CLIP_PLANE_PROVOKING_LAST,
    MISC_COMPLEX_TASK_DATA, MISC_CUSTOM_ATTRIBUTES, MISC_CUSTOM_ATTRIBUTES_AND_TASK_SHADER, MISC_EMIT_IN_CONTROL_FLOW,
    MISC_EMIT_IN_CONTROL_FLOW_BAD_EMIT_LAST, MISC_FIRST_INVOCATION_MESH, MISC_FIRST_INVOCATION_TASK,
    MISC_GROUP_MEMORY_BARRIER_IN_MESH_ARRAY, MISC_GROUP_MEMORY_BARRIER_IN_MESH_FLOAT,
    MISC_GROUP_MEMORY_BARRIER_IN_MESH_STRUCT, MISC_GROUP_MEMORY_BARRIER_IN_MESH_UINT64,
    MISC_GROUP_MEMORY_BARRIER_IN_MESH_VECTOR, MISC_GROUP_MEMORY_BARRIER_IN_TASK_ARRAY,
    MISC_GROUP_MEMORY_BARRIER_IN_TASK_FLOAT, MISC_GROUP_MEMORY_BARRIER_IN_TASK_STRUCT,
    MISC_GROUP_MEMORY_BARRIER_IN_TASK_UINT64, MISC_GROUP_MEMORY_BARRIER_IN_TASK_VECTOR, MISC_MANY_MESH_WORK_GROUPS_X,
    MISC_MANY_MESH_WORK_GROUPS_Y, MISC_MANY_MESH_WORK_GROUPS_Z, MISC_MANY_TASK_MESH_WORK_GROUPS_X,
    MISC_MANY_TASK_MESH_WORK_GROUPS_Y, MISC_MANY_TASK_MESH_WORK_GROUPS_Z, MISC_MANY_TASK_WORK_GROUPS_X,
    MISC_MANY_TASK_WORK_GROUPS_Y, MISC_MANY_TASK_WORK_GROUPS_Z, MISC_MAX_LINES, MISC_MAX_POINTS,
    MISC_MAX_TRIANGLES_WORKGROUPSIZE_16, MISC_MAX_TRIANGLES_WORKGROUPSIZE_32, MISC_MAX_TRIANGLES_WORKGROUPSIZE_64,
    MISC_MAXIMIZE_INVOCATIONS_32, MISC_MAXIMIZE_INVOCATIONS_64, MISC_MAXIMIZE_INVOCATIONS_128,
    MISC_MAXIMIZE_INVOCATIONS_256, MISC_MAXIMIZE_PRIMITIVES, MISC_MAXIMIZE_VERTICES,
    MISC_MEMORY_BARRIER_SHARED_IN_MESH_ARRAY, MISC_MEMORY_BARRIER_SHARED_IN_MESH_FLOAT,
    MISC_MEMORY_BARRIER_SHARED_IN_MESH_STRUCT, MISC_MEMORY_BARRIER_SHARED_IN_MESH_UINT64,
    MISC_MEMORY_BARRIER_SHARED_IN_MESH_VECTOR, MISC_MEMORY_BARRIER_SHARED_IN_TASK_ARRAY,
    MISC_MEMORY_BARRIER_SHARED_IN_TASK_FLOAT, MISC_MEMORY_BARRIER_SHARED_IN_TASK_STRUCT,
    MISC_MEMORY_BARRIER_SHARED_IN_TASK_UINT64, MISC_MEMORY_BARRIER_SHARED_IN_TASK_VECTOR, MISC_MIXED_PIPELINES,
    MISC_MULTIPLE_OUTPUTS_VERTICES, MISC_NO_LINES, MISC_NO_POINTS, MISC_NO_TRIANGLES, MISC_PAYLOAD_NOT_ACCESSED,
    MISC_PAYLOAD_READ, MISC_PER_PRIM_BLOCK_OUTPUT, MISC_PUSH_CONSTANT, MISC_PUSH_CONSTANT_AND_TASK_SHADER,
    MISC_REBIND_SETS, MISC_SINGLE_LINE, MISC_SINGLE_POINT, MISC_SINGLE_POINT_DEFAULT_SIZE, MISC_SINGLE_TRIANGLE,
};
use crate::generated::shaders::mesh_shader_misc_local_size_id::{LOCAL_SIZE_ID_MESH, LOCAL_SIZE_ID_TASK};
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
    make_descriptor_set, make_framebuffer, make_memory_barrier,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_value_color, create_draw_pipeline, rect_2d, viewport};
use crate::vkt::tests::mesh_shader::util::{
    check_task_mesh_shader_support_ext, mesh_shader_features, mesh_shader_properties,
};
use crate::vkt::tests::pipeline::pipeline_util::make_color_depth_render_pass;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

type Color = [f32; 4];

const OUTPUT_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

fn to_bytes(color: Color) -> [u8; 4] {
    color.map(|c| (c * 255.0 + 0.5).floor() as u8)
}

/// `MiscTestParams`
#[derive(Clone, Copy)]
struct MiscParams {
    task_count: Option<[u32; 3]>,
    mesh_count: [u32; 3],
    width: u32,
    height: u32,
    push_constants: bool,
    single_push_constant: bool,
    custom_attributes: bool,
    clip_distances: bool,
    provoking_last: bool,
    multiview: bool,
    /// `LocalSizeIdCase`: the work group size of the shaders is given by specialization constants 10-12 (task) and 20-22 (mesh).
    local_size_id: bool,
}

impl MiscParams {
    fn new(task_count: Option<[u32; 3]>, mesh_count: [u32; 3], width: u32, height: u32) -> Self {
        Self {
            task_count,
            mesh_count,
            width,
            height,
            push_constants: false,
            single_push_constant: false,
            custom_attributes: false,
            clip_distances: true,
            provoking_last: false,
            multiview: false,
            local_size_id: false,
        }
    }

    fn with_clip(mut self, clip_distances: bool, provoking_last: bool, multiview: bool) -> Self {
        self.custom_attributes = true;
        self.clip_distances = clip_distances;
        self.provoking_last = provoking_last;
        self.multiview = multiview;
        self
    }

    fn with_local_size_id(mut self) -> Self {
        self.local_size_id = true;
        self
    }

    fn with_custom_attributes(mut self) -> Self {
        self.custom_attributes = true;
        self
    }

    /// A single float pushed to the mesh stage, as `PayloadNotAccessedInstance::iterate` does.
    fn with_single_push_constant(mut self) -> Self {
        self.push_constants = true;
        self.single_push_constant = true;
        self
    }

    fn with_push_constants(mut self) -> Self {
        self.push_constants = true;
        self
    }

    fn needs_task_shader(&self) -> bool {
        self.task_count.is_some()
    }

    fn draw_count(&self) -> [u32; 3] {
        self.task_count.unwrap_or(self.mesh_count)
    }

    fn task_only(&self) -> bool {
        self.needs_task_shader() && self.mesh_count == [0, 0, 0]
    }
}

/// `genericCheckSupport`
fn generic_check_support(
    context: &Context<'_>,
    require_task_shader: bool,
    require_vertex_stores: bool,
) -> Result<(), TestError> {
    check_task_mesh_shader_support_ext(context, require_task_shader, true)?;

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
    fn image(width: u32, height: u32, color: Color) -> Vec<[u8; 4]> {
        vec![to_bytes(color); (width * height) as usize]
    }

    /// `MeshShaderMiscInstance::verifyResult`: floatThresholdCompare with a threshold of 0.005, i.e. one step of the 8-bit format.
    fn verify(&self, result: &[u8]) -> Result<(), TestError> {
        let matches = |pixel: &[u8], expected: [u8; 4]| {
            pixel
                .iter()
                .zip(expected)
                .all(|(&value, want)| (value as i32 - want as i32).abs() <= 1)
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
fn draw_misc(context: &Context<'_>, params: &MiscParams) -> Result<Vec<Vec<u8>>, TestError> {
    let device = context.get_device();
    let alloc = context.get_default_allocator();

    let image_format = OUTPUT_FORMAT;
    let image_extent = vk::Extent3D {
        width: params.width,
        height: params.height,
        depth: 1,
    };
    let image_usage =
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::STORAGE;
    let task_only = params.task_only();
    let layers = if params.multiview { 2 } else { 1 };

    let color_buffer_info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(image_format)
        .extent(image_extent)
        .mip_levels(1)
        .array_layers(layers)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(image_usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    let color_image = ImageWithMemory::new(device, alloc, color_buffer_info, MemoryRequirement::ANY)?;
    let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, layers);
    let view_type = if params.multiview {
        vk::ImageViewType::_2D_ARRAY
    } else {
        vk::ImageViewType::_2D
    };
    let color_view = make_image_view(device, color_image.get(), view_type, image_format, color_srr)?;

    // Create a memory buffer for verification.
    let verification_buffer_size = (params.width * params.height * 4) as vk::DeviceSize;
    let verification_buffers = (0..layers)
        .map(|_| {
            BufferWithMemory::new(
                device,
                alloc,
                make_buffer_create_info(verification_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
                MemoryRequirement::HOST_VISIBLE,
            )
        })
        .collect::<Result<Vec<_>, _>>()?;

    // Per-vertex (storage) and per-primitive (uniform) data of the custom attributes case.
    let custom = params.custom_attributes;
    let buffer_stages = if params.needs_task_shader() {
        vk::ShaderStageFlags::TASK_EXT
    } else {
        vk::ShaderStageFlags::MESH_EXT
    };
    let (pvd_bytes, ppd_bytes) = custom_attributes_data(params.clip_distances);
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

    // Descriptor set layout, pool and set for the task only case's storage image, or the custom attributes buffers.
    let set_layout = if task_only {
        Some(
            DescriptorSetLayoutBuilder::new()
                .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::TASK_EXT)
                .build(device)?,
        )
    } else if custom {
        Some(
            DescriptorSetLayoutBuilder::new()
                .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, buffer_stages)
                .add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, buffer_stages)
                .build(device)?,
        )
    } else {
        None
    };
    let descriptor_pool = if task_only {
        Some(
            DescriptorPoolBuilder::new()
                .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
                .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?,
        )
    } else if custom {
        Some(
            DescriptorPoolBuilder::new()
                .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
                .add_type(vk::DescriptorType::UNIFORM_BUFFER, 1)
                .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?,
        )
    } else {
        None
    };
    let descriptor_set = match (&descriptor_pool, &set_layout) {
        (Some(pool), Some(layout)) => {
            let set = make_descriptor_set(device, **pool, layout.get())?;
            if let (Some(pvd), Some(ppd)) = (&pvd_buffer, &ppd_buffer) {
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
            } else {
                let storage_image_info = [vk::DescriptorImageInfo {
                    sampler: vk::Sampler::null(),
                    image_view: *color_view,
                    image_layout: vk::ImageLayout::GENERAL,
                }];
                let write = vk::WriteDescriptorSet::builder()
                    .dst_set(set.get())
                    .dst_binding(0)
                    .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                    .image_info(&storage_image_info);
                unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
            }
            Some(set)
        }
        _ => None,
    };

    // Pipeline layout.
    let set_layouts: Vec<vk::DescriptorSetLayout> = set_layout.iter().map(|layout| layout.get()).collect();
    let pc_data: &[f32] = if params.single_push_constant {
        &[1.0]
    } else {
        &[0.25, 0.25, 0.75, 0.75]
    };
    let pc_bytes: Vec<u8> = pc_data.iter().flat_map(|value| value.to_ne_bytes()).collect();
    let pc_half_size = pc_bytes.len() as u32 / 2;
    let pc_ranges: Vec<vk::PushConstantRange> = if !params.push_constants {
        Vec::new()
    } else if params.needs_task_shader() && !params.single_push_constant {
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
    let binaries = context.get_binary_collection();
    let has_task = binaries.contains("task");
    let mesh_shader = create_shader_module(device, binaries.get("mesh")?)?;
    let frag_shader = create_shader_module(device, binaries.get("frag")?)?;
    let task_shader = if has_task {
        Some(create_shader_module(device, binaries.get("task")?)?)
    } else {
        None
    };

    // Render pass and framebuffer.
    let render_pass = if task_only {
        make_color_depth_render_pass(
            device,
            vk::Format::UNDEFINED,
            vk::Format::UNDEFINED,
            vk::AttachmentLoadOp::CLEAR,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        )?
    } else {
        make_misc_render_pass(device, image_format, params.multiview)?
    };
    let attachments: Vec<vk::ImageView> = if task_only { Vec::new() } else { vec![*color_view] };
    let framebuffer = make_framebuffer(
        device,
        *render_pass,
        &attachments,
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
    if params.local_size_id {
        // Spec constant data (must match the shaders): the work group size is 32x1x1 in both stages.
        let sc_data: [u32; 6] = [32, 1, 1, 32, 1, 1]; // 10, 11, 12, 20, 21, 22
        let sc_size = std::mem::size_of::<u32>() as u32;
        let entries: Vec<vk::SpecializationMapEntry> = [10u32, 11, 12, 20, 21, 22]
            .iter()
            .enumerate()
            .map(|(ndx, &constant_id)| vk::SpecializationMapEntry {
                constant_id,
                offset: ndx as u32 * sc_size,
                size: sc_size as usize,
            })
            .collect();
        state.specialization = Some((entries, sc_data.iter().flat_map(|value| value.to_ne_bytes()).collect()));
    }
    if params.provoking_last {
        state.provoking_vertex_mode = Some(vk::ProvokingVertexModeEXT::LAST_VERTEX);
    }
    if params.custom_attributes {
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
    let draw_count = params.draw_count();
    if task_only {
        // We will use the image as a storage image and we need to move it to the general layout.
        let barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::SHADER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::GENERAL,
            color_image.get(),
            color_srr,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TASK_SHADER_EXT,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            );
        }
    }
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
        device.cmd_draw_mesh_tasks_ext(cmd, draw_count[0], draw_count[1], draw_count[2]);
        device.cmd_end_render_pass(cmd);
    }

    // Copy color buffer to verification buffer.
    let color_access = vk::AccessFlags::COLOR_ATTACHMENT_WRITE
        | vk::AccessFlags::COLOR_ATTACHMENT_READ
        | vk::AccessFlags::SHADER_WRITE;
    let pre_copy_layout = if task_only {
        vk::ImageLayout::GENERAL
    } else {
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL
    };
    let pre_copy_barrier = make_image_memory_barrier(
        color_access,
        vk::AccessFlags::TRANSFER_READ,
        pre_copy_layout,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        color_image.get(),
        color_srr,
    );
    let post_copy_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT | vk::PipelineStageFlags::TASK_SHADER_EXT,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[pre_copy_barrier],
        );
        for (layer, verification_buffer) in verification_buffers.iter().enumerate() {
            let copy_region = make_buffer_image_copy(
                image_extent,
                make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, layer as u32, 1),
            );
            device.cmd_copy_image_to_buffer(
                cmd,
                color_image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                verification_buffer.get(),
                &[copy_region],
            );
        }
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

    let mut results = Vec::new();
    for verification_buffer in &verification_buffers {
        invalidate_alloc(device, verification_buffer.get_allocation())?;
        results.push(
            unsafe {
                std::slice::from_raw_parts(
                    verification_buffer.get_allocation().get_host_ptr().cast_const(),
                    verification_buffer_size as usize,
                )
            }
            .to_vec(),
        );
    }
    Ok(results)
}

pub(super) fn push_f32s(bytes: &mut Vec<u8>, values: &[f32]) {
    bytes.extend(values.iter().flat_map(|value| value.to_ne_bytes()));
}

/// `PerVertexData` and `PerPrimitiveData` of `CustomAttributesInstance::iterate`, in std430 and std140 layout.
pub(super) fn custom_attributes_data(clip_distances: bool) -> (Vec<u8>, Vec<u8>) {
    let mut per_vertex = Vec::new();
    // positions, with the bottom vertices far below the viewport when the geometry itself has to be clipped
    let bottom = if clip_distances { -1.0 } else { -19.0 };
    push_f32s(
        &mut per_vertex,
        &[
            -1.0, bottom, 0.0, 1.0, 1.0, bottom, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0,
        ],
    );
    // pointSizes
    push_f32s(&mut per_vertex, &[1.0; 4]);
    // clipDistances (unused for clipped geometry)
    push_f32s(
        &mut per_vertex,
        if clip_distances {
            &[1.0, -1.0, 1.0, -1.0]
        } else {
            &[0.0; 4]
        },
    );
    // custom1
    push_f32s(
        &mut per_vertex,
        &[
            0.25, 0.5, 10.0, 3.0, 0.25, 1.0, 20.0, 3.0, 0.5, 0.5, 20.0, 3.0, 0.5, 1.0, 10.0, 3.0,
        ],
    );
    // custom2
    push_f32s(&mut per_vertex, &[1.0, 1.0, 2.0, 2.0]);
    // custom3
    per_vertex.extend([3i32, 3, 4, 4].iter().flat_map(|value| value.to_ne_bytes()));

    // Some of these are declared as vectors to match the std140 layout, but only the first component is used.
    let mut per_primitive = Vec::new();
    // primitiveIds
    per_primitive.extend(
        [1000i32, 0, 0, 0, 1001, 0, 0, 0]
            .iter()
            .flat_map(|value| value.to_ne_bytes()),
    );
    // viewportIndices
    per_primitive.extend([1i32, 0, 0, 0, 1, 0, 0, 0].iter().flat_map(|value| value.to_ne_bytes()));
    // custom4
    per_primitive.extend(
        [100u32, 101, 102, 103, 200, 201, 202, 203]
            .iter()
            .flat_map(|value| value.to_ne_bytes()),
    );
    // custom5
    push_f32s(&mut per_primitive, &[6.0, 0.0, 0.0, 0.0, 7.0, 0.0, 0.0, 0.0]);

    (per_vertex, per_primitive)
}

/// `createCustomRenderPass`; the plain render pass when not multiview.
fn make_misc_render_pass(
    device: &Device,
    format: vk::Format,
    multiview: bool,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    if !multiview {
        return crate::vk::obj_util::make_render_pass(device, format);
    }

    let attachments = [vk::AttachmentDescription::builder()
        .format(format)
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
    let view_masks = [3u32];
    let mut multiview_create_info = vk::RenderPassMultiviewCreateInfo::builder().view_masks(&view_masks);
    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses)
        .push_next(&mut multiview_create_info);
    Ok(Unique::new(
        device,
        unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
    ))
}

/// `RebindSetsInstance::getQuadrantInfos`: offset x, offset y and colour.
fn rebind_sets_quadrants() -> [(f32, f32, Color); 4] {
    [
        (0.0, 0.0, [1.0, 0.0, 1.0, 1.0]),
        (1.0, 0.0, [1.0, 1.0, 0.0, 1.0]),
        (0.0, 1.0, [0.0, 0.0, 1.0, 1.0]),
        (1.0, 1.0, [0.0, 1.0, 1.0, 1.0]),
    ]
}

/// `MeshShaderMiscInstance::iterate` of `RebindSetsInstance`: four descriptor sets (SSBO for the task shader, texture for the mesh shader) bound in turn.
fn run_rebind_sets(context: &Context<'_>, params: &MiscParams) -> Result<Vec<u8>, TestError> {
    let device = context.get_device();
    let alloc = context.get_default_allocator();

    let quadrants = rebind_sets_quadrants();
    let set_count = quadrants.len() as u32;
    let texture_extent = vk::Extent3D {
        width: 1,
        height: 1,
        depth: 1,
    };
    let texture_format = vk::Format::R8G8B8A8_UNORM;
    let color_extent = vk::Extent3D {
        width: params.width,
        height: params.height,
        depth: 1,
    };
    let color_format = OUTPUT_FORMAT;

    let sampler_info = vk::SamplerCreateInfo::builder().build();
    let sampler = Unique::new(
        device,
        unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
    );

    let ssbo_size = std::mem::size_of::<f32>() as vk::DeviceSize;
    let mut ssbos = Vec::new();
    for (_, _, color) in &quadrants {
        let ssbo = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(ssbo_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let red_component = color[0].to_ne_bytes();
        unsafe {
            std::ptr::copy_nonoverlapping(
                red_component.as_ptr(),
                ssbo.get_allocation().get_host_ptr(),
                red_component.len(),
            )
        };
        ssbos.push(ssbo);
    }

    let texture_create_info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(texture_format)
        .extent(texture_extent)
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_DST)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    let texture_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let texture_srl = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1);
    let texture_copy_region = make_buffer_image_copy(texture_extent, texture_srl);

    let mut textures = Vec::new();
    let mut texture_views = Vec::new();
    for _ in &quadrants {
        let texture = ImageWithMemory::new(device, alloc, texture_create_info, MemoryRequirement::ANY)?;
        texture_views.push(make_image_view(
            device,
            texture.get(),
            vk::ImageViewType::_2D,
            texture_format,
            texture_srr,
        )?);
        textures.push(texture);
    }

    let mut auxiliar_buffers = Vec::new();
    for (_, _, color) in &quadrants {
        let buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(4, vk::BufferUsageFlags::TRANSFER_SRC),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let texel = to_bytes([color[1], 0.0, 0.0, 1.0]);
        unsafe { std::ptr::copy_nonoverlapping(texel.as_ptr(), buffer.get_allocation().get_host_ptr(), texel.len()) };
        auxiliar_buffers.push(buffer);
    }

    let set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::TASK_EXT)
        .add_single_binding(
            vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
            vk::ShaderStageFlags::MESH_EXT,
        )
        .build(device)?;

    let pc_size = 3 * std::mem::size_of::<f32>() as u32;
    let pc_range = vk::PushConstantRange {
        stage_flags: vk::ShaderStageFlags::MESH_EXT,
        offset: 0,
        size: pc_size,
    };
    let set_layouts = [set_layout.get()];
    let layout_info = vk::PipelineLayoutCreateInfo::builder()
        .set_layouts(&set_layouts)
        .push_constant_ranges(std::slice::from_ref(&pc_range));
    let pipeline_layout = Unique::new(
        device,
        unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
    );

    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, set_count)
        .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, set_count)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, set_count)?;

    let mut descriptor_sets = Vec::new();
    for _ in &quadrants {
        descriptor_sets.push(make_descriptor_set(device, *descriptor_pool, set_layout.get())?);
    }

    for (i, descriptor_set) in descriptor_sets.iter().enumerate() {
        let buffer_info = [make_descriptor_buffer_info(ssbos[i].get(), 0, ssbo_size)];
        let image_info = [vk::DescriptorImageInfo {
            sampler: *sampler,
            image_view: *texture_views[i],
            image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        }];
        let writes = [
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                .buffer_info(&buffer_info),
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(1)
                .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
                .image_info(&image_info),
        ];
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };
    }

    let color_create_info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(color_format)
        .extent(color_extent)
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let color_srl = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1);
    let color_attachment = ImageWithMemory::new(device, alloc, color_create_info, MemoryRequirement::ANY)?;
    let color_view = make_image_view(
        device,
        color_attachment.get(),
        vk::ImageViewType::_2D,
        color_format,
        color_srr,
    )?;

    let verification_buffer_size = (params.width * params.height * 4) as vk::DeviceSize;
    let verification_buffer = BufferWithMemory::new(
        device,
        alloc,
        make_buffer_create_info(verification_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let render_pass = make_misc_render_pass(device, color_format, false)?;
    let framebuffer = make_framebuffer(
        device,
        *render_pass,
        &[*color_view],
        color_extent.width,
        color_extent.height,
        1,
    )?;

    let binaries = context.get_binary_collection();
    let task_shader = create_shader_module(device, binaries.get("task")?)?;
    let mesh_shader = create_shader_module(device, binaries.get("mesh")?)?;
    let frag_shader = create_shader_module(device, binaries.get("frag")?)?;
    let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST)
        .with_full_viewport(color_extent.width, color_extent.height);
    state.rasterization.depth_bias_enable = vk::FALSE;
    let stages = [
        (vk::ShaderStageFlags::TASK_EXT, *task_shader),
        (vk::ShaderStageFlags::MESH_EXT, *mesh_shader),
        (vk::ShaderStageFlags::FRAGMENT, *frag_shader),
    ];
    let pipeline = create_draw_pipeline(device, *pipeline_layout, *render_pass, &stages, &state)?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;

    unsafe {
        for texture in &textures {
            let barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                texture.get(),
                texture_srr,
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            );
        }

        for (buffer, texture) in auxiliar_buffers.iter().zip(&textures) {
            device.cmd_copy_buffer_to_image(
                cmd,
                buffer.get(),
                texture.get(),
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &[texture_copy_region],
            );
        }

        for texture in &textures {
            let barrier = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                texture.get(),
                texture_srr,
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::MESH_SHADER_EXT,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            );
        }

        let clear_values = [clear_value_color([0.0, 0.0, 0.0, 1.0])];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(color_extent.width, color_extent.height))
            .clear_values(&clear_values);
        device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());

        let draw_count = params.draw_count();
        for (i, (offset_x, offset_y, color)) in quadrants.iter().enumerate() {
            let pc_data: Vec<u8> = [*offset_x, *offset_y, color[2]]
                .iter()
                .flat_map(|value| value.to_ne_bytes())
                .collect();
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_sets[i].get()],
                &[] as &[u32],
            );
            device.cmd_push_constants(cmd, *pipeline_layout, vk::ShaderStageFlags::MESH_EXT, 0, &pc_data);
            device.cmd_draw_mesh_tasks_ext(cmd, draw_count[0], draw_count[1], draw_count[2]);
        }

        device.cmd_end_render_pass(cmd);
    }

    let pre_copy_barrier = make_image_memory_barrier(
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        color_attachment.get(),
        color_srr,
    );
    let post_copy_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
    let copy_region = make_buffer_image_copy(color_extent, color_srl);
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
            color_attachment.get(),
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

/// `MixedPipelinesInstance::getQuadrantColors`
fn mixed_pipelines_quadrants(width: u32, height: u32) -> [(vk::Rect2D, Color); 4] {
    let (half_width, half_height) = (width / 2, height / 2);
    let rect = |x: u32, y: u32| vk::Rect2D {
        offset: vk::Offset2D {
            x: x as i32,
            y: y as i32,
        },
        extent: vk::Extent2D {
            width: half_width,
            height: half_height,
        },
    };
    [
        (rect(0, 0), [0.0, 0.0, 1.0, 1.0]),
        (rect(0, half_height), [0.0, 1.0, 1.0, 1.0]),
        (rect(half_width, 0), [1.0, 0.0, 1.0, 1.0]),
        (rect(half_width, half_height), [1.0, 1.0, 1.0, 1.0]),
    ]
}

/// `MixedPipelinesInstance::iterate`: alternates a classic and a mesh pipeline in one render pass, one quadrant each through a dynamic scissor.
fn run_mixed_pipelines(
    context: &Context<'_>,
    params: &MiscParams,
    dynamic_topology: bool,
) -> Result<Vec<u8>, TestError> {
    let device = context.get_device();
    let alloc = context.get_default_allocator();

    let image_format = OUTPUT_FORMAT;
    let image_extent = vk::Extent3D {
        width: params.width,
        height: params.height,
        depth: 1,
    };
    let color_buffer_info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(image_format)
        .extent(image_extent)
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
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

    let verification_buffer_size = (params.width * params.height * 4) as vk::DeviceSize;
    let verification_buffer = BufferWithMemory::new(
        device,
        alloc,
        make_buffer_create_info(verification_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let pc_size = 16u32;
    let pc_range = vk::PushConstantRange {
        stage_flags: vk::ShaderStageFlags::FRAGMENT,
        offset: 0,
        size: pc_size,
    };
    let layout_info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(std::slice::from_ref(&pc_range));
    let pipeline_layout = Unique::new(
        device,
        unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
    );

    let binaries = context.get_binary_collection();
    let vert_shader = create_shader_module(device, binaries.get("vert")?)?;
    let mesh_shader = create_shader_module(device, binaries.get("mesh")?)?;
    let frag_shader = create_shader_module(device, binaries.get("frag")?)?;

    let render_pass = make_misc_render_pass(device, image_format, false)?;
    let framebuffer = make_framebuffer(
        device,
        *render_pass,
        &[*color_view],
        image_extent.width,
        image_extent.height,
        1,
    )?;

    let blend_attachment = vk::PipelineColorBlendAttachmentState {
        blend_enable: vk::TRUE,
        src_color_blend_factor: vk::BlendFactor::ONE,
        dst_color_blend_factor: vk::BlendFactor::ONE,
        color_blend_op: vk::BlendOp::ADD,
        src_alpha_blend_factor: vk::BlendFactor::ONE,
        dst_alpha_blend_factor: vk::BlendFactor::ONE,
        alpha_blend_op: vk::BlendOp::ADD,
        color_write_mask: vk::ColorComponentFlags::all(),
    };

    let mut mesh_state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST)
        .with_full_viewport(image_extent.width, image_extent.height);
    mesh_state.color_blend_attachment = Some(blend_attachment);
    mesh_state.rasterization.depth_bias_enable = vk::FALSE;
    mesh_state.dynamic_states = vec![vk::DynamicState::SCISSOR];
    let mesh_pipeline = create_draw_pipeline(
        device,
        *pipeline_layout,
        *render_pass,
        &[
            (vk::ShaderStageFlags::MESH_EXT, *mesh_shader),
            (vk::ShaderStageFlags::FRAGMENT, *frag_shader),
        ],
        &mesh_state,
    )?;

    let static_topology = if dynamic_topology {
        vk::PrimitiveTopology::TRIANGLE_LIST
    } else {
        vk::PrimitiveTopology::TRIANGLE_STRIP
    };
    let mut classic_state =
        DrawPipelineState::new(static_topology).with_full_viewport(image_extent.width, image_extent.height);
    classic_state.color_blend_attachment = Some(blend_attachment);
    classic_state.rasterization.depth_bias_enable = vk::FALSE;
    classic_state.dynamic_states = vec![vk::DynamicState::SCISSOR];
    if dynamic_topology {
        classic_state.dynamic_states.push(vk::DynamicState::PRIMITIVE_TOPOLOGY);
    }
    let classic_pipeline = create_draw_pipeline(
        device,
        *pipeline_layout,
        *render_pass,
        &[
            (vk::ShaderStageFlags::VERTEX, *vert_shader),
            (vk::ShaderStageFlags::FRAGMENT, *frag_shader),
        ],
        &classic_state,
    )?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;

    let clear_values = [clear_value_color([0.0, 0.0, 0.0, 1.0])];
    let begin_info = vk::RenderPassBeginInfo::builder()
        .render_pass(*render_pass)
        .framebuffer(*framebuffer)
        .render_area(rect_2d(image_extent.width, image_extent.height))
        .clear_values(&clear_values);
    unsafe {
        device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
        for (idx, (rect, color)) in mixed_pipelines_quadrants(params.width, params.height)
            .iter()
            .enumerate()
        {
            device.cmd_set_scissor(cmd, 0, &[*rect]);
            let color_bytes: Vec<u8> = color.iter().flat_map(|value| value.to_ne_bytes()).collect();
            device.cmd_push_constants(cmd, *pipeline_layout, vk::ShaderStageFlags::FRAGMENT, 0, &color_bytes);

            if idx % 2 == 0 {
                if dynamic_topology {
                    device.cmd_set_primitive_topology_ext(cmd, vk::PrimitiveTopology::TRIANGLE_STRIP);
                }
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, classic_pipeline.get());
                device.cmd_draw(cmd, 4, 1, 0, 0);
            } else {
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, mesh_pipeline.get());
                device.cmd_draw_mesh_tasks_ext(cmd, 1, 1, 1);
            }
        }
        device.cmd_end_render_pass(cmd);
    }

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

/// 'x', 'y' or 'z' depending on if dim is 0, 1 or 2, respectively.
fn dim_suffix(dim: usize) -> char {
    ['x', 'y', 'z'][dim]
}

#[derive(Clone, Copy)]
enum Family {
    LocalSizeId,
    ComplexTaskData,
    SinglePoint {
        write_point_size: bool,
    },
    SingleLine,
    SingleTriangle,
    MaxPoints,
    MaxLines,
    MaxTriangles {
        workgroup_size: u32,
    },
    LargeWorkGroup {
        name_dim: usize,
        kind: LargeKind,
    },
    NoPrimitives {
        primitive: PrimitiveType,
    },
    SimpleBarrier {
        use_task: bool,
    },
    MemoryBarrier {
        barrier: MemoryBarrierType,
        use_task: bool,
        payload: PayloadType,
    },
    PayloadRead,
    MaximizePrimitives(MaximizeThreads),
    MaximizeVertices(MaximizeThreads),
    MaximizeInvocations(MaximizeThreads),
    FirstInvocation,
    MultipleOutputsVertices,
    PerPrimBlockOutput,
    PushConstant,
    CustomAttributes,
    Clip,
    PayloadNotAccessed,
    EmitInControlFlow {
        wrong_emit_last: bool,
    },
    MixedPipelines {
        dynamic_topology: bool,
    },
    RebindSets,
}

/// `MaximizeThreadsParams` beyond `MiscTestParams`.
#[derive(Clone, Copy)]
struct MaximizeThreads {
    local_size: u32,
    num_vertices: u32,
    num_primitives: u32,
}

/// `PrimitiveType`
#[derive(Clone, Copy)]
enum PrimitiveType {
    Points,
    Lines,
    Triangles,
}

/// `MemoryBarrierType`
#[derive(Clone, Copy)]
enum MemoryBarrierType {
    Shared,
    Group,
}

/// `PayloadType`
#[derive(Clone, Copy)]
enum PayloadType {
    Struct,
    Float,
    Vector,
    Array,
    Uint64,
}

#[derive(Clone, Copy)]
enum LargeKind {
    ManyTask,
    ManyMesh,
    ManyTaskMesh,
}

struct MeshShaderMiscCase {
    name: String,
    family: Family,
    params: MiscParams,
}

impl MeshShaderMiscCase {
    #[allow(clippy::new_ret_no_self)]
    fn new(name: impl Into<String>, family: Family, params: MiscParams) -> Box<dyn TestCase> {
        Box::new(Self {
            name: name.into(),
            family,
            params,
        })
    }
}

impl TestCase for MeshShaderMiscCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        // `MeshShaderMiscCase::checkSupport`
        generic_check_support(context, self.params.needs_task_shader(), false)?;

        match self.family {
            Family::SinglePoint {
                write_point_size: false,
            } => context.require_device_functionality("VK_KHR_maintenance5")?,
            Family::MaximizePrimitives(threads)
            | Family::MaximizeVertices(threads)
            | Family::MaximizeInvocations(threads) => {
                let properties = mesh_shader_properties(context);

                if threads.local_size > properties.max_mesh_work_group_size[0] {
                    return Err(TestError::NotSupported("Required local size not supported".to_string()));
                }

                if threads.num_vertices > properties.max_mesh_output_vertices {
                    return Err(TestError::NotSupported(
                        "Required number of output vertices not supported".to_string(),
                    ));
                }

                if threads.num_primitives > properties.max_mesh_output_primitives {
                    return Err(TestError::NotSupported(
                        "Required number of output primitives not supported".to_string(),
                    ));
                }
            }
            Family::CustomAttributes | Family::Clip => {
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

                if self.params.provoking_last {
                    context.require_device_functionality("VK_EXT_provoking_vertex")?;
                }

                if self.params.multiview {
                    let mut multiview_features = vk::PhysicalDeviceMultiviewFeatures::default();
                    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut multiview_features);
                    unsafe {
                        context
                            .get_instance()
                            .get_physical_device_features2(context.get_physical_device(), &mut features2)
                    };

                    if multiview_features.multiview == vk::FALSE {
                        return Err(TestError::NotSupported("Multiview not supported".to_string()));
                    }

                    if mesh_shader_features(context).multiview_mesh_shader == vk::FALSE {
                        return Err(TestError::NotSupported(
                            "Multiview not supported for mesh shaders".to_string(),
                        ));
                    }
                }
            }
            Family::MixedPipelines { dynamic_topology: true } => {
                context.require_device_functionality("VK_EXT_extended_dynamic_state")?
            }
            Family::LocalSizeId => context.require_device_functionality("VK_KHR_maintenance4")?,
            Family::FirstInvocation => {
                if context.api_version() < (1, 1, 0) {
                    return Err(TestError::NotSupported(
                        "Vulkan API version >= 1.1 required".to_string(),
                    ));
                }

                let mut subgroup_properties = vk::PhysicalDeviceSubgroupProperties::default();
                let mut properties = vk::PhysicalDeviceProperties2::builder().push_next(&mut subgroup_properties);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_properties2(context.get_physical_device(), &mut properties)
                };

                if !subgroup_properties
                    .supported_operations
                    .contains(vk::SubgroupFeatureFlags::BASIC)
                {
                    return Err(TestError::NotSupported(
                        "Subgroup basic features not supported".to_string(),
                    ));
                }
            }
            _ => {}
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.family {
            Family::LocalSizeId if self.params.needs_task_shader() => LOCAL_SIZE_ID_TASK.programs,
            Family::LocalSizeId => LOCAL_SIZE_ID_MESH.programs,
            Family::ComplexTaskData => MISC_COMPLEX_TASK_DATA.programs,
            Family::SinglePoint { write_point_size: true } => MISC_SINGLE_POINT.programs,
            Family::SinglePoint {
                write_point_size: false,
            } => MISC_SINGLE_POINT_DEFAULT_SIZE.programs,
            Family::SingleLine => MISC_SINGLE_LINE.programs,
            Family::SingleTriangle => MISC_SINGLE_TRIANGLE.programs,
            Family::MaxPoints => MISC_MAX_POINTS.programs,
            Family::MaxLines => MISC_MAX_LINES.programs,
            Family::MaxTriangles { workgroup_size: 64 } => MISC_MAX_TRIANGLES_WORKGROUPSIZE_64.programs,
            Family::MaxTriangles { workgroup_size: 32 } => MISC_MAX_TRIANGLES_WORKGROUPSIZE_32.programs,
            Family::MaxTriangles { .. } => MISC_MAX_TRIANGLES_WORKGROUPSIZE_16.programs,
            Family::LargeWorkGroup {
                name_dim: 0,
                kind: LargeKind::ManyTask,
            } => MISC_MANY_TASK_WORK_GROUPS_X.programs,
            Family::LargeWorkGroup {
                name_dim: 0,
                kind: LargeKind::ManyMesh,
            } => MISC_MANY_MESH_WORK_GROUPS_X.programs,
            Family::LargeWorkGroup {
                name_dim: 0,
                kind: LargeKind::ManyTaskMesh,
            } => MISC_MANY_TASK_MESH_WORK_GROUPS_X.programs,
            Family::LargeWorkGroup {
                name_dim: 1,
                kind: LargeKind::ManyTask,
            } => MISC_MANY_TASK_WORK_GROUPS_Y.programs,
            Family::LargeWorkGroup {
                name_dim: 1,
                kind: LargeKind::ManyMesh,
            } => MISC_MANY_MESH_WORK_GROUPS_Y.programs,
            Family::LargeWorkGroup {
                name_dim: 1,
                kind: LargeKind::ManyTaskMesh,
            } => MISC_MANY_TASK_MESH_WORK_GROUPS_Y.programs,
            Family::LargeWorkGroup {
                kind: LargeKind::ManyTask,
                ..
            } => MISC_MANY_TASK_WORK_GROUPS_Z.programs,
            Family::LargeWorkGroup {
                kind: LargeKind::ManyMesh,
                ..
            } => MISC_MANY_MESH_WORK_GROUPS_Z.programs,
            Family::LargeWorkGroup {
                kind: LargeKind::ManyTaskMesh,
                ..
            } => MISC_MANY_TASK_MESH_WORK_GROUPS_Z.programs,
            Family::NoPrimitives {
                primitive: PrimitiveType::Points,
            } => MISC_NO_POINTS.programs,
            Family::NoPrimitives {
                primitive: PrimitiveType::Lines,
            } => MISC_NO_LINES.programs,
            Family::NoPrimitives {
                primitive: PrimitiveType::Triangles,
            } => MISC_NO_TRIANGLES.programs,
            Family::SimpleBarrier { use_task: true } => MISC_BARRIER_IN_TASK.programs,
            Family::SimpleBarrier { use_task: false } => MISC_BARRIER_IN_MESH.programs,
            Family::MemoryBarrier {
                barrier: MemoryBarrierType::Shared,
                use_task: true,
                payload: PayloadType::Struct,
            } => MISC_MEMORY_BARRIER_SHARED_IN_TASK_STRUCT.programs,
            Family::MemoryBarrier {
                barrier: MemoryBarrierType::Shared,
                use_task: true,
                payload: PayloadType::Float,
            } => MISC_MEMORY_BARRIER_SHARED_IN_TASK_FLOAT.programs,
            Family::MemoryBarrier {
                barrier: MemoryBarrierType::Shared,
                use_task: true,
                payload: PayloadType::Vector,
            } => MISC_MEMORY_BARRIER_SHARED_IN_TASK_VECTOR.programs,
            Family::MemoryBarrier {
                barrier: MemoryBarrierType::Shared,
                use_task: true,
                payload: PayloadType::Array,
            } => MISC_MEMORY_BARRIER_SHARED_IN_TASK_ARRAY.programs,
            Family::MemoryBarrier {
                barrier: MemoryBarrierType::Shared,
                use_task: true,
                payload: PayloadType::Uint64,
            } => MISC_MEMORY_BARRIER_SHARED_IN_TASK_UINT64.programs,
            Family::MemoryBarrier {
                barrier: MemoryBarrierType::Shared,
                use_task: false,
                payload: PayloadType::Struct,
            } => MISC_MEMORY_BARRIER_SHARED_IN_MESH_STRUCT.programs,
            Family::MemoryBarrier {
                barrier: MemoryBarrierType::Shared,
                use_task: false,
                payload: PayloadType::Float,
            } => MISC_MEMORY_BARRIER_SHARED_IN_MESH_FLOAT.programs,
            Family::MemoryBarrier {
                barrier: MemoryBarrierType::Shared,
                use_task: false,
                payload: PayloadType::Vector,
            } => MISC_MEMORY_BARRIER_SHARED_IN_MESH_VECTOR.programs,
            Family::MemoryBarrier {
                barrier: MemoryBarrierType::Shared,
                use_task: false,
                payload: PayloadType::Array,
            } => MISC_MEMORY_BARRIER_SHARED_IN_MESH_ARRAY.programs,
            Family::MemoryBarrier {
                barrier: MemoryBarrierType::Shared,
                use_task: false,
                payload: PayloadType::Uint64,
            } => MISC_MEMORY_BARRIER_SHARED_IN_MESH_UINT64.programs,
            Family::MemoryBarrier {
                barrier: MemoryBarrierType::Group,
                use_task: true,
                payload: PayloadType::Struct,
            } => MISC_GROUP_MEMORY_BARRIER_IN_TASK_STRUCT.programs,
            Family::MemoryBarrier {
                barrier: MemoryBarrierType::Group,
                use_task: true,
                payload: PayloadType::Float,
            } => MISC_GROUP_MEMORY_BARRIER_IN_TASK_FLOAT.programs,
            Family::MemoryBarrier {
                barrier: MemoryBarrierType::Group,
                use_task: true,
                payload: PayloadType::Vector,
            } => MISC_GROUP_MEMORY_BARRIER_IN_TASK_VECTOR.programs,
            Family::MemoryBarrier {
                barrier: MemoryBarrierType::Group,
                use_task: true,
                payload: PayloadType::Array,
            } => MISC_GROUP_MEMORY_BARRIER_IN_TASK_ARRAY.programs,
            Family::MemoryBarrier {
                barrier: MemoryBarrierType::Group,
                use_task: true,
                payload: PayloadType::Uint64,
            } => MISC_GROUP_MEMORY_BARRIER_IN_TASK_UINT64.programs,
            Family::MemoryBarrier {
                barrier: MemoryBarrierType::Group,
                use_task: false,
                payload: PayloadType::Struct,
            } => MISC_GROUP_MEMORY_BARRIER_IN_MESH_STRUCT.programs,
            Family::MemoryBarrier {
                barrier: MemoryBarrierType::Group,
                use_task: false,
                payload: PayloadType::Float,
            } => MISC_GROUP_MEMORY_BARRIER_IN_MESH_FLOAT.programs,
            Family::MemoryBarrier {
                barrier: MemoryBarrierType::Group,
                use_task: false,
                payload: PayloadType::Vector,
            } => MISC_GROUP_MEMORY_BARRIER_IN_MESH_VECTOR.programs,
            Family::MemoryBarrier {
                barrier: MemoryBarrierType::Group,
                use_task: false,
                payload: PayloadType::Array,
            } => MISC_GROUP_MEMORY_BARRIER_IN_MESH_ARRAY.programs,
            Family::MemoryBarrier {
                barrier: MemoryBarrierType::Group,
                use_task: false,
                payload: PayloadType::Uint64,
            } => MISC_GROUP_MEMORY_BARRIER_IN_MESH_UINT64.programs,
            Family::PayloadRead => MISC_PAYLOAD_READ.programs,
            Family::MaximizePrimitives(_) => MISC_MAXIMIZE_PRIMITIVES.programs,
            Family::MaximizeVertices(_) => MISC_MAXIMIZE_VERTICES.programs,
            Family::MaximizeInvocations(MaximizeThreads { local_size: 32, .. }) => {
                MISC_MAXIMIZE_INVOCATIONS_32.programs
            }
            Family::MaximizeInvocations(MaximizeThreads { local_size: 64, .. }) => {
                MISC_MAXIMIZE_INVOCATIONS_64.programs
            }
            Family::MaximizeInvocations(MaximizeThreads { local_size: 128, .. }) => {
                MISC_MAXIMIZE_INVOCATIONS_128.programs
            }
            Family::MaximizeInvocations(_) => MISC_MAXIMIZE_INVOCATIONS_256.programs,
            Family::FirstInvocation if self.params.needs_task_shader() => MISC_FIRST_INVOCATION_TASK.programs,
            Family::FirstInvocation => MISC_FIRST_INVOCATION_MESH.programs,
            Family::MultipleOutputsVertices => MISC_MULTIPLE_OUTPUTS_VERTICES.programs,
            Family::PerPrimBlockOutput => MISC_PER_PRIM_BLOCK_OUTPUT.programs,
            Family::PushConstant if self.params.needs_task_shader() => MISC_PUSH_CONSTANT_AND_TASK_SHADER.programs,
            Family::PushConstant => MISC_PUSH_CONSTANT.programs,
            Family::CustomAttributes if self.params.needs_task_shader() => {
                MISC_CUSTOM_ATTRIBUTES_AND_TASK_SHADER.programs
            }
            Family::CustomAttributes => MISC_CUSTOM_ATTRIBUTES.programs,
            Family::PayloadNotAccessed => MISC_PAYLOAD_NOT_ACCESSED.programs,
            Family::MixedPipelines { .. } => MISC_MIXED_PIPELINES.programs,
            Family::RebindSets => MISC_REBIND_SETS.programs,
            Family::EmitInControlFlow { wrong_emit_last: false } => MISC_EMIT_IN_CONTROL_FLOW.programs,
            Family::EmitInControlFlow { wrong_emit_last: true } => MISC_EMIT_IN_CONTROL_FLOW_BAD_EMIT_LAST.programs,
            Family::Clip => match (
                self.params.clip_distances,
                self.params.needs_task_shader(),
                self.params.provoking_last,
            ) {
                (false, false, false) => MISC_CLIP_GEOM.programs,
                (false, true, false) => MISC_CLIP_GEOM_AND_TASK_SHADER.programs,
                (false, false, true) => MISC_CLIP_GEOM_PROVOKING_LAST.programs,
                (false, true, true) => MISC_CLIP_GEOM_AND_TASK_SHADER_PROVOKING_LAST.programs,
                (true, false, false) => MISC_CLIP_PLANE.programs,
                (true, true, false) => MISC_CLIP_PLANE_AND_TASK_SHADER.programs,
                (true, false, true) => MISC_CLIP_PLANE_PROVOKING_LAST.programs,
                (true, true, true) => MISC_CLIP_PLANE_AND_TASK_SHADER_PROVOKING_LAST.programs,
            },
        }
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

impl MeshShaderMiscInstance<'_> {
    /// Each family's `generateReferenceLevel`.
    fn reference(&self) -> Reference {
        let params = &self.params;
        let (width, height) = (params.width, params.height);
        let transparent_black = [0.0, 0.0, 0.0, 0.0];

        let image = |color: Color| Reference::image(width, height, color);
        let set_pixel =
            |image: &mut Vec<[u8; 4]>, x: u32, y: u32, color: Color| image[(y * width + x) as usize] = to_bytes(color);

        match self.family {
            Family::LocalSizeId => Reference::Solid([0.0, 0.0, 1.0, 1.0]),
            Family::ComplexTaskData => {
                let (half_width, half_height) = (width / 2, height / 2);
                let mut reference = image(transparent_black);
                // Each image quadrant gets a different color.
                for y in 0..height {
                    for x in 0..width {
                        let red = if y < half_height { 0.0 } else { 1.0 };
                        let green = if x < half_width { 0.0 } else { 1.0 };
                        set_pixel(&mut reference, x, y, [red, green, 1.0, 1.0]);
                    }
                }
                Reference::Image(reference)
            }
            Family::SinglePoint { .. } | Family::SingleTriangle => {
                // Single pixel in the center.
                let mut reference = image(transparent_black);
                set_pixel(&mut reference, width / 2, height / 2, [0.0, 1.0, 1.0, 1.0]);
                Reference::Image(reference)
            }
            Family::SingleLine => {
                let mut reference = image(transparent_black);
                // Center row.
                for x in 0..width {
                    set_pixel(&mut reference, x, height / 2, [0.0, 1.0, 1.0, 1.0]);
                }
                Reference::Image(reference)
            }
            Family::MaxPoints => {
                let mut reference = image(transparent_black);
                // Fill with gradient like the shader does.
                for y in 0..height {
                    for x in 0..width {
                        set_pixel(
                            &mut reference,
                            x,
                            y,
                            [
                                (x as f32 + 0.5) / width as f32,
                                (y as f32 + 0.5) / height as f32,
                                0.0,
                                1.0,
                            ],
                        );
                    }
                }
                Reference::Image(reference)
            }
            Family::MaxLines => {
                let mut reference = image(transparent_black);
                // Fill lines, 4 pixels per line.
                let num_lines = 255u32;
                let line_height = 4u32;
                for i in 0..num_lines {
                    let color = [0.0, 1.0, i as f32 / num_lines as f32, 1.0];
                    for j in 0..line_height {
                        set_pixel(&mut reference, 0, i * line_height + j, color);
                    }
                }
                Reference::Image(reference)
            }
            Family::MaxTriangles { .. }
            | Family::LargeWorkGroup { .. }
            | Family::SimpleBarrier { .. }
            | Family::PayloadRead
            | Family::MaximizeVertices(_)
            | Family::PushConstant
            | Family::MaximizeInvocations(_) => Reference::Solid([0.0, 0.0, 1.0, 1.0]),
            // Red and blue points on top of each other, blended additively.
            Family::MaximizePrimitives(_) => Reference::Solid([1.0, 0.0, 1.0, 1.0]),
            Family::PerPrimBlockOutput => Reference::Solid([1.0, 1.0, 0.0, 1.0]),
            Family::CustomAttributes | Family::Clip => {
                let mut reference = image(transparent_black);
                // The top left quarter, or the whole top half when the geometry is clipped instead of using clip distances.
                let used_width = if params.clip_distances { width / 2 } else { width };
                for y in 0..height / 2 {
                    for x in 0..used_width {
                        set_pixel(&mut reference, x, y, [0.0, 0.0, 1.0, 1.0]);
                    }
                }
                Reference::Image(reference)
            }
            Family::FirstInvocation => {
                const COLORED_PIXELS: u32 = 120;
                let mut reference = image(transparent_black);
                // Only the first invocation's count is used, so exactly the leading pixels are drawn.
                for x in 0..COLORED_PIXELS {
                    set_pixel(&mut reference, x, 0, [0.0, 0.0, 1.0, 1.0]);
                }
                Reference::Image(reference)
            }
            Family::RebindSets => {
                let mut reference = image([0.0, 0.0, 0.0, 1.0]);
                for (offset_x, offset_y, color) in rebind_sets_quadrants() {
                    let x_corner = (offset_x / 2.0 * width as f32) as u32;
                    let y_corner = (offset_y / 2.0 * height as f32) as u32;
                    for y in y_corner..y_corner + height / 2 {
                        for x in x_corner..x_corner + width / 2 {
                            set_pixel(&mut reference, x, y, color);
                        }
                    }
                }
                Reference::Image(reference)
            }
            Family::MixedPipelines { .. } => {
                let mut reference = image([0.0, 0.0, 0.0, 1.0]);
                for (rect, color) in mixed_pipelines_quadrants(width, height) {
                    for y in rect.offset.y as u32..rect.offset.y as u32 + rect.extent.height {
                        for x in rect.offset.x as u32..rect.offset.x as u32 + rect.extent.width {
                            set_pixel(&mut reference, x, y, color);
                        }
                    }
                }
                Reference::Image(reference)
            }
            Family::EmitInControlFlow { .. } => {
                let mut reference = image(transparent_black);
                // Only the left pixel is covered, as the first work group emits a single mesh work group.
                set_pixel(&mut reference, 0, 0, [0.0, 0.0, 1.0, 1.0]);
                Reference::Image(reference)
            }
            Family::MultipleOutputsVertices | Family::PayloadNotAccessed => {
                let mut reference = image(transparent_black);
                for y in 0..height {
                    for x in 0..width {
                        // Red and blue are halved because value 1.0 is at coordinate 3.0 for both.
                        let red = (x as f32 + 0.5) / width as f32 * 0.5;
                        let blue = (y as f32 + 0.5) / height as f32 * 0.5;
                        set_pixel(&mut reference, x, y, [red, 0.0, blue, 1.0]);
                    }
                }
                Reference::Image(reference)
            }
            // No primitives: clear color.
            Family::NoPrimitives { .. } => Reference::Solid(transparent_black),
            // Any of the two results is considered valid.
            Family::MemoryBarrier { .. } => Reference::AnyOf(vec![
                Reference::Solid([0.0, 0.0, 1.0, 1.0]),
                Reference::Solid([0.0, 0.0, 0.0, 1.0]),
            ]),
        }
    }
}

impl TestInstance for MeshShaderMiscInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        if let Family::MixedPipelines { dynamic_topology } = self.family {
            let result = run_mixed_pipelines(self.context, &self.params, dynamic_topology)?;
            self.reference().verify(&result)?;
            return Ok(TestStatus::pass("Pass"));
        }

        if let Family::RebindSets = self.family {
            let result = run_rebind_sets(self.context, &self.params)?;
            self.reference().verify(&result)?;
            return Ok(TestStatus::pass("Pass"));
        }

        let results = draw_misc(self.context, &self.params)?;
        let reference = self.reference();
        for (view, result) in results.iter().enumerate() {
            reference.verify(result).map_err(|error| match (view, error) {
                (1.., TestError::Fail(_)) => TestError::Fail(
                    "Result does not match reference for multiview view = 1; check log for details".to_string(),
                ),
                (_, error) => error,
            })?;
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createMeshShaderMiscTestsEXT`
pub fn create_mesh_shader_misc_tests_ext() -> TestCaseGroup {
    let mut misc_tests = TestCaseGroup::new("misc");

    // Pass a complex structure from the task to the mesh shader.
    misc_tests.add_child(MeshShaderMiscCase::new(
        "complex_task_data",
        Family::ComplexTaskData,
        MiscParams::new(Some([2, 1, 1]), [2, 1, 1], 8, 8),
    ));

    // Draw a single point. Use an odd value so there's a pixel in the exact center.
    misc_tests.add_child(MeshShaderMiscCase::new(
        "single_point",
        Family::SinglePoint { write_point_size: true },
        MiscParams::new(None, [1, 1, 1], 5, 7),
    ));

    // VK_KHR_maintenance5: test default point size is 1.0f. Draw a single point without writing to PointSize.
    misc_tests.add_child(MeshShaderMiscCase::new(
        "single_point_default_size",
        Family::SinglePoint {
            write_point_size: false,
        },
        MiscParams::new(None, [1, 1, 1], 5, 7),
    ));

    // Draw a single line. Use an odd value so there's a center line.
    misc_tests.add_child(MeshShaderMiscCase::new(
        "single_line",
        Family::SingleLine,
        MiscParams::new(None, [1, 1, 1], 8, 5),
    ));

    // Draw a single triangle.
    misc_tests.add_child(MeshShaderMiscCase::new(
        "single_triangle",
        Family::SingleTriangle,
        MiscParams::new(None, [1, 1, 1], 5, 7),
    ));

    // Draw the maximum number of points.
    misc_tests.add_child(MeshShaderMiscCase::new(
        "max_points",
        Family::MaxPoints,
        MiscParams::new(None, [1, 1, 1], 16, 16),
    ));

    // Draw the maximum number of lines.
    misc_tests.add_child(MeshShaderMiscCase::new(
        "max_lines",
        Family::MaxLines,
        MiscParams::new(None, [1, 1, 1], 1, 1020),
    ));

    // Draw the maximum number of triangles using a work group size of...
    for local_size in [[2u32, 4, 8], [4, 2, 4], [2, 2, 4]] {
        let work_group_size = local_size[0] * local_size[1] * local_size[2];
        let test_name = format!("max_triangles_workgroupsize_{work_group_size}");
        misc_tests.add_child(MeshShaderMiscCase::new(
            test_name,
            Family::MaxTriangles {
                workgroup_size: work_group_size,
            },
            MiscParams::new(None, [1, 1, 1], 512, 512),
        ));
    }

    for dim in 0..3usize {
        let dim_char = dim_suffix(dim);

        {
            let mut task_count = [8u32, 8, 8];
            task_count[dim] = 65535;
            misc_tests.add_child(MeshShaderMiscCase::new(
                format!("many_task_work_groups_{dim_char}"),
                Family::LargeWorkGroup {
                    name_dim: dim,
                    kind: LargeKind::ManyTask,
                },
                MiscParams::new(Some(task_count), [0, 0, 0], 2040, 2056),
            ));
        }

        {
            let mut mesh_count = [8u32, 8, 8];
            mesh_count[dim] = 65535;
            misc_tests.add_child(MeshShaderMiscCase::new(
                format!("many_mesh_work_groups_{dim_char}"),
                Family::LargeWorkGroup {
                    name_dim: dim,
                    kind: LargeKind::ManyMesh,
                },
                MiscParams::new(None, mesh_count, 2040, 2056),
            ));
        }

        {
            let mut mesh_count = [1u32, 1, 1];
            let mut task_count = [1u32, 1, 1];
            mesh_count[dim] = 256;
            task_count[dim] = 128;
            misc_tests.add_child(MeshShaderMiscCase::new(
                format!("many_task_mesh_work_groups_{dim_char}"),
                Family::LargeWorkGroup {
                    name_dim: dim,
                    kind: LargeKind::ManyTaskMesh,
                },
                MiscParams::new(Some(task_count), mesh_count, 2048, 2048),
            ));
        }
    }

    {
        // The extra-writes variant is skipped upstream too (it may be illegal), and the other three work around VK-GL-CTS issue 5589.
        for (primitive, primitive_name) in [
            (PrimitiveType::Points, "points"),
            (PrimitiveType::Lines, "lines"),
            (PrimitiveType::Triangles, "triangles"),
        ] {
            misc_tests.add_child(MeshShaderMiscCase::new(
                format!("no_{primitive_name}"),
                Family::NoPrimitives { primitive },
                MiscParams::new(None, [1, 1, 1], 16, 16),
            ));
        }
    }

    for use_task_shader in [true, false] {
        let task_count = if use_task_shader { Some([1u32, 1, 1]) } else { None };
        let name = format!("barrier_in_{}", if use_task_shader { "task" } else { "mesh" });
        misc_tests.add_child(MeshShaderMiscCase::new(
            name,
            Family::SimpleBarrier {
                use_task: use_task_shader,
            },
            MiscParams::new(task_count, [1, 1, 1], 1, 1),
        ));
    }

    {
        let barrier_types = [
            (MemoryBarrierType::Shared, "memory_barrier_shared"),
            (MemoryBarrierType::Group, "group_memory_barrier"),
        ];
        let payload_types = [
            (PayloadType::Struct, "struct"),
            (PayloadType::Float, "float"),
            (PayloadType::Vector, "vector"),
            (PayloadType::Array, "array"),
            (PayloadType::Uint64, "uint64"),
        ];

        for (barrier, barrier_name) in barrier_types {
            for use_task_shader in [true, false] {
                for (payload, payload_name) in payload_types {
                    let task_count = if use_task_shader { Some([1u32, 1, 1]) } else { None };
                    let shader = if use_task_shader { "task" } else { "mesh" };
                    let name = format!("{barrier_name}_in_{shader}_{payload_name}");
                    misc_tests.add_child(MeshShaderMiscCase::new(
                        name,
                        Family::MemoryBarrier {
                            barrier,
                            use_task: use_task_shader,
                            payload,
                        },
                        MiscParams::new(task_count, [1, 1, 1], 1, 1),
                    ));
                }
            }
        }
    }

    misc_tests.add_child(MeshShaderMiscCase::new(
        "payload_read",
        Family::PayloadRead,
        MiscParams::new(Some([1, 1, 1]), [1, 1, 1], 8, 8),
    ));

    {
        let threads = MaximizeThreads {
            local_size: 32,
            num_vertices: 128,
            num_primitives: 256,
        };
        misc_tests.add_child(MeshShaderMiscCase::new(
            "maximize_primitives",
            Family::MaximizePrimitives(threads),
            MiscParams::new(None, [1, 1, 1], 128, 1),
        ));
    }

    {
        let threads = MaximizeThreads {
            local_size: 32,
            num_vertices: 256,
            num_primitives: 128,
        };
        misc_tests.add_child(MeshShaderMiscCase::new(
            "maximize_vertices",
            Family::MaximizeVertices(threads),
            MiscParams::new(None, [1, 1, 1], 64, 1),
        ));
    }

    for invocation_case in [32u32, 64, 128, 256] {
        let num_pixels = invocation_case / 2;
        let threads = MaximizeThreads {
            local_size: invocation_case,
            num_vertices: num_pixels,
            num_primitives: num_pixels,
        };
        misc_tests.add_child(MeshShaderMiscCase::new(
            format!("maximize_invocations_{invocation_case}"),
            Family::MaximizeInvocations(threads),
            MiscParams::new(None, [1, 1, 1], num_pixels, 1),
        ));
    }

    misc_tests.add_child(MeshShaderMiscCase::new(
        "rebind_sets",
        Family::RebindSets,
        MiscParams::new(Some([1, 1, 1]), [1, 1, 1], 8, 8),
    ));

    for dynamic_topology in [false, true] {
        let name = format!(
            "mixed_pipelines{}",
            if dynamic_topology { "_dynamic_topology" } else { "" }
        );
        misc_tests.add_child(MeshShaderMiscCase::new(
            name,
            Family::MixedPipelines { dynamic_topology },
            MiscParams::new(None, [1, 1, 1], 8, 8),
        ));
    }

    for use_task_shader in [false, true] {
        let task_count = if use_task_shader { Some([1u32, 1, 1]) } else { None };
        let test_name = format!("first_invocation_{}", if use_task_shader { "task" } else { "mesh" });
        misc_tests.add_child(MeshShaderMiscCase::new(
            test_name,
            Family::FirstInvocation,
            MiscParams::new(task_count, [1, 1, 1], 128, 1),
        ));
    }

    // Tests that check LocalSizeId works as expected.
    for use_task in [false, true] {
        let task_count = if use_task { Some([1u32, 1, 1]) } else { None };
        let test_name = format!("local_size_id_{}", if use_task { "task" } else { "mesh" });
        misc_tests.add_child(MeshShaderMiscCase::new(
            test_name,
            Family::LocalSizeId,
            MiscParams::new(task_count, [1, 1, 1], 32, 1).with_local_size_id(),
        ));
    }

    super::work_group_ordering_tests::add_work_group_ordering_tests(&mut misc_tests);

    misc_tests.add_child(MeshShaderMiscCase::new(
        "multiple_outputs_vertices",
        Family::MultipleOutputsVertices,
        MiscParams::new(None, [1, 1, 1], 8, 8),
    ));

    misc_tests.add_child(MeshShaderMiscCase::new(
        "per_prim_block_output",
        Family::PerPrimBlockOutput,
        MiscParams::new(None, [1, 1, 1], 32, 32),
    ));

    misc_tests.add_child(MeshShaderMiscCase::new(
        "payload_not_accessed",
        Family::PayloadNotAccessed,
        MiscParams::new(None, [1, 1, 1], 8, 8).with_single_push_constant(),
    ));

    for wrong_emit_last in [false, true] {
        let name = format!(
            "emit_in_control_flow{}",
            if wrong_emit_last { "_bad_emit_last" } else { "" }
        );
        misc_tests.add_child(MeshShaderMiscCase::new(
            name,
            Family::EmitInControlFlow { wrong_emit_last },
            MiscParams::new(Some([1, 1, 1]), [1, 1, 1], 2, 1),
        ));
    }

    for use_task_shader in [false, true] {
        let task_count = if use_task_shader { Some([1u32, 1, 1]) } else { None };
        let name = format!(
            "custom_attributes{}",
            if use_task_shader { "_and_task_shader" } else { "" }
        );
        misc_tests.add_child(MeshShaderMiscCase::new(
            name,
            Family::CustomAttributes,
            MiscParams::new(task_count, [1, 1, 1], 32, 32).with_custom_attributes(),
        ));
    }

    for use_task_shader in [false, true] {
        for use_clip_planes in [false, true] {
            for use_provoking_vertex_last in [false, true] {
                for use_multiview in [false, true] {
                    let task_count = if use_task_shader { Some([1u32, 1, 1]) } else { None };
                    let name = format!(
                        "{}{}{}{}",
                        if use_clip_planes { "clip_plane" } else { "clip_geom" },
                        if use_task_shader { "_and_task_shader" } else { "" },
                        if use_provoking_vertex_last {
                            "_provoking_last"
                        } else {
                            ""
                        },
                        if use_multiview { "_multiview" } else { "" },
                    );
                    let params = MiscParams::new(task_count, [1, 1, 1], 32, 32).with_clip(
                        use_clip_planes,
                        use_provoking_vertex_last,
                        use_multiview,
                    );
                    misc_tests.add_child(MeshShaderMiscCase::new(name, Family::Clip, params));
                }
            }
        }
    }

    for use_task_shader in [false, true] {
        let task_count = if use_task_shader { Some([1u32, 1, 1]) } else { None };
        let name = format!("push_constant{}", if use_task_shader { "_and_task_shader" } else { "" });
        misc_tests.add_child(MeshShaderMiscCase::new(
            name,
            Family::PushConstant,
            MiscParams::new(task_count, [1, 1, 1], 16, 16).with_push_constants(),
        ));
    }

    super::vertex_state_tests::add_vertex_state_cases(&mut misc_tests);

    misc_tests
}
