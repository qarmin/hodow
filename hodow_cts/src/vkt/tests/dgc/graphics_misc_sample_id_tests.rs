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
// Modifications: rewritten in Rust for hodow_cts. The programs are in `shaders/manifest/dgc_ms.toml` (`scripts/gen_dgc_ms_manifest.py`,
// case `sample_id`). The pipelines are made by `build_ms_pipeline` of `graphics_misc_ms_tests`; the shader object variant renders with
// dynamic rendering and a resolve attachment.
//
// Here: `sample_id_state_*` of `dgc.ext.graphics.misc` (SampleIDStateInstance): four sequences that alternate between a pipeline (or
// shader pair) whose fragment shader forces sample shading with gl_SampleID and one that does not.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    DeviceV1_3, ExtDeviceGeneratedCommandsExtensionDeviceCommands, ExtExtendedDynamicState3ExtensionDeviceCommands,
};

use crate::generated::shaders::dgc_ms::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d};
use crate::vk::image_util::{ImageWithMemory, make_image_memory_barrier, make_image_subresource_range};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    allocate_command_buffer, make_command_pool, make_descriptor_set, make_memory_barrier,
    make_pipeline_layout_with_push_constants,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::dgc::graphics_draw_tests::{
    Construction, bind_shader_object_state, bind_shaders_with_nulls, copy_image_to_buffer, float_threshold_compare,
    push_back_element,
};
use crate::vkt::tests::dgc::graphics_misc_ms_tests::{
    MsPipelineOptions, build_ms_pipeline, check_image_support, copy_general_image_to_buffer, make_position_buffer,
    require_library_construction,
};
use crate::vkt::tests::dgc::util_ext::{
    DgcBuffer, DgcGenCmdsInfo, ExecutionSetManagerExt, IndirectCommandsLayoutBuilderExt, PreprocessBufferExt,
    check_dgc_ext_support, create_dgc_shader, preprocess_to_execute_barrier_ext, submit_and_wait_with_preprocess,
};
use crate::vkt::tests::draw::util::ImageWithBuffer;
use crate::vkt::tests::shader_object::util::ShaderObject;
use crate::vkt::{Context, TestCase, TestInstance};

type Vec4 = [f32; 4];

const FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const SAMPLE_COUNT: u32 = 4;
const PER_PIXEL_VERT: u32 = 4;
const GEOMETRY_COLOR: Vec4 = [0.0, 0.0, 1.0, 1.0];
const CLEAR_COLOR: Vec4 = [0.0, 0.0, 0.0, 1.0];

#[derive(Clone, Copy, PartialEq, Eq)]
enum ConstructionType {
    Monolithic,
    FastLinked,
    LinkTimeOptimized,
    ShaderObjectUnlinkedSpirv,
}

impl ConstructionType {
    fn pipeline_construction(self) -> Construction {
        match self {
            ConstructionType::Monolithic | ConstructionType::ShaderObjectUnlinkedSpirv => Construction::Monolithic,
            ConstructionType::FastLinked => Construction::FastLinked,
            ConstructionType::LinkTimeOptimized => Construction::LinkTimeOptimized,
        }
    }

    fn is_shader_object(self) -> bool {
        self == ConstructionType::ShaderObjectUnlinkedSpirv
    }
}

#[derive(Clone, Copy)]
struct Params {
    construction_type: ConstructionType,
    id_first: bool,
    preprocess: bool,
}

struct SampleIdStateCase {
    name: String,
    params: Params,
}

impl TestCase for SampleIdStateCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let use_eso = self.params.construction_type.is_shader_object();
        let stages = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;
        let bind_stages_pipeline = if use_eso { vk::ShaderStageFlags::empty() } else { stages };
        let bind_stages_shader_object = if use_eso { stages } else { vk::ShaderStageFlags::empty() };

        check_dgc_ext_support(
            context,
            stages,
            bind_stages_pipeline,
            bind_stages_shader_object,
            vk::IndirectCommandsInputModeFlagsEXT::empty(),
            false,
        )?;
        if use_eso {
            context.require_device_functionality("VK_EXT_shader_object")?;
        }
        require_library_construction(context, self.params.construction_type.pipeline_construction())?;
        check_image_support(
            context,
            vk::ImageUsageFlags::COLOR_ATTACHMENT
                | vk::ImageUsageFlags::TRANSFER_SRC
                | vk::ImageUsageFlags::TRANSFER_DST,
            vk::SampleCountFlags::_4,
        )
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == "sample_id")
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SampleIdStateInstance {
            context,
            params: self.params,
        })
    }
}

struct SampleIdStateInstance<'a> {
    context: &'a Context<'a>,
    params: Params,
}

/// A render pass with a multisample colour attachment (cleared, not stored) resolved into a single sample one.
fn make_resolve_render_pass(device: &Device) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let attachments = [
        vk::AttachmentDescription::builder()
            .format(FORMAT)
            .samples(vk::SampleCountFlags::_4)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::DONT_CARE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build(),
        vk::AttachmentDescription::builder()
            .format(FORMAT)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::DONT_CARE)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build(),
    ];
    let ms_att_ref = [vk::AttachmentReference::builder()
        .attachment(0)
        .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .build()];
    let ss_att_ref = [vk::AttachmentReference::builder()
        .attachment(1)
        .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .build()];
    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&ms_att_ref)
        .resolve_attachments(&ss_att_ref)
        .build()];
    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses);
    let render_pass = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, render_pass))
}

impl TestInstance for SampleIdStateInstance<'_> {
    /// `SampleIDStateInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let use_eso = params.construction_type.is_shader_object();
        let sample_count = vk::SampleCountFlags::_4;
        let fb_extent = (SAMPLE_COUNT, 1u32);
        let storage_extent = (SAMPLE_COUNT, SAMPLE_COUNT);
        let xfer_usage = vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
        let fb_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | xfer_usage;
        let storage_usage = vk::ImageUsageFlags::STORAGE | xfer_usage;
        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let shader_stages = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;

        // Multisample image for the framebuffer.
        let ms_image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(FORMAT)
            .extent(vk::Extent3D {
                width: fb_extent.0,
                height: fb_extent.1,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(sample_count)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(fb_usage)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let ms_img = ImageWithMemory::new(
            device,
            context.get_default_allocator(),
            ms_image_info,
            MemoryRequirement::ANY,
        )?;
        let ms_view =
            crate::vk::image_util::make_image_view(device, ms_img.get(), vk::ImageViewType::_2D, FORMAT, color_srr)?;

        // Single sample image for the color resolve, with verification buffer, and the storage image with its verification buffer.
        let ss_img = ImageWithBuffer::new(context, fb_extent.0, fb_extent.1, FORMAT, fb_usage, 4)?;
        let storage_img = ImageWithBuffer::new(context, storage_extent.0, storage_extent.1, FORMAT, storage_usage, 4)?;

        // Vertex buffer: a quad as a triangle strip covering each pixel.
        let pixel_count = fb_extent.0 * fb_extent.1;
        let normalize = |v: f32, size: f32| (v / size) * 2.0 - 1.0;
        let mut vertices: Vec<Vec4> = Vec::with_capacity((pixel_count * PER_PIXEL_VERT) as usize);
        for x in 0..fb_extent.0 {
            let fx = x as f32;
            let x_left = normalize(fx, fb_extent.0 as f32);
            let x_right = normalize(fx + 1.0, fb_extent.0 as f32);
            let y_top = -1.0;
            let y_bottom = 1.0;
            vertices.push([x_left, y_top, 0.0, 1.0]);
            vertices.push([x_left, y_bottom, 0.0, 1.0]);
            vertices.push([x_right, y_top, 0.0, 1.0]);
            vertices.push([x_right, y_bottom, 0.0, 1.0]);
        }
        let vertex_buffer = make_position_buffer(context, &vertices)?;
        let vertex_buffer_offset: vk::DeviceSize = 0;

        // Descriptor set.
        let desc_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::FRAGMENT)
            .build(device)?;
        let descriptor_set = make_descriptor_set(device, *desc_pool, *set_layout)?;
        {
            let storage_img_desc_info = [vk::DescriptorImageInfo {
                sampler: vk::Sampler::null(),
                image_view: *storage_img.view,
                image_layout: vk::ImageLayout::GENERAL,
            }];
            let writes = [vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                .image_info(&storage_img_desc_info)
                .build()];
            unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };
        }

        // Render pass and framebuffer.
        let render_pass = make_resolve_render_pass(device)?;
        let fb_views = [*ms_view, *ss_img.view];
        let framebuffer = {
            let info = vk::FramebufferCreateInfo::builder()
                .render_pass(*render_pass)
                .attachments(&fb_views)
                .width(fb_extent.0)
                .height(fb_extent.1)
                .layers(1);
            let handle = unsafe { device.create_framebuffer(&info, None) }.vk_check("vkCreateFramebuffer")?;
            Unique::new(device, handle)
        };

        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[*set_layout], &[])?;

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_n_module = create_shader_module(device, binaries.get("fragN")?)?;
        let frag_y_module = create_shader_module(device, binaries.get("fragY")?)?;

        // Note we add the shaders/pipeline without sample id first, followed by the ones with it.
        let mut pipelines = Vec::new();
        let mut vert_shaders: Vec<ShaderObject<'_>> = Vec::new();
        let mut frag_shaders: Vec<ShaderObject<'_>> = Vec::new();
        for use_sample_id in [false, true] {
            if use_eso {
                vert_shaders.push(create_dgc_shader(
                    device,
                    vk::ShaderStageFlags::VERTEX,
                    &binaries.get("vert")?,
                    &[*set_layout],
                    &[],
                    false,
                    false,
                )?);
                frag_shaders.push(create_dgc_shader(
                    device,
                    vk::ShaderStageFlags::FRAGMENT,
                    &binaries.get(if use_sample_id { "fragY" } else { "fragN" })?,
                    &[*set_layout],
                    &[],
                    false,
                    false,
                )?);
            } else {
                pipelines.push(build_ms_pipeline(
                    device,
                    *pipeline_layout,
                    *render_pass,
                    *vert_module,
                    if use_sample_id { *frag_y_module } else { *frag_n_module },
                    &MsPipelineOptions {
                        extent: fb_extent,
                        sample_count,
                        alpha_to_coverage: false,
                        dynamic_states: &[],
                        fragment_shading_rate: false,
                        indirect_bindable: true,
                        construction: params.construction_type.pipeline_construction(),
                    },
                )?);
            }
        }
        let wrapper_count = 2u32;

        // Indirect execution set.
        let mut ies_manager = if use_eso {
            let set_layouts = vec![*set_layout];
            let stage_infos = [
                (vert_shaders[0].get(), set_layouts.clone()),
                (frag_shaders[0].get(), set_layouts),
            ];
            let mut manager = ExecutionSetManagerExt::new_shader(
                device,
                &stage_infos,
                &[],
                wrapper_count * stage_infos.len() as u32,
            )?;
            for i in 0..wrapper_count as usize {
                manager.add_shader(i as u32 * 2, vert_shaders[i].get());
                manager.add_shader(i as u32 * 2 + 1, frag_shaders[i].get());
            }
            manager
        } else {
            let mut manager = ExecutionSetManagerExt::new_pipeline(device, *pipelines[0], wrapper_count)?;
            for (i, pipeline) in pipelines.iter().enumerate() {
                manager.add_pipeline(i as u32, **pipeline);
            }
            manager
        };
        ies_manager.update();
        let ies_handle = ies_manager.get();

        // DGC commands layout.
        let ies_info_type = if use_eso {
            vk::IndirectExecutionSetInfoTypeEXT::SHADER_OBJECTS
        } else {
            vk::IndirectExecutionSetInfoTypeEXT::PIPELINES
        };
        let cmds_layout_usage = if params.preprocess {
            vk::IndirectCommandsLayoutUsageFlagsEXT::EXPLICIT_PREPROCESS
        } else {
            vk::IndirectCommandsLayoutUsageFlagsEXT::empty()
        };
        let mut cmds_layout_builder =
            IndirectCommandsLayoutBuilderExt::new(cmds_layout_usage, shader_stages, *pipeline_layout);
        cmds_layout_builder.add_execution_set_token(0, ies_info_type, shader_stages);
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_draw_token(offset);
        let cmds_layout = cmds_layout_builder.build(device)?;

        // DGC buffer contents: one triangle strip (pixel) per sequence.
        let max_sequences = pixel_count;
        // Boolean vector indicating if sequence i should use gl_SampleID or not: [N, Y, N, Y] or [Y, N, Y, N] depending on id_first.
        let use_sample_id: Vec<bool> = (0..max_sequences)
            .map(|i| {
                let odd = i % 2 == 0;
                odd == params.id_first
            })
            .collect();
        let mut dgc_data: Vec<u32> = Vec::new();
        for i in 0..max_sequences {
            let draw_cmd = vk::DrawIndirectCommand {
                vertex_count: PER_PIXEL_VERT,
                instance_count: 1,
                first_vertex: i * PER_PIXEL_VERT,
                first_instance: 0,
            };
            // baseIndex: 0 or 1 for the first pipeline wrapper or the second one in this sequence.
            let base_index = u32::from(use_sample_id[i as usize]) % wrapper_count;
            if use_eso {
                // Pairs of vertex and fragment shader indices.
                dgc_data.push(base_index * 2);
                dgc_data.push(base_index * 2 + 1);
            } else {
                dgc_data.push(base_index);
            }
            push_back_element(&mut dgc_data, &draw_cmd);
        }

        let dgc_buffer_size = std::mem::size_of_val(dgc_data.as_slice()) as vk::DeviceSize;
        let dgc_buffer = DgcBuffer::new(
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

        // Preprocess buffer.
        let preprocess_buffer = PreprocessBufferExt::new(
            context,
            ies_handle,
            cmds_layout.get(),
            max_sequences,
            0,
            vk::Pipeline::null(),
            0,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();
        let preprocess_cmd_buffer = if params.preprocess {
            Some(allocate_command_buffer(
                device,
                *cmd_pool,
                vk::CommandBufferLevel::PRIMARY,
            )?)
        } else {
            None
        };

        begin_command_buffer(device, cmd_buffer)?;
        {
            // Transition storage image to the general layout and clear it before the fragment shader stage.
            let clear_access = vk::AccessFlags::TRANSFER_WRITE;
            let shader_access = vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE;
            let pre_clear_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                clear_access,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::GENERAL,
                storage_img.image.get(),
                color_srr,
            );
            let post_clear_barrier = make_memory_barrier(clear_access, shader_access);
            let clear_color = vk::ClearColorValue { float32: CLEAR_COLOR };
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[pre_clear_barrier],
                );
                device.cmd_clear_color_image(
                    cmd_buffer,
                    storage_img.image.get(),
                    vk::ImageLayout::GENERAL,
                    &clear_color,
                    &[color_srr],
                );
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::FRAGMENT_SHADER,
                    vk::DependencyFlags::empty(),
                    &[post_clear_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }

        let render_area = make_rect_2d(0, 0, fb_extent.0, fb_extent.1);
        let clear_value = vk::ClearValue {
            color: vk::ClearColorValue { float32: CLEAR_COLOR },
        };
        if use_eso {
            // The render pass wrapper of shader objects: transitions and dynamic rendering with a resolve attachment.
            let to_attachment = [
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    ms_img.get(),
                    color_srr,
                ),
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    ss_img.image.get(),
                    color_srr,
                ),
            ];
            let color_attachments = [vk::RenderingAttachmentInfo::builder()
                .image_view(*ms_view)
                .image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .resolve_mode(vk::ResolveModeFlags::AVERAGE)
                .resolve_image_view(*ss_img.view)
                .resolve_image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::DONT_CARE)
                .clear_value(clear_value)
                .build()];
            let rendering_info = vk::RenderingInfo::builder()
                .render_area(render_area)
                .layer_count(1)
                .color_attachments(&color_attachments);
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &to_attachment,
                );
                device.cmd_begin_rendering(cmd_buffer, &rendering_info);
            }
        } else {
            begin_render_pass(device, cmd_buffer, *render_pass, *framebuffer, render_area, clear_value);
        }
        unsafe {
            device.cmd_bind_descriptor_sets(
                cmd_buffer,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[],
            );
            device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[vertex_buffer.get()], &[vertex_buffer_offset]);
        }
        if use_eso {
            bind_shaders_with_nulls(
                context,
                cmd_buffer,
                &[
                    (vk::ShaderStageFlags::VERTEX, vert_shaders[0].get()),
                    (vk::ShaderStageFlags::FRAGMENT, frag_shaders[0].get()),
                ],
            );
            let vertex_bindings = [vk::VertexInputBindingDescription2EXT {
                binding: 0,
                stride: std::mem::size_of::<Vec4>() as u32,
                input_rate: vk::VertexInputRate::VERTEX,
                divisor: 1,
                ..Default::default()
            }];
            let vertex_attributes = [vk::VertexInputAttributeDescription2EXT {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 0,
                ..Default::default()
            }];
            bind_shader_object_state(
                context,
                cmd_buffer,
                vk::PrimitiveTopology::TRIANGLE_STRIP,
                0,
                fb_extent,
                Some((&vertex_bindings[..], &vertex_attributes[..])),
            );
            let sample_mask: vk::SampleMask = 0xFFFF_FFFF;
            unsafe {
                device.cmd_set_rasterization_samples_ext(cmd_buffer, sample_count);
                device.cmd_set_sample_mask_ext(cmd_buffer, sample_count, Some(&sample_mask));
            }
        } else {
            unsafe { device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipelines[0]) };
        }
        let mut preprocess_handle = vk::CommandBuffer::null();
        {
            let cmds_info = DgcGenCmdsInfo::new(
                shader_stages,
                ies_handle,
                cmds_layout.get(),
                dgc_buffer.get_device_address(),
                dgc_buffer.get_size(),
                preprocess_buffer.get_device_address(),
                preprocess_buffer.get_size(),
                max_sequences,
                0,
                0,
                vk::Pipeline::null(),
            );
            if let Some(owner) = &preprocess_cmd_buffer {
                preprocess_handle = owner.get();
                begin_command_buffer(device, preprocess_handle)?;
                unsafe { device.cmd_preprocess_generated_commands_ext(preprocess_handle, cmds_info.get(), cmd_buffer) };
                preprocess_to_execute_barrier_ext(device, preprocess_handle);
                end_command_buffer(device, preprocess_handle)?;
            }
            unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, params.preprocess, cmds_info.get()) };
        }
        if use_eso {
            unsafe { device.cmd_end_rendering(cmd_buffer) };
        } else {
            end_render_pass(device, cmd_buffer);
        }
        copy_image_to_buffer(
            device,
            cmd_buffer,
            ss_img.image.get(),
            ss_img.buffer.get(),
            fb_extent.0,
            fb_extent.1,
            1,
        );
        copy_general_image_to_buffer(
            device,
            cmd_buffer,
            storage_img.image.get(),
            storage_img.buffer.get(),
            storage_extent,
            vk::PipelineStageFlags::FRAGMENT_SHADER,
        );
        end_command_buffer(device, cmd_buffer)?;
        submit_and_wait_with_preprocess(device, queue, cmd_buffer, preprocess_handle)?;

        let result_fb = ss_img.read_bytes(device)?;
        let result_storage = storage_img.read_bytes(device)?;

        let reference_fb: Vec<Vec4> = vec![GEOMETRY_COLOR; (fb_extent.0 * fb_extent.1) as usize];
        let mut reference_storage: Vec<Vec4> = vec![CLEAR_COLOR; (storage_extent.0 * storage_extent.1) as usize];
        for x in 0..storage_extent.0 {
            if use_sample_id[x as usize] {
                for y in 0..storage_extent.1 {
                    reference_storage[(y * storage_extent.0 + x) as usize] = GEOMETRY_COLOR;
                }
            } else {
                reference_storage[(x * storage_extent.0 + x) as usize] = GEOMETRY_COLOR;
            }
        }

        let threshold = [0.0f32; 4];
        if !float_threshold_compare(result_fb, &reference_fb, threshold) {
            return Err(TestError::Fail(
                "Framebuffer contains unexpected results; check log for details --".to_string(),
            ));
        }
        if !float_threshold_compare(result_storage, &reference_storage, threshold) {
            return Err(TestError::Fail(
                "Storage image contains unexpected results; check log for details --".to_string(),
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// The `sample_id_state_*` cases, by their full dotted path in `dgc`.
pub fn create_dgc_graphics_misc_sample_id_tests_ext() -> Vec<(String, Box<dyn TestCase>)> {
    let construction_types = [
        (ConstructionType::Monolithic, "monolithic"),
        (ConstructionType::FastLinked, "fast_lib"),
        (ConstructionType::LinkTimeOptimized, "optimized_lib"),
        (ConstructionType::ShaderObjectUnlinkedSpirv, "unlinked_spirv"),
    ];
    let mut cases: Vec<(String, Box<dyn TestCase>)> = Vec::new();
    for (construction_type, suffix) in construction_types {
        for id_first in [false, true] {
            for preprocess in [false, true] {
                let name = format!(
                    "sample_id_state_{}{}_{suffix}",
                    u32::from(id_first),
                    if preprocess { "_preprocess" } else { "" }
                );
                cases.push((
                    format!("ext.graphics.misc.{name}"),
                    Box::new(SampleIdStateCase {
                        name,
                        params: Params {
                            construction_type,
                            id_first,
                            preprocess,
                        },
                    }),
                ));
            }
        }
    }
    cases
}
