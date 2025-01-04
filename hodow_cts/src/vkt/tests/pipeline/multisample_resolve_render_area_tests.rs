// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineMultisampleResolveRenderAreaTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::pipeline_multisample_render_area::RENDER_AREA;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::MemoryRequirement;
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_value_color, create_draw_pipeline, rect_2d};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const FRAMEBUFFER_SIZE: u32 = 32;

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestShape {
    Rectangle,
    Diamond,
    Parallelogram,
}

struct MultisampleRenderAreaCase {
    name: String,
    sample_count: u32,
    test_shape: TestShape,
}

impl TestCase for MultisampleRenderAreaCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `MultisampleRenderAreaTest::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        // Check support for MSAA image format used in the test.
        let format_properties = unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                COLOR_FORMAT,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
                vk::ImageCreateFlags::empty(),
            )
        }
        .vk_check("vkGetPhysicalDeviceImageFormatProperties")?;

        if format_properties.sample_counts.bits() & self.sample_count == 0 {
            return Err(TestError::NotSupported(
                "Format does not support this number of samples".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        RENDER_AREA.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MultisampleRenderAreaInstance {
            context,
            sample_count: self.sample_count,
            test_shape: self.test_shape,
        })
    }
}

struct MultisampleRenderAreaInstance<'a> {
    context: &'a Context<'a>,
    sample_count: u32,
    test_shape: TestShape,
}

impl MultisampleRenderAreaInstance<'_> {
    fn samples(&self) -> vk::SampleCountFlags {
        vk::SampleCountFlags::from_bits_truncate(self.sample_count)
    }

    /// `makeImageCreateInfo`
    fn make_image_create_info(&self, sample_count: u32) -> vk::ImageCreateInfo {
        vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(COLOR_FORMAT)
            .extent(vk::Extent3D {
                width: FRAMEBUFFER_SIZE,
                height: FRAMEBUFFER_SIZE,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(if sample_count < 2 {
                vk::SampleCountFlags::_1
            } else {
                self.samples()
            })
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build()
    }

    /// `makeRenderPass`
    fn make_render_pass<'a>(
        &self,
        device: &'a Device,
        initial_layout: vk::ImageLayout,
    ) -> Result<Unique<'a, vk::RenderPass>, TestError> {
        let attachment_descriptions = [
            vk::AttachmentDescription::builder()
                .format(COLOR_FORMAT)
                .samples(self.samples())
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(initial_layout)
                .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .build(),
            vk::AttachmentDescription::builder()
                .format(COLOR_FORMAT)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(initial_layout)
                .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .build(),
        ];
        let color_attachment_refs = [vk::AttachmentReference::builder()
            .attachment(0)
            .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build()];
        let resolve_attachment_refs = [vk::AttachmentReference::builder()
            .attachment(1)
            .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build()];
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_attachment_refs)
            .resolve_attachments(&resolve_attachment_refs)
            .build()];
        let info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachment_descriptions)
            .subpasses(&subpasses);
        let render_pass = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
        Ok(Unique::new(device, render_pass))
    }

    /// The vertices of the shape, which should fit just and just inside the renderArea.
    fn vertices(&self) -> [[f32; 4]; 6] {
        match self.test_shape {
            TestShape::Rectangle => {
                let size = 0.5f32;
                [
                    [size, -size, 0.0, 1.0],
                    [-size, -size, 0.0, 1.0],
                    [-size, size, 0.0, 1.0],
                    [-size, size, 0.0, 1.0],
                    [size, size, 0.0, 1.0],
                    [size, -size, 0.0, 1.0],
                ]
            }
            TestShape::Diamond => {
                let size = 0.5f32;
                [
                    [size, 0.0, 0.0, 1.0],
                    [-0.0, -size, 0.0, 1.0],
                    [-size, 0.0, 0.0, 1.0],
                    [size, 0.0, 0.0, 1.0],
                    [-size, 0.0, 0.0, 1.0],
                    [-0.0, size, 0.0, 1.0],
                ]
            }
            TestShape::Parallelogram => {
                let size = 0.3125f32;
                [
                    [size, -size, 0.0, 1.0],
                    [-0.5, -size, 0.0, 1.0],
                    [-size, size, 0.0, 1.0],
                    [-size, size, 0.0, 1.0],
                    [0.5, size, 0.0, 1.0],
                    [size, -size, 0.0, 1.0],
                ]
            }
        }
    }
}

impl TestInstance for MultisampleRenderAreaInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let color_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let fragment_module = create_shader_module(device, binaries.get("frag")?)?;

        let color_image = ImageWithMemory::new(
            device,
            allocator,
            self.make_image_create_info(self.sample_count),
            MemoryRequirement::ANY,
        )?;
        let color_image_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            color_subresource_range,
        )?;
        let resolve_color_image = ImageWithMemory::new(
            device,
            allocator,
            self.make_image_create_info(1),
            MemoryRequirement::ANY,
        )?;
        let resolve_color_image_view = make_image_view(
            device,
            resolve_color_image.get(),
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            color_subresource_range,
        )?;
        let attachment_images = [*color_image_view, *resolve_color_image_view];

        let color_buffer_size_bytes = (FRAMEBUFFER_SIZE * FRAMEBUFFER_SIZE * 4) as usize;
        let color_buffer_results = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                color_buffer_size_bytes as vk::DeviceSize,
                vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let render_pass_one = self.make_render_pass(device, vk::ImageLayout::UNDEFINED)?;
        let render_pass_two = self.make_render_pass(device, vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)?;
        let framebuffer_one = make_framebuffer(
            device,
            *render_pass_one,
            &attachment_images,
            FRAMEBUFFER_SIZE,
            FRAMEBUFFER_SIZE,
            1,
        )?;
        let framebuffer_two = make_framebuffer(
            device,
            *render_pass_two,
            &attachment_images,
            FRAMEBUFFER_SIZE,
            FRAMEBUFFER_SIZE,
            1,
        )?;

        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST)
            .with_position_input()
            .with_full_viewport(FRAMEBUFFER_SIZE, FRAMEBUFFER_SIZE);
        state.rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .line_width(1.0)
            .build();
        state.samples = self.samples();
        state.sample_mask = Some(0xffff);
        let graphics_pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass_one,
            &[
                (vk::ShaderStageFlags::VERTEX, *vertex_module),
                (vk::ShaderStageFlags::FRAGMENT, *fragment_module),
            ],
            &state,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let command_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *command_buffer;

        let vertex_buffer = create_host_buffer(context, &self.vertices(), vk::BufferUsageFlags::VERTEX_BUFFER)?;

        let test_render_area = vk::Rect2D {
            offset: vk::Offset2D {
                x: (FRAMEBUFFER_SIZE / 4) as i32,
                y: (FRAMEBUFFER_SIZE / 4) as i32,
            },
            extent: vk::Extent2D {
                width: FRAMEBUFFER_SIZE / 2,
                height: FRAMEBUFFER_SIZE / 2,
            },
        };
        let full_render_area = rect_2d(FRAMEBUFFER_SIZE, FRAMEBUFFER_SIZE);

        let clear_values_full_area = [
            clear_value_color([1.0, 0.0, 0.0, 1.0]),
            clear_value_color([1.0, 0.0, 0.0, 1.0]),
        ];
        let clear_values_test_area = [
            clear_value_color([0.0, 1.0, 0.0, 1.0]),
            clear_value_color([0.0, 1.0, 0.0, 1.0]),
        ];

        begin_command_buffer(device, cmd)?;

        // Clear whole render area with red color.
        let begin_one = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass_one)
            .framebuffer(*framebuffer_one)
            .render_area(full_render_area)
            .clear_values(&clear_values_full_area);
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_one, vk::SubpassContents::INLINE);
            device.cmd_end_render_pass(cmd);
        }

        let image_barriers = [
            make_image_memory_barrier(
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                color_image.get(),
                color_subresource_range,
            ),
            make_image_memory_barrier(
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                resolve_color_image.get(),
                color_subresource_range,
            ),
        ];
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &image_barriers,
            );
        }

        // Draw shape when render area size is halved.
        let begin_two = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass_two)
            .framebuffer(*framebuffer_two)
            .render_area(test_render_area)
            .clear_values(&clear_values_test_area);
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_two, vk::SubpassContents::INLINE);
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, graphics_pipeline.get());
            device.cmd_draw(cmd, 6, 1, 0, 0);
            device.cmd_end_render_pass(cmd);
        }

        copy_image_to_buffer(
            device,
            cmd,
            resolve_color_image.get(),
            color_buffer_results.get(),
            FRAMEBUFFER_SIZE,
            FRAMEBUFFER_SIZE,
        );

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        // Verify color output
        let alloc = color_buffer_results.get_allocation();
        crate::vk::mem_util::invalidate_alloc(device, alloc)?;
        let pixels = unsafe { std::slice::from_raw_parts(alloc.get_host_ptr(), color_buffer_size_bytes) };
        let pixel = |x: u32, y: u32| -> [u8; 4] {
            let offset = ((y * FRAMEBUFFER_SIZE + x) * 4) as usize;
            [
                pixels[offset],
                pixels[offset + 1],
                pixels[offset + 2],
                pixels[offset + 3],
            ]
        };

        // Color check for rendered shape. Shape color is yellow.
        if pixel(FRAMEBUFFER_SIZE / 2, FRAMEBUFFER_SIZE / 2) != [255, 255, 0, 255] {
            return Ok(TestStatus::fail("Pixel check failed: shape color"));
        }

        // Color check for the second render area. Clear color should be green.
        if self.test_shape != TestShape::Rectangle
            && pixel(FRAMEBUFFER_SIZE / 4 + 1, FRAMEBUFFER_SIZE / 4 + 1) != [0, 255, 0, 255]
        {
            // In the rectangle case the shape has covered the whole render area.
            return Ok(TestStatus::fail("Pixel check failed inside the render area"));
        }

        // Color check for possible overflowed multisample pixels outside of the second render area.
        // Clear color after the first beginRenderPass should be red.
        let min_value = (FRAMEBUFFER_SIZE / 4) as i32 - 1;
        let max_value = (FRAMEBUFFER_SIZE - FRAMEBUFFER_SIZE / 4) as i32;
        for y in 0..FRAMEBUFFER_SIZE {
            for x in 0..FRAMEBUFFER_SIZE {
                let (xi, yi) = (x as i32, y as i32);
                if !(xi > min_value && yi > min_value && xi < max_value && yi < max_value)
                    && pixel(x, y) != [255, 0, 0, 255]
                {
                    log::error!("Incorrect color value {:?} at location ({x}, {y})", pixel(x, y));
                    return Ok(TestStatus::fail("Pixel check failed outside the render area"));
                }
            }
        }

        Ok(TestStatus::pass("Success"))
    }
}

/// `createMultisampleResolveRenderpassRenderAreaTests`
pub fn create_multisample_resolve_renderpass_render_area_tests() -> TestCaseGroup {
    // resolving multisample image tests
    let mut test_group_resolve = TestCaseGroup::new("resolve");

    // renderpass render area tests
    let mut test_group_render_area = TestCaseGroup::new("renderpass_renderarea");

    let shapes = [
        ("rectangle", TestShape::Rectangle),
        ("diamond", TestShape::Diamond),
        ("parallelogram", TestShape::Parallelogram),
    ];
    let cases = [
        ("samples_2", 2u32),
        ("samples_4", 4),
        ("samples_8", 8),
        ("samples_16", 16),
    ];

    for (shape_name, test_shape) in shapes {
        for (case_name, sample_count) in cases {
            test_group_render_area.add_child(Box::new(MultisampleRenderAreaCase {
                name: format!("{shape_name}_{case_name}"),
                sample_count,
                test_shape,
            }) as Box<dyn TestCase>);
        }
    }

    test_group_resolve.add_child(test_group_render_area);
    test_group_resolve
}
