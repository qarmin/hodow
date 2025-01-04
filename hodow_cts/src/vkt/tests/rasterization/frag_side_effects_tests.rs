// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/rasterization/vktRasterizationFragShaderSideEffectsTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Test frag shader side effects are not removed by optimizations: a full-screen quad whose fragment shader writes
// to an SSBO and then (or before) discards, demotes, zeroes the sample mask or fails a fixed-function test. Every
// pixel's SSBO element must still be written. The shaders are in `shaders/manifest/rasterization_frag_side_effects.toml`.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::rasterization_frag_side_effects::*;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_buffer_info, make_descriptor_set, make_framebuffer, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The manifest declares its cases with this: just the shader pair.
pub struct FragSideEffectsProgram {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum CaseType {
    Kill,
    Demote,
    TerminateInvocation,
    SampleMaskBefore,
    SampleMaskAfter,
    AlphaCoverageBefore,
    AlphaCoverageAfter,
    DepthBounds,
    StencilNever,
    DepthNever,
}

const FRAMEBUFFER_WIDTH: u32 = 32;
const FRAMEBUFFER_HEIGHT: u32 = 32;
const TOTAL_PIXELS: u32 = FRAMEBUFFER_WIDTH * FRAMEBUFFER_HEIGHT;

const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
// VK_FORMAT_FEATURE_DEPTH_STENCIL_ATTACHMENT_BIT must be supported for one of these two, according to the spec.
const DEPTH_STENCIL_FORMATS: [vk::Format; 2] = [vk::Format::D32_SFLOAT_S8_UINT, vk::Format::D24_UNORM_S8_UINT];

#[derive(Clone, Copy)]
struct DepthBoundsParameters {
    min_depth_bounds: f32,
    max_depth_bounds: f32,
    #[allow(dead_code)]
    depth_value: f32,
}

#[derive(Clone, Copy)]
struct TestParams {
    case_type: CaseType,
    clear_color: [f32; 4],
    draw_color: [f32; 4],
    color_at_end: bool,
    depth_bounds_params: Option<DepthBoundsParameters>,
}

/// `expectClearColor`
fn expect_clear_color(case_type: CaseType) -> bool {
    case_type != CaseType::AlphaCoverageBefore && case_type != CaseType::AlphaCoverageAfter
}

/// `needsDepthStencilAttachment`
fn needs_depth_stencil_attachment(case_type: CaseType) -> bool {
    matches!(
        case_type,
        CaseType::DepthBounds | CaseType::DepthNever | CaseType::StencilNever
    )
}

/// The one UNORM byte a colour channel the test uses reads back as.
fn unorm8(value: f32) -> u8 {
    (value * 255.0).round() as u8
}

struct FragSideEffectsTestCase {
    name: &'static str,
    params: TestParams,
}

impl FragSideEffectsTestCase {
    /// `initPrograms`: the cases that share a shader share a generated program.
    fn program(&self) -> &'static FragSideEffectsProgram {
        let end = self.params.color_at_end;
        match self.params.case_type {
            CaseType::Kill => {
                if end {
                    &FSE_KILL_END
                } else {
                    &FSE_KILL_BEGIN
                }
            }
            CaseType::Demote => {
                if end {
                    &FSE_DEMOTE_END
                } else {
                    &FSE_DEMOTE_BEGIN
                }
            }
            CaseType::TerminateInvocation => {
                if end {
                    &FSE_TERMINATE_INVOCATION_END
                } else {
                    &FSE_TERMINATE_INVOCATION_BEGIN
                }
            }
            CaseType::SampleMaskBefore => {
                if end {
                    &FSE_SAMPLE_MASK_BEFORE_END
                } else {
                    &FSE_SAMPLE_MASK_BEFORE_BEGIN
                }
            }
            CaseType::SampleMaskAfter => {
                if end {
                    &FSE_SAMPLE_MASK_AFTER_END
                } else {
                    &FSE_SAMPLE_MASK_AFTER_BEGIN
                }
            }
            CaseType::AlphaCoverageBefore => {
                if end {
                    &FSE_ALPHA_COVERAGE_BEFORE_END
                } else {
                    &FSE_ALPHA_COVERAGE_BEFORE_BEGIN
                }
            }
            CaseType::AlphaCoverageAfter => {
                if end {
                    &FSE_ALPHA_COVERAGE_AFTER_END
                } else {
                    &FSE_ALPHA_COVERAGE_AFTER_BEGIN
                }
            }
            CaseType::DepthBounds => {
                if end {
                    &FSE_DEPTH_BOUNDS_END
                } else {
                    &FSE_DEPTH_BOUNDS_BEGIN
                }
            }
            CaseType::StencilNever | CaseType::DepthNever => {
                if end {
                    &FSE_PLAIN_END
                } else {
                    &FSE_PLAIN_BEGIN
                }
            }
        }
    }
}

impl TestCase for FragSideEffectsTestCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `FragSideEffectsTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let features = context.get_device_features();

        if features.fragment_stores_and_atomics == vk::FALSE {
            return Err(TestError::NotSupported(
                "Fragment shader stores and atomics not supported".to_string(),
            ));
        }

        match self.params.case_type {
            CaseType::DepthBounds => {
                if features.depth_bounds == vk::FALSE {
                    return Err(TestError::NotSupported("Depth bounds test not supported".to_string()));
                }
            }
            CaseType::Demote => context.require_device_functionality("VK_EXT_shader_demote_to_helper_invocation")?,
            CaseType::TerminateInvocation => {
                context.require_device_functionality("VK_KHR_shader_terminate_invocation")?
            }
            _ => {}
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.program().programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(FragSideEffectsInstance {
            context,
            params: self.params,
        })
    }
}

struct FragSideEffectsInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for FragSideEffectsInstance<'_> {
    /// `FragSideEffectsInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let queue = context.get_universal_queue();
        let queue_index = context.get_universal_queue_family_index();

        // Color and depth/stencil images.
        let image_info = |format: vk::Format, usage: vk::ImageUsageFlags| {
            vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(format)
                .extent(vk::Extent3D {
                    width: FRAMEBUFFER_WIDTH,
                    height: FRAMEBUFFER_HEIGHT,
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
        let color_image = ImageWithMemory::new(
            device,
            alloc,
            image_info(
                COLOR_FORMAT,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;

        let mut depth_stencil_image = None;
        let mut depth_stencil_format = vk::Format::UNDEFINED;

        if needs_depth_stencil_attachment(params.case_type) {
            // Find available image format first.
            for format in DEPTH_STENCIL_FORMATS {
                let properties = unsafe {
                    context
                        .get_instance()
                        .get_physical_device_format_properties(context.get_physical_device(), format)
                };
                if properties
                    .optimal_tiling_features
                    .contains(vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT)
                {
                    depth_stencil_format = format;
                    break;
                }
            }

            if depth_stencil_format == vk::Format::UNDEFINED {
                return Ok(TestStatus::fail("No suitable depth/stencil format found"));
            }

            depth_stencil_image = Some(ImageWithMemory::new(
                device,
                alloc,
                image_info(depth_stencil_format, vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT),
                MemoryRequirement::ANY,
            )?);
        }

        // Image views.
        let color_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let color_image_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            color_subresource_range,
        )?;

        let depth_stencil_image_view = match &depth_stencil_image {
            Some(image) => {
                let range = make_image_subresource_range(
                    vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL,
                    0,
                    1,
                    0,
                    1,
                );
                Some(make_image_view(
                    device,
                    image.get(),
                    vk::ImageViewType::_2D,
                    depth_stencil_format,
                    range,
                )?)
            }
            None => None,
        };

        // Color image buffer.
        let color_image_buffer_size = (TOTAL_PIXELS * 4) as vk::DeviceSize;
        let color_image_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(color_image_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Vertex buffer.
        let full_screen_quad: [[f32; 2]; 6] = [
            [-1.0, 1.0],
            [1.0, 1.0],
            [1.0, -1.0],
            [-1.0, 1.0],
            [1.0, -1.0],
            [-1.0, -1.0],
        ];
        let vertex_buffer_size = std::mem::size_of_val(&full_screen_quad) as vk::DeviceSize;
        let vertex_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(vertex_buffer_size, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let vertex_buffer_alloc = vertex_buffer.get_allocation();
        unsafe {
            std::ptr::copy_nonoverlapping(
                full_screen_quad.as_ptr() as *const u8,
                vertex_buffer_alloc.get_host_ptr(),
                vertex_buffer_size as usize,
            )
        };
        flush_alloc(device, vertex_buffer_alloc)?;

        // Storage buffer.
        let storage_buffer_size = (TOTAL_PIXELS as usize * std::mem::size_of::<i32>()) as vk::DeviceSize;
        let storage_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(
                storage_buffer_size,
                vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let storage_buffer_alloc = storage_buffer.get_allocation();
        unsafe { std::ptr::write_bytes(storage_buffer_alloc.get_host_ptr(), 0, storage_buffer_size as usize) };
        flush_alloc(device, storage_buffer_alloc)?;

        // Descriptor set layout, pipeline layout, pool and set.
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::FRAGMENT)
            .build(device)?;
        let set_layouts = [*descriptor_set_layout];
        let pipeline_layout = make_pipeline_layout(device, &set_layouts)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let descriptor_buffer_info = make_descriptor_buffer_info(storage_buffer.get(), 0, storage_buffer_size);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                *descriptor_set,
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &descriptor_buffer_info,
            )
            .update(device);

        // Render pass.
        let mut attachments = vec![
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
        ];
        if depth_stencil_image.is_some() {
            attachments.push(
                vk::AttachmentDescription::builder()
                    .format(depth_stencil_format)
                    .samples(vk::SampleCountFlags::_1)
                    .load_op(vk::AttachmentLoadOp::CLEAR)
                    .store_op(vk::AttachmentStoreOp::STORE)
                    .stencil_load_op(vk::AttachmentLoadOp::CLEAR)
                    .stencil_store_op(vk::AttachmentStoreOp::STORE)
                    .initial_layout(vk::ImageLayout::UNDEFINED)
                    .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                    .build(),
            );
        }
        let color_references = [vk::AttachmentReference::builder()
            .attachment(0)
            .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build()];
        let depth_stencil_reference = vk::AttachmentReference::builder()
            .attachment(1)
            .layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
            .build();
        let subpass = vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_references);
        let subpass = if depth_stencil_image.is_some() {
            subpass.depth_stencil_attachment(&depth_stencil_reference)
        } else {
            subpass
        };
        let subpasses = [subpass.build()];
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses);
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );

        // Framebuffer.
        let mut image_views = vec![*color_image_view];
        if let Some(view) = &depth_stencil_image_view {
            image_views.push(**view);
        }
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &image_views,
            FRAMEBUFFER_WIDTH,
            FRAMEBUFFER_HEIGHT,
            1,
        )?;

        // Shader modules.
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        // Pipeline state.
        let vertex_bindings = [vk::VertexInputBindingDescription {
            binding: 0,
            stride: std::mem::size_of::<[f32; 2]>() as u32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        let vertex_attributes = [vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32_SFLOAT,
            offset: 0,
        }];
        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&vertex_bindings)
            .vertex_attribute_descriptions(&vertex_attributes);
        let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(vk::PrimitiveTopology::TRIANGLE_LIST)
            .primitive_restart_enable(false);
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: FRAMEBUFFER_WIDTH as f32,
            height: FRAMEBUFFER_HEIGHT as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: FRAMEBUFFER_WIDTH,
                height: FRAMEBUFFER_HEIGHT,
            },
        }];
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

        let alpha_to_coverage_enable = matches!(
            params.case_type,
            CaseType::AlphaCoverageBefore | CaseType::AlphaCoverageAfter
        );
        let multisample_state = vk::PipelineMultisampleStateCreateInfo::builder()
            .rasterization_samples(vk::SampleCountFlags::_1)
            .sample_shading_enable(false)
            .alpha_to_coverage_enable(alpha_to_coverage_enable)
            .alpha_to_one_enable(false);

        let enable_depth_bounds = params.case_type == CaseType::DepthBounds;
        let enable_depth_stencil_test = depth_stencil_image.is_some();
        let depth_compare_op = if params.case_type == CaseType::DepthNever {
            vk::CompareOp::NEVER
        } else {
            vk::CompareOp::ALWAYS
        };
        let stencil_compare_op = if params.case_type == CaseType::StencilNever {
            vk::CompareOp::NEVER
        } else {
            vk::CompareOp::ALWAYS
        };
        let stencil_op_state = vk::StencilOpState::builder()
            .fail_op(vk::StencilOp::KEEP)
            .pass_op(vk::StencilOp::KEEP)
            .depth_fail_op(vk::StencilOp::KEEP)
            .compare_op(stencil_compare_op)
            .compare_mask(0xFF)
            .write_mask(0xFF)
            .reference(0)
            .build();
        let (min_depth_bounds, max_depth_bounds) = match params.depth_bounds_params {
            Some(bounds) if enable_depth_bounds => (bounds.min_depth_bounds, bounds.max_depth_bounds),
            _ => (0.0, 1.0),
        };
        let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(enable_depth_stencil_test)
            .depth_write_enable(enable_depth_stencil_test)
            .depth_compare_op(depth_compare_op)
            .depth_bounds_test_enable(enable_depth_bounds)
            .stencil_test_enable(enable_depth_stencil_test)
            .front(stencil_op_state)
            .back(stencil_op_state)
            .min_depth_bounds(min_depth_bounds)
            .max_depth_bounds(max_depth_bounds);

        let color_blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .src_color_blend_factor(vk::BlendFactor::ZERO)
            .dst_color_blend_factor(vk::BlendFactor::ZERO)
            .color_blend_op(vk::BlendOp::ADD)
            .src_alpha_blend_factor(vk::BlendFactor::ZERO)
            .dst_alpha_blend_factor(vk::BlendFactor::ZERO)
            .alpha_blend_op(vk::BlendOp::ADD)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder()
            .logic_op_enable(false)
            .logic_op(vk::LogicOp::NO_OP)
            .attachments(&color_blend_attachments);

        let stages = [
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::VERTEX)
                .module(*vert_module)
                .name(b"main\0")
                .build(),
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(*frag_module)
                .name(b"main\0")
                .build(),
        ];
        let pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input_state)
            .input_assembly_state(&input_assembly_state)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization_state)
            .multisample_state(&multisample_state)
            .depth_stencil_state(&depth_stencil_state)
            .color_blend_state(&color_blend_state)
            .layout(*pipeline_layout)
            .render_pass(*render_pass)
            .subpass(0)
            .base_pipeline_index(0);
        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        let graphics_pipeline = Unique::new(device, pipelines.0[0]);

        // Command buffer.
        let cmd_pool = make_command_pool(device, queue_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        // Draw full-screen quad.
        let clear_values = [
            vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: params.clear_color,
                },
            },
            vk::ClearValue {
                depth_stencil: vk::ClearDepthStencilValue { depth: 1.0, stencil: 0 },
            },
        ];
        let render_area = vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: FRAMEBUFFER_WIDTH,
                height: FRAMEBUFFER_HEIGHT,
            },
        };

        begin_command_buffer(device, cmd)?;
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(render_area)
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *graphics_pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[*descriptor_set],
                &[],
            );
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_draw(cmd, full_screen_quad.len() as u32, 1, 0, 0);
            device.cmd_end_render_pass(cmd);

            // Storage buffer frag-write to host-read barrier.
            let storage_buffer_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::HOST_READ,
                storage_buffer.get(),
                0,
                vk::WHOLE_SIZE,
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::FRAGMENT_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[storage_buffer_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        // Color image frag-write to transfer-read, the copy, and the transfer-write to host-read barrier.
        copy_image_to_buffer(
            device,
            cmd,
            color_image.get(),
            color_image_buffer.get(),
            FRAMEBUFFER_WIDTH,
            FRAMEBUFFER_HEIGHT,
        );

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        // Check SSBO contents.
        {
            invalidate_alloc(device, storage_buffer_alloc)?;
            let elements = unsafe {
                std::slice::from_raw_parts(storage_buffer_alloc.get_host_ptr() as *const i32, TOTAL_PIXELS as usize)
            };

            for (i, &element) in elements.iter().enumerate() {
                if element != 1 {
                    return Ok(TestStatus::fail(format!(
                        "Fail: Unexpected value in storage buffer element {i}"
                    )));
                }
            }
        }

        // Check color attachment.
        {
            let to_texel = |color: [f32; 4]| [unorm8(color[0]), unorm8(color[1]), unorm8(color[2]), unorm8(color[3])];
            let mut expected_colors = vec![to_texel(params.clear_color)];
            if !expect_clear_color(params.case_type) {
                expected_colors.push(to_texel(params.draw_color));
            }

            let color_image_buffer_alloc = color_image_buffer.get_allocation();
            invalidate_alloc(device, color_image_buffer_alloc)?;
            let pixels = unsafe {
                std::slice::from_raw_parts(
                    color_image_buffer_alloc.get_host_ptr(),
                    color_image_buffer_size as usize,
                )
            };

            let all_pix_ok = pixels
                .chunks_exact(4)
                .all(|pixel| expected_colors.iter().any(|expected| pixel == expected.as_slice()));
            if !all_pix_ok {
                return Ok(TestStatus::fail("Fail: color buffer with unexpected values"));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createFragSideEffectsTests`
pub fn create_frag_side_effects_tests() -> TestCaseGroup {
    let mut frag_side_effects_group = TestCaseGroup::new("frag_side_effects");

    let default_clear_color = [0.0f32, 0.0, 0.0, 1.0];
    let default_draw_color = [0.0f32, 0.0, 1.0, 1.0];

    for (color_at_end, group_name) in [(false, "color_at_beginning"), (true, "color_at_end")] {
        let mut color_order_group = TestCaseGroup::new(group_name);

        let plain = |case_type: CaseType, draw_color: [f32; 4], depth_bounds_params: Option<DepthBoundsParameters>| {
            TestParams {
                case_type,
                clear_color: default_clear_color,
                draw_color,
                color_at_end,
                depth_bounds_params,
            }
        };
        // Alpha coverage cases draw with alpha zero.
        let alpha_draw_color = [default_draw_color[0], default_draw_color[1], default_draw_color[2], 0.0];

        let cases = [
            ("kill", plain(CaseType::Kill, default_draw_color, None)),
            ("demote", plain(CaseType::Demote, default_draw_color, None)),
            (
                "terminate_invocation",
                plain(CaseType::TerminateInvocation, default_draw_color, None),
            ),
            (
                "sample_mask_before",
                plain(CaseType::SampleMaskBefore, default_draw_color, None),
            ),
            (
                "sample_mask_after",
                plain(CaseType::SampleMaskAfter, default_draw_color, None),
            ),
            ("stencil_never", plain(CaseType::StencilNever, default_draw_color, None)),
            ("depth_never", plain(CaseType::DepthNever, default_draw_color, None)),
            (
                "alpha_coverage_before",
                plain(CaseType::AlphaCoverageBefore, alpha_draw_color, None),
            ),
            (
                "alpha_coverage_after",
                plain(CaseType::AlphaCoverageAfter, alpha_draw_color, None),
            ),
            (
                "depth_bounds",
                plain(
                    CaseType::DepthBounds,
                    default_draw_color,
                    Some(DepthBoundsParameters {
                        min_depth_bounds: 0.25,
                        max_depth_bounds: 0.5,
                        depth_value: 0.75,
                    }),
                ),
            ),
        ];
        for (name, params) in cases {
            color_order_group.add_child(Box::new(FragSideEffectsTestCase { name, params }) as Box<dyn TestCase>);
        }

        frag_side_effects_group.add_child(color_order_group);
    }

    frag_side_effects_group
}
