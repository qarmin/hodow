// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/data/vulkan/amber/spirv_assembly/instruction/function_params/sampler_param.amber
//   external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmInstructionTests.cpp (createFunctionParamsGroup)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2020 Valve Corporation.
// Copyright (c) 2020 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. What Amber does for the script is done directly: a 1x1 RGBA8 texture is rendered green
// (texgen_pipeline), then a full-screen quad is drawn into a 64x64 BGRA8 target by a fragment shader that passes the combined image sampler to a
// function (main_pipeline), and every pixel of the target must be green. The script's own `EXPECT texture` readback is not repeated: a texture that
// was not green could not make the second pass green over a target cleared to black. Shaders in `shaders/manifest/spirv_assembly_function_params.toml`.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::spirv_assembly_function_params::*;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, make_rect_2d, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::pipeline::pipeline_util::read_color_attachment;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const TARGET_SIZE: u32 = 64;

struct SamplerParamCase;

impl TestCase for SamplerParamCase {
    fn name(&self) -> &str {
        "sampler_param"
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        FUNCTION_PARAMS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SamplerParamInstance { context })
    }
}

struct SamplerParamInstance<'a> {
    context: &'a Context<'a>,
}

fn make_color_render_pass(
    device: &Device,
    format: vk::Format,
    final_layout: vk::ImageLayout,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let attachments = [vk::AttachmentDescription::builder()
        .format(format)
        .samples(vk::SampleCountFlags::_1)
        .load_op(vk::AttachmentLoadOp::CLEAR)
        .store_op(vk::AttachmentStoreOp::STORE)
        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
        .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .final_layout(final_layout)
        .build()];
    let color_reference = [vk::AttachmentReference {
        attachment: 0,
        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    }];
    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_reference)
        .build()];
    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses);
    Ok(Unique::new(
        device,
        unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
    ))
}

fn make_quad_pipeline(
    device: &Device,
    layout: vk::PipelineLayout,
    render_pass: vk::RenderPass,
    vertex: vk::ShaderModule,
    fragment: vk::ShaderModule,
    size: u32,
) -> Result<Unique<'_, vk::Pipeline>, TestError> {
    let entry = c"main";
    let stages = [
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::VERTEX)
            .module(vertex)
            .name(entry.to_bytes_with_nul())
            .build(),
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::FRAGMENT)
            .module(fragment)
            .name(entry.to_bytes_with_nul())
            .build(),
    ];
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
    let input_assembly =
        vk::PipelineInputAssemblyStateCreateInfo::builder().topology(vk::PrimitiveTopology::TRIANGLE_LIST);
    let viewports = [vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: size as f32,
        height: size as f32,
        min_depth: 0.0,
        max_depth: 1.0,
    }];
    let scissors = [make_rect_2d(0, 0, size, size)];
    let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
        .viewports(&viewports)
        .scissors(&scissors);
    let rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .line_width(1.0);
    let multisample = vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
    let blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
        .blend_enable(false)
        .color_write_mask(vk::ColorComponentFlags::all())
        .build()];
    let color_blend = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&blend_attachments);
    let info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&stages)
        .vertex_input_state(&vertex_input)
        .input_assembly_state(&input_assembly)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization)
        .multisample_state(&multisample)
        .color_blend_state(&color_blend)
        .layout(layout)
        .render_pass(render_pass)
        .subpass(0)
        .base_pipeline_index(0);
    let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateGraphicsPipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

impl TestInstance for SamplerParamInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let queue = context.get_universal_queue();
        let texture_format = vk::Format::R8G8B8A8_UNORM;
        let target_format = vk::Format::B8G8R8A8_UNORM;

        let image_info = |format: vk::Format, size: u32, usage: vk::ImageUsageFlags| {
            vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(format)
                .extent(vk::Extent3D {
                    width: size,
                    height: size,
                    depth: 1,
                })
                .mip_levels(1)
                .array_layers(1)
                .samples(vk::SampleCountFlags::_1)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(usage)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build()
        };
        let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let texture = ImageWithMemory::new(
            device,
            allocator,
            image_info(
                texture_format,
                1,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::SAMPLED,
            ),
            MemoryRequirement::ANY,
        )?;
        let texture_view = make_image_view(
            device,
            texture.get(),
            vk::ImageViewType::_2D,
            texture_format,
            color_range,
        )?;
        let target = ImageWithMemory::new(
            device,
            allocator,
            image_info(
                target_format,
                TARGET_SIZE,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;
        let target_view = make_image_view(device, target.get(), vk::ImageViewType::_2D, target_format, color_range)?;

        let quad: [[f32; 4]; 6] = [
            [-1.0, -1.0, 0.0, 1.0],
            [1.0, -1.0, 0.0, 1.0],
            [-1.0, 1.0, 0.0, 1.0],
            [-1.0, 1.0, 0.0, 1.0],
            [1.0, -1.0, 0.0, 1.0],
            [1.0, 1.0, 0.0, 1.0],
        ];
        let quad_bytes = std::mem::size_of_val(&quad);
        let vertex_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(quad_bytes as u64, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                quad.as_ptr().cast::<u8>(),
                vertex_buffer.get_allocation().get_host_ptr(),
                quad_bytes,
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?;

        let binaries = context.get_binary_collection();
        let passthrough_vertex = create_shader_module(device, binaries.get("passthrough_vert")?)?;
        let green_fragment = create_shader_module(device, binaries.get("green_frag")?)?;
        let texcoord_vertex = create_shader_module(device, binaries.get("texcoord_vert")?)?;
        let sampler_fragment = create_shader_module(device, binaries.get("sampler_param_frag")?)?;

        let texgen_render_pass =
            make_color_render_pass(device, texture_format, vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL)?;
        let texgen_framebuffer = make_framebuffer(device, *texgen_render_pass, &[*texture_view], 1, 1, 1)?;
        let empty_layout = DescriptorSetLayoutBuilder::new().build(device)?;
        let texgen_pipeline_layout = make_pipeline_layout(device, &[*empty_layout])?;
        let texgen_pipeline = make_quad_pipeline(
            device,
            *texgen_pipeline_layout,
            *texgen_render_pass,
            *passthrough_vertex,
            *green_fragment,
            1,
        )?;

        let main_render_pass =
            make_color_render_pass(device, target_format, vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)?;
        let main_framebuffer =
            make_framebuffer(device, *main_render_pass, &[*target_view], TARGET_SIZE, TARGET_SIZE, 1)?;
        let sampler_info = vk::SamplerCreateInfo::builder()
            .mag_filter(vk::Filter::NEAREST)
            .min_filter(vk::Filter::NEAREST)
            .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
            .address_mode_u(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .address_mode_v(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .address_mode_w(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .max_lod(1.0)
            .border_color(vk::BorderColor::FLOAT_TRANSPARENT_BLACK);
        let sampler = Unique::new(
            device,
            unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
        );
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                vk::ShaderStageFlags::FRAGMENT,
            )
            .build(device)?;
        let main_pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let image_infos = [vk::DescriptorImageInfo::builder()
            .sampler(*sampler)
            .image_view(*texture_view)
            .image_layout(vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL)
            .build()];
        let writes = [vk::WriteDescriptorSet::builder()
            .dst_set(descriptor_set.get())
            .dst_binding(0)
            .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
            .image_info(&image_infos)
            .build()];
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };
        let main_pipeline = make_quad_pipeline(
            device,
            *main_pipeline_layout,
            *main_render_pass,
            *texcoord_vertex,
            *sampler_fragment,
            TARGET_SIZE,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;

        let texgen_cmd = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, *texgen_cmd)?;
        let clear_values = [vk::ClearValue {
            color: vk::ClearColorValue {
                float32: [0.0, 0.0, 0.0, 0.0],
            },
        }];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*texgen_render_pass)
            .framebuffer(*texgen_framebuffer)
            .render_area(make_rect_2d(0, 0, 1, 1))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(*texgen_cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(*texgen_cmd, vk::PipelineBindPoint::GRAPHICS, *texgen_pipeline);
            device.cmd_bind_vertex_buffers(*texgen_cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_draw(*texgen_cmd, 6, 1, 0, 0);
            device.cmd_end_render_pass(*texgen_cmd);
        }
        end_command_buffer(device, *texgen_cmd)?;
        submit_commands_and_wait(device, queue, *texgen_cmd)?;

        let main_cmd = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, *main_cmd)?;
        let clear_values = [vk::ClearValue {
            color: vk::ClearColorValue {
                float32: [0.0, 0.0, 0.0, 1.0],
            },
        }];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*main_render_pass)
            .framebuffer(*main_framebuffer)
            .render_area(make_rect_2d(0, 0, TARGET_SIZE, TARGET_SIZE))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(*main_cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(*main_cmd, vk::PipelineBindPoint::GRAPHICS, *main_pipeline);
            device.cmd_bind_descriptor_sets(
                *main_cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *main_pipeline_layout,
                0,
                &[*descriptor_set],
                &[],
            );
            device.cmd_bind_vertex_buffers(*main_cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_draw(*main_cmd, 6, 1, 0, 0);
            device.cmd_end_render_pass(*main_cmd);
        }
        end_command_buffer(device, *main_cmd)?;
        submit_commands_and_wait(device, queue, *main_cmd)?;

        let result = read_color_attachment(
            context,
            target.get(),
            target_format,
            (TARGET_SIZE, TARGET_SIZE),
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let pixels = result.get_const_access();
        for y in 0..TARGET_SIZE {
            for x in 0..TARGET_SIZE {
                let actual = pixels
                    .get_pixel(x, y, 0)
                    .map(|channel| (channel * 255.0).round() as i32);
                if actual != [0, 255, 0, 255] {
                    return Ok(TestStatus::fail(format!(
                        "Unexpected colour {actual:?} at ({x}, {y}), expected [0, 255, 0, 255]"
                    )));
                }
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createFunctionParamsGroup`
pub fn create_function_params_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("function_params");
    group.add_child(Box::new(SamplerParamCase) as Box<dyn crate::vkt::TestCase>);
    group
}
