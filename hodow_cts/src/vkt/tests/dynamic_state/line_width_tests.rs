// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/dynamic_state/vktDynamicStateLineWidthTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `line_width`: two subpasses draw a horizontal and a vertical line of different widths, one with a static line width in
// its pipeline and one with the width set dynamically, in either order. The counts of covered pixels along the first
// row and the first column must equal the widths.

use vulkanalia::prelude::v1_0::*;

use super::construction::create_graphics_pipeline;
use crate::generated::shaders::dynamic_state_line_width::LINE_WIDTH;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::rect_2d;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `TestLineWidthParams`
#[derive(Clone, Copy)]
struct TestLineWidthParams {
    static_topo: vk::PrimitiveTopology,
    dynamic_topo: vk::PrimitiveTopology,
    static_width: u32,
    dynamic_width: u32,
    dynamic_first: bool,
    format: vk::Format,
    width: u32,
    height: u32,
}

impl TestLineWidthParams {
    /// `TestLineWidthParams::rep`
    fn rep(&self) -> String {
        let topo = |topology: vk::PrimitiveTopology| {
            if topology == vk::PrimitiveTopology::LINE_LIST {
                "list"
            } else {
                "strip"
            }
        };
        if self.dynamic_first {
            format!(
                "{}{}_{}{}",
                topo(self.dynamic_topo),
                self.dynamic_width,
                topo(self.static_topo),
                self.static_width
            )
        } else {
            format!(
                "{}{}_{}{}",
                topo(self.static_topo),
                self.static_width,
                topo(self.dynamic_topo),
                self.dynamic_width
            )
        }
    }
}

/// `LineWidthCase`
struct LineWidthCase {
    name: String,
    params: TestLineWidthParams,
}

impl TestCase for LineWidthCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;
        let range = context.get_device_properties().limits.line_width_range;

        if (params.static_width as f32) < range[0]
            || (params.static_width as f32) > range[1]
            || (params.dynamic_width as f32) < range[0]
            || (params.dynamic_width as f32) > range[1]
        {
            return Err(TestError::NotSupported(
                "Line widths don't meet VkPhysicalDeviceLimits::lineWidthRange".to_string(),
            ));
        }

        if context.get_device_features().wide_lines == vk::FALSE {
            return Err(TestError::NotSupported(
                "VkPhysicalDeviceFeatures::wideLines not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        LINE_WIDTH.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(LineWidthInstance {
            context,
            params: self.params,
        })
    }
}

/// `LineWidthInstance`
struct LineWidthInstance<'a> {
    context: &'a Context<'a>,
    params: TestLineWidthParams,
}

impl<'a> LineWidthInstance<'a> {
    /// `LineWidthInstance::buildVertices`
    fn build_vertices(
        &self,
        line_topology: vk::PrimitiveTopology,
        horizontal: bool,
    ) -> Result<(BufferWithMemory<'a>, u32), TestError> {
        let vertices: Vec<[f32; 4]> = if line_topology == vk::PrimitiveTopology::LINE_LIST {
            if horizontal {
                vec![
                    [-1.0, 0.0, 0.0, 0.0],
                    [0.0, 0.0, 0.0, 0.0],
                    [0.0, 0.0, 0.0, 0.0],
                    [1.0, 0.0, 0.0, 0.0],
                ]
            } else {
                vec![
                    [0.0, -1.0, 0.0, 0.0],
                    [0.0, 0.0, 0.0, 0.0],
                    [0.0, 0.0, 0.0, 0.0],
                    [0.0, 1.0, 0.0, 0.0],
                ]
            }
        } else if horizontal {
            vec![[-1.0, 0.0, 0.0, 0.0], [0.0, 0.0, 0.0, 0.0], [1.0, 0.0, 0.0, 0.0]]
        } else {
            vec![[0.0, -1.0, 0.0, 0.0], [0.0, 0.0, 0.0, 0.0], [0.0, 1.0, 0.0, 0.0]]
        };

        let size = std::mem::size_of_val(vertices.as_slice());
        let buffer = BufferWithMemory::new(
            self.context.get_device(),
            self.context.get_default_allocator(),
            make_buffer_create_info(size as vk::DeviceSize, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE | MemoryRequirement::COHERENT,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertices.as_ptr().cast::<u8>(),
                buffer.get_allocation().get_host_ptr(),
                size,
            )
        };
        Ok((buffer, vertices.len() as u32))
    }

    /// `LineWidthInstance::buildRenderPass`: two identical subpasses with a dependency between them.
    fn build_render_pass(&self, format: vk::Format) -> Result<Unique<'a, vk::RenderPass>, TestError> {
        let device = self.context.get_device();
        let attachments = [vk::AttachmentDescription::builder()
            .format(format)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build()];
        let references = [vk::AttachmentReference::builder()
            .attachment(0)
            .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build()];
        let subpass = vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&references)
            .build();
        let subpasses = [subpass, subpass];
        let dependencies = [vk::SubpassDependency::builder()
            .src_subpass(0)
            .dst_subpass(1)
            .src_access_mask(vk::AccessFlags::MEMORY_WRITE)
            .dst_access_mask(vk::AccessFlags::MEMORY_READ)
            .src_stage_mask(vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT)
            .dst_stage_mask(vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT)
            .build()];
        let info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses)
            .dependencies(&dependencies);
        Ok(Unique::new(
            device,
            unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
        ))
    }

    /// `LineWidthInstance::buildPipeline`
    #[allow(clippy::too_many_arguments)]
    fn build_pipeline(
        &self,
        line_topology: vk::PrimitiveTopology,
        line_width: f32,
        dynamic: bool,
        subpass: u32,
        layout: vk::PipelineLayout,
        vertex_module: vk::ShaderModule,
        fragment_module: vk::ShaderModule,
        render_pass: vk::RenderPass,
    ) -> Result<Unique<'a, vk::Pipeline>, TestError> {
        let device = self.context.get_device();
        let (width, height) = (self.params.width, self.params.height);

        let scissors = [rect_2d(width, height)];
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: width as f32,
            height: height as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);

        let rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .line_width(if dynamic { 0.0 } else { line_width });

        let dynamic_states = [vk::DynamicState::LINE_WIDTH];
        let dynamic_state = vk::PipelineDynamicStateCreateInfo::builder().dynamic_states(&dynamic_states);

        let binding_idx = if dynamic { 0 } else { 1 };
        let attributes = [vk::VertexInputAttributeDescription {
            location: 0,
            binding: binding_idx,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: 0,
        }];
        let bindings = [vk::VertexInputBindingDescription {
            binding: binding_idx,
            stride: std::mem::size_of::<[f32; 4]>() as u32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        let input = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_attribute_descriptions(&attributes)
            .vertex_binding_descriptions(&bindings);
        let input_assembly = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(line_topology)
            .primitive_restart_enable(false);

        // makeGraphicsPipeline's defaults for the states a null pointer leaves out
        let multisample = vk::PipelineMultisampleStateCreateInfo::builder()
            .rasterization_samples(vk::SampleCountFlags::_1)
            .sample_shading_enable(false)
            .min_sample_shading(1.0);
        let stencil_op = vk::StencilOpState::builder()
            .fail_op(vk::StencilOp::KEEP)
            .pass_op(vk::StencilOp::KEEP)
            .depth_fail_op(vk::StencilOp::KEEP)
            .compare_op(vk::CompareOp::NEVER)
            .build();
        let depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(false)
            .depth_write_enable(false)
            .depth_compare_op(vk::CompareOp::LESS_OR_EQUAL)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(false)
            .front(stencil_op)
            .back(stencil_op)
            .min_depth_bounds(0.0)
            .max_depth_bounds(1.0);
        let blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let color_blend = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&blend_attachments);

        let stages = [
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::VERTEX)
                .module(vertex_module)
                .name(b"main\0")
                .build(),
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(fragment_module)
                .name(b"main\0")
                .build(),
        ];
        let mut info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&input)
            .input_assembly_state(&input_assembly)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization)
            .multisample_state(&multisample)
            .depth_stencil_state(&depth_stencil)
            .color_blend_state(&color_blend)
            .layout(layout)
            .render_pass(render_pass)
            .subpass(subpass)
            .base_pipeline_index(0);
        if dynamic {
            info = info.dynamic_state(&dynamic_state);
        }
        create_graphics_pipeline(device, &info)
    }

    /// `LineWidthInstance::verifyResults`
    fn verify_results(&self, pixels: &[u8], dynamic_color: [f32; 4], static_color: [f32; 4]) -> bool {
        let params = &self.params;
        let pixel = |x: u32, y: u32| -> [f32; 4] {
            let offset = ((y * params.width + x) * 16) as usize;
            let mut color = [0.0f32; 4];
            for (channel, value) in color.iter_mut().enumerate() {
                let start = offset + channel * 4;
                *value = f32::from_le_bytes([pixels[start], pixels[start + 1], pixels[start + 2], pixels[start + 3]]);
            }
            color
        };

        // count pixels in vertical line
        let result_static_width = (0..params.width).filter(|&x| pixel(x, 0) == static_color).count() as u32;

        // count pixels in horizontal line
        let result_dynamic_width = (0..params.height).filter(|&y| pixel(0, y) == dynamic_color).count() as u32;

        params.dynamic_width == result_dynamic_width && params.static_width == result_static_width
    }
}

impl TestInstance for LineWidthInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let queue = context.get_universal_queue();

        let binaries = context.get_binary_collection();
        let vertex = create_shader_module(device, binaries.get("vert")?)?;
        let fragment = create_shader_module(device, binaries.get("frag")?)?;
        // note that dynamic lines are always drawn horizontally
        let (dynamic_vertices, dynamic_vert_count) = self.build_vertices(params.dynamic_topo, true)?;
        let (static_vertices, static_vert_count) = self.build_vertices(params.static_topo, false)?;
        let vertex_buffers = [dynamic_vertices.get(), static_vertices.get()];
        let vertex_offsets = [0u64, 0u64];
        let dynamic_color = [1.0f32, 0.0, 1.0, 1.0];
        let static_color = [0.0f32, 1.0, 0.0, 1.0];

        let image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(params.format)
            .extent(vk::Extent3D {
                width: params.width,
                height: params.height,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(
                vk::ImageUsageFlags::COLOR_ATTACHMENT
                    | vk::ImageUsageFlags::TRANSFER_SRC
                    | vk::ImageUsageFlags::TRANSFER_DST,
            )
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let image = ImageWithMemory::new(device, alloc, image_info, MemoryRequirement::ANY)?;
        let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let prepare_copy = make_image_memory_barrier(
            vk::AccessFlags::MEMORY_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            image.get(),
            range,
        );
        let copy_region = make_buffer_image_copy(
            vk::Extent3D {
                width: params.width,
                height: params.height,
                depth: 1,
            },
            make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
        );
        let attachment = make_image_view(device, image.get(), vk::ImageViewType::_2D, params.format, range)?;
        let render_pass = self.build_render_pass(params.format)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*attachment], params.width, params.height, 1)?;
        let result_byte_size = (params.width * params.height) as usize * 16;
        let result_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(result_byte_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE | MemoryRequirement::COHERENT,
        )?;
        let pc_range = vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::FRAGMENT,
            offset: 0,
            size: std::mem::size_of::<[f32; 4]>() as u32,
        };
        let pc_ranges = [pc_range];
        let layout_info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(&pc_ranges);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );
        let dynamic_pipeline = self.build_pipeline(
            params.dynamic_topo,
            params.dynamic_width as f32,
            true,
            if params.dynamic_first { 0 } else { 1 },
            *pipeline_layout,
            *vertex,
            *fragment,
            *render_pass,
        )?;
        let static_pipeline = self.build_pipeline(
            params.static_topo,
            params.static_width as f32,
            false,
            if params.dynamic_first { 1 } else { 0 },
            *pipeline_layout,
            *vertex,
            *fragment,
            *render_pass,
        )?;
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        let push_color = |color: &[f32; 4]| unsafe {
            let bytes = std::slice::from_raw_parts(color.as_ptr().cast::<u8>(), std::mem::size_of::<[f32; 4]>());
            device.cmd_push_constants(cmd, *pipeline_layout, pc_range.stage_flags, pc_range.offset, bytes);
        };
        let put_dynamics = || {
            unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *dynamic_pipeline) };
            push_color(&dynamic_color);
            unsafe {
                device.cmd_set_line_width(cmd, params.dynamic_width as f32);
                device.cmd_draw(cmd, dynamic_vert_count, 1, 0, 0);
            }
        };
        let put_statics = || {
            unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *static_pipeline) };
            push_color(&static_color);
            unsafe { device.cmd_draw(cmd, static_vert_count, 1, 0, 0) };
        };

        begin_command_buffer(device, cmd)?;
        unsafe { device.cmd_bind_vertex_buffers(cmd, 0, &vertex_buffers, &vertex_offsets) };

        // beginColorRenderPass
        let clear_values = [vk::ClearValue {
            color: vk::ClearColorValue { float32: [0.0; 4] },
        }];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(params.width, params.height))
            .clear_values(&clear_values);
        unsafe { device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE) };

        if params.dynamic_first {
            put_dynamics()
        } else {
            put_statics()
        }
        unsafe { device.cmd_next_subpass(cmd, vk::SubpassContents::INLINE) };
        if params.dynamic_first {
            put_statics()
        } else {
            put_dynamics()
        }
        unsafe {
            device.cmd_end_render_pass(cmd);
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::BY_REGION,
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[prepare_copy],
            );
            device.cmd_copy_image_to_buffer(
                cmd,
                image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                result_buffer.get(),
                &[copy_region],
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        invalidate_alloc(device, result_buffer.get_allocation())?;
        let pixels =
            unsafe { std::slice::from_raw_parts(result_buffer.get_allocation().get_host_ptr(), result_byte_size) };
        if self.verify_results(pixels, dynamic_color, static_color) {
            Ok(TestStatus::pass(""))
        } else {
            Ok(TestStatus::fail(""))
        }
    }
}

/// `DynamicStateLWTests`
pub fn create_line_width_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("line_width");

    let list = vk::PrimitiveTopology::LINE_LIST;
    let strip = vk::PrimitiveTopology::LINE_STRIP;
    let format = vk::Format::R32G32B32A32_SFLOAT;
    let params = [
        (list, strip, true),
        (list, strip, false),
        (list, list, true),
        (list, list, false),
        (strip, list, true),
        (strip, list, false),
        (strip, strip, true),
        (strip, strip, false),
    ];

    let mut dyna_static = TestCaseGroup::new("dyna_static");
    let mut static_dyna = TestCaseGroup::new("static_dyna");
    let mut line_width = 0u32;
    for (static_topo, dynamic_topo, dynamic_first) in params {
        line_width += 1;
        let static_width = line_width;
        line_width += 1;
        let dynamic_width = line_width;
        let p = TestLineWidthParams {
            static_topo,
            dynamic_topo,
            static_width,
            dynamic_width,
            dynamic_first,
            format,
            width: 128,
            height: 128,
        };
        let case = Box::new(LineWidthCase {
            name: p.rep(),
            params: p,
        }) as Box<dyn TestCase>;
        if dynamic_first {
            dyna_static.add_child(case);
        } else {
            static_dyna.add_child(case);
        }
    }
    group.add_child(dyna_static);
    group.add_child(static_dyna);

    group
}
