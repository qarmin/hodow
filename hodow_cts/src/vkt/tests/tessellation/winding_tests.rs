// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/tessellation/vktTessellationWindingTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `hlsl_*` programs are compiled by glslang's HLSL front end (`hlsl_*` stages of the manifest).
//
// These tests correspond to dEQP-GLES31.functional.tessellation.winding.*

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::tessellation_winding::{
    WINDING_HLSL_QUADS_CCW, WINDING_HLSL_QUADS_CW, WINDING_HLSL_TRIANGLES_CCW, WINDING_HLSL_TRIANGLES_CW,
    WINDING_QUADS_CCW, WINDING_QUADS_CW, WINDING_TRIANGLES_CCW, WINDING_TRIANGLES_CW,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{make_image_memory_barrier, make_image_subresource_range};
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool, make_framebuffer, make_pipeline_layout};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, make_color_render_pass, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum TessPrimitiveType {
    Triangles,
    Quads,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Winding {
    Ccw,
    Cw,
}

/// `getCaseName`
fn get_case_name(primitive_type: TessPrimitiveType, hlsl: bool, winding: Winding, y_flip: bool) -> String {
    let primitive_name = if primitive_type == TessPrimitiveType::Triangles {
        "triangles"
    } else {
        "quads"
    };
    let winding_name = if winding == Winding::Ccw { "ccw" } else { "cw" };
    format!(
        "{}_{primitive_name}_{winding_name}{}",
        if hlsl { "hlsl" } else { "glsl" },
        if y_flip { "_yflip" } else { "" }
    )
}

/// Returns true when the image passes the verification.
fn verify_result_image(
    image: &[u8],
    width: u32,
    height: u32,
    primitive_type: TessPrimitiveType,
    domain_origin: vk::TessellationDomainOrigin,
    winding: Winding,
    y_flip: bool,
    front_face_winding: Winding,
) -> bool {
    let expect_visible_primitive =
        ((front_face_winding == winding) == (domain_origin == vk::TessellationDomainOrigin::UPPER_LEFT)) != y_flip;
    let total_num_pixels = (width * height) as i64;
    let white = [255u8, 255, 255, 255];
    let red = [255u8, 0, 0, 255];
    let pixel = |x: u32, y: u32| &image[((y * width + x) * 4) as usize..((y * width + x) * 4 + 4) as usize];

    // Count red and white pixels
    let mut num_white_pixels = 0i64;
    let mut num_red_pixels = 0i64;
    for y in 0..height {
        for x in 0..width {
            num_white_pixels += i64::from(pixel(x, y) == white);
            num_red_pixels += i64::from(pixel(x, y) == red);
        }
    }

    debug_assert!(num_white_pixels + num_red_pixels <= total_num_pixels);

    if total_num_pixels - num_white_pixels - num_red_pixels > 0 {
        // Failure: other than white or red pixels
        return false;
    }

    if expect_visible_primitive {
        if primitive_type == TessPrimitiveType::Triangles {
            let bad_pixel_tolerance = 5 * i64::from(width.max(height));

            if (num_white_pixels - total_num_pixels / 2).abs() > bad_pixel_tolerance {
                // Failure: wrong number of white pixels; expected approximately half
                return false;
            }

            // Check number of filled pixels (from left) in top and bottom rows to determine if triangle is in right orientation.
            let expected_start = (0i64, 1i64);
            let expected_end = (i64::from(width) - 1, i64::from(width));
            let expected_top = if y_flip { expected_start } else { expected_end };
            let expected_bottom = if y_flip { expected_end } else { expected_start };

            let num_top_filled = (0..width).take_while(|&x| pixel(x, 0) == white).count() as i64;
            let num_bottom_filled = (0..width).take_while(|&x| pixel(x, height - 1) == white).count() as i64;

            let in_bounds = |value: i64, (low, high): (i64, i64)| value >= low && value < high;
            if !in_bounds(num_top_filled, expected_top) || !in_bounds(num_bottom_filled, expected_bottom) {
                // Failure: triangle orientation is incorrect
                return false;
            }
        } else if num_white_pixels != total_num_pixels {
            // Failure: expected only white pixels (full-viewport quad)
            return false;
        }
    } else if num_white_pixels != 0 {
        // Failure: expected only red pixels (everything culled)
        return false;
    }

    true
}

struct WindingTest {
    name: String,
    primitive_type: TessPrimitiveType,
    hlsl: bool,
    domain_origin: Option<vk::TessellationDomainOrigin>,
    winding: Winding,
    y_flip: bool,
}

impl TestCase for WindingTest {
    fn name(&self) -> &str {
        &self.name
    }

    /// `WindingTest::createInstance`'s `requireFeatures`, and the extensions the instance constructor requires
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if context.get_device_features().tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requires VkPhysicalDeviceFeatures::tessellationShader".to_string(),
            ));
        }
        if self.y_flip {
            context.require_device_functionality("VK_KHR_maintenance1")?;
        }
        if self.domain_origin.is_some() {
            context.require_device_functionality("VK_KHR_maintenance2")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match (self.hlsl, self.primitive_type, self.winding) {
            (false, TessPrimitiveType::Triangles, Winding::Ccw) => WINDING_TRIANGLES_CCW.programs,
            (false, TessPrimitiveType::Triangles, Winding::Cw) => WINDING_TRIANGLES_CW.programs,
            (false, TessPrimitiveType::Quads, Winding::Ccw) => WINDING_QUADS_CCW.programs,
            (false, TessPrimitiveType::Quads, Winding::Cw) => WINDING_QUADS_CW.programs,
            (true, TessPrimitiveType::Triangles, Winding::Ccw) => WINDING_HLSL_TRIANGLES_CCW.programs,
            (true, TessPrimitiveType::Triangles, Winding::Cw) => WINDING_HLSL_TRIANGLES_CW.programs,
            (true, TessPrimitiveType::Quads, Winding::Ccw) => WINDING_HLSL_QUADS_CCW.programs,
            (true, TessPrimitiveType::Quads, Winding::Cw) => WINDING_HLSL_QUADS_CW.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(WindingTestInstance {
            context,
            primitive_type: self.primitive_type,
            domain_origin: self.domain_origin,
            winding: self.winding,
            y_flip: self.y_flip,
        })
    }
}

struct WindingTestInstance<'a> {
    context: &'a Context<'a>,
    primitive_type: TessPrimitiveType,
    domain_origin: Option<vk::TessellationDomainOrigin>,
    winding: Winding,
    y_flip: bool,
}

impl TestInstance for WindingTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();

        // Color attachment, and the buffer its image is copied to for verification
        const RENDER_SIZE: u32 = 64;
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let color_buffer = ImageWithBuffer::new(
            context,
            RENDER_SIZE,
            RENDER_SIZE,
            color_format,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            4,
        )?;
        let color_image_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        // Pipeline
        let render_pass = make_color_render_pass(
            device,
            color_format,
            vk::AttachmentLoadOp::CLEAR,
            vk::AttachmentStoreOp::STORE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], RENDER_SIZE, RENDER_SIZE, 1)?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let tesc_module = create_shader_module(device, binaries.get("tesc")?)?;
        let tese_module = create_shader_module(device, binaries.get("tese")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let stages = [
            (vk::ShaderStageFlags::VERTEX, *vert_module),
            (vk::ShaderStageFlags::TESSELLATION_CONTROL, *tesc_module),
            (vk::ShaderStageFlags::TESSELLATION_EVALUATION, *tese_module),
            (vk::ShaderStageFlags::FRAGMENT, *frag_module),
        ];

        // Front face is static state, so we have to create two pipelines.
        let make_pipeline = |front_face: vk::FrontFace| {
            let mut state = DrawPipelineState::new(vk::PrimitiveTopology::PATCH_LIST);
            state.dynamic_states = vec![vk::DynamicState::VIEWPORT, vk::DynamicState::SCISSOR];
            state.rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
                .polygon_mode(vk::PolygonMode::FILL)
                .cull_mode(vk::CullModeFlags::BACK)
                .front_face(front_face)
                .line_width(1.0)
                .build();
            state.patch_control_points = Some(1);
            state.tessellation_domain_origin = self.domain_origin;
            create_draw_pipeline(device, *pipeline_layout, *render_pass, &stages, &state)
        };
        let pipeline_counter_clockwise = make_pipeline(vk::FrontFace::COUNTER_CLOCKWISE)?;
        let pipeline_clockwise = make_pipeline(vk::FrontFace::CLOCKWISE)?;

        let test_cases = [
            (Winding::Ccw, *pipeline_counter_clockwise),
            (Winding::Cw, *pipeline_clockwise),
        ];

        let mut success = true;

        // Draw commands
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        for (case_ndx, &(front_face_winding, pipeline)) in test_cases.iter().enumerate() {
            // Reset the command buffer and begin.
            begin_command_buffer(device, *cmd_buffer)?;

            // Change color attachment image layout
            {
                // State is slightly different on the first iteration.
                let current_layout = if case_ndx == 0 {
                    vk::ImageLayout::UNDEFINED
                } else {
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL
                };
                let src_flags = if case_ndx == 0 {
                    vk::AccessFlags::empty()
                } else {
                    vk::AccessFlags::TRANSFER_READ
                };

                let color_attachment_layout_barrier = make_image_memory_barrier(
                    src_flags,
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    current_layout,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    color_buffer.image.get(),
                    color_image_subresource_range,
                );

                unsafe {
                    device.cmd_pipeline_barrier(
                        *cmd_buffer,
                        vk::PipelineStageFlags::TOP_OF_PIPE | vk::PipelineStageFlags::TRANSFER,
                        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[color_attachment_layout_barrier],
                    );
                }
            }

            // Begin render pass
            let render_area = rect_2d(RENDER_SIZE, RENDER_SIZE);
            let clear_values = [clear_value_color([1.0, 0.0, 0.0, 1.0])];
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(render_area)
                .clear_values(&clear_values);

            let size = RENDER_SIZE as f32;
            let viewport = vk::Viewport {
                x: 0.0,
                y: if self.y_flip { size } else { 0.0 },
                width: size,
                height: if self.y_flip { -size } else { size },
                min_depth: 0.0,
                max_depth: 1.0,
            };

            unsafe {
                device.cmd_begin_render_pass(*cmd_buffer, &begin_info, vk::SubpassContents::INLINE);
                device.cmd_set_viewport(*cmd_buffer, 0, &[viewport]);
                device.cmd_set_scissor(*cmd_buffer, 0, &[render_area]);
                device.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::GRAPHICS, pipeline);

                // Process a single abstract vertex.
                device.cmd_draw(*cmd_buffer, 1, 1, 0, 0);
                device.cmd_end_render_pass(*cmd_buffer);
            }

            // Copy render result to a host-visible buffer
            copy_image_to_buffer(
                device,
                *cmd_buffer,
                color_buffer.image.get(),
                color_buffer.buffer.get(),
                RENDER_SIZE,
                RENDER_SIZE,
            );
            end_command_buffer(device, *cmd_buffer)?;
            submit_commands_and_wait(device, queue, *cmd_buffer)?;

            // Verify case result
            let image_pixel_access = color_buffer.read_bytes(device)?;
            let domain_origin = self.domain_origin.unwrap_or(vk::TessellationDomainOrigin::UPPER_LEFT);
            success = verify_result_image(
                image_pixel_access,
                RENDER_SIZE,
                RENDER_SIZE,
                self.primitive_type,
                domain_origin,
                self.winding,
                self.y_flip,
                front_face_winding,
            ) && success;
        }

        Ok(if success {
            TestStatus::pass("OK")
        } else {
            TestStatus::fail("Failure")
        })
    }
}

/// `populateWindingGroup`
fn populate_winding_group(group: &mut TestCaseGroup, domain_origin: Option<vk::TessellationDomainOrigin>) {
    for primitive_type in [TessPrimitiveType::Triangles, TessPrimitiveType::Quads] {
        for hlsl in [false, true] {
            for winding in [Winding::Ccw, Winding::Cw] {
                for y_flip in [false, true] {
                    let name = get_case_name(primitive_type, hlsl, winding, y_flip);
                    group.add_child(Box::new(WindingTest {
                        name,
                        primitive_type,
                        hlsl,
                        domain_origin,
                        winding,
                        y_flip,
                    }) as Box<dyn TestCase>);
                }
            }
        }
    }
}

/// `createWindingTests`
pub fn create_winding_tests() -> TestCaseGroup {
    // Test the cw and ccw input layout qualifiers
    let mut group = TestCaseGroup::new("winding");

    // No tessellation domain specified
    let mut default_domain = TestCaseGroup::new("default_domain");
    populate_winding_group(&mut default_domain, None);
    group.add_child(default_domain);

    // Lower left tessellation domain
    let mut lower_left_domain = TestCaseGroup::new("lower_left_domain");
    populate_winding_group(&mut lower_left_domain, Some(vk::TessellationDomainOrigin::LOWER_LEFT));
    group.add_child(lower_left_domain);

    // Upper left tessellation domain
    let mut upper_left_domain = TestCaseGroup::new("upper_left_domain");
    populate_winding_group(&mut upper_left_domain, Some(vk::TessellationDomainOrigin::UPPER_LEFT));
    group.add_child(upper_left_domain);

    group
}
