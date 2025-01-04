// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineVertexInputSRGBTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The device always enables VK_KHR_maintenance10's feature when the
// extension exists, so the "strict" cases do not need upstream's `DevCaps` device.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::pipeline_vertex_input_srgb::{
    SRGB_VERTEX_W, SRGB_VERTEX_X, SRGB_VERTEX_Y, SRGB_VERTEX_Z,
};
use crate::tcu::pixel::linear_channel_to_srgb;
use crate::tcu::{Random, TestError, TestOutcome, TestResult, TestStatus};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool, make_framebuffer, make_pipeline_layout};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, make_color_render_pass, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::pipeline::shader_object_draw::{begin_draw, end_draw, make_shader_objects};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const EXTENT: u32 = 16;
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const CLEAR_COLOR: [f32; 4] = [0.0, 0.0, 0.0, 1.0];

/// `SRGBVertexInputParams`
#[derive(Clone, Copy)]
struct SrgbVertexInputParams {
    format: vk::Format,
    /// 0, 1, 2, 3 == R, G, B, A
    component: u32,
    strict: bool,
}

impl SrgbVertexInputParams {
    fn random_seed(&self) -> u32 {
        ((self.format.as_raw() as u32) << 2) | self.component
    }

    /// `tcu::getNumUsedChannels(mapVkFormat(format).order)`
    fn component_count(&self) -> u32 {
        format_component_count(self.format)
    }
}

fn format_component_count(format: vk::Format) -> u32 {
    match format {
        vk::Format::R8_SRGB => 1,
        vk::Format::R8G8_SRGB => 2,
        vk::Format::R8G8B8_SRGB | vk::Format::B8G8R8_SRGB => 3,
        _ => 4,
    }
}

struct SrgbVertexInputCase {
    name: String,
    params: SrgbVertexInputParams,
}

impl TestCase for SrgbVertexInputCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `SRGBVertexInputCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.params.strict {
            context.require_device_functionality("VK_KHR_maintenance10")?;
        }

        let format_properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), self.params.format)
        };
        if !format_properties
            .buffer_features
            .contains(vk::FormatFeatureFlags::VERTEX_BUFFER)
        {
            return Err(TestError::NotSupported(
                "Format not supported for vertex buffers".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.params.component {
            0 => SRGB_VERTEX_X.programs,
            1 => SRGB_VERTEX_Y.programs,
            2 => SRGB_VERTEX_Z.programs,
            _ => SRGB_VERTEX_W.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SrgbVertexInputInstance {
            context,
            params: self.params,
        })
    }
}

struct SrgbVertexInputInstance<'a> {
    context: &'a Context<'a>,
    params: SrgbVertexInputParams,
}

/// `prepareVertexBufferContents`: the values wanted for the tested component, laid out the way the format stores them.
fn prepare_vertex_buffer_contents(format: vk::Format, tested_component: u32, component_values: &[f32]) -> Vec<u8> {
    const PADDING_BYTE: u8 = 255;
    let format_component_count = format_component_count(format);
    let mut contents = Vec::with_capacity((format_component_count as usize) * component_values.len());

    let float_to_u8 = |v: f32| (v * 255.0) as u8;

    let mut component_index = tested_component;
    if matches!(format, vk::Format::B8G8R8_SRGB | vk::Format::B8G8R8A8_SRGB) && tested_component < 3 {
        // Reverse RGB component order.
        component_index = 2 - tested_component;
    }

    // Add each value to the vector with padding bytes for the unused components.
    for &component_value in component_values {
        let u8_value = float_to_u8(component_value);
        contents.resize(contents.len() + component_index as usize, PADDING_BYTE);
        contents.push(u8_value);
        contents.resize(
            contents.len() + (format_component_count - (component_index + 1)) as usize,
            PADDING_BYTE,
        );
    }
    contents
}

impl SrgbVertexInputInstance<'_> {
    /// `SRGBVertexInputInstance::runWithCoords`
    fn run_with_coords(&self, coords: &[f32], expected_covered_rows: u32) -> Result<bool, TestError> {
        let context = self.context;
        let device = context.get_device();
        let vert_buffer_data = prepare_vertex_buffer_contents(self.params.format, self.params.component, coords);
        let vert_buffer = create_host_buffer(context, &vert_buffer_data, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // Framebuffer: it can't be 2x2 or something small because we want to see some detail about extra pixels colored if
        // linearization does not happen.
        let color_buffer = ImageWithBuffer::new(
            context,
            EXTENT,
            EXTENT,
            COLOR_FORMAT,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            4,
        )?;

        let mut state =
            DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP).with_full_viewport(EXTENT, EXTENT);
        state.bindings = vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: self.params.component_count(),
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        state.attributes = vec![vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: self.params.format,
            offset: 0,
        }];
        state.rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .line_width(1.0)
            .build();

        let render_pass = make_color_render_pass(
            device,
            COLOR_FORMAT,
            vk::AttachmentLoadOp::CLEAR,
            vk::AttachmentStoreOp::STORE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], EXTENT, EXTENT, 1)?;

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let shader_objects = make_shader_objects(context, "vert", Some("frag"), &[], &[])?;
        let pipeline = if shader_objects.is_none() {
            Some(create_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &[
                    (vk::ShaderStageFlags::VERTEX, *vert_module),
                    (vk::ShaderStageFlags::FRAGMENT, *frag_module),
                ],
                &state,
            )?)
        } else {
            None
        };

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        let clear_values = [clear_value_color(CLEAR_COLOR)];
        begin_draw(
            device,
            cmd,
            shader_objects.as_ref(),
            &state,
            pipeline.as_ref().map(|pipeline| pipeline.get()),
            *render_pass,
            *framebuffer,
            rect_2d(EXTENT, EXTENT),
            &clear_values,
            &[(color_buffer.image.get(), *color_buffer.view)],
        );
        unsafe {
            device.cmd_bind_vertex_buffers(cmd, 0, &[vert_buffer.get()], &[0]);
            device.cmd_draw(cmd, coords.len() as u32, 1, 0, 0);
        }
        end_draw(device, cmd, shader_objects.is_some());
        copy_image_to_buffer(
            device,
            cmd,
            color_buffer.image.get(),
            color_buffer.buffer.get(),
            EXTENT,
            EXTENT,
        );
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        // Check that the top rows are filled and the rest is not.
        let result = color_buffer.read_bytes(device)?;
        let geom_color = [0u8, 0, 255, 255];
        let clear_color = [0u8, 0, 0, 255];
        for y in 0..EXTENT {
            let expected = if y < expected_covered_rows {
                geom_color
            } else {
                clear_color
            };
            for x in 0..EXTENT {
                let offset = ((y * EXTENT + x) * 4) as usize;
                if result[offset..offset + 4] != expected {
                    return Ok(false);
                }
            }
        }
        Ok(true)
    }
}

impl TestInstance for SrgbVertexInputInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let mut rnd = Random::new(self.params.random_seed());
        let covered_rows = rnd.get_int(1, EXTENT as i32 - 2) as u32;
        let y_coord = covered_rows as f32 / EXTENT as f32;

        let wanted_y_coords = [0.0f32, y_coord, 0.0, y_coord];

        // Run 0: expect linearization, so convert to RGB first. Alpha must not be linearized.
        let used_coords: Vec<f32> = if self.params.component < 3 {
            wanted_y_coords
                .iter()
                .map(|&coord| linear_channel_to_srgb(coord))
                .collect()
        } else {
            wanted_y_coords.to_vec()
        };
        if self.run_with_coords(&used_coords, covered_rows)? {
            return Ok(TestStatus::pass("Pass"));
        }

        // Strict mode did not work.
        if self.params.strict {
            return Err(TestError::Fail("Vertex coordinates have unexpected values".to_string()));
        }

        if !self.run_with_coords(&wanted_y_coords, covered_rows)? {
            return Err(TestError::Fail("Vertex coordinates have unexpected values".to_string()));
        }

        Ok(TestStatus::new(
            TestResult::QualityWarning,
            "sRGB vertex coordinates are not linearized",
        ))
    }
}

/// `createVertexInputSRGBTests`
pub fn create_vertex_input_srgb_tests() -> TestCaseGroup {
    let tested_formats = [
        (vk::Format::R8_SRGB, "r8_srgb"),
        (vk::Format::R8G8_SRGB, "r8g8_srgb"),
        (vk::Format::R8G8B8_SRGB, "r8g8b8_srgb"),
        (vk::Format::B8G8R8_SRGB, "b8g8r8_srgb"),
        (vk::Format::R8G8B8A8_SRGB, "r8g8b8a8_srgb"),
        (vk::Format::B8G8R8A8_SRGB, "b8g8r8a8_srgb"),
    ];

    let mut main_group = TestCaseGroup::new("srgb_vertex_formats");
    for (format, group_name) in tested_formats {
        let mut format_group = TestCaseGroup::new(group_name);
        for tested_component in 0..4u32 {
            if tested_component >= format_component_count(format) {
                continue;
            }
            for strict in [false, true] {
                let params = SrgbVertexInputParams {
                    format,
                    component: tested_component,
                    strict,
                };
                let test_name = format!(
                    "{}{}",
                    ["r", "g", "b", "a"][tested_component as usize],
                    if strict { "_strict" } else { "" }
                );
                format_group.add_child(Box::new(SrgbVertexInputCase {
                    name: test_name,
                    params,
                }) as Box<dyn TestCase>);
            }
        }
        main_group.add_child(format_group);
    }
    main_group
}
