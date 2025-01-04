// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktDynamicRenderingLocalReadTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Copyright (c) 2023 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Ported: the `null_color_attachment_location_*` cases
// (NullAttachmentLocationsTestCase), the `mapping_*_attachments_to_locs_from_*` cases (RemappingToHighLocationTestCase)
// and the `attachment_mapping_*` cases (AttachmentMappingTestCase). The pipeline is always monolithic, built without
// `GraphicsPipelineWrapper`; `LocalReadTestCase`'s BasicLocalReadTestInstance cases are in
// `dynamic_rendering_local_read_basic_tests`, and the rest (the blend state, graphics pipeline library, shader object and
// feedback loop instances, RemappingWithGapTestCase and the variants over graphics pipeline libraries) is registered there as
// stubs. The image comparison log is dropped.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_3, KhrDynamicRenderingLocalReadExtensionDeviceCommands};

use crate::generated::shaders::renderpass_dynamic_rendering_local_read::{
    LOCAL_READ_HIGH_1_FROM_1, LOCAL_READ_HIGH_1_FROM_2, LOCAL_READ_HIGH_1_FROM_3, LOCAL_READ_HIGH_2_FROM_2,
    LOCAL_READ_MAP_A4_I0, LOCAL_READ_MAP_A4_I2, LOCAL_READ_MAP_A8_I4, LOCAL_READ_MAP_A8_I6, LOCAL_READ_NULL,
};
use crate::tcu::image_compare::float_threshold_compare;
use crate::tcu::pixel::{ConstPixelBufferAccess, TextureLevel, clear};
use crate::tcu::texture::map_vk_format;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{rect_2d, viewport};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const RENDER_SIZE: u32 = 16;
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
/// `kMaxLocation`
const MAX_LOCATION: u32 = 3;

struct ColorTargets<'a> {
    images: Vec<ImageWithMemory<'a>>,
    views: Vec<Unique<'a, vk::ImageView>>,
    output_buffers: Vec<BufferWithMemory<'a>>,
}

/// The per-attachment image, view and readback buffer both upstream tests create in the same loop.
fn create_targets<'a>(
    context: &'a Context<'_>,
    count: u32,
    usage: vk::ImageUsageFlags,
) -> Result<ColorTargets<'a>, TestError> {
    let device = context.get_device();
    let allocator = context.get_default_allocator();
    let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let output_buffer_size = u64::from(RENDER_SIZE * RENDER_SIZE * 4);

    let mut targets = ColorTargets {
        images: Vec::new(),
        views: Vec::new(),
        output_buffers: Vec::new(),
    };
    for _ in 0..count {
        let create_info = vk::ImageCreateInfo {
            s_type: vk::StructureType::IMAGE_CREATE_INFO,
            next: std::ptr::null(),
            flags: vk::ImageCreateFlags::empty(),
            image_type: vk::ImageType::_2D,
            format: COLOR_FORMAT,
            extent: vk::Extent3D {
                width: RENDER_SIZE,
                height: RENDER_SIZE,
                depth: 1,
            },
            mip_levels: 1,
            array_layers: 1,
            samples: vk::SampleCountFlags::_1,
            tiling: vk::ImageTiling::OPTIMAL,
            usage,
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 0,
            queue_family_indices: std::ptr::null(),
            initial_layout: vk::ImageLayout::UNDEFINED,
        };
        let image = ImageWithMemory::new(device, allocator, create_info, MemoryRequirement::ANY)?;
        targets.views.push(make_image_view(
            device,
            image.get(),
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            color_srr,
        )?);
        targets.images.push(image);
        targets.output_buffers.push(BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                output_buffer_size,
                vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?);
    }
    Ok(targets)
}

/// `makeDynamicRenderingAttachmentInfo` for a clear to opaque black
fn make_attachment_info(
    image_view: vk::ImageView,
    image_layout: vk::ImageLayout,
    load_op: vk::AttachmentLoadOp,
) -> vk::RenderingAttachmentInfo {
    vk::RenderingAttachmentInfo::builder()
        .image_view(image_view)
        .image_layout(image_layout)
        .resolve_mode(vk::ResolveModeFlags::NONE)
        .resolve_image_view(vk::ImageView::null())
        .resolve_image_layout(vk::ImageLayout::UNDEFINED)
        .load_op(load_op)
        .store_op(vk::AttachmentStoreOp::STORE)
        .clear_value(vk::ClearValue {
            color: vk::ClearColorValue {
                float32: [0.0, 0.0, 0.0, 1.0],
            },
        })
        .build()
}

fn attachment_location_info(count: u32, locations: *const u32) -> vk::RenderingAttachmentLocationInfo {
    vk::RenderingAttachmentLocationInfo {
        s_type: vk::StructureType::RENDERING_ATTACHMENT_LOCATION_INFO,
        next: std::ptr::null(),
        color_attachment_count: count,
        color_attachment_locations: locations,
    }
}

fn input_attachment_index_info(count: u32, indices: *const u32) -> vk::RenderingInputAttachmentIndexInfo {
    vk::RenderingInputAttachmentIndexInfo {
        s_type: vk::StructureType::RENDERING_INPUT_ATTACHMENT_INDEX_INFO,
        next: std::ptr::null(),
        color_attachment_count: count,
        color_attachment_input_indices: indices,
        depth_input_attachment_index: std::ptr::null(),
        stencil_input_attachment_index: std::ptr::null(),
    }
}

/// One monolithic pipeline for dynamic rendering into `attachment_count` colour attachments of `COLOR_FORMAT`, with blending
/// disabled and every channel written, and the optional attachment location and input attachment index infos chained.
fn make_pipeline<'a>(
    device: &'a Device,
    layout: vk::PipelineLayout,
    vertex_module: vk::ShaderModule,
    fragment_module: vk::ShaderModule,
    attachment_count: u32,
    location_info: Option<&mut vk::RenderingAttachmentLocationInfo>,
    input_index_info: Option<&mut vk::RenderingInputAttachmentIndexInfo>,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let formats = vec![COLOR_FORMAT; attachment_count as usize];
    let mut rendering_create_info = vk::PipelineRenderingCreateInfo::builder()
        .view_mask(0)
        .color_attachment_formats(&formats)
        .depth_attachment_format(vk::Format::UNDEFINED)
        .stencil_attachment_format(vk::Format::UNDEFINED);

    let stages = [
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::VERTEX)
            .module(vertex_module)
            .name(b"main\0")
            .build(),
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::FRAGMENT)
            .module(fragment_module)
            .name(b"main\0")
            .build(),
    ];
    let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder();
    let input_assembly_state =
        vk::PipelineInputAssemblyStateCreateInfo::builder().topology(vk::PrimitiveTopology::TRIANGLE_STRIP);
    let viewports = [viewport(0.0, 0.0, RENDER_SIZE as f32, RENDER_SIZE as f32, 0.0, 1.0)];
    let scissors = [rect_2d(RENDER_SIZE, RENDER_SIZE)];
    let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
        .viewports(&viewports)
        .scissors(&scissors);
    let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(false)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .depth_bias_enable(false)
        .line_width(1.0);
    let multisample_state =
        vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
    let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder();
    let color_blend_attachment_states = vec![
        vk::PipelineColorBlendAttachmentState::builder()
            .color_write_mask(vk::ColorComponentFlags::all())
            .build();
        attachment_count as usize
    ];
    let color_blend_state =
        vk::PipelineColorBlendStateCreateInfo::builder().attachments(&color_blend_attachment_states);

    let mut info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&stages)
        .vertex_input_state(&vertex_input_state)
        .input_assembly_state(&input_assembly_state)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization_state)
        .multisample_state(&multisample_state)
        .depth_stencil_state(&depth_stencil_state)
        .color_blend_state(&color_blend_state)
        .layout(layout)
        .render_pass(vk::RenderPass::null())
        .subpass(0)
        .base_pipeline_index(0)
        .push_next(&mut rendering_create_info);
    if let Some(location_info) = location_info {
        info = info.push_next(location_info);
    }
    if let Some(input_index_info) = input_index_info {
        info = info.push_next(input_index_info);
    }

    let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateGraphicsPipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

/// The barrier every attachment gets before rendering and again before the readback copy.
fn color_barrier(
    image: vk::Image,
    src: vk::AccessFlags,
    dst: vk::AccessFlags,
    old_layout: vk::ImageLayout,
    new_layout: vk::ImageLayout,
) -> vk::ImageMemoryBarrier {
    make_image_memory_barrier(
        src,
        dst,
        old_layout,
        new_layout,
        image,
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
    )
}

fn pipeline_barrier(
    device: &Device,
    cmd: vk::CommandBuffer,
    src_stage: vk::PipelineStageFlags,
    dst_stage: vk::PipelineStageFlags,
    flags: vk::DependencyFlags,
    barriers: &[vk::ImageMemoryBarrier],
) {
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            src_stage,
            dst_stage,
            flags,
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            barriers,
        )
    };
}

fn copy_to_output_buffers(device: &Device, cmd: vk::CommandBuffer, targets: &ColorTargets<'_>) {
    let color_sl = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1);
    let copy_region = make_buffer_image_copy(
        vk::Extent3D {
            width: RENDER_SIZE,
            height: RENDER_SIZE,
            depth: 1,
        },
        color_sl,
    );
    for (image, buffer) in targets.images.iter().zip(&targets.output_buffers) {
        unsafe {
            device.cmd_copy_image_to_buffer(
                cmd,
                image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                buffer.get(),
                &[copy_region],
            )
        };
    }
}

/// `tcu::floatThresholdCompare` of an output buffer against a uniform colour, threshold 0.005.
fn buffer_matches_color(
    context: &Context<'_>,
    buffer: &BufferWithMemory<'_>,
    expected: [f32; 4],
) -> Result<bool, TestError> {
    let allocation = buffer.get_allocation();
    invalidate_alloc(context.get_device(), allocation)?;

    let texture_format =
        map_vk_format(COLOR_FORMAT).ok_or_else(|| TestError::InternalError("no texture format".to_string()))?;
    let mut expected_level = TextureLevel::new(texture_format, RENDER_SIZE, RENDER_SIZE, 1)?;
    clear(&mut expected_level.get_access(), expected);

    let data = unsafe {
        std::slice::from_raw_parts(
            allocation.get_host_ptr().cast_const(),
            (RENDER_SIZE * RENDER_SIZE * 4) as usize,
        )
    };
    let result_image = ConstPixelBufferAccess::new(texture_format, [RENDER_SIZE, RENDER_SIZE, 1], data);
    Ok(float_threshold_compare(&expected_level.get_const_access(), &result_image, [0.005; 4]).ok)
}

const RED: [f32; 4] = [1.0, 0.0, 0.0, 1.0];
const GREEN: [f32; 4] = [0.0, 1.0, 0.0, 1.0];
const BLUE: [f32; 4] = [0.0, 0.0, 1.0, 1.0];
/// `tcu::RGBA::gray().toVec()`
const GRAY: [f32; 4] = [128.0 / 255.0, 128.0 / 255.0, 128.0 / 255.0, 1.0];

// ---------------------------------------------------------------------------------------------------------------------
// null_color_attachment_location_*
// ---------------------------------------------------------------------------------------------------------------------

#[derive(Clone, Copy)]
struct NullParams {
    command_mode: bool,
    null_after_remap: bool,
    null_before_identity: bool,
}

fn run_null_attachment_locations(context: &Context<'_>, params: NullParams) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let color_attachment_count = 4u32;

    let targets = create_targets(
        context,
        color_attachment_count,
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
    )?;
    let color_attachments: Vec<vk::RenderingAttachmentInfo> = targets
        .views
        .iter()
        .map(|view| {
            make_attachment_info(
                **view,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::AttachmentLoadOp::CLEAR,
            )
        })
        .collect();
    let mut color_image_barriers: Vec<vk::ImageMemoryBarrier> = targets
        .images
        .iter()
        .map(|image| {
            color_barrier(
                image.get(),
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            )
        })
        .collect();

    let non_identity_locations: Vec<u32> = (0..color_attachment_count)
        .map(|i| (color_attachment_count - 1) - i)
        .collect();
    let identity_locations: Vec<u32> = (0..color_attachment_count).collect();

    let pipeline_layout = make_pipeline_layout(device, &[])?;
    let binaries = context.get_binary_collection();
    let vert_shader = create_shader_module(device, binaries.get("vert")?)?;
    let frag_shader = create_shader_module(device, binaries.get("frag")?)?;

    let identity_info = attachment_location_info(color_attachment_count, identity_locations.as_ptr());
    let mut non_identity_info = attachment_location_info(color_attachment_count, non_identity_locations.as_ptr());
    // An info whose locations pointer is NULL
    let mut empty_info = attachment_location_info(color_attachment_count, std::ptr::null());

    let with_location_info = !params.command_mode;
    let graphics_pipeline = make_pipeline(
        device,
        *pipeline_layout,
        *vert_shader,
        *frag_shader,
        color_attachment_count,
        if with_location_info {
            Some(&mut empty_info)
        } else {
            None
        },
        None,
    )?;

    let alt_pipeline = if params.null_after_remap {
        Some(make_pipeline(
            device,
            *pipeline_layout,
            *vert_shader,
            *frag_shader,
            color_attachment_count,
            Some(&mut non_identity_info),
            None,
        )?)
    } else {
        None
    };

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;

    pipeline_barrier(
        device,
        cmd,
        vk::PipelineStageFlags::empty(),
        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
        vk::DependencyFlags::empty(),
        &color_image_barriers,
    );

    let rendering_info = vk::RenderingInfo::builder()
        .render_area(rect_2d(RENDER_SIZE, RENDER_SIZE))
        .layer_count(1)
        .view_mask(0)
        .color_attachments(&color_attachments);
    unsafe { device.cmd_begin_rendering(cmd, &rendering_info) };

    if params.command_mode {
        if params.null_after_remap {
            unsafe {
                device.cmd_set_rendering_attachment_locations_khr(cmd, &non_identity_info);
                if let Some(alt_pipeline) = &alt_pipeline {
                    device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, alt_pipeline.get());
                }
                device.cmd_draw(cmd, 4, 1, 0, 0);
            }
        }

        unsafe { device.cmd_set_rendering_attachment_locations_khr(cmd, &empty_info) };
    } else if params.null_before_identity {
        unsafe { device.cmd_set_rendering_attachment_locations_khr(cmd, &identity_info) };
    }

    unsafe {
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, graphics_pipeline.get());
        device.cmd_draw(cmd, 4, 1, 0, 0);
        device.cmd_end_rendering(cmd);
    }

    for barrier in &mut color_image_barriers {
        barrier.src_access_mask = vk::AccessFlags::COLOR_ATTACHMENT_WRITE;
        barrier.dst_access_mask = vk::AccessFlags::TRANSFER_READ;
        barrier.old_layout = vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL;
        barrier.new_layout = vk::ImageLayout::TRANSFER_SRC_OPTIMAL;
    }
    pipeline_barrier(
        device,
        cmd,
        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
        vk::PipelineStageFlags::TRANSFER,
        vk::DependencyFlags::empty(),
        &color_image_barriers,
    );

    copy_to_output_buffers(device, cmd, &targets);

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    // Verification
    let expected_colors = [RED, BLUE, GREEN, GRAY];
    for (buffer, expected) in targets.output_buffers.iter().zip(expected_colors) {
        if !buffer_matches_color(context, buffer, expected)? {
            return Ok(TestStatus::fail("Fail"));
        }
    }

    Ok(TestStatus::pass("Pass"))
}

struct NullAttachmentLocationsTestCase {
    name: String,
    params: NullParams,
}

impl TestCase for NullAttachmentLocationsTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_dynamic_rendering_local_read")
    }

    fn programs(&self) -> BinaryCollection {
        LOCAL_READ_NULL.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(NullAttachmentLocationsTestInstance {
            context,
            params: self.params,
        })
    }
}

struct NullAttachmentLocationsTestInstance<'a> {
    context: &'a Context<'a>,
    params: NullParams,
}

impl TestInstance for NullAttachmentLocationsTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_null_attachment_locations(self.context, self.params)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// mapping_*_attachments_to_locs_from_*
// ---------------------------------------------------------------------------------------------------------------------

#[derive(Clone, Copy)]
struct RemapToHighParams {
    num_attachments: u32,
    first_remap_location: u32,
}

fn run_remap_to_high_location(context: &Context<'_>, params: RemapToHighParams) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let color_attachment_count = params.num_attachments;

    let targets = create_targets(
        context,
        color_attachment_count,
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
    )?;
    let color_attachments: Vec<vk::RenderingAttachmentInfo> = targets
        .views
        .iter()
        .map(|view| {
            make_attachment_info(
                **view,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::AttachmentLoadOp::CLEAR,
            )
        })
        .collect();
    let mut color_image_barriers: Vec<vk::ImageMemoryBarrier> = targets
        .images
        .iter()
        .map(|image| {
            color_barrier(
                image.get(),
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            )
        })
        .collect();

    let non_identity_locations: Vec<u32> = (0..color_attachment_count)
        .map(|i| i + params.first_remap_location)
        .collect();

    let pipeline_layout = make_pipeline_layout(device, &[])?;
    let binaries = context.get_binary_collection();
    let vert_shader = create_shader_module(device, binaries.get("vert")?)?;
    let frag_shader = create_shader_module(device, binaries.get("frag")?)?;

    let mut non_identity_info = attachment_location_info(color_attachment_count, non_identity_locations.as_ptr());

    let pipeline = make_pipeline(
        device,
        *pipeline_layout,
        *vert_shader,
        *frag_shader,
        color_attachment_count,
        Some(&mut non_identity_info),
        None,
    )?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;

    pipeline_barrier(
        device,
        cmd,
        vk::PipelineStageFlags::empty(),
        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
        vk::DependencyFlags::empty(),
        &color_image_barriers,
    );

    let rendering_info = vk::RenderingInfo::builder()
        .render_area(rect_2d(RENDER_SIZE, RENDER_SIZE))
        .layer_count(1)
        .view_mask(0)
        .color_attachments(&color_attachments);
    unsafe {
        device.cmd_begin_rendering(cmd, &rendering_info);
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
        device.cmd_set_rendering_attachment_locations_khr(cmd, &non_identity_info);
        device.cmd_draw(cmd, 4, 1, 0, 0);
        device.cmd_end_rendering(cmd);
    }

    for barrier in &mut color_image_barriers {
        barrier.src_access_mask = vk::AccessFlags::COLOR_ATTACHMENT_WRITE;
        barrier.dst_access_mask = vk::AccessFlags::TRANSFER_READ;
        barrier.old_layout = vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL;
        barrier.new_layout = vk::ImageLayout::TRANSFER_SRC_OPTIMAL;
    }
    pipeline_barrier(
        device,
        cmd,
        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
        vk::PipelineStageFlags::TRANSFER,
        vk::DependencyFlags::empty(),
        &color_image_barriers,
    );

    copy_to_output_buffers(device, cmd, &targets);

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    // Verification
    let expected_colors = [GREEN, RED];
    for (i, buffer) in targets.output_buffers.iter().enumerate() {
        if !buffer_matches_color(context, buffer, expected_colors[i % 2])? {
            return Ok(TestStatus::fail("Fail"));
        }
    }

    Ok(TestStatus::pass("Pass"))
}

struct RemappingToHighLocationTestCase {
    name: String,
    params: RemapToHighParams,
}

impl TestCase for RemappingToHighLocationTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_dynamic_rendering_local_read")
    }

    fn programs(&self) -> BinaryCollection {
        match (self.params.num_attachments, self.params.first_remap_location) {
            (1, 1) => LOCAL_READ_HIGH_1_FROM_1.programs,
            (1, 2) => LOCAL_READ_HIGH_1_FROM_2.programs,
            (1, 3) => LOCAL_READ_HIGH_1_FROM_3.programs,
            _ => LOCAL_READ_HIGH_2_FROM_2.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(RemapToHighLocationTestInstance {
            context,
            params: self.params,
        })
    }
}

struct RemapToHighLocationTestInstance<'a> {
    context: &'a Context<'a>,
    params: RemapToHighParams,
}

impl TestInstance for RemapToHighLocationTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_remap_to_high_location(self.context, self.params)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// attachment_mapping_*
// ---------------------------------------------------------------------------------------------------------------------

#[derive(Clone, Copy)]
struct AttachmentMappingParams {
    pipeline_mapping_count: u32,
    input_attachment_count: u32,
    attachment_count: u32,
    different_indices: bool,
}

const EXPECTED_MAPPING_COLORS: [[f32; 4]; 8] = [
    [0.0, 0.0, 1.0, 1.0],
    [0.0, 1.0, 0.0, 1.0],
    [0.0, 1.0, 1.0, 1.0],
    [1.0, 0.0, 0.0, 1.0],
    [1.0, 0.0, 1.0, 1.0],
    [1.0, 1.0, 0.0, 1.0],
    [1.0, 1.0, 1.0, 1.0],
    [0.5, 0.5, 0.5, 1.0],
];

fn run_attachment_mapping(context: &Context<'_>, params: AttachmentMappingParams) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let color_attachment_count = params.attachment_count;
    let inputs_count = params.input_attachment_count;
    let has_input_attachments = inputs_count > 0;

    let mut image_usage =
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
    if has_input_attachments {
        image_usage |= vk::ImageUsageFlags::INPUT_ATTACHMENT;
    }
    let targets = create_targets(context, color_attachment_count, image_usage)?;

    let color_attachments: Vec<vk::RenderingAttachmentInfo> = targets
        .views
        .iter()
        .enumerate()
        .map(|(i, view)| {
            make_attachment_info(
                **view,
                vk::ImageLayout::GENERAL,
                if (i as u32) < inputs_count {
                    vk::AttachmentLoadOp::LOAD
                } else {
                    vk::AttachmentLoadOp::CLEAR
                },
            )
        })
        .collect();
    let mut color_image_barriers: Vec<vk::ImageMemoryBarrier> = targets
        .images
        .iter()
        .map(|image| {
            color_barrier(
                image.get(),
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::GENERAL,
            )
        })
        .collect();
    let draw_image_barriers: Vec<vk::ImageMemoryBarrier> = targets
        .images
        .iter()
        .map(|image| {
            color_barrier(
                image.get(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::INPUT_ATTACHMENT_READ,
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::GENERAL,
            )
        })
        .collect();

    let mut input_attachment_indices: Vec<u32> = (0..8).collect();
    if params.pipeline_mapping_count > 1 {
        input_attachment_indices[..params.pipeline_mapping_count as usize].rotate_left(1);
    }

    let rendering_input_attachment_index_info =
        input_attachment_index_info(color_attachment_count, input_attachment_indices.as_ptr());

    let mut input_attachment_indices_pipeline = input_attachment_indices.clone();
    if params.different_indices {
        // Shuffle indices that are not used by the shader
        let mut input_attachment_index_to_color_attachment = vec![0u32; params.pipeline_mapping_count as usize];
        for color_index in 0..params.pipeline_mapping_count {
            let input_index = input_attachment_indices[color_index as usize];
            input_attachment_index_to_color_attachment[input_index as usize] = color_index;
        }

        if (params.pipeline_mapping_count - params.input_attachment_count) > 1 {
            input_attachment_index_to_color_attachment[params.input_attachment_count as usize..].rotate_left(1);
        }

        for input_index in 0..params.pipeline_mapping_count {
            let color_index = input_attachment_index_to_color_attachment[input_index as usize];
            input_attachment_indices_pipeline[color_index as usize] = input_index;
        }
    }

    let mut input_attachment_image_indices = vec![0u32; inputs_count as usize];
    for attachment_index in 0..color_attachment_count {
        let input_index = input_attachment_indices[attachment_index as usize];
        if input_index < inputs_count {
            input_attachment_image_indices[input_index as usize] = attachment_index;
        }
    }

    let mut pipeline_input_attachment_index_info =
        input_attachment_index_info(color_attachment_count, input_attachment_indices_pipeline.as_ptr());

    let descriptor_type = vk::DescriptorType::INPUT_ATTACHMENT;
    let mut descriptor_set_layout = None;
    let mut _descriptor_pool = None;
    let mut descriptor_set = None;

    if has_input_attachments {
        let pool = DescriptorPoolBuilder::new()
            .add_type(descriptor_type, inputs_count)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let mut layout_builder = DescriptorSetLayoutBuilder::new();
        for _ in 0..inputs_count {
            layout_builder = layout_builder.add_single_binding(descriptor_type, vk::ShaderStageFlags::FRAGMENT);
        }
        let layout = layout_builder.build(device)?;
        let set = make_descriptor_set(device, *pool, *layout)?;

        let image_infos: Vec<vk::DescriptorImageInfo> = (0..inputs_count as usize)
            .map(|i| vk::DescriptorImageInfo {
                sampler: vk::Sampler::null(),
                image_view: *targets.views[input_attachment_image_indices[i] as usize],
                image_layout: vk::ImageLayout::GENERAL,
            })
            .collect();
        let writes: Vec<vk::WriteDescriptorSet> = (0..inputs_count as usize)
            .map(|i| {
                vk::WriteDescriptorSet::builder()
                    .dst_set(set.get())
                    .dst_binding(i as u32)
                    .descriptor_type(descriptor_type)
                    .image_info(&image_infos[i..i + 1])
                    .build()
            })
            .collect();
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        _descriptor_pool = Some(pool);
        descriptor_set_layout = Some(layout);
        descriptor_set = Some(set);
    }

    let pipeline_layout = match &descriptor_set_layout {
        Some(layout) => make_pipeline_layout(device, &[**layout])?,
        None => make_pipeline_layout(device, &[])?,
    };
    let binaries = context.get_binary_collection();
    let vert_shader_module = create_shader_module(device, binaries.get("vert")?)?;
    let frag0_shader_module = create_shader_module(device, binaries.get("frag0")?)?;

    let rendering_info = vk::RenderingInfo::builder()
        .render_area(rect_2d(RENDER_SIZE, RENDER_SIZE))
        .layer_count(1)
        .view_mask(0)
        .color_attachments(&color_attachments);

    let graphics_pipeline0 = make_pipeline(
        device,
        *pipeline_layout,
        *vert_shader_module,
        *frag0_shader_module,
        color_attachment_count,
        None,
        if has_input_attachments {
            None
        } else {
            Some(&mut pipeline_input_attachment_index_info)
        },
    )?;

    let graphics_pipeline1 = if has_input_attachments {
        let frag1_shader_module = create_shader_module(device, binaries.get("frag1")?)?;
        Some(make_pipeline(
            device,
            *pipeline_layout,
            *vert_shader_module,
            *frag1_shader_module,
            color_attachment_count,
            None,
            Some(&mut pipeline_input_attachment_index_info),
        )?)
    } else {
        None
    };

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    begin_command_buffer(device, cmd)?;

    pipeline_barrier(
        device,
        cmd,
        vk::PipelineStageFlags::empty(),
        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
        vk::DependencyFlags::empty(),
        &color_image_barriers,
    );

    unsafe { device.cmd_begin_rendering(cmd, &rendering_info) };

    match (&graphics_pipeline1, &descriptor_set) {
        (Some(graphics_pipeline1), Some(descriptor_set)) => {
            unsafe {
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, graphics_pipeline0.get());
                device.cmd_draw(cmd, 4, 1, 0, 0);
            }
            pipeline_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::FRAGMENT_SHADER,
                vk::DependencyFlags::BY_REGION,
                &draw_image_barriers,
            );

            unsafe {
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, graphics_pipeline1.get());
                device.cmd_set_rendering_input_attachment_indices_khr(cmd, &rendering_input_attachment_index_info);
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    *pipeline_layout,
                    0,
                    &[descriptor_set.get()],
                    &[] as &[u32],
                );
                device.cmd_draw(cmd, 4, 1, 0, 0);
            }
        }
        _ => unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, graphics_pipeline0.get());
            device.cmd_set_rendering_input_attachment_indices_khr(cmd, &rendering_input_attachment_index_info);
            device.cmd_draw(cmd, 4, 1, 0, 0);
        },
    }
    unsafe { device.cmd_end_rendering(cmd) };

    for barrier in &mut color_image_barriers {
        barrier.src_access_mask = vk::AccessFlags::COLOR_ATTACHMENT_WRITE;
        barrier.dst_access_mask = vk::AccessFlags::TRANSFER_READ;
        barrier.old_layout = vk::ImageLayout::GENERAL;
        barrier.new_layout = vk::ImageLayout::TRANSFER_SRC_OPTIMAL;
    }
    pipeline_barrier(
        device,
        cmd,
        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
        vk::PipelineStageFlags::TRANSFER,
        vk::DependencyFlags::empty(),
        &color_image_barriers,
    );

    copy_to_output_buffers(device, cmd, &targets);

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    for (i, buffer) in targets.output_buffers.iter().enumerate() {
        let j = if (i as u32) < params.input_attachment_count {
            input_attachment_image_indices[i] as usize
        } else {
            i
        };

        if !buffer_matches_color(context, buffer, EXPECTED_MAPPING_COLORS[j])? {
            let join = |values: &[u32]| values.iter().map(u32::to_string).collect::<Vec<_>>().join(", ");
            log::info!(
                "vkCmdSetRenderingInputAttachmentIndices set pColorAttachmentInputIndices to: {}\nVkRenderingInputAttachmentIndexInfo::pColorAttachmentInputIndices were set to: {}",
                join(&input_attachment_indices[..color_attachment_count as usize]),
                join(&input_attachment_indices_pipeline[..params.pipeline_mapping_count as usize])
            );

            return Ok(TestStatus::fail("Fail"));
        }
    }

    Ok(TestStatus::pass("Pass"))
}

struct AttachmentMappingTestCase {
    name: &'static str,
    params: AttachmentMappingParams,
}

impl TestCase for AttachmentMappingTestCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_dynamic_rendering_local_read")?;

        let limits = &context.get_device_properties().limits;

        if self.params.attachment_count > limits.max_color_attachments {
            return Err(TestError::NotSupported(
                "attachmentCount is greater than maxColorAttachments".to_string(),
            ));
        }

        if self.params.input_attachment_count > limits.max_per_stage_descriptor_input_attachments {
            return Err(TestError::NotSupported(
                "inputAttachmentCount is greater than maxPerStageDescriptorInputAttachments".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match (self.params.attachment_count, self.params.input_attachment_count) {
            (4, 0) => LOCAL_READ_MAP_A4_I0.programs,
            (4, _) => LOCAL_READ_MAP_A4_I2.programs,
            (8, 4) => LOCAL_READ_MAP_A8_I4.programs,
            _ => LOCAL_READ_MAP_A8_I6.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(AttachmentMappingTestInstance {
            context,
            params: self.params,
        })
    }
}

struct AttachmentMappingTestInstance<'a> {
    context: &'a Context<'a>,
    params: AttachmentMappingParams,
}

impl TestInstance for AttachmentMappingTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_attachment_mapping(self.context, self.params)
    }
}

/// The part of `createDynamicRenderingLocalReadTests` that sits behind `!useSecondaryCmdBuffer` and needs no
/// `LocalReadTestCase`.
/// `createDynamicRenderingLocalReadTests` for a secondary command buffer that contains only part of the dynamic render pass: the
/// `LocalReadTestCase` and `RemappingWithGapTestCase` entries
pub fn create_dynamic_rendering_local_read_secondary_tests() -> TestCaseGroup {
    let mut main_group = TestCaseGroup::new("local_read");
    super::dynamic_rendering_local_read_basic_tests::add_local_read_test_configs(&mut main_group, true);
    super::dynamic_rendering_local_read_basic_tests::add_local_read_gap_cases(&mut main_group);
    main_group
}

pub fn create_dynamic_rendering_local_read_tests() -> TestCaseGroup {
    let mut main_group = TestCaseGroup::new("local_read");
    super::dynamic_rendering_local_read_basic_tests::add_local_read_test_configs(&mut main_group, false);

    // Test pColorAttachmentLocations set to NULL
    for null_before_identity in [false, true] {
        let test_name = format!(
            "null_color_attachment_location_with_locationinfo{}",
            if null_before_identity { "_before_identity" } else { "" }
        );
        main_group.add_child(Box::new(NullAttachmentLocationsTestCase {
            name: test_name,
            params: NullParams {
                command_mode: false,
                null_after_remap: false,
                null_before_identity,
            },
        }) as Box<dyn TestCase>);
    }

    for null_after_remap in [false, true] {
        let test_name = format!(
            "null_color_attachment_location_with_command{}",
            if null_after_remap { "_after_remap" } else { "" }
        );
        main_group.add_child(Box::new(NullAttachmentLocationsTestCase {
            name: test_name,
            params: NullParams {
                command_mode: true,
                null_after_remap,
                null_before_identity: false,
            },
        }) as Box<dyn TestCase>);
    }

    // Test mapping to (unused) locations higher than default locations
    for num_attachments in [1u32, 2] {
        for first_remap_location in num_attachments..=MAX_LOCATION {
            let last_location = first_remap_location + (num_attachments - 1); // includes first used location

            if last_location > MAX_LOCATION {
                break;
            }

            let test_name = format!("mapping_{num_attachments}_attachments_to_locs_from_{first_remap_location}");
            main_group.add_child(Box::new(RemappingToHighLocationTestCase {
                name: test_name,
                params: RemapToHighParams {
                    num_attachments,
                    first_remap_location,
                },
            }) as Box<dyn TestCase>);
        }
    }

    // Test mismatched pipeline input attachment mapping with render pass attachment mapping
    let attachment_mapping_tests = [
        (0u32, 0u32, 4u32, false, "attachment_mapping_no_mappings"),
        (2, 0, 4, false, "attachment_mapping_some_mappings"),
        (4, 0, 4, false, "attachment_mapping_all_mappings"),
        (2, 0, 4, true, "attachment_mapping_some_mappings_different"),
        (4, 0, 4, true, "attachment_mapping_all_mappings_different"),
        (2, 2, 4, false, "attachment_mapping_input_attachments"),
        (4, 2, 4, false, "attachment_mapping_input_attachments_all"),
        (3, 2, 4, false, "attachment_mapping_input_attachments_superset"),
        (4, 2, 4, true, "attachment_mapping_input_attachments_all_different"),
        (3, 2, 4, true, "attachment_mapping_input_attachments_superset_different"),
        (4, 4, 8, false, "attachment_mapping_input_attachments_4"),
        (8, 4, 8, false, "attachment_mapping_input_attachments_all_4"),
        (6, 4, 8, false, "attachment_mapping_input_attachments_superset_4"),
        (8, 4, 8, true, "attachment_mapping_input_attachments_all_different_4"),
        (
            6,
            4,
            8,
            true,
            "attachment_mapping_input_attachments_superset_different_4",
        ),
        (6, 6, 8, false, "attachment_mapping_input_attachments_6"),
        (8, 6, 8, false, "attachment_mapping_input_attachments_all_6"),
        (7, 6, 8, false, "attachment_mapping_input_attachments_superset_6"),
        (8, 6, 8, true, "attachment_mapping_input_attachments_all_different_6"),
        (
            7,
            6,
            8,
            true,
            "attachment_mapping_input_attachments_superset_different_6",
        ),
    ];

    for (pipeline_mapping_count, input_attachment_count, attachment_count, different_indices, name) in
        attachment_mapping_tests
    {
        let params = AttachmentMappingParams {
            pipeline_mapping_count,
            input_attachment_count,
            attachment_count,
            different_indices,
        };
        main_group.add_child(Box::new(AttachmentMappingTestCase { name, params }) as Box<dyn TestCase>);
    }

    super::dynamic_rendering_local_read_basic_tests::add_local_read_gap_cases(&mut main_group);

    main_group
}
