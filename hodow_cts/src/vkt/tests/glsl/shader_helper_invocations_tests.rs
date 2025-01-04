// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shaderexecutor/vktShaderHelperInvocationsTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The six `helper_invocations` cases: a triangle is drawn twice; the first picture is copied to a buffer or kept as an image and the second draw
// reads it in a fragment shader through `fwidth`, which needs the helper invocations of the quads on the triangle's edge to load correctly (ssbo, device address, ubo, storage image,
// texture) or, for `output_variables`, reads it as an input attachment of a second subpass. The shaders are written by `scripts/gen_shader_helper_invocations.py`
// into `shaders/manifest/shader_helper_invocations.toml`. The failing images are not logged.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::DeviceV1_2;

use crate::generated::shaders::shader_helper_invocations::ALL_SHARED_PROGRAM;
use crate::tcu::vector::IVec2;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_create_info, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_framebuffer, make_graphics_pipeline, make_memory_barrier, make_pipeline_layout,
    make_pipeline_layout_with_push_constants,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const RENDER_SIZE: u32 = 32;
const COLOR_FORMAT: vk::Format = vk::Format::R32_UINT;
const INPUT_CLEAR_COLOR: u32 = 21;
const FINAL_CLEAR_COLOR: u32 = 30;

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestType {
    LoadSsbo,
    LoadAddress,
    LoadUbo,
    LoadImage,
    LoadTexture,
    OutputVariables,
}

/// The configuration `HelperInvocationsTestInstance`'s constructor derives from the test type
struct Config {
    using_buffer: bool,
    using_sampler: bool,
    using_descriptor_set: bool,
    using_device_address: bool,
    using_second_subpass: bool,
    tested_image_usage: vk::ImageUsageFlags,
    tested_buffer_usage: vk::BufferUsageFlags,
    tested_descriptor_type: vk::DescriptorType,
    expected_color: u32,
}

impl Config {
    fn new(test_type: TestType) -> Self {
        let mut config = Self {
            using_buffer: true,
            using_sampler: false,
            using_descriptor_set: true,
            using_device_address: false,
            using_second_subpass: false,
            tested_image_usage: vk::ImageUsageFlags::TRANSFER_SRC,
            tested_buffer_usage: vk::BufferUsageFlags::STORAGE_BUFFER,
            tested_descriptor_type: vk::DescriptorType::STORAGE_BUFFER,
            expected_color: 63,
        };
        match test_type {
            TestType::LoadSsbo => {}
            TestType::LoadAddress => {
                config.using_descriptor_set = false;
                config.using_device_address = true;
                config.tested_buffer_usage =
                    vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS;
            }
            TestType::LoadUbo => {
                config.tested_buffer_usage = vk::BufferUsageFlags::UNIFORM_BUFFER;
                config.tested_descriptor_type = vk::DescriptorType::UNIFORM_BUFFER;
            }
            TestType::LoadImage => {
                config.using_buffer = false;
                config.tested_image_usage |= vk::ImageUsageFlags::STORAGE;
                config.tested_descriptor_type = vk::DescriptorType::STORAGE_IMAGE;
            }
            TestType::LoadTexture => {
                config.using_sampler = true;
                config.using_buffer = false;
                config.tested_image_usage |= vk::ImageUsageFlags::SAMPLED;
                config.tested_descriptor_type = vk::DescriptorType::COMBINED_IMAGE_SAMPLER;
            }
            TestType::OutputVariables => {
                config.using_buffer = false;
                config.using_second_subpass = true;
                config.tested_image_usage = vk::ImageUsageFlags::INPUT_ATTACHMENT;
                config.tested_descriptor_type = vk::DescriptorType::INPUT_ATTACHMENT;
            }
        }
        config
    }
}

/// `HelperInvocationsTestCase`
struct HelperInvocationsCase {
    name: &'static str,
    test_type: TestType,
}

impl TestCase for HelperInvocationsCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.test_type == TestType::LoadAddress {
            context.require_device_functionality("VK_KHR_buffer_device_address")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let key = format!("shi_{}", self.name);
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == key)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(HelperInvocationsInstance {
            context,
            test_type: self.test_type,
            config: Config::new(self.test_type),
        })
    }
}

/// `HelperInvocationsTestInstance`
struct HelperInvocationsInstance<'a> {
    context: &'a Context<'a>,
    test_type: TestType,
    config: Config,
}

/// `HelperInvocationsTestInstance::setupRenderPass`
fn setup_render_pass<'a>(
    device: &'a Device,
    color_format: vk::Format,
    using_second_subpass: bool,
) -> Result<Unique<'a, vk::RenderPass>, TestError> {
    let attachment = vk::AttachmentDescription::builder()
        .format(color_format)
        .samples(vk::SampleCountFlags::_1)
        .load_op(vk::AttachmentLoadOp::CLEAR)
        .store_op(vk::AttachmentStoreOp::STORE)
        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
        .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .final_layout(vk::ImageLayout::GENERAL)
        .build();
    let attachments = [attachment, attachment];

    let color_ref0 = [vk::AttachmentReference {
        attachment: 0,
        layout: vk::ImageLayout::GENERAL,
    }];
    let color_ref1 = [vk::AttachmentReference {
        attachment: 1,
        layout: vk::ImageLayout::GENERAL,
    }];
    let preserve = [1u32];

    let mut subpass0 = vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_ref0);
    if using_second_subpass {
        subpass0 = subpass0.preserve_attachments(&preserve);
    }
    let subpass1 = vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_ref1)
        .input_attachments(&color_ref0);
    let subpasses = [subpass0.build(), subpass1.build()];

    let dependencies = [vk::SubpassDependency {
        src_subpass: 0,
        dst_subpass: 1,
        src_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
        dst_stage_mask: vk::PipelineStageFlags::FRAGMENT_SHADER,
        src_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        dst_access_mask: vk::AccessFlags::INPUT_ATTACHMENT_READ,
        dependency_flags: vk::DependencyFlags::BY_REGION,
    }];

    let subpass_count = 1 + usize::from(using_second_subpass);
    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments[..subpass_count])
        .subpasses(&subpasses[..subpass_count])
        .dependencies(&dependencies[..usize::from(using_second_subpass)]);
    let render_pass = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, render_pass))
}

/// `makeGraphicsPipeline` for the read pass: `make_graphics_pipeline` always builds subpass 0, and the output_variables read pipeline belongs to subpass 1
fn make_read_pipeline<'a>(
    device: &'a Device,
    pipeline_layout: vk::PipelineLayout,
    vertex: vk::ShaderModule,
    fragment: vk::ShaderModule,
    render_pass: vk::RenderPass,
    subpass: u32,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
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
    let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder();
    let input_assembly = vk::PipelineInputAssemblyStateCreateInfo::builder()
        .topology(vk::PrimitiveTopology::TRIANGLE_STRIP)
        .primitive_restart_enable(false);
    let viewports = [vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: RENDER_SIZE as f32,
        height: RENDER_SIZE as f32,
        min_depth: 0.0,
        max_depth: 1.0,
    }];
    let scissors = [make_rect_2d(0, 0, RENDER_SIZE, RENDER_SIZE)];
    let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
        .viewports(&viewports)
        .scissors(&scissors);
    let rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .line_width(1.0);
    let multisample = vk::PipelineMultisampleStateCreateInfo::builder()
        .rasterization_samples(vk::SampleCountFlags::_1)
        .min_sample_shading(1.0);
    let depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder().max_depth_bounds(1.0);
    let blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
        .blend_enable(false)
        .color_write_mask(
            vk::ColorComponentFlags::R
                | vk::ColorComponentFlags::G
                | vk::ColorComponentFlags::B
                | vk::ColorComponentFlags::A,
        )
        .build()];
    let color_blend = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&blend_attachments);

    let info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&stages)
        .vertex_input_state(&vertex_input)
        .input_assembly_state(&input_assembly)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization)
        .multisample_state(&multisample)
        .depth_stencil_state(&depth_stencil)
        .color_blend_state(&color_blend)
        .layout(pipeline_layout)
        .render_pass(render_pass)
        .subpass(subpass);
    crate::vk::pipeline_construction::create_graphics_pipeline(device, &info)
}

impl TestInstance for HelperInvocationsInstance<'_> {
    /// `HelperInvocationsTestInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        // For LOAD_* cases the same triangle is drawn twice. The result of the first draw is copied to a buffer (when testing ssbo) and passed as
        // input to the second draw, which calls fwidth on the value read from it. The test expects one of four values - the clear colour around
        // the triangle, zero inside it and one of two values on the edges that depend on the clear and render values of the first draw.
        let context = self.context;
        let config = &self.config;
        let device = context.get_device();
        let queue_family_index = context.get_universal_queue_family_index();
        let allocator = context.get_default_allocator();

        let render_size = IVec2::new(RENDER_SIZE as i32, RENDER_SIZE as i32);
        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let extent = vk::Extent3D {
            width: RENDER_SIZE,
            height: RENDER_SIZE,
            depth: 1,
        };
        let copy_region = make_buffer_image_copy(
            extent,
            make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
        );

        // create color attachments that will be used as input in second draw
        let input_image = ImageWithMemory::new(
            device,
            allocator,
            make_image_create_info(
                render_size,
                COLOR_FORMAT,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | config.tested_image_usage,
            ),
            MemoryRequirement::ANY,
        )?;
        let input_image_view = make_image_view(
            device,
            input_image.get(),
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            color_srr,
        )?;

        // create second image that will be used for verification
        let final_image = ImageWithMemory::new(
            device,
            allocator,
            make_image_create_info(
                render_size,
                COLOR_FORMAT,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;
        let final_image_view = make_image_view(
            device,
            final_image.get(),
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            color_srr,
        )?;

        // create buffer that will be used to read first rendered image
        let fragments_count = (RENDER_SIZE * RENDER_SIZE) as usize;
        let buffer_size = (fragments_count * std::mem::size_of::<u32>()) as vk::DeviceSize;
        let src_dst_usage = vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST;
        let memory_requirement = if config.using_device_address {
            MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS
        } else {
            MemoryRequirement::HOST_VISIBLE
        };
        let input_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(buffer_size, src_dst_usage | config.tested_buffer_usage),
            memory_requirement,
        )?;

        // create buffer that will be used to read result of second draw and used for verification
        let final_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(buffer_size, src_dst_usage),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // get device address of input buffer if this is needed by tested case
        let input_buffer_address: u64 = if config.using_device_address {
            let address_info = vk::BufferDeviceAddressInfo::builder().buffer(input_buffer.get());
            unsafe { device.get_buffer_device_address(&address_info) }
        } else {
            0
        };

        // create sampler if it is needed by tested case
        let sampler = if config.using_sampler {
            let sampler_info = vk::SamplerCreateInfo::builder();
            Some(Unique::new(
                device,
                unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
            ))
        } else {
            None
        };

        // create descriptor set if it is needed by tested case
        let mut descriptor_set_layout = None;
        let mut descriptor_pool = None;
        let mut descriptor_set = None;
        if config.using_descriptor_set {
            let pool = DescriptorPoolBuilder::new()
                .add_type(config.tested_descriptor_type, 1)
                .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
            let layout = DescriptorSetLayoutBuilder::new()
                .add_single_binding(config.tested_descriptor_type, vk::ShaderStageFlags::FRAGMENT)
                .build(device)?;
            let set = make_descriptor_set(device, *pool, *layout)?;

            if config.using_buffer {
                let buffer_info = make_descriptor_buffer_info(input_buffer.get(), 0, buffer_size);
                DescriptorSetUpdateBuilder::new()
                    .write_single(
                        set.get(),
                        Location::binding(0),
                        config.tested_descriptor_type,
                        &buffer_info,
                    )
                    .update(device);
            } else {
                let image_info = [vk::DescriptorImageInfo {
                    sampler: sampler.as_ref().map_or(vk::Sampler::null(), |sampler| **sampler),
                    image_view: *input_image_view,
                    image_layout: vk::ImageLayout::GENERAL,
                }];
                let write = vk::WriteDescriptorSet::builder()
                    .dst_set(set.get())
                    .dst_binding(0)
                    .descriptor_type(config.tested_descriptor_type)
                    .image_info(&image_info)
                    .build();
                unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
            }
            descriptor_pool = Some(pool);
            descriptor_set_layout = Some(layout);
            descriptor_set = Some(set);
        }

        // create shader modules
        let binaries = context.get_binary_collection();
        let vert_shader_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_write_shader_module = create_shader_module(device, binaries.get("frag_write")?)?;
        let frag_read_shader_module = create_shader_module(device, binaries.get("frag_read")?)?;

        // create renderpass and framebuffers for both pipelines
        let att_count = 1 + usize::from(config.using_second_subpass);
        let views = [*input_image_view, *final_image_view];
        let render_pass = setup_render_pass(device, COLOR_FORMAT, config.using_second_subpass)?;
        let write_framebuffer =
            make_framebuffer(device, *render_pass, &views[..att_count], RENDER_SIZE, RENDER_SIZE, 1)?;
        let read_framebuffer = if config.using_second_subpass {
            None
        } else {
            Some(make_framebuffer(
                device,
                *render_pass,
                &views[1..2],
                RENDER_SIZE,
                RENDER_SIZE,
                1,
            )?)
        };

        // create write and read pipelines
        let write_pipeline_layout = make_pipeline_layout(device, &[])?;
        let write_pipeline = make_graphics_pipeline(
            device,
            *write_pipeline_layout,
            *vert_shader_module,
            *frag_write_shader_module,
            *render_pass,
            (RENDER_SIZE, RENDER_SIZE),
            vk::PrimitiveTopology::TRIANGLE_STRIP,
        )?;
        let set_layouts: Vec<vk::DescriptorSetLayout> = descriptor_set_layout.iter().map(|layout| **layout).collect();
        let push_constant_ranges: Vec<vk::PushConstantRange> = if config.using_device_address {
            vec![vk::PushConstantRange {
                stage_flags: vk::ShaderStageFlags::FRAGMENT,
                offset: 0,
                size: 2 * std::mem::size_of::<u32>() as u32,
            }]
        } else {
            Vec::new()
        };
        let read_pipeline_layout =
            make_pipeline_layout_with_push_constants(device, &set_layouts, &push_constant_ranges)?;
        let read_pipeline = make_read_pipeline(
            device,
            *read_pipeline_layout,
            *vert_shader_module,
            *frag_read_shader_module,
            *render_pass,
            u32::from(config.using_second_subpass),
        )?;

        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = cmd_buffer.get();
        let render_area = make_rect_2d(0, 0, RENDER_SIZE, RENDER_SIZE);
        let clear_color = |value: u32| vk::ClearValue {
            color: vk::ClearColorValue { uint32: [value; 4] },
        };

        begin_command_buffer(device, cmd)?;

        if config.using_second_subpass {
            let clear_values = [clear_color(INPUT_CLEAR_COLOR), clear_color(FINAL_CLEAR_COLOR)];
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*write_framebuffer)
                .render_area(render_area)
                .clear_values(&clear_values);
            unsafe {
                device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);

                // draw single triangle with different color for each fragment
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *write_pipeline);
                device.cmd_draw(cmd, 3, 1, 0, 0);

                device.cmd_next_subpass(cmd, vk::SubpassContents::INLINE);

                // draw same triangle once again but using values from first subpass as inputs
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *read_pipeline);
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    *read_pipeline_layout,
                    0,
                    &[descriptor_set.as_ref().expect("made above").get()],
                    &[],
                );
                device.cmd_draw(cmd, 3, 1, 0, 0);
            }
            end_render_pass(device, cmd);
        } else {
            // draw single triangle, we use this to identify which fragments are under triangle
            begin_render_pass(
                device,
                cmd,
                *render_pass,
                *write_framebuffer,
                render_area,
                clear_color(INPUT_CLEAR_COLOR),
            );
            unsafe {
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *write_pipeline);
                device.cmd_draw(cmd, 3, 1, 0, 0);
            }
            end_render_pass(device, cmd);

            unsafe {
                // wait for color attachment to be filled
                let memory_barrier =
                    make_memory_barrier(vk::AccessFlags::COLOR_ATTACHMENT_WRITE, vk::AccessFlags::TRANSFER_READ);
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[memory_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );

                // copy color image to buffer
                device.cmd_copy_image_to_buffer(
                    cmd,
                    input_image.get(),
                    vk::ImageLayout::GENERAL,
                    input_buffer.get(),
                    &[copy_region],
                );

                // wait for buffer to have data from color image
                let memory_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::MEMORY_READ);
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::ALL_GRAPHICS,
                    vk::DependencyFlags::empty(),
                    &[memory_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }

            // draw same triangle once again but this time data with previous rendering result is passed as input to FS
            begin_render_pass(
                device,
                cmd,
                *render_pass,
                **read_framebuffer.as_ref().expect("made above"),
                render_area,
                clear_color(FINAL_CLEAR_COLOR),
            );
            unsafe {
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *read_pipeline);
                if let Some(set) = &descriptor_set {
                    device.cmd_bind_descriptor_sets(
                        cmd,
                        vk::PipelineBindPoint::GRAPHICS,
                        *read_pipeline_layout,
                        0,
                        &[set.get()],
                        &[],
                    );
                }
                if config.using_device_address {
                    device.cmd_push_constants(
                        cmd,
                        *read_pipeline_layout,
                        vk::ShaderStageFlags::FRAGMENT,
                        0,
                        &input_buffer_address.to_ne_bytes(),
                    );
                }
                device.cmd_draw(cmd, 3, 1, 0, 0);
            }
            end_render_pass(device, cmd);
        }

        unsafe {
            // wait for color image
            let memory_barrier =
                make_memory_barrier(vk::AccessFlags::COLOR_ATTACHMENT_WRITE, vk::AccessFlags::TRANSFER_READ);
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[memory_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );

            // read back color image with data written by the second FS
            device.cmd_copy_image_to_buffer(
                cmd,
                final_image.get(),
                vk::ImageLayout::GENERAL,
                final_buffer.get(),
                &[copy_region],
            );

            // wait for buffer to have data from color image
            let memory_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[memory_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, cmd)?;

        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;
        let _keep_alive = (&descriptor_pool, &sampler);

        // get input buffer and final buffer
        invalidate_alloc(device, input_buffer.get_allocation())?;
        invalidate_alloc(device, final_buffer.get_allocation())?;
        // SAFETY: both buffers are host visible, `fragments_count` words long and were just invalidated.
        let (input_data, final_data) = unsafe {
            (
                std::slice::from_raw_parts(
                    input_buffer.get_allocation().get_host_ptr().cast::<u32>(),
                    fragments_count,
                ),
                std::slice::from_raw_parts(
                    final_buffer.get_allocation().get_host_ptr().cast::<u32>(),
                    fragments_count,
                ),
            )
        };

        // verification of final buffer
        if self.test_type == TestType::OutputVariables {
            let mut test_passed = true;
            for y in 0..RENDER_SIZE {
                for x in 0..RENDER_SIZE {
                    let i = (x + y * RENDER_SIZE) as usize;
                    let mut expected = FINAL_CLEAR_COLOR;

                    // if fragment color is not equal to clear color then calculate the same value as in the shader
                    if final_data[i] != expected {
                        expected = x + y * 32 + x * y;
                    }

                    test_passed &= expected == final_data[i];
                }
            }

            if test_passed {
                return Ok(TestStatus::pass("Pass"));
            }
        } else {
            let mut fragments_with_zero_color = 0u32; // fragments that are part of quads that are fully in triangle
            let mut fragments_with_clear_color = 0u32; // fragments that are not part of any quads that are in triangle
            let mut fragments_with_expected_color = 0u32;
            let mut fragments_with_expected_color_times_two = 0u32;
            for &v in final_data {
                fragments_with_zero_color += u32::from(v == 0);
                fragments_with_clear_color += u32::from(v == FINAL_CLEAR_COLOR);
                fragments_with_expected_color += u32::from(v == config.expected_color);
                fragments_with_expected_color_times_two += u32::from(v == 2 * config.expected_color);
            }

            let checked_sum = fragments_with_zero_color
                + fragments_with_clear_color
                + fragments_with_expected_color
                + fragments_with_expected_color_times_two;

            // make sure that helper invocations didn't write to final color attachment
            let helper_wrote_color = input_data
                .iter()
                .zip(final_data)
                .any(|(&input, &final_value)| input == INPUT_CLEAR_COLOR && final_value != FINAL_CLEAR_COLOR);

            // expect that result contains only four specified colors;
            // expect that counters of all four colours are greater than minimal values produced by all implementations;
            // expect that corresponding fragments have clear color in input and in final attachment
            if fragments_count as u32 == checked_sum
                && fragments_with_zero_color > 120
                && fragments_with_expected_color > 30
                && fragments_with_expected_color_times_two > 3
                && !helper_wrote_color
            {
                return Ok(TestStatus::pass(fragments_with_expected_color.to_string()));
            }
        }

        Ok(TestStatus::fail("Fail"))
    }
}

/// `createShaderHelperInvocationsTests`
pub fn create_shader_helper_invocations_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("helper_invocations");
    for (name, test_type) in [
        ("load_from_ssbo", TestType::LoadSsbo),
        ("load_from_address", TestType::LoadAddress),
        ("load_from_ubo", TestType::LoadUbo),
        ("load_from_image", TestType::LoadImage),
        ("load_from_texture", TestType::LoadTexture),
        ("output_variables", TestType::OutputVariables),
    ] {
        group.add_child(Box::new(HelperInvocationsCase { name, test_type }) as Box<dyn TestCase>);
    }
    group
}
