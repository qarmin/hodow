// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/tessellation/vktTessellationGeometryGridRenderTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The geometry and tessellation shaders upstream builds from the case's
// flags are pre-expanded into the manifest, one program set per case, so the instance only needs the layer count.
//
// Ported from dEQP-GLES31.functional.tessellation_geometry_interaction.render.* (`limits` and `scatter` sit directly in
// `geometry_interaction`).

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::tessellation_geometry_grid_render::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_memory_barrier, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::util::{
    DrawPipelineState, clear_value_color, create_draw_pipeline, make_color_render_pass, rect_2d,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const RENDER_SIZE: u32 = 256;

struct GridRenderTestCase {
    name: &'static str,
    num_layers: u32,
}

impl TestCase for GridRenderTestCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `requireFeatures(FEATURE_TESSELLATION_SHADER | FEATURE_GEOMETRY_SHADER)`, which `iterate` starts with.
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let features = context.get_device_features();
        if features.tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported("Tessellation shader not supported".to_string()));
        }
        if features.geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported("Geometry shader not supported".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == self.name)
            .unwrap_or_else(|| panic!("the shader manifest has no case named {}", self.name))
            .programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(GridRenderTestInstance {
            context,
            num_layers: self.num_layers,
        })
    }
}

struct GridRenderTestInstance<'a> {
    context: &'a Context<'a>,
    num_layers: u32,
}

/// `verifyResultLayer`: every pixel must be a linear combination of green and yellow.
fn verify_result_layer(layer: &[u8]) -> bool {
    let threshold = 8u8;
    layer
        .chunks_exact(4)
        .all(|pixel| !(pixel[1] < 255 - threshold || pixel[2] > threshold))
}

impl TestInstance for GridRenderTestInstance<'_> {
    /// `GridRenderTestInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let num_layers = self.num_layers;
        let device = context.get_device();
        let queue = context.get_universal_queue();

        // Color attachment
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let color_image_all_layers_range =
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, num_layers);
        let color_image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(color_format)
            .extent(vk::Extent3D {
                width: RENDER_SIZE,
                height: RENDER_SIZE,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(num_layers)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let color_attachment_view_type = if num_layers == 1 {
            vk::ImageViewType::_2D
        } else {
            vk::ImageViewType::_2D_ARRAY
        };
        let color_attachment_image = ImageWithMemory::new(
            device,
            context.get_default_allocator(),
            color_image_info,
            MemoryRequirement::ANY,
        )?;

        // Color output buffer: image will be copied here for verification (big enough for all layers).
        let layer_size = (RENDER_SIZE * RENDER_SIZE * 4) as usize;
        let color_buffer_size_bytes = layer_size * num_layers as usize;
        let color_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(
                color_buffer_size_bytes as vk::DeviceSize,
                vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Pipeline: no vertex input attributes nor descriptors.
        let color_attachment_view = make_image_view(
            device,
            color_attachment_image.get(),
            color_attachment_view_type,
            color_format,
            color_image_all_layers_range,
        )?;
        let render_pass = make_color_render_pass(
            device,
            color_format,
            vk::AttachmentLoadOp::CLEAR,
            vk::AttachmentStoreOp::STORE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*color_attachment_view],
            RENDER_SIZE,
            RENDER_SIZE,
            num_layers,
        )?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let tesc_module = create_shader_module(device, binaries.get("tesc")?)?;
        let tese_module = create_shader_module(device, binaries.get("tese")?)?;
        let geom_module = create_shader_module(device, binaries.get("geom")?)?;
        let stages = [
            (vk::ShaderStageFlags::VERTEX, *vert_module),
            (vk::ShaderStageFlags::FRAGMENT, *frag_module),
            (vk::ShaderStageFlags::TESSELLATION_CONTROL, *tesc_module),
            (vk::ShaderStageFlags::TESSELLATION_EVALUATION, *tese_module),
            (vk::ShaderStageFlags::GEOMETRY, *geom_module),
        ];

        let mut state =
            DrawPipelineState::new(vk::PrimitiveTopology::PATCH_LIST).with_full_viewport(RENDER_SIZE, RENDER_SIZE);
        state.patch_control_points = Some(1);
        let pipeline = create_draw_pipeline(device, *pipeline_layout, *render_pass, &stages, &state)?;

        begin_command_buffer(device, *cmd_buffer)?;

        // Change color attachment image layout
        {
            let color_attachment_layout_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                color_attachment_image.get(),
                color_image_all_layers_range,
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    *cmd_buffer,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[color_attachment_layout_barrier],
                );
            }
        }

        // Begin render pass, rendering a single point at the origin
        let clear_values = [clear_value_color([0.0, 0.0, 0.0, 1.0])];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(RENDER_SIZE, RENDER_SIZE))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(*cmd_buffer, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_draw(*cmd_buffer, 1, 1, 0, 0);
            device.cmd_end_render_pass(*cmd_buffer);
        }

        // Copy render result to a host-visible buffer
        {
            let to_transfer = make_image_memory_barrier(
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                color_attachment_image.get(),
                color_image_all_layers_range,
            );
            let copy_region = make_buffer_image_copy(
                vk::Extent3D {
                    width: RENDER_SIZE,
                    height: RENDER_SIZE,
                    depth: 1,
                },
                make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, num_layers),
            );
            let to_host = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
            unsafe {
                device.cmd_pipeline_barrier(
                    *cmd_buffer,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[to_transfer],
                );
                device.cmd_copy_image_to_buffer(
                    *cmd_buffer,
                    color_attachment_image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    color_buffer.get(),
                    &[copy_region],
                );
                device.cmd_pipeline_barrier(
                    *cmd_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[to_host],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }

        end_command_buffer(device, *cmd_buffer)?;
        submit_commands_and_wait(device, queue, *cmd_buffer)?;

        // Verify results
        invalidate_alloc(device, color_buffer.get_allocation())?;
        let image_all_layers = unsafe {
            std::slice::from_raw_parts(color_buffer.get_allocation().get_host_ptr(), color_buffer_size_bytes)
        };
        let all_ok = image_all_layers.chunks_exact(layer_size).all(verify_result_layer);

        Ok(if all_ok {
            TestStatus::pass("OK")
        } else {
            TestStatus::fail("Image comparison failed")
        })
    }
}

/// `createGeometryGridRenderLimitsTests`
pub fn create_geometry_grid_render_limits_tests() -> TestCaseGroup {
    // Render with properties near their limits
    let mut group = TestCaseGroup::new("limits");

    // Minimum maximum tessellation level, minimum maximum number of vertices of the geometry shader, minimum maximum
    // number of geometry shader invocations
    for name in [
        "output_required_max_tessellation",
        "output_required_max_geometry",
        "output_required_max_invocations",
    ] {
        group.add_child(Box::new(GridRenderTestCase { name, num_layers: 1 }) as Box<dyn TestCase>);
    }
    group
}

/// `createGeometryGridRenderScatterTests`
pub fn create_geometry_grid_render_scatter_tests() -> TestCaseGroup {
    // Scatter output primitives
    let mut group = TestCaseGroup::new("scatter");

    // Each geometry shader instance outputs its primitives far from other instances of the same execution
    group.add_child(Box::new(GridRenderTestCase {
        name: "geometry_scatter_instances",
        num_layers: 1,
    }) as Box<dyn TestCase>);
    // Each geometry shader instance outputs its primitives far from other primitives of the same instance
    group.add_child(Box::new(GridRenderTestCase {
        name: "geometry_scatter_primitives",
        num_layers: 1,
    }) as Box<dyn TestCase>);
    // Each geometry shader instance outputs its primitives to multiple layers and far from other primitives of the same instance
    group.add_child(Box::new(GridRenderTestCase {
        name: "geometry_scatter_layers",
        num_layers: 8,
    }) as Box<dyn TestCase>);
    group
}
