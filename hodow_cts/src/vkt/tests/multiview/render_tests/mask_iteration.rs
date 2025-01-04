// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/multiview/vktMultiViewRenderTests.cpp (MultiViewMaskIterationTestInstance)
//
// Modifications: rewritten in Rust for hodow_cts.

use vulkanalia::vk::DeviceV1_3;

use super::*;
use crate::vk::obj_util::make_memory_barrier;

impl<'a> Run<'a> {
    /// `MultiViewMaskIterationTestInstance::beforeRender`
    fn mask_iteration_before_render(&self, cmd: vk::CommandBuffer, image: vk::Image) {
        let device = self.context.get_device();
        let layout = if self.p.use_general_layout {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::TRANSFER_DST_OPTIMAL
        };
        self.image_barrier(
            cmd,
            image,
            vk::ImageLayout::UNDEFINED,
            layout,
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::TRANSFER,
        );

        let clear_color = vk::ClearColorValue { float32: [0.0; 4] };
        unsafe { device.cmd_clear_color_image(cmd, image, layout, &clear_color, &[self.layers_range()]) };

        if self.p.use_general_layout {
            let barrier = make_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::DependencyFlags::empty(),
                    &[barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        } else {
            self.image_barrier(
                cmd,
                image,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            );
        }
    }

    /// `MultiViewMaskIterationTestInstance::afterRender`
    fn mask_iteration_after_render(&self, cmd: vk::CommandBuffer, image: vk::Image) {
        if self.p.use_general_layout {
            let barrier = make_memory_barrier(
                vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
            );
            unsafe {
                self.context.get_device().cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        } else {
            self.image_barrier(
                cmd,
                image,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
            );
        }
    }

    /// `MultiViewMaskIterationTestInstance::iterate`
    pub(super) fn iterate_mask_iteration(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let p = &self.p;
        let mut failure = false;
        let subpass_count = p.view_masks.len();
        let layer_count = p.extent.depth;
        let fb_extent = vk::Extent3D {
            width: p.extent.width,
            height: p.extent.height,
            depth: 1,
        };

        // `ImageWithBuffer`: the colour image over all layers and the buffer its contents are copied to.
        let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;
        let image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(p.color_format)
            .extent(fb_extent)
            .mip_levels(1)
            .array_layers(layer_count)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(color_usage)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let color_image = ImageWithMemory::new(
            device,
            context.get_default_allocator(),
            image_info,
            MemoryRequirement::ANY,
        )?;
        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, layer_count);
        let color_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D_ARRAY,
            p.color_format,
            color_srr,
        )?;
        let color_layer_size = (fb_extent.width * fb_extent.height * 4) as usize;
        let color_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(
                (color_layer_size * layer_count as usize) as vk::DeviceSize,
                vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let clear_value = clear_value_color([0.0; 4]);

        let (major, minor, _) = context.api_version();
        let vk12_support = (major, minor) >= (1, 2);
        let binaries = context.get_binary_collection();
        let vertex_shader_module = create_shader_module(
            device,
            binaries.get(if vk12_support { "vert-spv15" } else { "vert-spv10" })?,
        )?;
        let frag_shader_module = create_shader_module(device, binaries.get("view_mask_iteration")?)?;

        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: fb_extent.width as f32,
            height: fb_extent.height as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [rect_2d(fb_extent.width, fb_extent.height)];
        let pipeline_layout = make_pipeline_layout(device, &[])?;

        let color_blend_att_state = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .src_color_blend_factor(vk::BlendFactor::ZERO)
            .dst_color_blend_factor(vk::BlendFactor::ZERO)
            .color_blend_op(vk::BlendOp::ADD)
            .src_alpha_blend_factor(vk::BlendFactor::ZERO)
            .dst_alpha_blend_factor(vk::BlendFactor::ZERO)
            .alpha_blend_op(vk::BlendOp::ADD)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];

        let attachment_layout = if p.use_general_layout {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL
        };

        for subpass_ndx in 0..subpass_count {
            let layer_mask = p.view_masks[subpass_ndx];

            // FrameBuffer & renderPass
            let mut render_pass = None;
            let mut frame_buffer = None;
            if !self.dynamic() {
                let opts = RenderPassOptions {
                    use_general_layout: p.use_general_layout,
                    ..RenderPassOptions::new(vec![layer_mask])
                };
                let created = self.make_render_pass(&opts)?;
                frame_buffer = Some(make_framebuffer(
                    device,
                    *created,
                    &[*color_view],
                    fb_extent.width,
                    fb_extent.height,
                    1,
                )?);
                render_pass = Some(created);
            }
            let render_pass_handle = render_pass.as_ref().map_or_else(vk::RenderPass::null, |rp| **rp);

            // The pipeline: no vertex input, a full screen triangle.
            let stages = [
                vk::PipelineShaderStageCreateInfo::builder()
                    .stage(vk::ShaderStageFlags::VERTEX)
                    .module(*vertex_shader_module)
                    .name(b"main\0")
                    .build(),
                vk::PipelineShaderStageCreateInfo::builder()
                    .stage(vk::ShaderStageFlags::FRAGMENT)
                    .module(*frag_shader_module)
                    .name(b"main\0")
                    .build(),
            ];
            let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder();
            let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
                .topology(vk::PrimitiveTopology::TRIANGLE_LIST)
                .primitive_restart_enable(false);
            let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
                .viewports(&viewports)
                .scissors(&scissors);
            let raster_state = vk::PipelineRasterizationStateCreateInfo::builder()
                .depth_clamp_enable(false)
                .rasterizer_discard_enable(false)
                .polygon_mode(vk::PolygonMode::FILL)
                .cull_mode(vk::CullModeFlags::NONE)
                .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
                .depth_bias_enable(false)
                .line_width(1.0);
            let multisample_state =
                vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
            let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder()
                .logic_op_enable(false)
                .logic_op(vk::LogicOp::CLEAR)
                .attachments(&color_blend_att_state);
            let color_formats = [p.color_format];
            let mut rendering_create_info = vk::PipelineRenderingCreateInfo::builder()
                .view_mask(layer_mask)
                .color_attachment_formats(&color_formats)
                .depth_attachment_format(vk::Format::UNDEFINED)
                .stencil_attachment_format(vk::Format::UNDEFINED);
            let mut pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
                .stages(&stages)
                .vertex_input_state(&vertex_input_state)
                .input_assembly_state(&input_assembly_state)
                .viewport_state(&viewport_state)
                .rasterization_state(&raster_state)
                .multisample_state(&multisample_state)
                .color_blend_state(&color_blend_state)
                .layout(*pipeline_layout)
                .render_pass(render_pass_handle)
                .subpass(0)
                .base_pipeline_index(0);
            if render_pass_handle == vk::RenderPass::null() {
                pipeline_info = pipeline_info.push_next(&mut rendering_create_info);
            }
            let pipelines =
                unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
                    .vk_check("vkCreateGraphicsPipelines")?;
            let pipeline = Unique::new(device, pipelines.0[0]);

            let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
            let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            let cmd = *cmd_buffer;

            begin_command_buffer(device, cmd)?;
            self.mask_iteration_before_render(cmd, color_image.get());

            if !self.dynamic() {
                let clear_values = [clear_value];
                let begin_info = vk::RenderPassBeginInfo::builder()
                    .render_pass(render_pass_handle)
                    .framebuffer(frame_buffer.as_ref().map_or_else(vk::Framebuffer::null, |fb| **fb))
                    .render_area(scissors[0])
                    .clear_values(&clear_values);
                self.cmd_begin_render_pass_with(cmd, &begin_info, vk::SubpassContents::INLINE);
            } else {
                let color_attachments = [vk::RenderingAttachmentInfo::builder()
                    .image_view(*color_view)
                    .image_layout(attachment_layout)
                    .resolve_mode(vk::ResolveModeFlags::NONE)
                    .resolve_image_layout(vk::ImageLayout::UNDEFINED)
                    .load_op(vk::AttachmentLoadOp::LOAD)
                    .store_op(vk::AttachmentStoreOp::STORE)
                    .clear_value(clear_value)
                    .build()];
                let rendering_info = vk::RenderingInfo::builder()
                    .flags(vk::RenderingFlags::empty())
                    .render_area(scissors[0])
                    .layer_count(layer_count)
                    .view_mask(layer_mask)
                    .color_attachments(&color_attachments);
                unsafe { device.cmd_begin_rendering(cmd, &rendering_info) };
            }

            unsafe {
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
                device.cmd_draw(cmd, 3, 1, 0, 0);
            }

            if !self.dynamic() {
                self.cmd_end_render_pass(cmd);
            } else {
                unsafe { device.cmd_end_rendering(cmd) };
            }

            self.mask_iteration_after_render(cmd, color_image.get());

            // Copy all image contents to their verification buffers
            let copy_region = vk::BufferImageCopy {
                buffer_offset: 0,
                buffer_row_length: 0,
                buffer_image_height: 0,
                image_subresource: vk::ImageSubresourceLayers {
                    aspect_mask: vk::ImageAspectFlags::COLOR,
                    mip_level: 0,
                    base_array_layer: 0,
                    layer_count,
                },
                image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                image_extent: fb_extent,
            };
            let layout = if p.use_general_layout {
                vk::ImageLayout::GENERAL
            } else {
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL
            };
            unsafe {
                device.cmd_copy_image_to_buffer(cmd, color_image.get(), layout, color_buffer.get(), &[copy_region])
            };

            // Global barrier to synchronize verification buffers to host reads.
            let transfer_to_host_barrier =
                make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[transfer_to_host_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }

            end_command_buffer(device, cmd)?;
            submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

            // Invalidate all allocations.
            invalidate_alloc(device, color_buffer.get_allocation())?;

            // Verify all layers in all images; exact results are expected.
            let data = unsafe {
                std::slice::from_raw_parts(
                    color_buffer.get_allocation().get_host_ptr(),
                    color_layer_size * layer_count as usize,
                )
            };
            for layer_idx in 0..layer_count {
                let layer_written = layer_mask & (1 << layer_idx) != 0;
                let layer_data =
                    &data[color_layer_size * layer_idx as usize..color_layer_size * (layer_idx as usize + 1)];
                // Needs to match frag shader.
                let expected: [u8; 4] = if layer_written {
                    [layer_idx as u8, 255, 0, 255]
                } else {
                    [0, 0, 0, 0]
                };
                if !layer_data.chunks_exact(4).all(|pixel| pixel == expected) {
                    failure = true;
                }
            }
        }

        if failure {
            return Ok(TestStatus::fail(
                "Invalid value found in verification buffers; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }
}
