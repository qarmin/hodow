// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/data/vulkan/amber/draw/misc/flat_b_sat_error.amber (registered by vktBasicDrawTests.cpp)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. What the Amber pipeline does is done directly: five points over a 5x1
// B8G8R8A8 target, one per pixel, the vertex data's y value passed flat to the fragment shader, which turns it into red.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::draw_misc::FLAT_B_SAT_ERROR;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_graphics_pipeline_full, make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::pipeline::pipeline_util::read_color_attachment;
use crate::vkt::{Context, TestCase, TestInstance};

const WIDTH: u32 = 5;
const HEIGHT: u32 = 1;
const FORMAT: vk::Format = vk::Format::B8G8R8A8_UNORM;
const POSITIONS: [[f32; 2]; 5] = [[0.0, 0.0], [1.0, 0.5], [2.0, 1.0], [3.0, 1.5], [4.0, 2.0]];
const EXPECTED_RED: [u8; 5] = [0, 0, 128, 128, 128];

struct FlatBSatErrorCase;

impl TestCase for FlatBSatErrorCase {
    fn name(&self) -> &str {
        "flat_b_sat_error"
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        FLAT_B_SAT_ERROR.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(FlatBSatErrorInstance { context })
    }
}

struct FlatBSatErrorInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for FlatBSatErrorInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();

        let image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(FORMAT)
            .extent(vk::Extent3D {
                width: WIDTH,
                height: HEIGHT,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let image = ImageWithMemory::new(
            device,
            context.get_default_allocator(),
            image_info,
            MemoryRequirement::ANY,
        )?;
        let view = make_image_view(
            device,
            *image,
            vk::ImageViewType::_2D,
            FORMAT,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;

        let render_pass = make_render_pass(device, FORMAT)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*view], WIDTH, HEIGHT, 1)?;
        let layout = make_pipeline_layout(device, &[])?;
        let binaries = context.get_binary_collection();
        let vs = create_shader_module(device, binaries.get("vert")?)?;
        let fs = create_shader_module(device, binaries.get("frag")?)?;
        let pipeline = make_graphics_pipeline_full(
            device,
            *layout,
            *vs,
            *fs,
            *render_pass,
            (WIDTH, HEIGHT),
            vk::PrimitiveTopology::POINT_LIST,
            vk::SampleCountFlags::_1,
            None,
            1,
            Some((vk::Format::R32G32_SFLOAT, 8)),
        )?;

        let vertex_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(
                std::mem::size_of_val(&POSITIONS) as vk::DeviceSize,
                vk::BufferUsageFlags::VERTEX_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                POSITIONS.as_ptr().cast::<u8>(),
                vertex_buffer.get_allocation().get_host_ptr(),
                std::mem::size_of_val(&POSITIONS),
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, *cmd)?;
        begin_render_pass(
            device,
            *cmd,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, WIDTH, HEIGHT),
            vk::ClearValue {
                color: vk::ClearColorValue { float32: [0.0; 4] },
            },
        );
        unsafe {
            device.cmd_bind_pipeline(*cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_vertex_buffers(*cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_draw(*cmd, POSITIONS.len() as u32, 1, 0, 0);
        }
        end_render_pass(device, *cmd);
        end_command_buffer(device, *cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), *cmd)?;

        let result = read_color_attachment(
            context,
            *image,
            FORMAT,
            (WIDTH, HEIGHT),
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let pixels = result.get_const_access();
        for (x, &expected) in EXPECTED_RED.iter().enumerate() {
            let pixel = pixels.get_pixel(x as u32, 0, 0);
            let rgba = pixel.map(|channel| (channel * 255.0).round() as u8);
            if rgba != [expected, 0, 0, 255] {
                return Ok(TestStatus::fail(format!(
                    "Pixel {x} is {rgba:?}, expected [{expected}, 0, 0, 255]"
                )));
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// The `flat_b_sat_error` case of the `misc` group.
pub fn create_flat_b_sat_error_case() -> Box<dyn TestCase> {
    Box::new(FlatBSatErrorCase)
}
