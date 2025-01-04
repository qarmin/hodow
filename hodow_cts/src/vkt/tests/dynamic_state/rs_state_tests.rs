// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/dynamic_state/vktDynamicStateRSTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `rs_state`: depth bias, depth bias clamp and line width are set dynamically, and two cases check that a non-zero
// dynamic depth bias really is applied. The `_mesh` variants are not ported.

use vulkanalia::prelude::v1_0::*;

use super::construction::create_graphics_pipeline;
use crate::generated::shaders::dynamic_state_depth_bias_nonzero::DEPTH_BIAS_NONZERO;
use crate::generated::shaders::dynamic_state_vertex_fetch::VERTEX_FETCH;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::MemoryRequirement;
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool, make_framebuffer};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::rect_2d;
use crate::vkt::tests::dynamic_state::base_class::{
    BLUE, BaseConfig, DepthAttachment, DepthStencilDynamicState, DynamicStateBase, GREEN, HEIGHT, PositionColorVertex,
    StateTestCase, WIDTH, build_reference_frame, check_depth_bias_clamp_support, check_nothing,
    check_wide_lines_support, depth_stencil_state, make_color_depth_stencil_render_pass, read_rgba8_image,
    stencil_op_state,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `DepthBiasBaseCase`'s configuration: depth test and write enabled with GREATER_OR_EQUAL.
fn depth_bias_config(data: Vec<PositionColorVertex>) -> BaseConfig {
    let mut config = BaseConfig::vertex_fetch(data);
    config.depth = DepthAttachment::DepthStencil { stencil_load: false };
    let replace = stencil_op_state(
        vk::StencilOp::REPLACE,
        vk::StencilOp::REPLACE,
        vk::StencilOp::REPLACE,
        vk::CompareOp::ALWAYS,
    );
    config.depth_stencil_states = vec![depth_stencil_state(
        true,
        true,
        vk::CompareOp::GREATER_OR_EQUAL,
        false,
        false,
        replace,
        replace,
    )];
    config
}

/// `DepthBiasBaseCase`'s `setDynamicViewportState`, `setDynamicBlendState` and `setDynamicDepthStencilState`.
fn set_depth_bias_states(base: &DynamicStateBase<'_>) {
    base.set_dynamic_viewport_state(WIDTH, HEIGHT);
    base.set_dynamic_blend_state([0.0; 4]);
    base.set_dynamic_depth_stencil_state(DepthStencilDynamicState::default());
}

/// The reference frame of the depth bias cases: the green square at +-0.5 over blue.
fn green_square_over_blue() -> Result<crate::tcu::pixel::TextureLevel, TestError> {
    build_reference_frame([0.0, 0.0, 0.0, 1.0], |x_coord, y_coord| {
        if (-0.5..=0.5).contains(&x_coord) && (-0.5..=0.5).contains(&y_coord) {
            Some(GREEN)
        } else {
            Some(BLUE)
        }
    })
}

/// `DepthBiasParamTestInstance`
fn depth_bias_run<'a>(context: &'a Context<'a>) -> TestOutcome {
    let device = context.get_device();
    let quad = |z: f32, color: [f32; 4], half: f32| {
        [
            PositionColorVertex::new([-half, half, z, 1.0], color),
            PositionColorVertex::new([half, half, z, 1.0], color),
            PositionColorVertex::new([-half, -half, z, 1.0], color),
            PositionColorVertex::new([half, -half, z, 1.0], color),
        ]
    };
    let mut data = Vec::new();
    data.extend(quad(0.5, BLUE, 1.0));
    data.extend(quad(1.0, GREEN, 0.5));
    data.extend(quad(0.5, [1.0, 0.0, 0.0, 1.0], 1.0));

    let base = DynamicStateBase::new(context, depth_bias_config(data))?;

    base.begin_render_pass()?;

    // set states here
    set_depth_bias_states(&base);

    base.bind_pipeline(0);

    base.bind_vertex_buffer();

    base.set_dynamic_rasterization_state(1.0, 0.0, 0.0, 0.0);
    base.draw(4, 0);
    base.draw(4, 4);

    base.set_dynamic_rasterization_state(1.0, -1.0, 0.0, 0.0);
    base.draw(4, 8);

    base.end_and_submit()?;

    // validation
    unsafe { device.queue_wait_idle(context.get_universal_queue()) }.vk_check("vkQueueWaitIdle")?;

    let reference_frame = green_square_over_blue()?;
    base.verify_against(&reference_frame)
}

/// `DepthBiasClampParamTestInstance`
fn depth_bias_clamp_run<'a>(context: &'a Context<'a>) -> TestOutcome {
    let _device = context.get_device();
    let mut data = Vec::new();
    for (z, color, half) in [(0.0f32, BLUE, 1.0f32), (0.01, GREEN, 0.5)] {
        data.push(PositionColorVertex::new([-half, half, z, 1.0], color));
        data.push(PositionColorVertex::new([half, half, z, 1.0], color));
        data.push(PositionColorVertex::new([-half, -half, z, 1.0], color));
        data.push(PositionColorVertex::new([half, -half, z, 1.0], color));
    }

    let base = DynamicStateBase::new(context, depth_bias_config(data))?;

    base.begin_render_pass()?;

    // set states here
    set_depth_bias_states(&base);

    base.bind_pipeline(0);

    base.bind_vertex_buffer();

    base.set_dynamic_rasterization_state(1.0, 1000.0, 0.005, 0.0);
    base.draw(4, 0);

    base.set_dynamic_rasterization_state(1.0, 0.0, 0.0, 0.0);
    base.draw(4, 4);

    base.end_and_submit()?;

    // validation
    let reference_frame = green_square_over_blue()?;
    base.verify_against(&reference_frame)
}

/// `LineWidthParamTestInstance`
fn line_width_run<'a>(context: &'a Context<'a>) -> TestOutcome {
    let data = vec![
        PositionColorVertex::new([-1.0, 0.0, 0.0, 1.0], GREEN),
        PositionColorVertex::new([1.0, 0.0, 0.0, 1.0], GREEN),
    ];
    let config = BaseConfig::new("vert", "frag", vk::PrimitiveTopology::LINE_LIST, data);
    let base = DynamicStateBase::new(context, config)?;

    base.begin_render_pass()?;

    // set states here
    let line_width_max = context.get_device_properties().limits.line_width_range[1];

    base.set_dynamic_viewport_state(WIDTH, HEIGHT);
    base.set_dynamic_blend_state([0.0; 4]);
    base.set_dynamic_depth_stencil_state(DepthStencilDynamicState::default());
    base.set_dynamic_rasterization_state(line_width_max.floor(), 0.0, 0.0, 0.0);

    base.bind_pipeline(0);

    base.bind_vertex_buffer();
    base.draw_lines(base.data.len() as u32, 0);

    base.end_and_submit()?;

    // validation
    let line_half_width = (f64::from(line_width_max).floor() / f64::from(HEIGHT)) as f32;
    let reference_frame = build_reference_frame([0.0, 0.0, 0.0, 1.0], |x_coord, y_coord| {
        if (-1.0..=1.0).contains(&x_coord) && (-line_half_width..=line_half_width).contains(&y_coord) {
            Some(GREEN)
        } else {
            None
        }
    })?;
    base.verify_against(&reference_frame)
}

/// `DepthBiasNonZeroPushConstants`
#[repr(C)]
#[derive(Clone, Copy)]
struct DepthBiasNonZeroPushConstants {
    geometry_depth: f32,
    min_depth: f32,
    max_depth: f32,
}

/// `DepthBiasNonZeroParams`, without the construction type and the mesh flag.
#[derive(Clone, Copy)]
struct DepthBiasNonZeroParams {
    depth_bias_constant: f32,
    depth_bias_clamp: f32,
    push_constants: DepthBiasNonZeroPushConstants,
}

/// `DepthBiasNonZeroCase`. Tests that fail if both the depth bias clamp or depth constant factor stay at 0.0f instead of applying the real values.
struct DepthBiasNonZeroCase {
    name: &'static str,
    params: DepthBiasNonZeroParams,
    mesh: bool,
}

impl DepthBiasNonZeroCase {
    /// `DepthBiasNonZeroCase::getExpectedColor`
    const EXPECTED_COLOR: [u8; 4] = [0, 255, 0, 255];
}

impl TestCase for DepthBiasNonZeroCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.params.depth_bias_clamp != 0.0 {
            check_depth_bias_clamp_support(context)?;
        }
        if self.mesh {
            context.require_device_functionality("VK_EXT_mesh_shader")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        if self.mesh {
            crate::generated::shaders::dynamic_state_depth_bias_nonzero::DEPTH_BIAS_NONZERO_MESH.programs
        } else {
            DEPTH_BIAS_NONZERO.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DepthBiasNonZeroInstance {
            context,
            params: self.params,
            mesh: self.mesh,
        })
    }
}

/// `DepthBiasNonZeroInstance`
struct DepthBiasNonZeroInstance<'a> {
    context: &'a Context<'a>,
    params: DepthBiasNonZeroParams,
    mesh: bool,
}

impl TestInstance for DepthBiasNonZeroInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let queue = context.get_universal_queue();

        let depth_format = vk::Format::D16_UNORM;
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
        let depth_usage = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
        let extent = vk::Extent3D {
            width: 8,
            height: 8,
            depth: 1,
        };
        let pc_data = params.push_constants;
        let pc_data_size = std::mem::size_of::<DepthBiasNonZeroPushConstants>() as u32;
        let mesh = self.mesh;
        let pc_stages = (if mesh {
            vk::ShaderStageFlags::MESH_EXT
        } else {
            vk::ShaderStageFlags::VERTEX
        }) | vk::ShaderStageFlags::FRAGMENT;
        let pc_range = vk::PushConstantRange {
            stage_flags: pc_stages,
            offset: 0,
            size: pc_data_size,
        };

        // The render pass: both attachments cleared on load and left in TRANSFER_SRC_OPTIMAL.
        let render_pass = make_color_depth_stencil_render_pass(
            device,
            color_format,
            depth_format,
            vk::AttachmentLoadOp::CLEAR,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        )?;

        let mut stencil_op = stencil_op_state(
            vk::StencilOp::KEEP,
            vk::StencilOp::KEEP,
            vk::StencilOp::KEEP,
            vk::CompareOp::NEVER,
        );
        stencil_op.compare_mask = 0;
        stencil_op.write_mask = 0;
        stencil_op.reference = 0;

        // Color buffer.
        let color_buffer_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(color_format)
            .extent(extent)
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(color_usage)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let color_buffer = ImageWithMemory::new(device, alloc, color_buffer_info, MemoryRequirement::ANY)?;

        // Depth buffer.
        let depth_buffer_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(depth_format)
            .extent(extent)
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(depth_usage)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let depth_buffer = ImageWithMemory::new(device, alloc, depth_buffer_info, MemoryRequirement::ANY)?;

        let color_view = make_image_view(
            device,
            color_buffer.get(),
            vk::ImageViewType::_2D,
            color_format,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;
        let depth_view = make_image_view(
            device,
            depth_buffer.get(),
            vk::ImageViewType::_2D,
            depth_format,
            make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1),
        )?;

        // Create framebuffer.
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*color_view, *depth_view],
            extent.width,
            extent.height,
            1,
        )?;

        // Descriptor set and pipeline layout.
        let set_layout_info = vk::DescriptorSetLayoutCreateInfo::builder();
        let ds_layout = Unique::new(
            device,
            unsafe { device.create_descriptor_set_layout(&set_layout_info, None) }
                .vk_check("vkCreateDescriptorSetLayout")?,
        );
        let set_layouts = [*ds_layout];
        let pc_ranges = [pc_range];
        let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder()
            .set_layouts(&set_layouts)
            .push_constant_ranges(&pc_ranges);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        // Shader modules.
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get(if mesh { "mesh" } else { "vert" })?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: extent.width as f32,
            height: extent.height as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [rect_2d(extent.width, extent.height)];

        // Vertex input state without bindings and attributes.
        let vertex_input_info = vk::PipelineVertexInputStateCreateInfo::builder();
        let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(vk::PrimitiveTopology::TRIANGLE_LIST)
            .primitive_restart_enable(false);
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);

        // Depth/stencil state, with depth test and writes enabled.
        let depth_stencil_state_info = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(true)
            .depth_write_enable(true)
            .depth_compare_op(vk::CompareOp::ALWAYS)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(false)
            .front(stencil_op)
            .back(stencil_op)
            .min_depth_bounds(0.0)
            .max_depth_bounds(1.0);

        // Rasterization state with depth bias enabled.
        let rasterization_info = vk::PipelineRasterizationStateCreateInfo::builder()
            .depth_clamp_enable(false)
            .rasterizer_discard_enable(false)
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::CLOCKWISE)
            .depth_bias_enable(true)
            .depth_bias_constant_factor(0.0)
            .depth_bias_clamp(0.0)
            .depth_bias_slope_factor(0.0)
            .line_width(1.0);

        let multisample_state =
            vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
        let blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&blend_attachments);

        // Dynamic state.
        let dynamic_states = [vk::DynamicState::DEPTH_BIAS];
        let dynamic_state_info = vk::PipelineDynamicStateCreateInfo::builder().dynamic_states(&dynamic_states);

        let stages = [
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(if mesh {
                    vk::ShaderStageFlags::MESH_EXT
                } else {
                    vk::ShaderStageFlags::VERTEX
                })
                .module(*vert_module)
                .name(b"main\0")
                .build(),
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(*frag_module)
                .name(b"main\0")
                .build(),
        ];
        let mut pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization_info)
            .multisample_state(&multisample_state)
            .depth_stencil_state(&depth_stencil_state_info)
            .color_blend_state(&color_blend_state)
            .dynamic_state(&dynamic_state_info)
            .layout(*pipeline_layout)
            .render_pass(*render_pass)
            .subpass(0)
            .base_pipeline_index(0);
        // A pipeline with a mesh shader has no vertex input or input assembly state.
        if !mesh {
            pipeline_info = pipeline_info
                .vertex_input_state(&vertex_input_info)
                .input_assembly_state(&input_assembly_state);
        }
        let pipeline = create_graphics_pipeline(device, &pipeline_info)?;

        // Command pool and buffer.
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        // Clear colors.
        let clear_values = [
            vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: [0.0, 0.0, 0.0, 1.0],
                },
            },
            vk::ClearValue {
                depth_stencil: vk::ClearDepthStencilValue { depth: 0.0, stencil: 0 },
            },
        ];

        begin_command_buffer(device, cmd)?;
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(scissors[0])
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_set_depth_bias(cmd, params.depth_bias_constant, params.depth_bias_clamp, 0.0);
            let pc_bytes = std::slice::from_raw_parts(
                (&pc_data as *const DepthBiasNonZeroPushConstants).cast::<u8>(),
                pc_data_size as usize,
            );
            device.cmd_push_constants(cmd, *pipeline_layout, pc_stages, 0, pc_bytes);
            if mesh {
                use vulkanalia::vk::ExtMeshShaderExtensionDeviceCommands;
                device.cmd_draw_mesh_tasks_ext(cmd, 1, 1, 1);
            } else {
                device.cmd_draw(cmd, 3, 1, 0, 0);
            }
            device.cmd_end_render_pass(cmd);
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        // Check color buffer contents.
        let color_pixels = read_rgba8_image(
            context,
            color_buffer.get(),
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            extent.width,
            extent.height,
        )?;
        if color_pixels
            .chunks_exact(4)
            .any(|pixel| pixel != DepthBiasNonZeroCase::EXPECTED_COLOR)
        {
            return Ok(TestStatus::fail("Unexpected color buffer value; check log for details"));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `DynamicStateRSTests`
pub fn create_rs_state_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("rs_state");

    group.add_child(Box::new(StateTestCase {
        name: "depth_bias",
        programs: VERTEX_FETCH.programs,
        support: check_nothing,
        run: depth_bias_run,
    }) as Box<dyn TestCase>);
    group.add_child(
        Box::new(crate::vkt::tests::dynamic_state::base_class::MeshStateTestCase {
            programs: crate::generated::shaders::dynamic_state_vertex_fetch::VERTEX_FETCH_MESH.programs,
            name: "depth_bias_mesh",
            support: check_nothing,
            run: depth_bias_run,
        }) as Box<dyn TestCase>,
    );
    group.add_child(Box::new(StateTestCase {
        name: "depth_bias_clamp",
        programs: VERTEX_FETCH.programs,
        support: check_depth_bias_clamp_support,
        run: depth_bias_clamp_run,
    }) as Box<dyn TestCase>);
    group.add_child(
        Box::new(crate::vkt::tests::dynamic_state::base_class::MeshStateTestCase {
            programs: crate::generated::shaders::dynamic_state_vertex_fetch::VERTEX_FETCH_MESH.programs,
            name: "depth_bias_clamp_mesh",
            support: check_depth_bias_clamp_support,
            run: depth_bias_clamp_run,
        }) as Box<dyn TestCase>,
    );
    // Draw a line with width set to max defined by physical device
    group.add_child(
        Box::new(crate::vkt::tests::dynamic_state::base_class::MeshStateTestCase {
            programs: crate::generated::shaders::dynamic_state_vertex_fetch::VERTEX_FETCH_LINES_MESH.programs,
            name: "line_width_mesh",
            support: check_wide_lines_support,
            run: line_width_run,
        }) as Box<dyn TestCase>,
    );
    group.add_child(Box::new(StateTestCase {
        name: "line_width",
        programs: VERTEX_FETCH.programs,
        support: check_wide_lines_support,
        run: line_width_run,
    }) as Box<dyn TestCase>);

    for mesh in [false, true] {
        let constant_name: &'static str = if mesh {
            "nonzero_depth_bias_constant_mesh"
        } else {
            "nonzero_depth_bias_constant"
        };
        let clamp_name: &'static str = if mesh {
            "nonzero_depth_bias_clamp_mesh"
        } else {
            "nonzero_depth_bias_clamp"
        };
        group.add_child(Box::new(DepthBiasNonZeroCase {
            name: constant_name,
            params: DepthBiasNonZeroParams {
                depth_bias_constant: 16384.0,
                depth_bias_clamp: 0.0,
                push_constants: DepthBiasNonZeroPushConstants {
                    geometry_depth: 0.375,
                    min_depth: 0.5,
                    max_depth: 1.0,
                },
            },
            mesh,
        }) as Box<dyn TestCase>);
        group.add_child(Box::new(DepthBiasNonZeroCase {
            name: clamp_name,
            params: DepthBiasNonZeroParams {
                depth_bias_constant: 16384.0,
                depth_bias_clamp: 0.125,
                push_constants: DepthBiasNonZeroPushConstants {
                    geometry_depth: 0.375,
                    min_depth: 0.46875,
                    max_depth: 0.53125,
                },
            },
            mesh,
        }) as Box<dyn TestCase>);
    }

    group
}
