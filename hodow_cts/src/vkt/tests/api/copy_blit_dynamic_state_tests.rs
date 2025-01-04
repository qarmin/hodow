// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiCopiesAndBlittingDynamicStateMetaOpsTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The base class of upstream's instance is not carried over: the case uploads the red source and the black
// destination, draws to a multisampled image (rasterization samples dynamic), copies or blits the whole image, draws again and checks the destination of the meta
// operation and, through an input attachment read of every sample, the multisampled image. The draws run with dynamic rendering, as upstream's wrapper does.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_3, ExtExtendedDynamicState3ExtensionDeviceCommands, InstanceV1_1};

use super::copies_image_tests::{FillMode, ImageParms, generate_buffer, read_image, upload_image};
use crate::generated::shaders::api_copy_blit_dynamic_state::DYNAMIC_STATE_META_OPS;
use crate::tcu::image_compare::float_threshold_compare;
use crate::tcu::pixel::{TextureLevel, clear};
use crate::tcu::{IVec2, TestError, TestOutcome, TestStatus, map_vk_format};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, make_rect_2d, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_create_info, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_framebuffer, make_memory_barrier, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{begin_rendering, end_rendering};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const SIZE: u32 = 64;
const FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

#[derive(Clone, Copy, PartialEq, Eq)]
enum MetaOperation {
    Copy,
    Blit,
}

#[derive(Clone, Copy)]
struct Params {
    meta_op: MetaOperation,
    samples: vk::SampleCountFlags,
}

struct PipelineOptions<'a> {
    layout: vk::PipelineLayout,
    stages: &'a [vk::PipelineShaderStageCreateInfo],
    render_pass: vk::RenderPass,
    dynamic_rendering: bool,
    color_attachments: bool,
}

fn build_pipeline<'a>(
    device: &'a Device,
    options: &PipelineOptions<'_>,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
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
        vk::PipelineInputAssemblyStateCreateInfo::builder().topology(vk::PrimitiveTopology::TRIANGLE_STRIP);
    let viewports = [vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: SIZE as f32,
        height: SIZE as f32,
        min_depth: 0.0,
        max_depth: 1.0,
    }];
    let scissors = [make_rect_2d(0, 0, SIZE, SIZE)];
    let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
        .viewports(&viewports)
        .scissors(&scissors);
    let rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .depth_bias_enable(false)
        .line_width(1.0);
    let multisample = vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
    let depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder();
    let blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
        .blend_enable(true)
        .src_color_blend_factor(vk::BlendFactor::SRC_ALPHA)
        .dst_color_blend_factor(vk::BlendFactor::ONE_MINUS_SRC_ALPHA)
        .color_blend_op(vk::BlendOp::ADD)
        .src_alpha_blend_factor(vk::BlendFactor::ZERO)
        .dst_alpha_blend_factor(vk::BlendFactor::ONE)
        .alpha_blend_op(vk::BlendOp::ADD)
        .color_write_mask(vk::ColorComponentFlags::all())
        .build()];
    let attachments: &[vk::PipelineColorBlendAttachmentState] = if options.color_attachments {
        &blend_attachments
    } else {
        &[]
    };
    let color_blend = vk::PipelineColorBlendStateCreateInfo::builder()
        .logic_op(vk::LogicOp::NO_OP)
        .attachments(attachments);
    let dynamic_states = [vk::DynamicState::RASTERIZATION_SAMPLES_EXT];
    let dynamic_state = vk::PipelineDynamicStateCreateInfo::builder().dynamic_states(if options.dynamic_rendering {
        &dynamic_states[..]
    } else {
        &[]
    });
    let color_formats = [FORMAT];
    let mut rendering = vk::PipelineRenderingCreateInfo::builder().color_attachment_formats(&color_formats);
    let mut info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(options.stages)
        .vertex_input_state(&vertex_input)
        .input_assembly_state(&input_assembly)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization)
        .multisample_state(&multisample)
        .depth_stencil_state(&depth_stencil)
        .color_blend_state(&color_blend)
        .dynamic_state(&dynamic_state)
        .layout(options.layout)
        .render_pass(options.render_pass)
        .subpass(0)
        .base_pipeline_index(0);
    if options.dynamic_rendering {
        info = info.push_next(&mut rendering);
    }
    crate::vk::pipeline_construction::create_graphics_pipeline(device, &info)
}

fn stage(stage: vk::ShaderStageFlags, module: vk::ShaderModule) -> vk::PipelineShaderStageCreateInfo {
    vk::PipelineShaderStageCreateInfo::builder()
        .stage(stage)
        .module(module)
        .name(b"main\0")
        .build()
}

struct DynamicStateCase {
    name: String,
    params: Params,
}

impl TestCase for DynamicStateCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let mut features3 = vk::PhysicalDeviceExtendedDynamicState3FeaturesEXT::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features3);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
        }
        if features3.extended_dynamic_state3_rasterization_samples == vk::FALSE {
            return Err(TestError::NotSupported(
                "extendedDynamicState3RasterizationSamples not supported".to_string(),
            ));
        }
        context.require_device_functionality("VK_KHR_dynamic_rendering")?;

        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let image_supported = |usage: vk::ImageUsageFlags| unsafe {
            instance.get_physical_device_image_format_properties(
                physical_device,
                FORMAT,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                usage,
                vk::ImageCreateFlags::empty(),
            )
        };
        if image_supported(vk::ImageUsageFlags::TRANSFER_SRC).is_err() {
            return Err(TestError::NotSupported("Source format not supported".to_string()));
        }
        if image_supported(vk::ImageUsageFlags::TRANSFER_DST).is_err() {
            return Err(TestError::NotSupported("Destination format not supported".to_string()));
        }
        if self.params.meta_op == MetaOperation::Blit {
            let features = unsafe { instance.get_physical_device_format_properties(physical_device, FORMAT) }
                .optimal_tiling_features;
            if !features.contains(vk::FormatFeatureFlags::BLIT_SRC) {
                return Err(TestError::NotSupported(
                    "Format feature blit source not supported".to_string(),
                ));
            }
            if !features.contains(vk::FormatFeatureFlags::BLIT_DST) {
                return Err(TestError::NotSupported(
                    "Format feature blit destination not supported".to_string(),
                ));
            }
        }
        let limits = unsafe { instance.get_physical_device_properties(physical_device) }.limits;
        if SIZE > limits.max_image_dimension_2d {
            return Err(TestError::NotSupported(
                "Requested 2D src image dimensions not supported".to_string(),
            ));
        }
        let ms_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::INPUT_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;
        match image_supported(ms_usage) {
            Err(_) => Err(TestError::NotSupported("Image format is not supported".to_string())),
            Ok(properties) if !properties.sample_counts.contains(self.params.samples) => Err(TestError::NotSupported(
                "Requested sample count is not supported".to_string(),
            )),
            Ok(_) => Ok(()),
        }
    }

    fn programs(&self) -> BinaryCollection {
        DYNAMIC_STATE_META_OPS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DynamicStateInstance {
            context,
            params: self.params,
        })
    }
}

struct DynamicStateInstance<'a> {
    context: &'a Context<'a>,
    params: Params,
}

fn push_bytes(values: &[i32]) -> Vec<u8> {
    values.iter().flat_map(|value| value.to_ne_bytes()).collect()
}

impl TestInstance for DynamicStateInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();
        let families = [queue_family_index];
        let samples = self.params.samples;
        let sample_count = samples.bits() as i32;
        let size = IVec2::new(SIZE as i32, SIZE as i32);
        let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let render_area = make_rect_2d(0, 0, SIZE, SIZE);

        // Source (red) and destination (black) of the meta operation.
        let transfer_usage = vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
        let source = ImageWithMemory::new(
            device,
            allocator,
            make_image_create_info(size, FORMAT, transfer_usage),
            MemoryRequirement::ANY,
        )?;
        let destination = ImageWithMemory::new(
            device,
            allocator,
            make_image_create_info(size, FORMAT, transfer_usage),
            MemoryRequirement::ANY,
        )?;
        let tcu_format =
            map_vk_format(FORMAT).ok_or_else(|| TestError::InternalError("RGBA8 has a texture format".to_string()))?;
        let src_params = ImageParms {
            image_type: vk::ImageType::_2D,
            format: FORMAT,
            extent: [SIZE, SIZE, 1],
            tiling: vk::ImageTiling::OPTIMAL,
            fill_mode: FillMode::Red,
            create_flags: None,
        };
        let dst_params = ImageParms {
            fill_mode: FillMode::Red,
            ..src_params
        };
        let mut source_level = TextureLevel::new(tcu_format, SIZE, SIZE, 1)?;
        generate_buffer(&mut source_level.get_access(), SIZE, SIZE, 1, FillMode::Red, false);
        upload_image(
            context,
            &source_level.get_const_access(),
            source.get(),
            &src_params,
            false,
            &families,
            false,
        )?;
        let mut destination_level = TextureLevel::new(tcu_format, SIZE, SIZE, 1)?;
        clear(&mut destination_level.get_access(), [0.0, 0.0, 0.0, 1.0]);
        upload_image(
            context,
            &destination_level.get_const_access(),
            destination.get(),
            &dst_params,
            false,
            &families,
            false,
        )?;

        // The multisampled image of the draws.
        let mut ms_info = make_image_create_info(
            size,
            FORMAT,
            vk::ImageUsageFlags::COLOR_ATTACHMENT
                | vk::ImageUsageFlags::INPUT_ATTACHMENT
                | vk::ImageUsageFlags::TRANSFER_SRC
                | vk::ImageUsageFlags::TRANSFER_DST,
        );
        ms_info.samples = samples;
        let ms_image = ImageWithMemory::new(device, allocator, ms_info, MemoryRequirement::ANY)?;
        let ms_view = make_image_view(device, ms_image.get(), vk::ImageViewType::_2D, FORMAT, color_range)?;

        // Vertices of the draws.
        let (a, b, c, d) = (
            [-1.0f32, -1.0, 0.0, 1.0],
            [1.0f32, -1.0, 0.0, 1.0],
            [1.0f32, 1.0, 0.0, 1.0],
            [-1.0f32, 1.0, 0.0, 1.0],
        );
        let vertices = [a, c, b, a, c, d];
        let vertex_data_size = (vertices.len() * 16) as u64;
        let vertex_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(vertex_data_size, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertices.as_ptr() as *const u8,
                vertex_buffer.get_allocation().get_host_ptr(),
                vertex_data_size as usize,
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?;

        // Draw pipeline.
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let push_range = [vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::FRAGMENT,
            offset: 0,
            size: 16,
        }];
        let draw_layout_info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(&push_range);
        let draw_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&draw_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );
        let draw_stages = [
            stage(vk::ShaderStageFlags::VERTEX, *vert_module),
            stage(vk::ShaderStageFlags::FRAGMENT, *frag_module),
        ];
        let draw_pipeline = build_pipeline(
            device,
            &PipelineOptions {
                layout: *draw_layout,
                stages: &draw_stages,
                render_pass: vk::RenderPass::null(),
                dynamic_rendering: true,
                color_attachments: true,
            },
        )?;

        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        let do_draw = |draw_count: i32| {
            let clear_value = vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: [1.0, 0.0, 0.0, 1.0],
                },
            };
            let pre_clear = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                ms_image.get(),
                color_range,
            );
            let post_clear = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_WRITE
                    | vk::AccessFlags::SHADER_READ
                    | vk::AccessFlags::COLOR_ATTACHMENT_READ
                    | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                ms_image.get(),
                color_range,
            );
            let post_draw = make_image_memory_barrier(
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                if draw_count == 0 {
                    vk::AccessFlags::SHADER_WRITE
                } else {
                    vk::AccessFlags::INPUT_ATTACHMENT_READ
                },
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::GENERAL,
                ms_image.get(),
                color_range,
            );
            let pre_second_draw = make_image_memory_barrier(
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                ms_image.get(),
                color_range,
            );
            let push_constants = push_bytes(&[draw_count, SIZE as i32, SIZE as i32, sample_count]);
            let barrier = |src_stage, dst_stage, image_barrier: vk::ImageMemoryBarrier| unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    src_stage,
                    dst_stage,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[image_barrier],
                );
            };
            if draw_count == 0 {
                barrier(
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    pre_clear,
                );
                unsafe {
                    device.cmd_clear_color_image(
                        cmd,
                        ms_image.get(),
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        &clear_value.color,
                        &[color_range],
                    )
                };
                barrier(
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::FRAGMENT_SHADER | vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    post_clear,
                );
            } else {
                barrier(
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    pre_second_draw,
                );
            }
            begin_rendering(
                device,
                cmd,
                *ms_view,
                render_area,
                clear_value,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::AttachmentLoadOp::LOAD,
                vk::RenderingFlags::empty(),
                1,
                0,
            );
            unsafe {
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *draw_pipeline);
                device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
                device.cmd_push_constants(cmd, *draw_layout, vk::ShaderStageFlags::FRAGMENT, 0, &push_constants);
                if draw_count == 0 {
                    device.cmd_set_rasterization_samples_ext(cmd, samples);
                }
                device.cmd_draw(cmd, vertices.len() as u32, 1, 0, 0);
            }
            end_rendering(device, cmd);
            barrier(
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::FRAGMENT_SHADER,
                post_draw,
            );
        };

        begin_command_buffer(device, cmd)?;
        do_draw(0);

        // The meta operation.
        let src_to_operation = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            source.get(),
            color_range,
        );
        let dst_to_operation = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            destination.get(),
            color_range,
        );
        let layers = vk::ImageSubresourceLayers {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            mip_level: 0,
            base_array_layer: 0,
            layer_count: 1,
        };
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[src_to_operation, dst_to_operation],
            );
            match self.params.meta_op {
                MetaOperation::Copy => {
                    let region = vk::ImageCopy {
                        src_subresource: layers,
                        src_offset: vk::Offset3D::default(),
                        dst_subresource: layers,
                        dst_offset: vk::Offset3D::default(),
                        extent: vk::Extent3D {
                            width: SIZE,
                            height: SIZE,
                            depth: 1,
                        },
                    };
                    device.cmd_copy_image(
                        cmd,
                        source.get(),
                        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                        destination.get(),
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        &[region],
                    );
                }
                MetaOperation::Blit => {
                    let offsets = [
                        vk::Offset3D::default(),
                        vk::Offset3D {
                            x: SIZE as i32,
                            y: SIZE as i32,
                            z: 1,
                        },
                    ];
                    let region = vk::ImageBlit {
                        src_subresource: layers,
                        src_offsets: offsets,
                        dst_subresource: layers,
                        dst_offsets: offsets,
                    };
                    device.cmd_blit_image(
                        cmd,
                        source.get(),
                        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                        destination.get(),
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        &[region],
                        vk::Filter::NEAREST,
                    );
                }
            }
        }

        do_draw(1);
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        // The destination of the meta operation: the red source, copied or blitted one to one.
        let mut result_level = TextureLevel::new(tcu_format, SIZE, SIZE, 1)?;
        read_image(
            context,
            destination.get(),
            &dst_params,
            &mut result_level,
            false,
            &families,
        )?;
        let threshold = if self.params.meta_op == MetaOperation::Copy {
            0.0
        } else {
            0.01
        };
        if !float_threshold_compare(
            &source_level.get_const_access(),
            &result_level.get_const_access(),
            [threshold; 4],
        )
        .ok
        {
            return Ok(TestStatus::fail(if self.params.meta_op == MetaOperation::Copy {
                "Copy test"
            } else {
                "Blit test"
            }));
        }

        // The multisampled image, sample by sample.
        let buffer_count = (SIZE * SIZE) as usize * sample_count as usize;
        let buffer_size = (buffer_count * 16) as u64;
        let results = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let expects = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let verify_frag_module = create_shader_module(device, binaries.get("fragVerify")?)?;
        let buffer_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::FRAGMENT)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::FRAGMENT)
            .build(device)?;
        let attachment_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::INPUT_ATTACHMENT, vk::ShaderStageFlags::FRAGMENT)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 2)
            .add_type(vk::DescriptorType::INPUT_ATTACHMENT, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 2)?;
        let buffer_set = make_descriptor_set(device, *descriptor_pool, *buffer_set_layout)?;
        let attachment_set = make_descriptor_set(device, *descriptor_pool, *attachment_set_layout)?;
        let results_info = make_descriptor_buffer_info(results.get(), 0, buffer_size);
        let expects_info = make_descriptor_buffer_info(expects.get(), 0, buffer_size);
        let image_info = vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *ms_view,
            image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        };
        let writes = [
            vk::WriteDescriptorSet {
                dst_set: *buffer_set,
                dst_binding: 0,
                descriptor_count: 1,
                descriptor_type: vk::DescriptorType::STORAGE_BUFFER,
                buffer_info: &results_info,
                ..Default::default()
            },
            vk::WriteDescriptorSet {
                dst_set: *buffer_set,
                dst_binding: 1,
                descriptor_count: 1,
                descriptor_type: vk::DescriptorType::STORAGE_BUFFER,
                buffer_info: &expects_info,
                ..Default::default()
            },
            vk::WriteDescriptorSet {
                dst_set: *attachment_set,
                dst_binding: 0,
                descriptor_count: 1,
                descriptor_type: vk::DescriptorType::INPUT_ATTACHMENT,
                image_info: &image_info,
                ..Default::default()
            },
        ];
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        let verify_push_range = [vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::FRAGMENT,
            offset: 0,
            size: 12,
        }];
        let set_layouts = [*buffer_set_layout, *attachment_set_layout];
        let verify_layout_info = vk::PipelineLayoutCreateInfo::builder()
            .set_layouts(&set_layouts)
            .push_constant_ranges(&verify_push_range);
        let verify_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&verify_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        let attachment = vk::AttachmentDescription {
            flags: vk::AttachmentDescriptionFlags::empty(),
            format: FORMAT,
            samples,
            load_op: vk::AttachmentLoadOp::LOAD,
            store_op: vk::AttachmentStoreOp::STORE,
            stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
            stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
            initial_layout: vk::ImageLayout::GENERAL,
            final_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        };
        let input_reference = [vk::AttachmentReference {
            attachment: 0,
            layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        }];
        let subpass = vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .input_attachments(&input_reference)
            .build();
        // A self dependency, the load operation counts as a write of the attachment.
        let dependency = vk::SubpassDependency {
            src_subpass: 0,
            dst_subpass: 0,
            src_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            dst_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            src_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            dst_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_READ,
            dependency_flags: vk::DependencyFlags::BY_REGION,
        };
        let attachments = [attachment];
        let subpasses = [subpass];
        let dependencies = [dependency];
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses)
            .dependencies(&dependencies);
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );
        let framebuffer = make_framebuffer(device, *render_pass, &[*ms_view], SIZE, SIZE, 1)?;
        let verify_stages = [
            stage(vk::ShaderStageFlags::VERTEX, *vert_module),
            stage(vk::ShaderStageFlags::FRAGMENT, *verify_frag_module),
        ];
        let verify_pipeline = build_pipeline(
            device,
            &PipelineOptions {
                layout: *verify_layout,
                stages: &verify_stages,
                render_pass: *render_pass,
                dynamic_rendering: false,
                color_attachments: false,
            },
        )?;

        let verify_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let verify_cmd = *verify_cmd_buffer;
        let load_barrier = make_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::COLOR_ATTACHMENT_READ,
        );
        let buffer_barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
        let verify_push = push_bytes(&[SIZE as i32, SIZE as i32, sample_count]);
        begin_command_buffer(device, verify_cmd)?;
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(render_area);
        unsafe {
            device.cmd_begin_render_pass(verify_cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_pipeline_barrier(
                verify_cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::BY_REGION,
                &[load_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
            device.cmd_bind_pipeline(verify_cmd, vk::PipelineBindPoint::GRAPHICS, *verify_pipeline);
            device.cmd_bind_vertex_buffers(verify_cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_push_constants(
                verify_cmd,
                *verify_layout,
                vk::ShaderStageFlags::FRAGMENT,
                0,
                &verify_push,
            );
            device.cmd_bind_descriptor_sets(
                verify_cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *verify_layout,
                0,
                &[*buffer_set, *attachment_set],
                &[] as &[u32],
            );
            device.cmd_draw(verify_cmd, vertices.len() as u32, 1, 0, 0);
            device.cmd_end_render_pass(verify_cmd);
            device.cmd_pipeline_barrier(
                verify_cmd,
                vk::PipelineStageFlags::FRAGMENT_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[buffer_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, verify_cmd)?;
        submit_commands_and_wait(device, queue, verify_cmd)?;

        invalidate_alloc(device, results.get_allocation())?;
        invalidate_alloc(device, expects.get_allocation())?;
        let output = unsafe {
            std::slice::from_raw_parts(
                results.get_allocation().get_host_ptr().cast_const().cast::<f32>(),
                buffer_count * 4,
            )
        };
        let expected = unsafe {
            std::slice::from_raw_parts(
                expects.get_allocation().get_host_ptr().cast_const().cast::<f32>(),
                buffer_count * 4,
            )
        };
        for x in 0..SIZE as usize {
            for y in 0..SIZE as usize {
                for s in 0..sample_count as usize {
                    let index = (y * SIZE as usize + x) * sample_count as usize + s;
                    if (0..4).any(|c| (expected[index * 4 + c] - output[index * 4 + c]).abs() > 0.01) {
                        return Ok(TestStatus::fail(format!(
                            "Verification failed for coordinates ({x}, {y}) sample {s} output: {:?} expected: {:?}",
                            &output[index * 4..index * 4 + 4],
                            &expected[index * 4..index * 4 + 4]
                        )));
                    }
                }
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createDynamicStateMetaOperationsTests`
pub fn create_dynamic_state_meta_operations_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("dynamic_state");
    for (name, meta_op) in [("copy", MetaOperation::Copy), ("blit", MetaOperation::Blit)] {
        let mut meta_group = TestCaseGroup::new(name);
        for (count, samples) in [
            (2, vk::SampleCountFlags::_2),
            (4, vk::SampleCountFlags::_4),
            (8, vk::SampleCountFlags::_8),
            (16, vk::SampleCountFlags::_16),
            (32, vk::SampleCountFlags::_32),
            (64, vk::SampleCountFlags::_64),
        ] {
            meta_group.add_child(Box::new(DynamicStateCase {
                name: format!("draw_multisampled_image_r8g8b8a8_unorm_samples_{count}"),
                params: Params { meta_op, samples },
            }) as Box<dyn TestCase>);
        }
        group.add_child(meta_group);
    }
    group
}
