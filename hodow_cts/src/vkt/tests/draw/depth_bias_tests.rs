// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/draw/vktDrawDepthBiasTests.cpp (the Amber scripts under data/vulkan/amber/draw/depth_bias)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021-2022 Google Inc.
// Copyright (c) 2021-2022 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. What an Amber graphics pipeline does for these scripts is done directly: a 100x100
// R8G8B8A8_UNORM colour attachment cleared to black and a D16_UNORM depth attachment cleared to 0.3, a red rectangle at depth 0.17
// drawn without depth bias and a green one at depth 0.18 drawn with a constant depth bias of -700 (-700 / 2^16 in depth), both
// with the `less` depth compare. The bias is what lets the green one through, so a red pixel in the result means the bias was not
// applied. The script's compute verification (every pixel must have red 0 and alpha 1) is done on the host over the read back colour.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::draw_depth_bias::{DEPTH_BIAS_PLAIN, DEPTH_BIAS_TESS};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, make_rect_2d, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::default_depth_stencil_state;
use crate::vkt::tests::draw::{initial_transition_color_2d_image, initial_transition_depth_2d_image};
use crate::vkt::tests::pipeline::pipeline_util::read_color_attachment;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const SIZE: u32 = 100;
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const DEPTH_FORMAT: vk::Format = vk::Format::D16_UNORM;
const CLEAR_DEPTH: f32 = 0.3;
const DEPTH_BIAS_CONSTANT_FACTOR: f32 = -700.0;

#[derive(Clone, Copy)]
struct DepthBiasParams {
    polygon_mode: vk::PolygonMode,
    patch_list: bool,
}

/// One of the six scripts: `depthBiasCase`, whose requirements are the features the script names.
struct DepthBiasCase {
    name: &'static str,
    params: DepthBiasParams,
}

impl TestCase for DepthBiasCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let features = context.get_device_features();
        if self.params.patch_list && features.tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "Features.tessellationShader not supported".to_string(),
            ));
        }
        if self.params.polygon_mode != vk::PolygonMode::FILL && features.fill_mode_non_solid == vk::FALSE {
            return Err(TestError::NotSupported(
                "Features.fillModeNonSolid not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        if self.params.patch_list {
            DEPTH_BIAS_TESS.programs
        } else {
            DEPTH_BIAS_PLAIN.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DepthBiasInstance {
            context,
            params: self.params,
        })
    }
}

struct DepthBiasInstance<'a> {
    context: &'a Context<'a>,
    params: DepthBiasParams,
}

impl<'a> DepthBiasInstance<'a> {
    fn host_buffer<T: Copy>(
        &self,
        values: &[T],
        usage: vk::BufferUsageFlags,
    ) -> Result<BufferWithMemory<'a>, TestError> {
        let device = self.context.get_device();
        let size = std::mem::size_of_val(values);
        let buffer = BufferWithMemory::new(
            device,
            self.context.get_default_allocator(),
            make_buffer_create_info(size as vk::DeviceSize, usage),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                values.as_ptr().cast::<u8>(),
                buffer.get_allocation().get_host_ptr(),
                size,
            )
        };
        flush_alloc(device, buffer.get_allocation())?;
        Ok(buffer)
    }

    /// The two pipelines of the script: the same state with the depth bias `bias` and the vertex data it draws.
    fn create_pipeline(
        &self,
        render_pass: vk::RenderPass,
        layout: vk::PipelineLayout,
        bias: f32,
    ) -> Result<Unique<'a, vk::Pipeline>, TestError> {
        let device = self.context.get_device();
        let binaries = self.context.get_binary_collection();

        let vs = create_shader_module(device, binaries.get("vert")?)?;
        let fs = create_shader_module(device, binaries.get("frag")?)?;
        let tc = if self.params.patch_list {
            Some(create_shader_module(device, binaries.get("tesc")?)?)
        } else {
            None
        };
        let te = if self.params.patch_list {
            Some(create_shader_module(device, binaries.get("tese")?)?)
        } else {
            None
        };

        let mut stages = vec![
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::VERTEX)
                .module(*vs)
                .name(b"main\0")
                .build(),
        ];
        if let (Some(tc), Some(te)) = (&tc, &te) {
            stages.push(
                vk::PipelineShaderStageCreateInfo::builder()
                    .stage(vk::ShaderStageFlags::TESSELLATION_CONTROL)
                    .module(**tc)
                    .name(b"main\0")
                    .build(),
            );
            stages.push(
                vk::PipelineShaderStageCreateInfo::builder()
                    .stage(vk::ShaderStageFlags::TESSELLATION_EVALUATION)
                    .module(**te)
                    .name(b"main\0")
                    .build(),
            );
        }
        stages.push(
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(*fs)
                .name(b"main\0")
                .build(),
        );

        let bindings = [
            vk::VertexInputBindingDescription {
                binding: 0,
                stride: 12,
                input_rate: vk::VertexInputRate::VERTEX,
            },
            vk::VertexInputBindingDescription {
                binding: 1,
                stride: 16,
                input_rate: vk::VertexInputRate::VERTEX,
            },
        ];
        let attributes = [
            vk::VertexInputAttributeDescription {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32B32_SFLOAT,
                offset: 0,
            },
            vk::VertexInputAttributeDescription {
                location: 1,
                binding: 1,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 0,
            },
        ];
        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&bindings)
            .vertex_attribute_descriptions(&attributes);
        let input_assembly_state =
            vk::PipelineInputAssemblyStateCreateInfo::builder().topology(if self.params.patch_list {
                vk::PrimitiveTopology::PATCH_LIST
            } else {
                vk::PrimitiveTopology::TRIANGLE_LIST
            });
        let tessellation_state = vk::PipelineTessellationStateCreateInfo::builder().patch_control_points(3);

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

        let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
            .depth_clamp_enable(false)
            .rasterizer_discard_enable(false)
            .polygon_mode(self.params.polygon_mode)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .depth_bias_enable(true)
            .depth_bias_constant_factor(bias)
            .depth_bias_clamp(0.0)
            .depth_bias_slope_factor(0.0)
            .line_width(1.0);
        let multisample_state =
            vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);

        let mut depth_stencil_state = default_depth_stencil_state();
        depth_stencil_state.depth_test_enable = vk::TRUE;
        depth_stencil_state.depth_write_enable = vk::TRUE;
        depth_stencil_state.depth_compare_op = vk::CompareOp::LESS;
        depth_stencil_state.stencil_test_enable = vk::FALSE;
        depth_stencil_state.min_depth_bounds = 0.0;
        depth_stencil_state.max_depth_bounds = 1.0;

        let attachment_states = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&attachment_states);

        let mut pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input_state)
            .input_assembly_state(&input_assembly_state)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization_state)
            .multisample_state(&multisample_state)
            .depth_stencil_state(&depth_stencil_state)
            .color_blend_state(&color_blend_state)
            .layout(layout)
            .render_pass(render_pass)
            .subpass(0)
            .base_pipeline_index(0);
        if self.params.patch_list {
            pipeline_info = pipeline_info.tessellation_state(&tessellation_state);
        }
        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        Ok(Unique::new(device, pipelines.0[0]))
    }
}

impl TestInstance for DepthBiasInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let extent = vk::Extent3D {
            width: SIZE,
            height: SIZE,
            depth: 1,
        };

        let image_info = |format: vk::Format, usage: vk::ImageUsageFlags| {
            vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(format)
                .extent(extent)
                .mip_levels(1)
                .array_layers(1)
                .samples(vk::SampleCountFlags::_1)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(usage)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build()
        };
        let color = ImageWithMemory::new(
            device,
            alloc,
            image_info(
                COLOR_FORMAT,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;
        let color_view = make_image_view(
            device,
            *color,
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;
        let depth = ImageWithMemory::new(
            device,
            alloc,
            image_info(DEPTH_FORMAT, vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT),
            MemoryRequirement::ANY,
        )?;
        let depth_view = make_image_view(
            device,
            *depth,
            vk::ImageViewType::_2D,
            DEPTH_FORMAT,
            make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1),
        )?;

        let attachments = [
            vk::AttachmentDescription::builder()
                .format(COLOR_FORMAT)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .build(),
            vk::AttachmentDescription::builder()
                .format(DEPTH_FORMAT)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::DONT_CARE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .build(),
        ];
        let color_reference = [vk::AttachmentReference {
            attachment: 0,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        }];
        let depth_reference = vk::AttachmentReference {
            attachment: 1,
            layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        };
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_reference)
            .depth_stencil_attachment(&depth_reference)
            .build()];
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses);
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_view, *depth_view], SIZE, SIZE, 1)?;

        let layout = make_pipeline_layout(device, &[])?;
        let pipeline_no_bias = self.create_pipeline(*render_pass, *layout, 0.0)?;
        let pipeline_bias = self.create_pipeline(*render_pass, *layout, DEPTH_BIAS_CONSTANT_FACTOR)?;

        let square = |z: f32| -> [[f32; 3]; 6] {
            [
                [-0.5, -0.5, z],
                [0.5, -0.5, z],
                [0.5, 0.5, z],
                [0.5, 0.5, z],
                [-0.5, 0.5, z],
                [-0.5, -0.5, z],
            ]
        };
        let position_a = self.host_buffer(&square(0.17), vk::BufferUsageFlags::VERTEX_BUFFER)?;
        let position_b = self.host_buffer(&square(0.18), vk::BufferUsageFlags::VERTEX_BUFFER)?;
        let color_a = self.host_buffer(&[[1.0f32, 0.0, 0.0, 1.0]; 6], vk::BufferUsageFlags::VERTEX_BUFFER)?;
        let color_b = self.host_buffer(&[[0.0f32, 1.0, 0.0, 1.0]; 6], vk::BufferUsageFlags::VERTEX_BUFFER)?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, *cmd_buffer)?;

        initial_transition_color_2d_image(
            device,
            *cmd_buffer,
            *color,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            1,
        );
        initial_transition_depth_2d_image(
            device,
            *cmd_buffer,
            *depth,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
            vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
        );

        let clear_values = [
            vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: [0.0, 0.0, 0.0, 1.0],
                },
            },
            vk::ClearValue {
                depth_stencil: vk::ClearDepthStencilValue {
                    depth: CLEAR_DEPTH,
                    stencil: 0,
                },
            },
        ];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(make_rect_2d(0, 0, SIZE, SIZE))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(*cmd_buffer, &begin_info, vk::SubpassContents::INLINE);

            device.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline_no_bias);
            device.cmd_bind_vertex_buffers(*cmd_buffer, 0, &[position_a.get(), color_a.get()], &[0, 0]);
            device.cmd_draw(*cmd_buffer, 6, 1, 0, 0);

            device.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline_bias);
            device.cmd_bind_vertex_buffers(*cmd_buffer, 0, &[position_b.get(), color_b.get()], &[0, 0]);
            device.cmd_draw(*cmd_buffer, 6, 1, 0, 0);

            device.cmd_end_render_pass(*cmd_buffer);
        }
        end_command_buffer(device, *cmd_buffer)?;
        submit_commands_and_wait(device, context.get_universal_queue(), *cmd_buffer)?;

        // The script's verification pipeline: red 0 and alpha 1 in every pixel, anything else is the red rectangle showing through.
        let result = read_color_attachment(
            context,
            *color,
            COLOR_FORMAT,
            (SIZE, SIZE),
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let pixels = result.get_const_access();
        for y in 0..SIZE {
            for x in 0..SIZE {
                let pixel = pixels.get_pixel(x, y, 0);
                if pixel[0] != 0.0 || pixel[3] != 1.0 {
                    return Ok(TestStatus::fail(format!(
                        "Unexpected colour {pixel:?} at ({x}, {y}): the red rectangle is on top, so the depth bias was not applied"
                    )));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createDepthBiasTests`
pub fn create_depth_bias_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("depth_bias");

    let cases = [
        ("depth_bias_triangle_list_fill", vk::PolygonMode::FILL, false),
        ("depth_bias_triangle_list_line", vk::PolygonMode::LINE, false),
        ("depth_bias_triangle_list_point", vk::PolygonMode::POINT, false),
        ("depth_bias_patch_list_tri_fill", vk::PolygonMode::FILL, true),
        ("depth_bias_patch_list_tri_line", vk::PolygonMode::LINE, true),
        ("depth_bias_patch_list_tri_point", vk::PolygonMode::POINT, true),
    ];
    for (name, polygon_mode, patch_list) in cases {
        group.add_child(Box::new(DepthBiasCase {
            name,
            params: DepthBiasParams {
                polygon_mode,
                patch_list,
            },
        }) as Box<dyn TestCase>);
    }

    group
}
