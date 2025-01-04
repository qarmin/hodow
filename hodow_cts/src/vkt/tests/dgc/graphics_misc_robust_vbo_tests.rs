// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCGraphicsMiscTestsExt.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Copyright (c) 2024 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The programs are in `shaders/manifest/dgc_ms.toml` (`scripts/gen_dgc_ms_manifest.py`, case
// `robust_vbo`). The custom device with robust buffer access is a `RobustnessDevice`; the DGC helpers have `_on` variants taking its device.
//
// Here: `robust_vbo*` of `dgc.ext.graphics.misc` (NullVBOInstance): each row of points gets one real vertex buffer for the XY coordinates
// and a null vertex buffer for the Z coordinate, which robust buffer access makes read as zero (the depth test compares equal to the zero
// depth clear value).

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    DeviceV1_3, ExtDeviceGeneratedCommandsExtensionDeviceCommands, ExtExtendedDynamicStateExtensionDeviceCommands,
};

use crate::generated::shaders::dgc_ms::ALL_SHARED_PROGRAM;
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, end_render_pass, make_rect_2d};
use crate::vk::device_address_commands::buffer_device_address;
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_pipeline_layout_with_push_constants,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::context::{RobustnessDevice, RobustnessFeatures};
use crate::vkt::tests::dgc::graphics_draw_tests::{
    Construction, ExtraState, PipelineOptions, StageModules, bind_shader_object_state_on, bind_shaders_with_nulls_on,
    build_draw_pipeline_with_input, copy_image_to_buffer, float_threshold_compare, push_back_element,
};
use crate::vkt::tests::dgc::util_ext::{
    DgcBuffer, DgcGenCmdsInfo, IndirectCommandsLayoutBuilderExt, PreprocessBufferExt, check_dgc_ext_support,
    create_dgc_shader, preprocess_to_execute_barrier_ext, submit_and_wait_with_preprocess,
};
use crate::vkt::tests::draw::util::end_rendering;
use crate::vkt::tests::shader_object::util::ShaderObject;
use crate::vkt::{Context, TestCase, TestInstance};

type Vec4 = [f32; 4];

const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const DEPTH_FORMAT: vk::Format = vk::Format::D16_UNORM;
const GEOMETRY_COLOR: Vec4 = [0.0, 0.0, 1.0, 1.0];
const CLEAR_COLOR: Vec4 = [0.0, 0.0, 0.0, 1.0];
const MAX_PADDING: i32 = 3;

#[derive(Clone, Copy)]
struct Params {
    use_shader_objects: bool,
    preprocess: bool,
}

impl Params {
    fn random_seed(&self) -> u32 {
        1721133137 + u32::from(self.use_shader_objects)
    }
}

/// Dynamic rendering over a colour and a depth attachment, both cleared on load and stored.
fn begin_rendering_with_depth(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    color_view: vk::ImageView,
    depth_view: vk::ImageView,
    render_area: vk::Rect2D,
    clear_color: vk::ClearValue,
    clear_depth: vk::ClearValue,
) {
    let color_attachments = [vk::RenderingAttachmentInfo::builder()
        .image_view(color_view)
        .image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .resolve_mode(vk::ResolveModeFlags::NONE)
        .load_op(vk::AttachmentLoadOp::CLEAR)
        .store_op(vk::AttachmentStoreOp::STORE)
        .clear_value(clear_color)
        .build()];
    let depth_attachment = vk::RenderingAttachmentInfo::builder()
        .image_view(depth_view)
        .image_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
        .resolve_mode(vk::ResolveModeFlags::NONE)
        .load_op(vk::AttachmentLoadOp::CLEAR)
        .store_op(vk::AttachmentStoreOp::STORE)
        .clear_value(clear_depth)
        .build();
    let rendering_info = vk::RenderingInfo::builder()
        .render_area(render_area)
        .layer_count(1)
        .color_attachments(&color_attachments)
        .depth_attachment(&depth_attachment);
    unsafe { device.cmd_begin_rendering(cmd_buffer, &rendering_info) };
}

struct NullVboCase {
    name: String,
    params: Params,
}

impl TestCase for NullVboCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let stages = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;
        check_dgc_ext_support(
            context,
            stages,
            vk::ShaderStageFlags::empty(),
            vk::ShaderStageFlags::empty(),
            vk::IndirectCommandsInputModeFlagsEXT::empty(),
            false,
        )?;
        if self.params.use_shader_objects {
            context.require_device_functionality("VK_EXT_shader_object")?;
        }

        // Robust buffer access support check, on the physical device: the Context's own device has the feature off.
        let features = unsafe {
            context
                .get_instance()
                .get_physical_device_features(context.get_physical_device())
        };
        if features.robust_buffer_access == vk::FALSE {
            return Err(TestError::NotSupported("robustBufferAccess not supported".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == "robust_vbo")
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(NullVboInstance {
            context,
            params: self.params,
        })
    }
}

struct NullVboInstance<'a> {
    context: &'a Context<'a>,
    params: Params,
}

impl TestInstance for NullVboInstance<'_> {
    /// `NullVBOInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let use_shader_objects = params.use_shader_objects;

        // Custom device with robust buffer access.
        let robust_device = RobustnessDevice::new(
            context.get_instance(),
            context.get_physical_device(),
            context.get_universal_queue_family_index(),
            RobustnessFeatures::default(),
        )?;
        let device = robust_device.device();
        let queue = robust_device.queue();
        let qf_index = context.get_universal_queue_family_index();
        let allocator = context.get_default_allocator();
        let shader_stages = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;

        // Test using that device for some vertex bindings.
        let fb_extent = 16u32;
        let pixel_count = fb_extent * fb_extent;
        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let depth_srr = make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1);
        let make_image = |format: vk::Format, usage: vk::ImageUsageFlags| -> Result<ImageWithMemory<'_>, TestError> {
            let info = vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(format)
                .extent(vk::Extent3D {
                    width: fb_extent,
                    height: fb_extent,
                    depth: 1,
                })
                .mip_levels(1)
                .array_layers(1)
                .samples(vk::SampleCountFlags::_1)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(usage)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build();
            ImageWithMemory::new(device, allocator, info, MemoryRequirement::ANY)
        };

        // We'll enable the depth test to make sure depth is zero as per the robust read.
        let color_image = make_image(
            COLOR_FORMAT,
            vk::ImageUsageFlags::COLOR_ATTACHMENT
                | vk::ImageUsageFlags::TRANSFER_DST
                | vk::ImageUsageFlags::TRANSFER_SRC,
        )?;
        let color_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            color_srr,
        )?;
        let depth_image = make_image(
            DEPTH_FORMAT,
            vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
                | vk::ImageUsageFlags::TRANSFER_DST
                | vk::ImageUsageFlags::TRANSFER_SRC,
        )?;
        let depth_view = make_image_view(
            device,
            depth_image.get(),
            vk::ImageViewType::_2D,
            DEPTH_FORMAT,
            depth_srr,
        )?;
        let color_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(u64::from(pixel_count * 4), vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // We'll have one vertex buffer and draw per row.
        let mut vertices: Vec<[f32; 2]> = Vec::with_capacity(pixel_count as usize);
        for y in 0..fb_extent {
            for x in 0..fb_extent {
                let x_center = (x as f32 + 0.5) / fb_extent as f32 * 2.0 - 1.0;
                let y_center = (y as f32 + 0.5) / fb_extent as f32 * 2.0 - 1.0;
                vertices.push([x_center, y_center]);
            }
        }

        let vertex_buffer_size = (std::mem::size_of::<[f32; 2]>() * fb_extent as usize) as vk::DeviceSize;
        let mut vertex_buffers: Vec<BufferWithMemory<'_>> = Vec::new();
        for row_idx in 0..fb_extent {
            let buffer = BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(
                    vertex_buffer_size,
                    vk::BufferUsageFlags::VERTEX_BUFFER | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS,
                ),
                MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS,
            )?;
            {
                let alloc = buffer.get_allocation();
                let row = &vertices[(fb_extent * row_idx) as usize..(fb_extent * (row_idx + 1)) as usize];
                // SAFETY: the buffer holds one row of vertices.
                unsafe {
                    std::ptr::copy_nonoverlapping(
                        row.as_ptr().cast::<u8>(),
                        alloc.get_host_ptr(),
                        vertex_buffer_size as usize,
                    )
                };
                flush_alloc(device, alloc)?;
            }
            vertex_buffers.push(buffer);
        }

        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[], &[])?;

        // We have two bindings. From one of them we'll extract the XY coordinates, and the second one will contain the Z. Note the stride
        // will be obtained from the DGC buffer.
        let bindings = [
            vk::VertexInputBindingDescription::builder()
                .binding(0)
                .stride(0)
                .input_rate(vk::VertexInputRate::VERTEX)
                .build(),
            vk::VertexInputBindingDescription::builder()
                .binding(1)
                .stride(0)
                .input_rate(vk::VertexInputRate::VERTEX)
                .build(),
        ];
        let attributes = [
            vk::VertexInputAttributeDescription::builder()
                .location(0)
                .binding(0)
                .format(vk::Format::R32G32_SFLOAT)
                .offset(0)
                .build(),
            vk::VertexInputAttributeDescription::builder()
                .location(1)
                .binding(1)
                .format(vk::Format::R32_SFLOAT)
                .offset(0)
                .build(),
        ];
        let bindings_2 = [
            vk::VertexInputBindingDescription2EXT {
                binding: 0,
                stride: 0,
                input_rate: vk::VertexInputRate::VERTEX,
                divisor: 1,
                ..Default::default()
            },
            vk::VertexInputBindingDescription2EXT {
                binding: 1,
                stride: 0,
                input_rate: vk::VertexInputRate::VERTEX,
                divisor: 1,
                ..Default::default()
            },
        ];
        let attributes_2 = [
            vk::VertexInputAttributeDescription2EXT {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32_SFLOAT,
                offset: 0,
                ..Default::default()
            },
            vk::VertexInputAttributeDescription2EXT {
                location: 1,
                binding: 1,
                format: vk::Format::R32_SFLOAT,
                offset: 0,
                ..Default::default()
            },
        ];

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        // Render pass and framebuffer (pipelines only).
        let render_pass = {
            let attachments = [
                vk::AttachmentDescription::builder()
                    .format(COLOR_FORMAT)
                    .samples(vk::SampleCountFlags::_1)
                    .load_op(vk::AttachmentLoadOp::CLEAR)
                    .store_op(vk::AttachmentStoreOp::STORE)
                    .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                    .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                    .initial_layout(vk::ImageLayout::UNDEFINED)
                    .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                    .build(),
                vk::AttachmentDescription::builder()
                    .format(DEPTH_FORMAT)
                    .samples(vk::SampleCountFlags::_1)
                    .load_op(vk::AttachmentLoadOp::CLEAR)
                    .store_op(vk::AttachmentStoreOp::STORE)
                    .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                    .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                    .initial_layout(vk::ImageLayout::UNDEFINED)
                    .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                    .build(),
            ];
            let color_refs = [vk::AttachmentReference::builder()
                .attachment(0)
                .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .build()];
            let depth_ref = vk::AttachmentReference::builder()
                .attachment(1)
                .layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .build();
            let subpasses = [vk::SubpassDescription::builder()
                .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                .color_attachments(&color_refs)
                .depth_stencil_attachment(&depth_ref)
                .build()];
            let info = vk::RenderPassCreateInfo::builder()
                .attachments(&attachments)
                .subpasses(&subpasses);
            Unique::new(
                device,
                unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
            )
        };
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*color_view, *depth_view],
            fb_extent,
            fb_extent,
            1,
        )?;

        let mut pipeline = None;
        let mut vert_shader: Option<ShaderObject<'_>> = None;
        let mut frag_shader: Option<ShaderObject<'_>> = None;
        if use_shader_objects {
            let features = context.get_device_features();
            let tess_feature = features.tessellation_shader != vk::FALSE;
            let geom_feature = features.geometry_shader != vk::FALSE;
            vert_shader = Some(create_dgc_shader(
                device,
                vk::ShaderStageFlags::VERTEX,
                &binaries.get("vert")?,
                &[],
                &[],
                tess_feature,
                geom_feature,
            )?);
            frag_shader = Some(create_dgc_shader(
                device,
                vk::ShaderStageFlags::FRAGMENT,
                &binaries.get("frag")?,
                &[],
                &[],
                tess_feature,
                geom_feature,
            )?);
        } else {
            pipeline = Some(build_draw_pipeline_with_input(
                device,
                *pipeline_layout,
                *render_pass,
                &StageModules {
                    vert: *vert_module,
                    tesc: None,
                    tese: None,
                    geom: None,
                    frag: *frag_module,
                },
                &PipelineOptions {
                    extent: (fb_extent, fb_extent),
                    topology: vk::PrimitiveTopology::POINT_LIST,
                    patch_control_points: 0,
                    dynamic_stride: true,
                    dynamic_patch_control_points: false,
                    no_vertex_input: false,
                    extra_attribute: false,
                    indirect_bindable: false,
                    construction: Construction::Monolithic,
                    depth_test: true,
                    rendering: None,
                },
                Some((&bindings[..], &attributes[..])),
                ExtraState {
                    depth_compare_op: Some(vk::CompareOp::EQUAL),
                    ..Default::default()
                },
            )?);
        }

        let layout_flags = if params.preprocess {
            vk::IndirectCommandsLayoutUsageFlagsEXT::EXPLICIT_PREPROCESS
        } else {
            vk::IndirectCommandsLayoutUsageFlagsEXT::empty()
        };
        let mut cmds_layout_builder =
            IndirectCommandsLayoutBuilderExt::new(layout_flags, shader_stages, *pipeline_layout);
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_vertex_buffer_token(offset, 0);
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_vertex_buffer_token(offset, 1);
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_draw_token(offset);
        let cmds_layout = cmds_layout_builder.build(device)?;

        // Each row gets its own vertex buffers and draw.
        let mut dgc_data: Vec<u32> = Vec::new();
        let mut rnd = Random::new(params.random_seed());
        for vertex_buffer in &vertex_buffers {
            let real_bind_cmd = vk::BindVertexBufferIndirectCommandEXT {
                buffer_address: buffer_device_address(device, vertex_buffer.get()),
                size: vertex_buffer_size as u32,
                stride: std::mem::size_of::<[f32; 2]>() as u32,
            };
            push_back_element(&mut dgc_data, &real_bind_cmd);

            let null_vbo_padding = rnd.get_int(0, MAX_PADDING) as u32;
            let null_vbo_stride = (null_vbo_padding + 1) * std::mem::size_of::<f32>() as u32;
            let null_vbo_size = null_vbo_stride * fb_extent;
            let null_vbo_cmd = vk::BindVertexBufferIndirectCommandEXT {
                buffer_address: 0,
                size: null_vbo_size,
                stride: null_vbo_stride,
            };
            push_back_element(&mut dgc_data, &null_vbo_cmd);

            let draw_cmd = vk::DrawIndirectCommand {
                vertex_count: fb_extent,
                instance_count: 1,
                first_vertex: 0,
                first_instance: 0,
            };
            push_back_element(&mut dgc_data, &draw_cmd);
        }

        let dgc_buffer_size = std::mem::size_of_val(dgc_data.as_slice()) as vk::DeviceSize;
        let dgc_buffer = DgcBuffer::new_on(
            device,
            context,
            dgc_buffer_size,
            vk::BufferUsageFlags::empty(),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = dgc_buffer.get_allocation();
            // SAFETY: the buffer was created with the size of the data.
            unsafe {
                std::ptr::copy_nonoverlapping(
                    dgc_data.as_ptr().cast::<u8>(),
                    alloc.get_host_ptr(),
                    dgc_buffer_size as usize,
                )
            };
            flush_alloc(device, alloc)?;
        }

        let cmd_pool = make_command_pool(device, qf_index)?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();
        let clear_value_color = vk::ClearValue {
            color: vk::ClearColorValue { float32: CLEAR_COLOR },
        };
        // Depth must be zero so the test passes with the null VBO Z value.
        let clear_value_depth = vk::ClearValue {
            depth_stencil: vk::ClearDepthStencilValue { depth: 0.0, stencil: 0 },
        };

        let pipeline_handle = pipeline.as_ref().map_or(vk::Pipeline::null(), |pipeline| **pipeline);
        let shaders_vec: Vec<vk::ShaderEXT> = match (&vert_shader, &frag_shader) {
            (Some(vert), Some(frag)) => vec![vert.get(), frag.get()],
            _ => Vec::new(),
        };
        let preprocess_buffer = PreprocessBufferExt::new_with_shaders_on(
            device,
            context,
            vk::IndirectExecutionSetEXT::null(),
            cmds_layout.get(),
            fb_extent,
            0,
            pipeline_handle,
            &shaders_vec,
            0,
        )?;

        let preprocess_cmd_buffer = if params.preprocess {
            let owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            begin_command_buffer(device, owner.get())?;
            Some(owner)
        } else {
            None
        };

        begin_command_buffer(device, cmd_buffer)?;
        let render_area = make_rect_2d(0, 0, fb_extent, fb_extent);
        if use_shader_objects {
            // The render pass wrapper of shader objects: transitions and dynamic rendering clearing both attachments.
            let to_attachment = [
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    color_image.get(),
                    color_srr,
                ),
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    depth_image.get(),
                    depth_srr,
                ),
            ];
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT | vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &to_attachment,
                );
            }
            begin_rendering_with_depth(
                device,
                cmd_buffer,
                *color_view,
                *depth_view,
                render_area,
                clear_value_color,
                clear_value_depth,
            );
        } else {
            let clear_values = [clear_value_color, clear_value_depth];
            let info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(render_area)
                .clear_values(&clear_values);
            unsafe { device.cmd_begin_render_pass(cmd_buffer, &info, vk::SubpassContents::INLINE) };
        }

        // Initial state.
        if use_shader_objects {
            if let (Some(vert), Some(frag)) = (&vert_shader, &frag_shader) {
                bind_shaders_with_nulls_on(
                    device,
                    context,
                    cmd_buffer,
                    &[
                        (vk::ShaderStageFlags::VERTEX, vert.get()),
                        (vk::ShaderStageFlags::FRAGMENT, frag.get()),
                    ],
                );
            }
            bind_shader_object_state_on(
                device,
                context,
                cmd_buffer,
                vk::PrimitiveTopology::POINT_LIST,
                0,
                (fb_extent, fb_extent),
                Some((&bindings_2[..], &attributes_2[..])),
            );
            unsafe {
                device.cmd_set_depth_test_enable_ext(cmd_buffer, true);
                device.cmd_set_depth_write_enable_ext(cmd_buffer, true);
                device.cmd_set_depth_compare_op_ext(cmd_buffer, vk::CompareOp::EQUAL);
            }
        } else {
            unsafe { device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, pipeline_handle) };
        }
        {
            let cmds_info = if shaders_vec.is_empty() {
                DgcGenCmdsInfo::new(
                    shader_stages,
                    vk::IndirectExecutionSetEXT::null(),
                    cmds_layout.get(),
                    dgc_buffer.get_device_address(),
                    dgc_buffer.get_size(),
                    preprocess_buffer.get_device_address(),
                    preprocess_buffer.get_size(),
                    fb_extent,
                    0,
                    0,
                    pipeline_handle,
                )
            } else {
                DgcGenCmdsInfo::new_with_shaders(
                    shader_stages,
                    vk::IndirectExecutionSetEXT::null(),
                    cmds_layout.get(),
                    dgc_buffer.get_device_address(),
                    dgc_buffer.get_size(),
                    preprocess_buffer.get_device_address(),
                    preprocess_buffer.get_size(),
                    fb_extent,
                    0,
                    0,
                    &shaders_vec,
                )
            };
            if let Some(owner) = &preprocess_cmd_buffer {
                unsafe { device.cmd_preprocess_generated_commands_ext(owner.get(), cmds_info.get(), cmd_buffer) };
                preprocess_to_execute_barrier_ext(device, owner.get());
            }
            unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, params.preprocess, cmds_info.get()) };
        }
        if use_shader_objects {
            end_rendering(device, cmd_buffer);
        } else {
            end_render_pass(device, cmd_buffer);
        }
        copy_image_to_buffer(
            device,
            cmd_buffer,
            color_image.get(),
            color_buffer.get(),
            fb_extent,
            fb_extent,
            1,
        );
        end_command_buffer(device, cmd_buffer)?;

        if let Some(owner) = &preprocess_cmd_buffer {
            preprocess_to_execute_barrier_ext(device, owner.get());
            end_command_buffer(device, owner.get())?;
        }

        submit_and_wait_with_preprocess(
            device,
            queue,
            cmd_buffer,
            preprocess_cmd_buffer
                .as_ref()
                .map_or(vk::CommandBuffer::null(), |owner| owner.get()),
        )?;

        crate::vk::mem_util::invalidate_alloc(device, color_buffer.get_allocation())?;
        // SAFETY: the buffer holds the 16x16 RGBA8 image copied into it.
        let result = unsafe {
            std::slice::from_raw_parts(color_buffer.get_allocation().get_host_ptr(), (pixel_count * 4) as usize)
        };
        let reference = vec![GEOMETRY_COLOR; pixel_count as usize];
        if !float_threshold_compare(result, &reference, [0.0; 4]) {
            return Ok(TestStatus::fail(
                "Unexpected result in color buffer; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// The `robust_vbo*` cases, by their full dotted path in `dgc`.
pub fn create_dgc_graphics_misc_robust_vbo_tests_ext() -> Vec<(String, Box<dyn TestCase>)> {
    let mut cases: Vec<(String, Box<dyn TestCase>)> = Vec::new();
    for use_shader_objects in [false, true] {
        for preprocess in [false, true] {
            let name = format!(
                "robust_vbo{}{}",
                if use_shader_objects { "_shader_objects" } else { "" },
                if preprocess { "_preprocess" } else { "" },
            );
            cases.push((
                format!("ext.graphics.misc.{name}"),
                Box::new(NullVboCase {
                    name,
                    params: Params {
                        use_shader_objects,
                        preprocess,
                    },
                }),
            ));
        }
    }
    cases
}
