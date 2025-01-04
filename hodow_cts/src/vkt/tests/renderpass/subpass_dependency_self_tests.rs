// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktRenderPassSubpassDependencyTests.cpp (`SubpassSelfDependencyBackwardsTestInstance`, `InputAttachmentCoherencyTestInstance`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Render pass and render pass 2 only (the groups are not added for dynamic rendering, as upstream).
// The reference of `geometry_to_indirectdraw` is drawn with the colour pass-through shaders of the pipeline tests fed a red vertex colour, which
// is what upstream's `SelfDependencyBackwardsFragShader` writes. The coherency case uses one monolithic pipeline construction.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;

use crate::generated::shaders::renderpass_subpass_dependencies_self::{INPUT_ATTACHMENT_COHERENCY, SELF_BACKWARDS};
use crate::rr::render_state::RenderState;
use crate::rr::renderer::Program;
use crate::tcu::image_compare::float_threshold_compare;
use crate::tcu::random::Random;
use crate::tcu::{IVec2, TestError, TestOutcome, TestStatus, map_vk_format};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{end_command_buffer, make_rect_2d, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_create_info, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_framebuffer, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::pipeline::pipeline_util::{
    ColorFragmentShader, ColorVertexShader, ReferenceRenderer, Vertex4Rgba, map_vk_primitive_topology,
    read_color_attachment,
};
use crate::vkt::tests::renderpass::group_params::{GroupParams, RenderingType};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

struct SubpassDef {
    inputs: Vec<(u32, vk::ImageLayout, vk::ImageAspectFlags)>,
    colors: Vec<(u32, vk::ImageLayout, vk::ImageAspectFlags)>,
    depth_stencil: Option<(u32, vk::ImageLayout, vk::ImageAspectFlags)>,
}

/// `createRenderPass` for the legacy and the render pass 2 flavours from the same description.
fn create_render_pass<'a>(
    device: &'a Device,
    render_pass2: bool,
    attachments: &[vk::AttachmentDescription],
    subpasses: &[SubpassDef],
    dependencies: &[vk::SubpassDependency],
) -> Result<Unique<'a, vk::RenderPass>, TestError> {
    if !render_pass2 {
        let refs = |list: &[(u32, vk::ImageLayout, vk::ImageAspectFlags)]| -> Vec<vk::AttachmentReference> {
            list.iter()
                .map(|&(attachment, layout, _)| vk::AttachmentReference { attachment, layout })
                .collect()
        };
        let inputs: Vec<_> = subpasses.iter().map(|s| refs(&s.inputs)).collect();
        let colors: Vec<_> = subpasses.iter().map(|s| refs(&s.colors)).collect();
        let depth_stencils: Vec<_> = subpasses
            .iter()
            .map(|s| {
                s.depth_stencil
                    .map(|(attachment, layout, _)| vk::AttachmentReference { attachment, layout })
            })
            .collect();
        let descriptions: Vec<_> = (0..subpasses.len())
            .map(|i| {
                let mut builder = vk::SubpassDescription::builder()
                    .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                    .input_attachments(&inputs[i])
                    .color_attachments(&colors[i]);
                if let Some(depth_stencil) = depth_stencils[i].as_ref() {
                    builder = builder.depth_stencil_attachment(depth_stencil);
                }
                builder.build()
            })
            .collect();
        let info = vk::RenderPassCreateInfo::builder()
            .attachments(attachments)
            .subpasses(&descriptions)
            .dependencies(dependencies);
        return Ok(Unique::new(
            device,
            unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
        ));
    }

    let refs = |list: &[(u32, vk::ImageLayout, vk::ImageAspectFlags)]| -> Vec<vk::AttachmentReference2> {
        list.iter()
            .map(|&(attachment, layout, aspect_mask)| vk::AttachmentReference2 {
                s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
                next: std::ptr::null(),
                attachment,
                layout,
                aspect_mask,
            })
            .collect()
    };
    let inputs: Vec<_> = subpasses.iter().map(|s| refs(&s.inputs)).collect();
    let colors: Vec<_> = subpasses.iter().map(|s| refs(&s.colors)).collect();
    let depth_stencils: Vec<_> = subpasses
        .iter()
        .map(|s| s.depth_stencil.map(|d| refs(&[d])[0]))
        .collect();
    let descriptions: Vec<vk::SubpassDescription2> = (0..subpasses.len())
        .map(|i| vk::SubpassDescription2 {
            s_type: vk::StructureType::SUBPASS_DESCRIPTION_2,
            next: std::ptr::null(),
            flags: vk::SubpassDescriptionFlags::empty(),
            pipeline_bind_point: vk::PipelineBindPoint::GRAPHICS,
            view_mask: 0,
            input_attachment_count: inputs[i].len() as u32,
            input_attachments: inputs[i].as_ptr(),
            color_attachment_count: colors[i].len() as u32,
            color_attachments: colors[i].as_ptr(),
            resolve_attachments: std::ptr::null(),
            depth_stencil_attachment: depth_stencils[i].as_ref().map_or(std::ptr::null(), |d| d as *const _),
            preserve_attachment_count: 0,
            preserve_attachments: std::ptr::null(),
        })
        .collect();
    let attachment_descriptions: Vec<vk::AttachmentDescription2> = attachments
        .iter()
        .map(|a| vk::AttachmentDescription2 {
            s_type: vk::StructureType::ATTACHMENT_DESCRIPTION_2,
            next: std::ptr::null(),
            flags: a.flags,
            format: a.format,
            samples: a.samples,
            load_op: a.load_op,
            store_op: a.store_op,
            stencil_load_op: a.stencil_load_op,
            stencil_store_op: a.stencil_store_op,
            initial_layout: a.initial_layout,
            final_layout: a.final_layout,
        })
        .collect();
    let dependency_descriptions: Vec<vk::SubpassDependency2> = dependencies
        .iter()
        .map(|d| vk::SubpassDependency2 {
            s_type: vk::StructureType::SUBPASS_DEPENDENCY_2,
            next: std::ptr::null(),
            src_subpass: d.src_subpass,
            dst_subpass: d.dst_subpass,
            src_stage_mask: d.src_stage_mask,
            dst_stage_mask: d.dst_stage_mask,
            src_access_mask: d.src_access_mask,
            dst_access_mask: d.dst_access_mask,
            dependency_flags: d.dependency_flags,
            view_offset: 0,
        })
        .collect();
    let info = vk::RenderPassCreateInfo2 {
        s_type: vk::StructureType::RENDER_PASS_CREATE_INFO_2,
        next: std::ptr::null(),
        flags: vk::RenderPassCreateFlags::empty(),
        attachment_count: attachment_descriptions.len() as u32,
        attachments: attachment_descriptions.as_ptr(),
        subpass_count: descriptions.len() as u32,
        subpasses: descriptions.as_ptr(),
        dependency_count: dependency_descriptions.len() as u32,
        dependencies: dependency_descriptions.as_ptr(),
        correlated_view_mask_count: 0,
        correlated_view_masks: std::ptr::null(),
    };
    Ok(Unique::new(
        device,
        unsafe { device.create_render_pass2_khr(&info, None) }.vk_check("vkCreateRenderPass2KHR")?,
    ))
}

fn begin_render_pass(
    device: &Device,
    render_pass2: bool,
    cmd: vk::CommandBuffer,
    begin_info: &vk::RenderPassBeginInfo,
) {
    if render_pass2 {
        let subpass_begin = vk::SubpassBeginInfo::builder().contents(vk::SubpassContents::INLINE);
        unsafe { device.cmd_begin_render_pass2_khr(cmd, begin_info, &subpass_begin) };
    } else {
        unsafe { device.cmd_begin_render_pass(cmd, begin_info, vk::SubpassContents::INLINE) };
    }
}

fn next_subpass(device: &Device, render_pass2: bool, cmd: vk::CommandBuffer) {
    if render_pass2 {
        let subpass_begin = vk::SubpassBeginInfo::builder().contents(vk::SubpassContents::INLINE);
        let subpass_end = vk::SubpassEndInfo::builder();
        unsafe { device.cmd_next_subpass2_khr(cmd, &subpass_begin, &subpass_end) };
    } else {
        unsafe { device.cmd_next_subpass(cmd, vk::SubpassContents::INLINE) };
    }
}

fn end_render_pass(device: &Device, render_pass2: bool, cmd: vk::CommandBuffer) {
    if render_pass2 {
        let subpass_end = vk::SubpassEndInfo::builder();
        unsafe { device.cmd_end_render_pass2_khr(cmd, &subpass_end) };
    } else {
        unsafe { device.cmd_end_render_pass(cmd) };
    }
}

fn attachment_description(
    format: vk::Format,
    load_op: vk::AttachmentLoadOp,
    store_op: vk::AttachmentStoreOp,
    stencil_load_op: vk::AttachmentLoadOp,
    stencil_store_op: vk::AttachmentStoreOp,
    initial: vk::ImageLayout,
    final_layout: vk::ImageLayout,
) -> vk::AttachmentDescription {
    vk::AttachmentDescription {
        flags: vk::AttachmentDescriptionFlags::empty(),
        format,
        samples: vk::SampleCountFlags::_1,
        load_op,
        store_op,
        stencil_load_op,
        stencil_store_op,
        initial_layout: initial,
        final_layout,
    }
}

struct PipelineParams<'p> {
    layout: vk::PipelineLayout,
    render_pass: vk::RenderPass,
    subpass: u32,
    stages: &'p [vk::PipelineShaderStageCreateInfo],
    topology: vk::PrimitiveTopology,
    size: (u32, u32),
    cull_mode: vk::CullModeFlags,
    front_face: vk::FrontFace,
    depth_stencil: vk::PipelineDepthStencilStateCreateInfo,
    blend_attachment_count: usize,
}

/// A graphics pipeline over one `vec4` position attribute, with `makeGraphicsPipeline`'s defaults for the rest.
fn build_pipeline<'a>(device: &'a Device, params: &PipelineParams<'_>) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let bindings = [vk::VertexInputBindingDescription {
        binding: 0,
        stride: 16,
        input_rate: vk::VertexInputRate::VERTEX,
    }];
    let attributes = [vk::VertexInputAttributeDescription {
        location: 0,
        binding: 0,
        format: vk::Format::R32G32B32A32_SFLOAT,
        offset: 0,
    }];
    let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder()
        .vertex_binding_descriptions(&bindings)
        .vertex_attribute_descriptions(&attributes);
    let input_assembly = vk::PipelineInputAssemblyStateCreateInfo::builder().topology(params.topology);
    let viewports = [vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: params.size.0 as f32,
        height: params.size.1 as f32,
        min_depth: 0.0,
        max_depth: 1.0,
    }];
    let scissors = [make_rect_2d(0, 0, params.size.0, params.size.1)];
    let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
        .viewports(&viewports)
        .scissors(&scissors);
    let rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(params.cull_mode)
        .front_face(params.front_face)
        .depth_bias_enable(false)
        .line_width(1.0);
    let multisample = vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
    let blend_attachment = vk::PipelineColorBlendAttachmentState::builder()
        .blend_enable(false)
        .src_color_blend_factor(vk::BlendFactor::ONE)
        .dst_color_blend_factor(vk::BlendFactor::ZERO)
        .color_blend_op(vk::BlendOp::ADD)
        .src_alpha_blend_factor(vk::BlendFactor::ONE)
        .dst_alpha_blend_factor(vk::BlendFactor::ZERO)
        .alpha_blend_op(vk::BlendOp::ADD)
        .color_write_mask(vk::ColorComponentFlags::all())
        .build();
    let blend_attachments = vec![blend_attachment; params.blend_attachment_count];
    let color_blend = vk::PipelineColorBlendStateCreateInfo::builder()
        .logic_op(vk::LogicOp::CLEAR)
        .attachments(&blend_attachments);
    let info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(params.stages)
        .vertex_input_state(&vertex_input)
        .input_assembly_state(&input_assembly)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization)
        .multisample_state(&multisample)
        .depth_stencil_state(&params.depth_stencil)
        .color_blend_state(&color_blend)
        .layout(params.layout)
        .render_pass(params.render_pass)
        .subpass(params.subpass)
        .base_pipeline_index(0);
    crate::vk::pipeline_construction::create_graphics_pipeline(device, &info)
}

fn stage(stage: vk::ShaderStageFlags, module: vk::ShaderModule) -> vk::PipelineShaderStageCreateInfo {
    vk::PipelineShaderStageCreateInfo::builder()
        .stage(stage)
        .module(module)
        .name(b"main\0")
        .build()
}

fn vertex_buffer<'a>(context: &'a Context<'a>, vertices: &[[f32; 4]]) -> Result<BufferWithMemory<'a>, TestError> {
    let device = context.get_device();
    let size = (vertices.len() * 16) as u64;
    let buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(size, vk::BufferUsageFlags::VERTEX_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe {
        std::ptr::copy_nonoverlapping(
            vertices.as_ptr() as *const u8,
            buffer.get_allocation().get_host_ptr(),
            size as usize,
        )
    };
    flush_alloc(device, buffer.get_allocation())?;
    Ok(buffer)
}

fn begin_command_buffer_plain(device: &Device, cmd: vk::CommandBuffer) -> Result<(), TestError> {
    let begin_info = vk::CommandBufferBeginInfo::builder();
    unsafe { device.begin_command_buffer(cmd, &begin_info) }.vk_check("vkBeginCommandBuffer")
}

fn check_render_pass2(context: &Context<'_>, rendering_type: RenderingType) -> Result<(), TestError> {
    if rendering_type == RenderingType::RenderPass2 {
        context.require_device_functionality("VK_KHR_create_renderpass2")?;
    }
    Ok(())
}

// ---------------------------------------------------------------------------------------------------------------------
// self_dependency.render_size_*.geometry_to_indirectdraw
// ---------------------------------------------------------------------------------------------------------------------

struct SelfBackwardsCase {
    size: u32,
    rendering_type: RenderingType,
}

impl TestCase for SelfBackwardsCase {
    fn name(&self) -> &str {
        "geometry_to_indirectdraw"
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if context.get_device_features().geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requested core feature is not supported: geometryShader".to_string(),
            ));
        }
        check_render_pass2(context, self.rendering_type)
    }

    fn programs(&self) -> BinaryCollection {
        SELF_BACKWARDS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SelfBackwardsInstance {
            context,
            size: self.size,
            render_pass2: self.rendering_type == RenderingType::RenderPass2,
        })
    }
}

struct SelfBackwardsInstance<'a> {
    context: &'a Context<'a>,
    size: u32,
    render_pass2: bool,
}

impl TestInstance for SelfBackwardsInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let (width, height) = (self.size, self.size);
        let format = vk::Format::R8G8B8A8_UNORM;
        let mut rand = Random::new(5);

        let command_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;

        let image_info = make_image_create_info(
            IVec2::new(width as i32, height as i32),
            format,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        );
        let output_image = ImageWithMemory::new(
            device,
            context.get_default_allocator(),
            image_info,
            MemoryRequirement::ANY,
        )?;

        let indirect_buffer_size = 16u64;
        let indirect_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(
                indirect_buffer_size,
                vk::BufferUsageFlags::INDIRECT_BUFFER | vk::BufferUsageFlags::STORAGE_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let draw_indirect_command = vk::DrawIndirectCommand {
            vertex_count: 64,
            instance_count: 1,
            first_vertex: 0,
            first_instance: 0,
        };
        unsafe {
            std::ptr::write_unaligned(
                indirect_buffer.get_allocation().get_host_ptr() as *mut vk::DrawIndirectCommand,
                draw_indirect_command,
            )
        };
        flush_alloc(device, indirect_buffer.get_allocation())?;

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::GEOMETRY)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let buffer_info = make_descriptor_buffer_info(indirect_buffer.get(), 0, indirect_buffer_size);
        let write = vk::WriteDescriptorSet {
            dst_set: *descriptor_set,
            dst_binding: 0,
            descriptor_count: 1,
            descriptor_type: vk::DescriptorType::STORAGE_BUFFER,
            buffer_info: &buffer_info,
            ..Default::default()
        };
        unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;

        let attachments = [attachment_description(
            format,
            vk::AttachmentLoadOp::CLEAR,
            vk::AttachmentStoreOp::STORE,
            vk::AttachmentLoadOp::DONT_CARE,
            vk::AttachmentStoreOp::DONT_CARE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )];
        let subpasses = [SubpassDef {
            inputs: vec![],
            colors: vec![(
                0,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageAspectFlags::empty(),
            )],
            depth_stencil: None,
        }];
        let dependencies = [vk::SubpassDependency {
            src_subpass: 0,
            dst_subpass: 0,
            src_stage_mask: vk::PipelineStageFlags::GEOMETRY_SHADER,
            dst_stage_mask: vk::PipelineStageFlags::DRAW_INDIRECT,
            src_access_mask: vk::AccessFlags::SHADER_WRITE,
            dst_access_mask: vk::AccessFlags::INDIRECT_COMMAND_READ,
            dependency_flags: vk::DependencyFlags::empty(),
        }];
        let render_pass = create_render_pass(device, self.render_pass2, &attachments, &subpasses, &dependencies)?;

        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let geometry_module = create_shader_module(device, binaries.get("geom")?)?;
        let fragment_module = create_shader_module(device, binaries.get("frag")?)?;
        let stages = [
            stage(vk::ShaderStageFlags::VERTEX, *vertex_module),
            stage(vk::ShaderStageFlags::GEOMETRY, *geometry_module),
            stage(vk::ShaderStageFlags::FRAGMENT, *fragment_module),
        ];
        let pipeline = build_pipeline(
            device,
            &PipelineParams {
                layout: *pipeline_layout,
                render_pass: *render_pass,
                subpass: 0,
                stages: &stages,
                topology: vk::PrimitiveTopology::POINT_LIST,
                size: (width, height),
                cull_mode: vk::CullModeFlags::NONE,
                front_face: vk::FrontFace::COUNTER_CLOCKWISE,
                depth_stencil: vk::PipelineDepthStencilStateCreateInfo::builder().build(),
                blend_attachment_count: 1,
            },
        )?;

        let output_view = make_image_view(
            device,
            output_image.get(),
            vk::ImageViewType::_2D,
            format,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*output_view], width, height, 1)?;

        // Pixel centered random points, to make the reference comparison easier.
        let mut vertex_data: Vec<[f32; 4]> = Vec::with_capacity(128);
        for _ in 0..128 {
            let x = (rand.get_uint32() % width * 2) as f32 / width as f32 - 1.0;
            let y = (rand.get_uint32() % height * 2) as f32 / height as f32 - 1.0;
            vertex_data.push([x, y, 1.0, 1.0]);
        }
        let vertex_buffer = vertex_buffer(context, &vertex_data)?;

        begin_command_buffer_plain(device, *command_buffer)?;
        unsafe {
            device.cmd_bind_pipeline(*command_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_descriptor_sets(
                *command_buffer,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[*descriptor_set],
                &[] as &[u32],
            );
        }
        let clear_values = [vk::ClearValue {
            color: vk::ClearColorValue {
                float32: [0.0, 1.0, 0.0, 1.0],
            },
        }];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(make_rect_2d(0, 0, width, height))
            .clear_values(&clear_values);
        begin_render_pass(device, self.render_pass2, *command_buffer, &begin_info);
        unsafe {
            device.cmd_bind_vertex_buffers(*command_buffer, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_pipeline(*command_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            // The first indirect draw: the first 64 items.
            device.cmd_draw_indirect(*command_buffer, indirect_buffer.get(), 0, 1, 0);
            let barrier = vk::MemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::SHADER_WRITE)
                .dst_access_mask(vk::AccessFlags::INDIRECT_COMMAND_READ)
                .build();
            device.cmd_pipeline_barrier(
                *command_buffer,
                vk::PipelineStageFlags::GEOMETRY_SHADER,
                vk::PipelineStageFlags::DRAW_INDIRECT,
                vk::DependencyFlags::empty(),
                &[barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
            // The second indirect draw: the last 64 items.
            device.cmd_draw_indirect(*command_buffer, indirect_buffer.get(), 0, 1, 0);
        }
        end_render_pass(device, self.render_pass2, *command_buffer);
        end_command_buffer(device, *command_buffer)?;
        submit_commands_and_wait(device, context.get_universal_queue(), *command_buffer)?;

        let rendered = read_color_attachment(
            context,
            output_image.get(),
            format,
            (width, height),
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;

        // Points become quads like the ones the geometry shader emits.
        let offset = 0.03f32;
        let mut triangles: Vec<Vertex4Rgba> = Vec::with_capacity(vertex_data.len() * 6);
        let red = [1.0, 0.0, 0.0, 1.0];
        for v in &vertex_data {
            let moved = |dx: f32, dy: f32| Vertex4Rgba {
                position: [v[0] + dx, v[1] + dy, v[2], v[3]],
                color: red,
            };
            triangles.push(moved(-offset, offset));
            triangles.push(moved(-offset, -offset));
            triangles.push(moved(offset, offset));
            triangles.push(moved(-offset, -offset));
            triangles.push(moved(offset, offset));
            triangles.push(moved(offset, -offset));
        }
        let tcu_format =
            map_vk_format(format).ok_or_else(|| TestError::InternalError("RGBA8 has a texture format".to_string()))?;
        let vertex_shader = ColorVertexShader::new();
        let fragment_shader = ColorFragmentShader::new(tcu_format, None, false);
        let program = Program {
            vertex_shader: &vertex_shader,
            fragment_shader: &fragment_shader,
            geometry_shader: None,
        };
        let mut reference = ReferenceRenderer::new(width, height, tcu_format, None)?;
        let render_state = RenderState::new(
            reference.get_viewport_state(),
            context.get_device_properties().limits.sub_pixel_precision_bits as i32,
        );
        reference.color_clear([0.0, 1.0, 0.0, 1.0]);
        reference.draw(
            &program,
            &render_state,
            map_vk_primitive_topology(vk::PrimitiveTopology::TRIANGLE_LIST),
            &triangles,
        );

        if !float_threshold_compare(&reference.get_access(), &rendered.get_const_access(), [0.01; 4]).ok {
            return Ok(TestStatus::fail("Image compare failed."));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// input_attachment_coherency.test
// ---------------------------------------------------------------------------------------------------------------------

struct CoherencyCase {
    rendering_type: RenderingType,
}

impl TestCase for CoherencyCase {
    fn name(&self) -> &str {
        "test"
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_render_pass2(context, self.rendering_type)?;
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let color =
            unsafe { instance.get_physical_device_format_properties(physical_device, vk::Format::R8G8B8A8_UNORM) }
                .optimal_tiling_features;
        let required = vk::FormatFeatureFlags::COLOR_ATTACHMENT | vk::FormatFeatureFlags::TRANSFER_SRC;
        if !color.contains(required) {
            return Err(TestError::NotSupported(
                "VK_FORMAT_R8G8B8A8_UNORM format not supported for required rendering/readback features".to_string(),
            ));
        }
        let depth_stencil =
            unsafe { instance.get_physical_device_format_properties(physical_device, vk::Format::D24_UNORM_S8_UINT) }
                .optimal_tiling_features;
        if !depth_stencil.contains(vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT) {
            return Err(TestError::NotSupported(
                "VK_FORMAT_D24_UNORM_S8_UINT format not supported for depth/stencil features".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        INPUT_ATTACHMENT_COHERENCY.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CoherencyInstance {
            context,
            render_pass2: self.rendering_type == RenderingType::RenderPass2,
        })
    }
}

struct CoherencyInstance<'a> {
    context: &'a Context<'a>,
    render_pass2: bool,
}

impl TestInstance for CoherencyInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let (width, height) = (32u32, 32u32);
        let size = IVec2::new(width as i32, height as i32);
        let (overlap_min_x, overlap_max_x, overlap_min_y, overlap_max_y) = (10u32, 25u32, 10u32, 25u32);
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let depth_format = vk::Format::D24_UNORM_S8_UINT;

        let depth_image = ImageWithMemory::new(
            device,
            allocator,
            make_image_create_info(
                size,
                depth_format,
                vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::INPUT_ATTACHMENT,
            ),
            MemoryRequirement::ANY,
        )?;
        let color_image = ImageWithMemory::new(
            device,
            allocator,
            make_image_create_info(
                size,
                color_format,
                vk::ImageUsageFlags::COLOR_ATTACHMENT
                    | vk::ImageUsageFlags::INPUT_ATTACHMENT
                    | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;
        let gbuffer_image = ImageWithMemory::new(
            device,
            allocator,
            make_image_create_info(
                size,
                color_format,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::INPUT_ATTACHMENT,
            ),
            MemoryRequirement::ANY,
        )?;
        let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let depth_range =
            make_image_subresource_range(vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL, 0, 1, 0, 1);
        let depth_view = make_image_view(
            device,
            depth_image.get(),
            vk::ImageViewType::_2D,
            depth_format,
            depth_range,
        )?;
        let color_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            color_format,
            color_range,
        )?;
        let gbuffer_view = make_image_view(
            device,
            gbuffer_image.get(),
            vk::ImageViewType::_2D,
            color_format,
            color_range,
        )?;

        let subpass0_vertices: [[f32; 4]; 6] = [
            [-1.0, -1.0, 0.0665, 1.0],
            [1.0, 1.0, 0.0665, 1.0],
            [1.0, -1.0, 0.0665, 1.0],
            [-1.0, -1.0, 0.0665, 1.0],
            [-1.0, 1.0, 0.0665, 1.0],
            [1.0, 1.0, 0.0665, 1.0],
        ];
        let subpass1_vertices: [[f32; 4]; 6] = [
            [-0.6, -0.6, 0.0857, 1.0],
            [1.4, 1.4, 0.0857, 1.0],
            [1.4, -0.6, 0.0857, 1.0],
            [-0.6, -0.6, 0.0857, 1.0],
            [-0.6, 1.4, 0.0857, 1.0],
            [1.4, 1.4, 0.0857, 1.0],
        ];
        let vertex_buffer0 = vertex_buffer(context, &subpass0_vertices)?;
        let vertex_buffer1 = vertex_buffer(context, &subpass1_vertices)?;

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::INPUT_ATTACHMENT, vk::ShaderStageFlags::FRAGMENT)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::INPUT_ATTACHMENT, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let image_info = vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *gbuffer_view,
            image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        };
        let write = vk::WriteDescriptorSet {
            dst_set: *descriptor_set,
            dst_binding: 0,
            descriptor_count: 1,
            descriptor_type: vk::DescriptorType::INPUT_ATTACHMENT,
            image_info: &image_info,
            ..Default::default()
        };
        unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
        let geometry_pipeline_layout = make_pipeline_layout(device, &[])?;
        let resolve_pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;

        let attachments = [
            attachment_description(
                depth_format,
                vk::AttachmentLoadOp::CLEAR,
                vk::AttachmentStoreOp::STORE,
                vk::AttachmentLoadOp::CLEAR,
                vk::AttachmentStoreOp::STORE,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            ),
            attachment_description(
                color_format,
                vk::AttachmentLoadOp::CLEAR,
                vk::AttachmentStoreOp::STORE,
                vk::AttachmentLoadOp::DONT_CARE,
                vk::AttachmentStoreOp::DONT_CARE,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            ),
            attachment_description(
                color_format,
                vk::AttachmentLoadOp::CLEAR,
                vk::AttachmentStoreOp::DONT_CARE,
                vk::AttachmentLoadOp::DONT_CARE,
                vk::AttachmentStoreOp::DONT_CARE,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            ),
        ];
        let color_layout = vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL;
        let depth_stencil_reference = Some((
            0,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL,
        ));
        let subpasses = [
            SubpassDef {
                inputs: vec![],
                colors: vec![
                    (2, color_layout, vk::ImageAspectFlags::COLOR),
                    (1, color_layout, vk::ImageAspectFlags::COLOR),
                ],
                depth_stencil: depth_stencil_reference,
            },
            SubpassDef {
                inputs: vec![(
                    2,
                    vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
                    vk::ImageAspectFlags::COLOR,
                )],
                colors: vec![(1, color_layout, vk::ImageAspectFlags::COLOR)],
                depth_stencil: depth_stencil_reference,
            },
        ];
        let dependencies = [vk::SubpassDependency {
            src_subpass: 0,
            dst_subpass: 1,
            src_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT
                | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
            dst_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT
                | vk::PipelineStageFlags::FRAGMENT_SHADER
                | vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS,
            src_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
            dst_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE
                | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ
                | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE
                | vk::AccessFlags::INPUT_ATTACHMENT_READ,
            dependency_flags: vk::DependencyFlags::BY_REGION,
        }];
        let render_pass = create_render_pass(device, self.render_pass2, &attachments, &subpasses, &dependencies)?;
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*depth_view, *color_view, *gbuffer_view],
            width,
            height,
            1,
        )?;

        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let opaque_module = create_shader_module(device, binaries.get("frag_opaque")?)?;
        let resolve_module = create_shader_module(device, binaries.get("frag_resolve")?)?;
        let mut depth_stencil = crate::vkt::tests::draw::util::default_depth_stencil_state();
        depth_stencil.depth_test_enable = vk::TRUE;
        depth_stencil.depth_write_enable = vk::TRUE;
        depth_stencil.depth_compare_op = vk::CompareOp::GREATER_OR_EQUAL;
        let opaque_stages = [
            stage(vk::ShaderStageFlags::VERTEX, *vertex_module),
            stage(vk::ShaderStageFlags::FRAGMENT, *opaque_module),
        ];
        let resolve_stages = [
            stage(vk::ShaderStageFlags::VERTEX, *vertex_module),
            stage(vk::ShaderStageFlags::FRAGMENT, *resolve_module),
        ];
        let geometry_pipeline = build_pipeline(
            device,
            &PipelineParams {
                layout: *geometry_pipeline_layout,
                render_pass: *render_pass,
                subpass: 0,
                stages: &opaque_stages,
                topology: vk::PrimitiveTopology::TRIANGLE_LIST,
                size: (width, height),
                cull_mode: vk::CullModeFlags::BACK,
                front_face: vk::FrontFace::COUNTER_CLOCKWISE,
                depth_stencil,
                blend_attachment_count: 2,
            },
        )?;
        let resolve_pipeline = build_pipeline(
            device,
            &PipelineParams {
                layout: *resolve_pipeline_layout,
                render_pass: *render_pass,
                subpass: 1,
                stages: &resolve_stages,
                topology: vk::PrimitiveTopology::TRIANGLE_LIST,
                size: (width, height),
                cull_mode: vk::CullModeFlags::BACK,
                front_face: vk::FrontFace::COUNTER_CLOCKWISE,
                depth_stencil,
                blend_attachment_count: 1,
            },
        )?;

        let command_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer_plain(device, *cmd)?;

        let initial_barriers = [
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                depth_image.get(),
                depth_range,
            ),
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                color_image.get(),
                color_range,
            ),
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                gbuffer_image.get(),
                color_range,
            ),
        ];
        unsafe {
            device.cmd_pipeline_barrier(
                *cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::ALL_GRAPHICS,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &initial_barriers,
            );
        }

        let clear_values = [
            vk::ClearValue {
                depth_stencil: vk::ClearDepthStencilValue { depth: 0.0, stencil: 0 },
            },
            vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: [0.0, 0.0, 0.0, 1.0],
                },
            },
            vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: [1.0, 0.0, 0.0, 1.0],
                },
            },
        ];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(make_rect_2d(0, 0, width, height))
            .clear_values(&clear_values);
        begin_render_pass(device, self.render_pass2, *cmd, &begin_info);
        unsafe {
            device.cmd_bind_pipeline(*cmd, vk::PipelineBindPoint::GRAPHICS, *geometry_pipeline);
            device.cmd_bind_vertex_buffers(*cmd, 0, &[vertex_buffer0.get()], &[0]);
            device.cmd_draw(*cmd, 6, 1, 0, 0);
        }
        next_subpass(device, self.render_pass2, *cmd);
        unsafe {
            device.cmd_bind_pipeline(*cmd, vk::PipelineBindPoint::GRAPHICS, *resolve_pipeline);
            device.cmd_bind_vertex_buffers(*cmd, 0, &[vertex_buffer1.get()], &[0]);
            device.cmd_bind_descriptor_sets(
                *cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *resolve_pipeline_layout,
                0,
                &[*descriptor_set],
                &[] as &[u32],
            );
            device.cmd_draw(*cmd, 6, 1, 0, 0);
        }
        end_render_pass(device, self.render_pass2, *cmd);
        end_command_buffer(device, *cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), *cmd)?;

        let result = read_color_attachment(
            context,
            color_image.get(),
            color_format,
            (width, height),
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let result_access = result.get_const_access();
        let expected = [0.0f32, 1.0, 0.0, 1.0];
        for y in overlap_min_y..=overlap_max_y {
            for x in overlap_min_x..=overlap_max_x {
                let pixel = result_access.get_pixel(x, y, 0);
                if (0..4).any(|c| (pixel[c] - expected[c]).abs() > 0.02) {
                    return Ok(TestStatus::fail(
                        "Resolved color attachment holds corrupted pixels (stale cache read detected)",
                    ));
                }
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// The `self_dependency` and `input_attachment_coherency` groups of `subpass_dependencies`.
pub fn add_self_dependency_tests(group: &mut TestCaseGroup, group_params: GroupParams) {
    if group_params.rendering_type == RenderingType::DynamicRendering {
        return;
    }
    let mut self_dependency = TestCaseGroup::new("self_dependency");
    for (name, size) in [
        ("render_size_64_64", 64u32),
        ("render_size_128_128", 128),
        ("render_size_512_512", 512),
    ] {
        let mut size_group = TestCaseGroup::new(name);
        size_group.add_child(Box::new(SelfBackwardsCase {
            size,
            rendering_type: group_params.rendering_type,
        }) as Box<dyn TestCase>);
        self_dependency.add_child(size_group);
    }
    group.add_child(self_dependency);

    let mut coherency = TestCaseGroup::new("input_attachment_coherency");
    coherency.add_child(Box::new(CoherencyCase {
        rendering_type: group_params.rendering_type,
    }) as Box<dyn TestCase>);
    group.add_child(coherency);
}
