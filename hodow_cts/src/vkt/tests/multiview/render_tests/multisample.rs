// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/multiview/vktMultiViewRenderTests.cpp (MultiViewMultisampleTestInstance)
//
// Modifications: rewritten in Rust for hodow_cts.

use super::*;

impl<'a> Run<'a> {
    /// `MultiViewMultisampleTestInstance::iterate`
    pub(super) fn iterate_multisample(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let p = &self.p;
        let subpass_count = p.view_masks.len() as u32;
        let use_resolve_attachment = self.kind == TestType::MultisampleResolve;

        let color_attachment = ImageAttachment::new(context, p.extent, p.color_format, p.samples)?;
        let resolve_attachment = ImageAttachment::new(context, p.extent, p.color_format, vk::SampleCountFlags::_1)?;

        // FrameBuffer & renderPass
        let mut render_pass = None;
        let mut framebuffer = None;
        if !self.dynamic() {
            let opts = RenderPassOptions {
                samples: vk::SampleCountFlags::_4,
                use_general_layout: p.use_general_layout,
                use_resolve: use_resolve_attachment,
                ..RenderPassOptions::new(p.view_masks.clone())
            };
            let created = self.make_render_pass(&opts)?;
            let mut views = vec![*color_attachment.view];
            if use_resolve_attachment {
                views.push(*resolve_attachment.view);
            }
            framebuffer = Some(make_framebuffer(
                device,
                *created,
                &views,
                p.extent.width,
                p.extent.height,
                1,
            )?);
            render_pass = Some(created);
        }
        let render_pass_handle = render_pass.as_ref().map_or_else(vk::RenderPass::null, |rp| **rp);
        let framebuffer_handle = framebuffer.as_ref().map_or_else(vk::Framebuffer::null, |fb| **fb);

        // pipelineLayout and pipelines
        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let modules = self.load_stage_modules()?;
        let stage_infos = stage_infos(&modules);
        let mut pipelines = Vec::new();
        for subpass_ndx in 0..subpass_count {
            pipelines.push(self.make_graphics_pipeline(
                render_pass_handle,
                *pipeline_layout,
                &stage_infos,
                subpass_ndx,
                &PipelineOptions::default(),
            )?);
        }

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        let data = create_vertex_data(self.kind, p.extent, 0);
        let vertex_coord_buffer = create_host_buffer(context, &data.coord, vk::BufferUsageFlags::VERTEX_BUFFER)?;
        let vertex_color_buffer = create_host_buffer(context, &data.color, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        let frame = Frame {
            cmd: *cmd_buffer,
            render_pass: render_pass_handle,
            framebuffer: framebuffer_handle,
            color_image: color_attachment.image.get(),
            color_view: *color_attachment.view,
            resolve_image: resolve_attachment.image.get(),
            resolve_view: *resolve_attachment.view,
            ds_image: vk::Image::null(),
            ds_view: vk::ImageView::null(),
            pipelines: pipelines.iter().map(|pipeline| pipeline.get()).collect(),
            pipeline_layout: *pipeline_layout,
            vertex_buffers: [vertex_coord_buffer.get(), vertex_color_buffer.get()],
            index_buffer: None,
            descriptor_set: None,
        };

        self.draw_multisample(&frame, use_resolve_attachment)?;

        let result = self.read_image(&frame, frame.resolve_image)?;
        let reference = self.image_data(&data);
        if !self.check_image(&self.result_pixels(&result, p.color_format), &reference) {
            return Ok(TestStatus::fail("Fail"));
        }
        Ok(TestStatus::pass("Pass"))
    }

    /// `MultiViewMultisampleTestInstance::draw` and `afterRenderPass`
    fn draw_multisample(&self, f: &Frame, use_resolve_attachment: bool) -> Result<(), TestError> {
        let device = self.context.get_device();
        let subpass_count = self.p.view_masks.len() as u32;
        let draw_count_per_subpass = if subpass_count == 1 { SQUARE_COUNT } else { 1 };
        let vertex_per_primitive = 3u32;
        let vertex_buffer_offsets = [0u64, 0u64];
        let resolve_image = if use_resolve_attachment {
            f.resolve_image
        } else {
            vk::Image::null()
        };
        let subresource_layers = vk::ImageSubresourceLayers {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            mip_level: 0,
            base_array_layer: 0,
            layer_count: self.p.extent.depth,
        };
        let image_resolve_region = vk::ImageResolve {
            src_subresource: subresource_layers,
            src_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            dst_subresource: subresource_layers,
            dst_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            extent: vk::Extent3D {
                width: self.p.extent.width,
                height: self.p.extent.height,
                depth: 1,
            },
        };

        begin_command_buffer(device, f.cmd)?;
        self.before_render_pass(f, resolve_image);

        if !self.dynamic() {
            self.cmd_begin_render_pass(f, vk::SubpassContents::INLINE);
        }

        for subpass_ndx in 0..subpass_count {
            unsafe {
                device.cmd_bind_vertex_buffers(f.cmd, 0, &f.vertex_buffers, &vertex_buffer_offsets);
                device.cmd_bind_pipeline(
                    f.cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    f.pipelines[subpass_ndx as usize],
                );
            }

            if self.dynamic() {
                let resolve_view = if use_resolve_attachment {
                    f.resolve_view
                } else {
                    vk::ImageView::null()
                };
                self.add_rendering_subpass_dependency_if_required(f, subpass_ndx, resolve_image);
                self.begin_subpass_rendering_with(
                    f,
                    subpass_ndx,
                    vk::RenderingFlags::empty(),
                    if subpass_ndx != 0 {
                        vk::AttachmentLoadOp::LOAD
                    } else {
                        vk::AttachmentLoadOp::CLEAR
                    },
                    clear_value_color([0.0; 4]),
                    resolve_view,
                );
            }

            for draw_ndx in 0..draw_count_per_subpass {
                unsafe {
                    device.cmd_draw(
                        f.cmd,
                        vertex_per_primitive,
                        1,
                        (draw_ndx + subpass_ndx % SQUARE_COUNT) * vertex_per_primitive,
                        0,
                    )
                };
            }

            self.end_subpass(f, subpass_ndx, subpass_count, vk::SubpassContents::INLINE);
        }

        if !self.dynamic() {
            self.cmd_end_render_pass(f.cmd);
        }

        // `afterRenderPass`
        self.image_barrier(
            f.cmd,
            f.color_image,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::GENERAL,
            vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::PipelineStageFlags::TRANSFER,
        );
        let initial_resolve_layout = if use_resolve_attachment {
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL
        } else {
            vk::ImageLayout::UNDEFINED
        };
        let src_access = if use_resolve_attachment {
            vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE
        } else {
            vk::AccessFlags::empty()
        };
        self.image_barrier(
            f.cmd,
            f.resolve_image,
            initial_resolve_layout,
            vk::ImageLayout::GENERAL,
            src_access,
            vk::AccessFlags::TRANSFER_WRITE,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::PipelineStageFlags::TRANSFER,
        );

        if !use_resolve_attachment {
            unsafe {
                device.cmd_resolve_image(
                    f.cmd,
                    f.color_image,
                    vk::ImageLayout::GENERAL,
                    f.resolve_image,
                    vk::ImageLayout::GENERAL,
                    &[image_resolve_region],
                )
            };
        }

        end_command_buffer(device, f.cmd)?;
        submit_commands_and_wait(device, self.context.get_universal_queue(), f.cmd)
    }
}
