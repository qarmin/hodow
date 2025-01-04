// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineDynamicControlPoints.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtExtendedDynamicState2ExtensionDeviceCommands, InstanceV1_1};

use crate::generated::shaders::pipeline_dynamic_control_points::{
    DYNAMIC_CONTROL_POINTS_CHANGE_OUTPUT, DYNAMIC_CONTROL_POINTS_CHANGE_OUTPUT_WINDING,
    DYNAMIC_CONTROL_POINTS_CHANGE_WINDING,
};
use crate::tcu::image_compare::float_threshold_compare;
use crate::tcu::pixel::{ConstPixelBufferAccess, TextureLevel};
use crate::tcu::{ChannelOrder, ChannelType, TestError, TestOutcome, TestStatus, TextureFormat};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool, make_framebuffer, make_pipeline_layout};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, make_color_render_pass, rect_2d,
    viewport,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::pipeline::shader_object_draw::{begin_draw, end_draw, make_shader_objects_stages};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `TestConfig`, with the construction type left out: only monolithic pipelines are built.
#[derive(Clone, Copy)]
struct TestConfig {
    change_output: bool,
    first_clockwise: bool,
    cull_mode: vk::CullModeFlags,
    expected_first: [f32; 4],
    expected_second: [f32; 4],
}

struct DynamicControlPointsTestCase {
    name: &'static str,
    config: TestConfig,
}

impl TestCase for DynamicControlPointsTestCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `DynamicControlPointsTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if context.get_device_features().tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requires VkPhysicalDeviceFeatures::tessellationShader".to_string(),
            ));
        }

        let mut eds2_features = vk::PhysicalDeviceExtendedDynamicState2FeaturesEXT::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut eds2_features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
        if eds2_features.extended_dynamic_state2_patch_control_points == vk::FALSE {
            return Err(TestError::NotSupported(
                "Dynamic patch control points aren't supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match (self.config.change_output, self.config.first_clockwise) {
            (true, false) => DYNAMIC_CONTROL_POINTS_CHANGE_OUTPUT.programs,
            (false, true) => DYNAMIC_CONTROL_POINTS_CHANGE_WINDING.programs,
            _ => DYNAMIC_CONTROL_POINTS_CHANGE_OUTPUT_WINDING.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DynamicControlPointsTestInstance {
            context,
            config: self.config,
        })
    }
}

struct DynamicControlPointsTestInstance<'a> {
    context: &'a Context<'a>,
    config: TestConfig,
}

impl TestInstance for DynamicControlPointsTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let config = self.config;
        let device = context.get_device();
        let image_format = vk::Format::R8G8B8A8_UNORM;
        const WIDTH: u32 = 4;
        const HEIGHT: u32 = 4;
        let mapped_format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);

        let color_buffer = ImageWithBuffer::new(
            context,
            WIDTH,
            HEIGHT,
            image_format,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            4,
        )?;
        let render_pass = make_color_render_pass(
            device,
            image_format,
            vk::AttachmentLoadOp::CLEAR,
            vk::AttachmentStoreOp::STORE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], WIDTH, HEIGHT, 1)?;

        let viewport_left = viewport(0.0, 0.0, WIDTH as f32 / 2.0, HEIGHT as f32, 0.0, 1.0);
        let viewport_right = viewport(WIDTH as f32 / 2.0, 0.0, WIDTH as f32 / 2.0, HEIGHT as f32, 0.0, 1.0);
        let scissors_left = vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: WIDTH / 2,
                height: HEIGHT,
            },
        };
        let scissors_right = vk::Rect2D {
            offset: vk::Offset2D {
                x: (WIDTH / 2) as i32,
                y: 0,
            },
            extent: vk::Extent2D {
                width: WIDTH / 2,
                height: HEIGHT,
            },
        };
        let graphics_pipeline_layout = make_pipeline_layout(device, &[])?;

        let binaries = context.get_binary_collection();
        let vtx_shader = create_shader_module(device, binaries.get("vert")?)?;
        let frg_shader = create_shader_module(device, binaries.get("frag")?)?;
        let tsc_shader1 = create_shader_module(device, binaries.get("tesc")?)?;
        let tsc_shader2 = create_shader_module(
            device,
            binaries.get(if config.change_output { "tesc2" } else { "tesc" })?,
        )?;
        let tse_shader1 = create_shader_module(device, binaries.get("tese")?)?;
        let tse_shader2 = create_shader_module(device, binaries.get("tese2")?)?;

        let make_state = |viewport: vk::Viewport, scissor: vk::Rect2D| {
            let mut state = DrawPipelineState::new(vk::PrimitiveTopology::PATCH_LIST);
            state.viewports = vec![viewport];
            state.scissors = vec![scissor];
            state.dynamic_states = vec![vk::DynamicState::PATCH_CONTROL_POINTS_EXT];
            state.rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
                .polygon_mode(vk::PolygonMode::FILL)
                .cull_mode(config.cull_mode)
                .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
                .line_width(1.0)
                .build();
            // Ignored by the draw: the count is dynamic state.
            state.patch_control_points = Some(3);
            state
        };

        let state_left = make_state(viewport_left, scissors_left);
        let state_right = make_state(viewport_right, scissors_right);
        let (tesc2, tese2) = (if config.change_output { "tesc2" } else { "tesc" }, "tese2");
        let shader_objects = [
            make_shader_objects_stages(
                context,
                &[
                    (vk::ShaderStageFlags::VERTEX, "vert"),
                    (vk::ShaderStageFlags::TESSELLATION_CONTROL, "tesc"),
                    (vk::ShaderStageFlags::TESSELLATION_EVALUATION, "tese"),
                    (vk::ShaderStageFlags::FRAGMENT, "frag"),
                ],
                &[],
                &[],
            )?,
            make_shader_objects_stages(
                context,
                &[
                    (vk::ShaderStageFlags::VERTEX, "vert"),
                    (vk::ShaderStageFlags::TESSELLATION_CONTROL, tesc2),
                    (vk::ShaderStageFlags::TESSELLATION_EVALUATION, tese2),
                    (vk::ShaderStageFlags::FRAGMENT, "frag"),
                ],
                &[],
                &[],
            )?,
        ];
        let (pipeline1, pipeline2) = if shader_objects[0].is_none() {
            let pipeline1 = create_draw_pipeline(
                device,
                *graphics_pipeline_layout,
                *render_pass,
                &[
                    (vk::ShaderStageFlags::VERTEX, *vtx_shader),
                    (vk::ShaderStageFlags::TESSELLATION_CONTROL, *tsc_shader1),
                    (vk::ShaderStageFlags::TESSELLATION_EVALUATION, *tse_shader1),
                    (vk::ShaderStageFlags::FRAGMENT, *frg_shader),
                ],
                &state_left,
            )?;
            let pipeline2 = create_draw_pipeline(
                device,
                *graphics_pipeline_layout,
                *render_pass,
                &[
                    (vk::ShaderStageFlags::VERTEX, *vtx_shader),
                    (vk::ShaderStageFlags::TESSELLATION_CONTROL, *tsc_shader2),
                    (vk::ShaderStageFlags::TESSELLATION_EVALUATION, *tse_shader2),
                    (vk::ShaderStageFlags::FRAGMENT, *frg_shader),
                ],
                &state_right,
            )?;
            (Some(pipeline1), Some(pipeline2))
        } else {
            (None, None)
        };

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let command_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        let clear_values = [clear_value_color([1.0, 1.0, 1.0, 1.0])];
        let render_area = rect_2d(WIDTH, HEIGHT);

        // render 2 triangles with each pipeline, covering the entire screen
        // depending on the test settings one of them might be culled
        begin_command_buffer(device, *command_buffer)?;
        begin_draw(
            device,
            *command_buffer,
            shader_objects[0].as_ref(),
            &state_left,
            None,
            *render_pass,
            *framebuffer,
            render_area,
            &clear_values,
            &[(color_buffer.image.get(), *color_buffer.view)],
        );
        unsafe {
            device.cmd_set_patch_control_points_ext(*command_buffer, 3);
            if let Some(pipeline1) = &pipeline1 {
                device.cmd_bind_pipeline(*command_buffer, vk::PipelineBindPoint::GRAPHICS, **pipeline1);
            }
            device.cmd_draw(*command_buffer, 6, 1, 0, 0);
            if let Some(shader_objects) = &shader_objects[1] {
                shader_objects.bind(*command_buffer, &state_right);
            } else if let Some(pipeline2) = &pipeline2 {
                device.cmd_bind_pipeline(*command_buffer, vk::PipelineBindPoint::GRAPHICS, **pipeline2);
            }
            device.cmd_draw(*command_buffer, 6, 1, 0, 0);
        }
        end_draw(device, *command_buffer, shader_objects[0].is_some());
        copy_image_to_buffer(
            device,
            *command_buffer,
            color_buffer.image.get(),
            color_buffer.buffer.get(),
            WIDTH,
            HEIGHT,
        );
        end_command_buffer(device, *command_buffer)?;
        submit_commands_and_wait(device, context.get_universal_queue(), *command_buffer)?;

        let out_pixels =
            ConstPixelBufferAccess::new(mapped_format, [WIDTH, HEIGHT, 1], color_buffer.read_bytes(device)?);

        let mut reference_level = TextureLevel::new(mapped_format, WIDTH, HEIGHT, 1)?;
        {
            let mut reference = reference_level.get_access();
            for y in 0..HEIGHT {
                for x in 0..WIDTH {
                    reference.set_pixel(
                        if x < WIDTH / 2 {
                            config.expected_first
                        } else {
                            config.expected_second
                        },
                        x,
                        y,
                        0,
                    );
                }
            }
        }

        if !float_threshold_compare(&reference_level.get_const_access(), &out_pixels, [0.0; 4]).ok {
            return Ok(TestStatus::fail(
                "Color output does not match reference, image added to log",
            ));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createDynamicControlPointTests`
pub fn create_dynamic_control_point_tests() -> TestCaseGroup {
    // Tests checking dynamic bind points and switching pipelines
    let mut group = TestCaseGroup::new("dynamic_control_points");

    // test switching pipelines with dynamic control points while changing the number of tcs invocations
    group.add_child(Box::new(DynamicControlPointsTestCase {
        name: "change_output",
        config: TestConfig {
            change_output: true,
            first_clockwise: false,
            cull_mode: vk::CullModeFlags::NONE,
            expected_first: [1.0, 0.0, 1.0, 1.0],
            expected_second: [1.0, 0.0, 1.0, 1.0],
        },
    }) as Box<dyn TestCase>);

    // test switching pipelines with dynamic control points while switching winding
    group.add_child(Box::new(DynamicControlPointsTestCase {
        name: "change_winding",
        config: TestConfig {
            change_output: false,
            first_clockwise: true,
            cull_mode: vk::CullModeFlags::FRONT,
            expected_first: [1.0, 1.0, 1.0, 1.0],
            expected_second: [1.0, 0.0, 1.0, 1.0],
        },
    }) as Box<dyn TestCase>);

    // test switching pipelines with dynamic control points while switching winding and number of tcs invocations
    group.add_child(Box::new(DynamicControlPointsTestCase {
        name: "change_output_winding",
        config: TestConfig {
            change_output: true,
            first_clockwise: true,
            cull_mode: vk::CullModeFlags::FRONT,
            expected_first: [1.0, 1.0, 1.0, 1.0],
            expected_second: [1.0, 0.0, 1.0, 1.0],
        },
    }) as Box<dyn TestCase>);
    group
}
