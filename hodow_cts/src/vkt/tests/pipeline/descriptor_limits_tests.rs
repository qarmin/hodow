// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineDescriptorLimitsTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders' last binding is substituted into one template per
// descriptor type, so the manifest carries 396 cases rather than the instance generating source text.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::pipeline_descriptor_limits::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_framebuffer,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, clear_color_image, clear_value_color, create_draw_pipeline, make_color_render_pass, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::pipeline::shader_object_draw::{begin_draw, end_draw, make_shader_objects};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestType {
    Samplers,
    UniformBuffers,
    StorageBuffers,
    SampledImages,
    StorageImages,
    InputAttachments,
}

impl TestType {
    fn name(self) -> &'static str {
        match self {
            Self::Samplers => "samplers",
            Self::UniformBuffers => "uniform_buffers",
            Self::StorageBuffers => "storage_buffers",
            Self::SampledImages => "sampled_images",
            Self::StorageImages => "storage_images",
            Self::InputAttachments => "input_attachments",
        }
    }

    fn descriptor_type(self) -> vk::DescriptorType {
        match self {
            Self::Samplers => vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
            Self::UniformBuffers => vk::DescriptorType::UNIFORM_BUFFER,
            Self::StorageBuffers => vk::DescriptorType::STORAGE_BUFFER,
            Self::SampledImages => vk::DescriptorType::SAMPLED_IMAGE,
            Self::StorageImages => vk::DescriptorType::STORAGE_IMAGE,
            Self::InputAttachments => vk::DescriptorType::INPUT_ATTACHMENT,
        }
    }
}

/// `TestParams`, with the construction type left out: only monolithic pipelines are built.
#[derive(Clone, Copy)]
struct TestParams {
    test_type: TestType,
    use_comp_shader: bool,
    framebuffer_size: u32,
    desc_count: u32,
}

impl TestParams {
    fn get_desc_count(&self) -> u32 {
        if self.test_type == TestType::StorageBuffers && self.use_comp_shader {
            self.desc_count - 1
        } else {
            self.desc_count
        }
    }
}

struct DescriptorLimitTest {
    name: String,
    params: TestParams,
}

impl TestCase for DescriptorLimitTest {
    fn name(&self) -> &str {
        &self.name
    }

    /// `DescriptorLimitTest::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let limits = &context.get_device_properties().limits;
        let params = &self.params;

        // We have to make sure, that we don't bind anything outside of valid descriptor binding locations determined by maxPerStageResources.
        if params.desc_count > limits.max_per_stage_resources.saturating_sub(1) {
            return Err(TestError::NotSupported(format!(
                "maxPerStageResources ({})",
                limits.max_per_stage_resources
            )));
        }

        let (limit, limit_name) = match params.test_type {
            TestType::Samplers => (
                limits.max_per_stage_descriptor_samplers,
                "maxPerStageDescriptorSamplers",
            ),
            TestType::UniformBuffers => (
                limits.max_per_stage_descriptor_uniform_buffers,
                "maxPerStageDescriptorUniformBuffers",
            ),
            TestType::StorageBuffers => (
                limits.max_per_stage_descriptor_storage_buffers,
                "maxPerStageDescriptorStorageBuffers",
            ),
            TestType::SampledImages => (
                limits.max_per_stage_descriptor_sampled_images,
                "maxPerStageDescriptorSampledImages",
            ),
            TestType::StorageImages => (
                limits.max_per_stage_descriptor_storage_images,
                "maxPerStageDescriptorStorageImages",
            ),
            TestType::InputAttachments => (
                limits.max_per_stage_descriptor_input_attachments,
                "maxPerStageDescriptorInputAttachments",
            ),
        };
        if params.desc_count > limit {
            return Err(TestError::NotSupported(format!("{limit_name} ({limit})")));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let name = self.program_name();
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == name)
            .unwrap_or_else(|| panic!("the shader manifest has no case named {name}"))
            .programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DescriptorLimitTestInstance {
            context,
            params: self.params,
        })
    }
}

impl DescriptorLimitTest {
    fn program_name(&self) -> String {
        format!(
            "{}_{}_{}",
            if self.params.use_comp_shader { "comp" } else { "frag" },
            self.params.test_type.name(),
            self.params.desc_count
        )
    }
}

struct DescriptorLimitTestInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

/// `makeRenderPassInputAttachment`
fn make_render_pass_input_attachment(
    device: &Device,
    color_format: vk::Format,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let color_attachment_description = vk::AttachmentDescription::builder()
        .format(color_format)
        .samples(vk::SampleCountFlags::_1)
        .load_op(vk::AttachmentLoadOp::CLEAR)
        .store_op(vk::AttachmentStoreOp::STORE)
        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
        .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .build();
    let input_attachment_description = vk::AttachmentDescription::builder()
        .format(color_format)
        .samples(vk::SampleCountFlags::_1)
        .load_op(vk::AttachmentLoadOp::LOAD)
        .store_op(vk::AttachmentStoreOp::STORE)
        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
        .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
        .initial_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .final_layout(vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL)
        .build();
    let attachment_descriptions = [
        input_attachment_description,
        input_attachment_description,
        color_attachment_description,
    ];
    let input_attachment_references = [
        vk::AttachmentReference {
            attachment: 0,
            layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        },
        vk::AttachmentReference {
            attachment: 1,
            layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        },
    ];
    let color_attachment_reference = [vk::AttachmentReference {
        attachment: 2,
        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    }];
    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .input_attachments(&input_attachment_references)
        .color_attachments(&color_attachment_reference)
        .build()];
    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachment_descriptions)
        .subpasses(&subpasses);
    Ok(Unique::new(
        device,
        unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
    ))
}

fn create_image<'a>(
    context: &'a Context<'a>,
    size: u32,
    format: vk::Format,
    usage: vk::ImageUsageFlags,
) -> Result<ImageWithMemory<'a>, TestError> {
    let info = vk::ImageCreateInfo::builder()
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
        .build();
    ImageWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        info,
        MemoryRequirement::ANY,
    )
}

impl TestInstance for DescriptorLimitTestInstance<'_> {
    /// `DescriptorLimitTestInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let p = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let size = p.framebuffer_size;
        let test_type = p.test_type;

        // Pick correct test parameters based on test type
        let shader_stage_flags = if p.use_comp_shader {
            vk::ShaderStageFlags::COMPUTE
        } else {
            vk::ShaderStageFlags::FRAGMENT
        };
        let pipeline_stage_flags = if p.use_comp_shader {
            vk::PipelineStageFlags::COMPUTE_SHADER
        } else {
            vk::PipelineStageFlags::FRAGMENT_SHADER
        };
        let image_flags = match test_type {
            TestType::InputAttachments => {
                vk::ImageUsageFlags::COLOR_ATTACHMENT
                    | vk::ImageUsageFlags::INPUT_ATTACHMENT
                    | vk::ImageUsageFlags::TRANSFER_DST
            }
            TestType::StorageImages => vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_DST,
            _ => vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_DST,
        };
        let final_image_layout = match test_type {
            TestType::InputAttachments => vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            TestType::StorageImages => vk::ImageLayout::GENERAL,
            _ => vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        };

        // Create shaders
        let binaries = context.get_binary_collection();
        let vertex_shader_module = if p.use_comp_shader {
            None
        } else {
            Some(create_shader_module(device, binaries.get("vert")?)?)
        };
        let tested_shader_module = create_shader_module(device, binaries.get("test")?)?;

        // Create images
        let color_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let color_image = create_image(
            context,
            size,
            color_format,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        )?;
        let color_image_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            color_format,
            color_subresource_range,
        )?;
        let input_images = [
            create_image(context, size, color_format, image_flags)?,
            create_image(context, size, color_format, image_flags)?,
        ];
        let input_image_views = [
            make_image_view(
                device,
                input_images[0].get(),
                vk::ImageViewType::_2D,
                color_format,
                color_subresource_range,
            )?,
            make_image_view(
                device,
                input_images[1].get(),
                vk::ImageViewType::_2D,
                color_format,
                color_subresource_range,
            )?,
        ];
        let test_colors = [[1.0f32, 0.0, 0.0, 1.0], [0.0, 1.0, 0.0, 1.0]];
        let desc_count = p.get_desc_count();

        for i in 0..2 {
            clear_color_image(
                context,
                input_images[i].get(),
                test_colors[i],
                vk::ImageLayout::UNDEFINED,
                final_image_layout,
                pipeline_stage_flags,
                1,
                1,
            )?;
        }

        // Create Samplers
        let sampler_info = vk::SamplerCreateInfo::builder()
            .mag_filter(vk::Filter::NEAREST)
            .min_filter(vk::Filter::NEAREST)
            .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
            .address_mode_u(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .address_mode_v(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .address_mode_w(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .mip_lod_bias(0.0)
            .anisotropy_enable(false)
            .compare_enable(false)
            .min_lod(0.0)
            .max_lod(0.25)
            .border_color(vk::BorderColor::FLOAT_TRANSPARENT_BLACK)
            .unnormalized_coordinates(false);
        let samplers = [
            Unique::new(
                device,
                unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
            ),
            Unique::new(
                device,
                unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
            ),
        ];

        // Create buffers
        let buffer_element_size = 16u64;
        let ubo_buffers = [
            create_host_buffer(context, &test_colors[0], vk::BufferUsageFlags::UNIFORM_BUFFER)?,
            create_host_buffer(context, &test_colors[1], vk::BufferUsageFlags::UNIFORM_BUFFER)?,
        ];
        let ssbo_buffers = [
            create_host_buffer(context, &test_colors[0], vk::BufferUsageFlags::STORAGE_BUFFER)?,
            create_host_buffer(context, &test_colors[1], vk::BufferUsageFlags::STORAGE_BUFFER)?,
        ];
        let comp_buffer_result = create_host_buffer(context, &[0.0f32; 4], vk::BufferUsageFlags::STORAGE_BUFFER)?;

        // Attachments of the framebuffer
        let mut attachment_views = Vec::new();
        if test_type == TestType::InputAttachments {
            attachment_views.push(*input_image_views[0]);
            attachment_views.push(*input_image_views[1]);
        }
        attachment_views.push(*color_image_view);

        // Result image buffer for fragment shader run
        let result_image_buffer_size = (size * size * 4) as usize;
        let result_image_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(
                result_image_buffer_size as vk::DeviceSize,
                vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Create vertex buffer
        let vertices: [[f32; 4]; 6] = [
            [1.0, -1.0, 0.0, 1.0],
            [-1.0, -1.0, 0.0, 1.0],
            [-1.0, 1.0, 0.0, 1.0],
            [-1.0, 1.0, 0.0, 1.0],
            [1.0, 1.0, 0.0, 1.0],
            [1.0, -1.0, 0.0, 1.0],
        ];
        let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // Descriptor pool and descriptor set
        let mut pool_builder = DescriptorPoolBuilder::new();
        // If compute pipeline is used for testing something else than SSBOs, one SSBO descriptor is still needed for writing of the test result.
        if test_type != TestType::StorageBuffers && p.use_comp_shader {
            pool_builder = pool_builder.add_type(vk::DescriptorType::STORAGE_BUFFER, 1);
        }
        // We must be an extra careful here: since the result buffer as well the input buffers are allocated from the same
        // descriptor pool full descriptor count should be used while allocating the pool when compute shader is used.
        pool_builder = pool_builder.add_type(
            test_type.descriptor_type(),
            if test_type == TestType::StorageBuffers {
                p.desc_count
            } else {
                desc_count
            },
        );
        let descriptor_pool = pool_builder.build(
            device,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1 + u32::from(p.use_comp_shader),
        )?;

        let mut layout_builder = DescriptorSetLayoutBuilder::new();
        let stages = if test_type == TestType::InputAttachments {
            vk::ShaderStageFlags::FRAGMENT
        } else {
            shader_stage_flags
        };
        for _ in 0..desc_count {
            layout_builder = layout_builder.add_single_binding(test_type.descriptor_type(), stages);
        }
        let descriptor_set_layout = layout_builder.build(device)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let descriptor_set_layout_result;
        let descriptor_set_result;
        if p.use_comp_shader {
            descriptor_set_layout_result = Some(
                DescriptorSetLayoutBuilder::new()
                    .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
                    .build(device)?,
            );
            descriptor_set_result = match &descriptor_set_layout_result {
                Some(layout) => Some(make_descriptor_set(device, *descriptor_pool, **layout)?),
                None => None,
            };
        } else {
            descriptor_set_layout_result = None;
            descriptor_set_result = None;
        }

        // Setup renderpass and framebuffer.
        let render_pass = if test_type == TestType::InputAttachments {
            make_render_pass_input_attachment(device, color_format)?
        } else {
            make_color_render_pass(
                device,
                color_format,
                vk::AttachmentLoadOp::CLEAR,
                vk::AttachmentStoreOp::STORE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            )?
        };
        let framebuffer = make_framebuffer(device, *render_pass, &attachment_views, size, size, 1)?;

        // Command buffer
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        let mut clear_color_values = Vec::new();
        if test_type == TestType::InputAttachments {
            clear_color_values.push(clear_value_color([0.39, 0.58, 0.93, 1.0]));
            clear_color_values.push(clear_value_color([0.39, 0.58, 0.93, 1.0]));
        }
        clear_color_values.push(clear_value_color([0.39, 0.58, 0.93, 1.0]));

        // Bind buffers
        let image_layout = if test_type == TestType::StorageImages {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL
        };
        let image_infos = [
            vk::DescriptorImageInfo {
                sampler: *samplers[0],
                image_view: *input_image_views[0],
                image_layout,
            },
            vk::DescriptorImageInfo {
                sampler: *samplers[1],
                image_view: *input_image_views[1],
                image_layout,
            },
        ];
        let ubo_infos = [
            make_descriptor_buffer_info(ubo_buffers[0].get(), 0, buffer_element_size),
            make_descriptor_buffer_info(ubo_buffers[1].get(), 0, buffer_element_size),
        ];
        let ssbo_infos = [
            make_descriptor_buffer_info(ssbo_buffers[0].get(), 0, buffer_element_size),
            make_descriptor_buffer_info(ssbo_buffers[1].get(), 0, buffer_element_size),
        ];
        let ssbo_info_result = make_descriptor_buffer_info(comp_buffer_result.get(), 0, buffer_element_size);

        if let Some(set) = &descriptor_set_result {
            DescriptorSetUpdateBuilder::new()
                .write_single(
                    set.get(),
                    Location::binding(0),
                    vk::DescriptorType::STORAGE_BUFFER,
                    &ssbo_info_result,
                )
                .update(device);
        }
        // Every descriptor but the last one is the first input, the last one is the second input.
        let writes: Vec<vk::WriteDescriptorSet> = (0..desc_count)
            .map(|binding| {
                let which = usize::from(binding == desc_count - 1);
                let mut write = vk::WriteDescriptorSet {
                    s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                    next: std::ptr::null(),
                    dst_set: descriptor_set.get(),
                    dst_binding: binding,
                    dst_array_element: 0,
                    descriptor_count: 1,
                    descriptor_type: test_type.descriptor_type(),
                    image_info: std::ptr::null(),
                    buffer_info: std::ptr::null(),
                    texel_buffer_view: std::ptr::null(),
                };
                match test_type {
                    TestType::UniformBuffers => write.buffer_info = &ubo_infos[which],
                    TestType::StorageBuffers => write.buffer_info = &ssbo_infos[which],
                    _ => write.image_info = &image_infos[which],
                }
                write
            })
            .collect();
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        // Create pipeline layout
        let mut desc_set_layouts = vec![*descriptor_set_layout];
        if let Some(layout) = &descriptor_set_layout_result {
            desc_set_layouts.push(**layout);
        }
        let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&desc_set_layouts);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        let compute_pipeline;
        let graphics_pipeline;
        let mut shader_objects = None;
        let mut draw_state = None;
        if p.use_comp_shader {
            let stage = vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::COMPUTE)
                .module(*tested_shader_module)
                .name(b"main\0")
                .build();
            let pipeline_info = vk::ComputePipelineCreateInfo::builder()
                .stage(stage)
                .layout(*pipeline_layout)
                .base_pipeline_index(-1)
                .build();
            let pipelines =
                unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
                    .vk_check("vkCreateComputePipelines")?;
            compute_pipeline = Some(Unique::new(device, pipelines.0[0]));
            graphics_pipeline = None;
        } else {
            let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST)
                .with_position_input()
                .with_full_viewport(size, size);
            state.sample_mask = Some(0x1);
            let vertex_module = vertex_shader_module
                .as_ref()
                .ok_or_else(|| TestError::InternalError("vertex shader missing".to_string()))?;
            shader_objects = make_shader_objects(context, "vert", Some("test"), &desc_set_layouts, &[])?;
            graphics_pipeline = if shader_objects.is_some() {
                None
            } else {
                Some(create_draw_pipeline(
                    device,
                    *pipeline_layout,
                    *render_pass,
                    &[
                        (vk::ShaderStageFlags::VERTEX, **vertex_module),
                        (vk::ShaderStageFlags::FRAGMENT, *tested_shader_module),
                    ],
                    &state,
                )?)
            };
            draw_state = Some(state);
            compute_pipeline = None;
        }

        begin_command_buffer(device, cmd)?;
        if let (Some(pipeline), Some(result_set)) = (&compute_pipeline, &descriptor_set_result) {
            unsafe {
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, **pipeline);
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::COMPUTE,
                    *pipeline_layout,
                    0,
                    &[descriptor_set.get(), result_set.get()],
                    &[] as &[u32],
                );
                device.cmd_dispatch(cmd, 1, 1, 1);
                let barrier = vk::MemoryBarrier::builder()
                    .src_access_mask(vk::AccessFlags::SHADER_WRITE)
                    .dst_access_mask(vk::AccessFlags::HOST_READ)
                    .build();
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        } else if let Some(state) = &draw_state {
            begin_draw(
                device,
                cmd,
                shader_objects.as_ref(),
                state,
                graphics_pipeline.as_ref().map(|pipeline| pipeline.get()),
                *render_pass,
                *framebuffer,
                rect_2d(size, size),
                &clear_color_values,
                &[(color_image.get(), *color_image_view)],
            );
            unsafe {
                device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    *pipeline_layout,
                    0,
                    &[descriptor_set.get()],
                    &[] as &[u32],
                );
                device.cmd_draw(cmd, 6, 1, 0, 0);
            }
            end_draw(device, cmd, shader_objects.is_some());
            copy_image_to_buffer(device, cmd, color_image.get(), result_image_buffer.get(), size, size);
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        // Check results
        if !p.use_comp_shader {
            invalidate_alloc(device, result_image_buffer.get_allocation())?;
            let result = unsafe {
                std::slice::from_raw_parts(
                    result_image_buffer.get_allocation().get_host_ptr(),
                    result_image_buffer_size,
                )
            };
            let expected = test_colors[1].map(|c| (c * 255.0).round() as u8);
            if result.chunks_exact(4).any(|pixel| pixel != expected) {
                return Ok(TestStatus::fail("Rendered color image is not correct"));
            }
        } else {
            invalidate_alloc(device, comp_buffer_result.get_allocation())?;
            let result_value: [f32; 4] = unsafe {
                comp_buffer_result
                    .get_allocation()
                    .get_host_ptr()
                    .cast::<[f32; 4]>()
                    .read_unaligned()
            };
            if result_value != [0.0, 1.0, 0.0, 1.0] {
                return Ok(TestStatus::fail("Result buffer value is not correct"));
            }
        }

        Ok(TestStatus::pass("Success"))
    }
}

/// `createDescriptorLimitsTests`
pub fn create_descriptor_limits_tests() -> TestCaseGroup {
    create_descriptor_limits_tests_for(false)
}

/// The shader object types have the fragment shader group without the input attachment cases.
pub fn create_descriptor_limits_tests_for(shader_object: bool) -> TestCaseGroup {
    let mut descriptor_limit_test_group = TestCaseGroup::new("descriptor_limits");
    let framebuffer_size = 32;
    let num_descriptors: [u32; 36] = [
        3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 31, 32, 63, 64, 100, 127, 128, 199, 200, 256,
        512, 1024, 2048, 4096, 8192, 16384, 32768, 65535,
    ];

    let mut compute_shader_group = TestCaseGroup::new("compute_shader");
    for test_value in num_descriptors {
        for test_type in [
            TestType::Samplers,
            TestType::UniformBuffers,
            TestType::StorageBuffers,
            TestType::SampledImages,
            TestType::StorageImages,
        ] {
            let params = TestParams {
                test_type,
                use_comp_shader: true,
                framebuffer_size,
                desc_count: test_value,
            };
            compute_shader_group.add_child(Box::new(DescriptorLimitTest {
                name: format!("{}_{test_value}", test_type.name()),
                params,
            }) as Box<dyn TestCase>);
        }
    }
    if !shader_object {
        descriptor_limit_test_group.add_child(compute_shader_group);
    }

    let mut fragment_shader_group = TestCaseGroup::new("fragment_shader");
    for test_value in num_descriptors {
        for test_type in [
            TestType::Samplers,
            TestType::UniformBuffers,
            TestType::StorageBuffers,
            TestType::SampledImages,
            TestType::StorageImages,
            TestType::InputAttachments,
        ] {
            if shader_object && test_type == TestType::InputAttachments {
                continue;
            }
            let params = TestParams {
                test_type,
                use_comp_shader: false,
                framebuffer_size,
                desc_count: test_value,
            };
            fragment_shader_group.add_child(Box::new(DescriptorLimitTest {
                name: format!("{}_{test_value}", test_type.name()),
                params,
            }) as Box<dyn TestCase>);
        }
    }
    descriptor_limit_test_group.add_child(fragment_shader_group);

    descriptor_limit_test_group
}
