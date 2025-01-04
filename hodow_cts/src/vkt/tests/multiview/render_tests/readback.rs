// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/multiview/vktMultiViewRenderTests.cpp (MultiViewReadbackTestInstance)
//
// Modifications: rewritten in Rust for hodow_cts.

use super::*;

impl<'a> Run<'a> {
    /// `MultiViewReadbackTestInstance::iterate`
    pub(super) fn iterate_readback(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let p = &self.p;
        let subpass_count = p.view_masks.len() as u32;
        let implicit_clear = self.kind == TestType::ReadbackImplicitClear;

        let color_attachment = ImageAttachment::new(context, p.extent, p.color_format, vk::SampleCountFlags::_1)?;

        // The four quarters of the image
        let half_width = p.extent.width / 2;
        let half_height = p.extent.height / 2;
        let mut quarters = Vec::new();
        for x in 0..2 {
            for y in 0..2 {
                quarters.push(vk::Rect2D {
                    offset: vk::Offset2D {
                        x: half_width as i32 * x,
                        y: half_height as i32 * y,
                    },
                    extent: vk::Extent2D {
                        width: half_width,
                        height: half_height,
                    },
                });
            }
        }

        // createCommandBuffer
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        for pass in 0..2 {
            let full_clear_pass = pass == 0;
            let load_op = if !full_clear_pass {
                vk::AttachmentLoadOp::LOAD
            } else if implicit_clear {
                vk::AttachmentLoadOp::CLEAR
            } else {
                vk::AttachmentLoadOp::DONT_CARE
            };

            let mut render_pass = None;
            let mut framebuffer = None;
            if !self.dynamic() {
                let opts = RenderPassOptions {
                    color_load_op: load_op,
                    use_general_layout: p.use_general_layout,
                    ..RenderPassOptions::new(p.view_masks.clone())
                };
                let created = self.make_render_pass(&opts)?;
                framebuffer = Some(make_framebuffer(
                    device,
                    *created,
                    &[*color_attachment.view],
                    p.extent.width,
                    p.extent.height,
                    1,
                )?);
                render_pass = Some(created);
            }
            let render_pass_handle = render_pass.as_ref().map_or_else(vk::RenderPass::null, |rp| **rp);
            let framebuffer_handle = framebuffer.as_ref().map_or_else(vk::Framebuffer::null, |fb| **fb);

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

            let frame = Frame {
                cmd: *cmd_buffer,
                render_pass: render_pass_handle,
                framebuffer: framebuffer_handle,
                color_image: color_attachment.image.get(),
                color_view: *color_attachment.view,
                resolve_image: vk::Image::null(),
                resolve_view: vk::ImageView::null(),
                ds_image: vk::Image::null(),
                ds_view: vk::ImageView::null(),
                pipelines: pipelines.iter().map(|pipeline| pipeline.get()).collect(),
                pipeline_layout: *pipeline_layout,
                vertex_buffers: [vk::Buffer::null(); 2],
                index_buffer: None,
                descriptor_set: None,
            };

            self.draw_clears(&frame, &quarters, full_clear_pass)?;
        }

        let frame = Frame {
            cmd: *cmd_buffer,
            render_pass: vk::RenderPass::null(),
            framebuffer: vk::Framebuffer::null(),
            color_image: color_attachment.image.get(),
            color_view: *color_attachment.view,
            resolve_image: vk::Image::null(),
            resolve_view: vk::ImageView::null(),
            ds_image: vk::Image::null(),
            ds_view: vk::ImageView::null(),
            pipelines: Vec::new(),
            pipeline_layout: vk::PipelineLayout::null(),
            vertex_buffers: [vk::Buffer::null(); 2],
            index_buffer: None,
            descriptor_set: None,
        };
        let result = self.read_image(&frame, frame.color_image)?;
        let no_vertices = VertexData {
            coord: Vec::new(),
            color: Vec::new(),
            indices: Vec::new(),
        };
        let reference = self.image_data(&no_vertices);
        if !self.check_image(&self.result_pixels(&result, p.color_format), &reference) {
            return Ok(TestStatus::fail("Fail"));
        }
        Ok(TestStatus::pass("Pass"))
    }

    /// `MultiViewReadbackTestInstance::clear`
    fn clear_rect(&self, cmd: vk::CommandBuffer, clear_rect_2d: vk::Rect2D, clear_color: [f32; 4]) {
        let clear_rect = vk::ClearRect {
            rect: clear_rect_2d,
            base_array_layer: 0,
            layer_count: 1,
        };
        let clear_attachment = vk::ClearAttachment {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            color_attachment: 0,
            clear_value: clear_value_color(clear_color),
        };
        unsafe {
            self.context
                .get_device()
                .cmd_clear_attachments(cmd, &[clear_attachment], &[clear_rect])
        };
    }

    /// `MultiViewReadbackTestInstance::drawClears`
    fn draw_clears(&self, f: &Frame, quarters: &[vk::Rect2D], clear_pass: bool) -> Result<(), TestError> {
        let device = self.context.get_device();
        let subpass_count = self.p.view_masks.len() as u32;
        let render_area = self.render_area();
        let table = color_table();
        let render_pass_clear_value = clear_value_color(table[0]);
        let draw_count_per_subpass = if subpass_count == 1 { SQUARE_COUNT } else { 1 };
        let with_clear_color = clear_pass && self.kind == TestType::ReadbackImplicitClear;

        begin_command_buffer(device, f.cmd)?;

        if clear_pass {
            self.before_render_pass(f, vk::Image::null());
        }

        if !self.dynamic() {
            let clear_values = [render_pass_clear_value];
            let mut begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(f.render_pass)
                .framebuffer(f.framebuffer)
                .render_area(render_area);
            if with_clear_color {
                begin_info = begin_info.clear_values(&clear_values);
            }
            self.cmd_begin_render_pass_with(f.cmd, &begin_info, vk::SubpassContents::INLINE);
        }

        for subpass_ndx in 0..subpass_count {
            unsafe {
                device.cmd_bind_pipeline(
                    f.cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    f.pipelines[subpass_ndx as usize],
                )
            };

            if self.dynamic() {
                self.add_rendering_subpass_dependency_if_required(f, subpass_ndx, vk::Image::null());

                let mut load_operation = vk::AttachmentLoadOp::LOAD;
                if clear_pass {
                    load_operation = if self.kind == TestType::ReadbackImplicitClear {
                        vk::AttachmentLoadOp::CLEAR
                    } else {
                        vk::AttachmentLoadOp::DONT_CARE
                    };
                }
                self.begin_subpass_rendering_with(
                    f,
                    subpass_ndx,
                    vk::RenderingFlags::empty(),
                    load_operation,
                    render_pass_clear_value,
                    vk::ImageView::null(),
                );
            }

            if clear_pass {
                if self.kind == TestType::ReadbackExplicitClear {
                    self.clear_rect(f.cmd, render_area, table[subpass_ndx as usize % 4]);
                }
            } else {
                for draw_ndx in 0..draw_count_per_subpass {
                    let primitive_number = (draw_ndx + subpass_ndx % SQUARE_COUNT) as usize;
                    self.clear_rect(f.cmd, quarters[primitive_number], table[4 + primitive_number]);
                }
            }

            self.end_subpass(f, subpass_ndx, subpass_count, vk::SubpassContents::INLINE);
        }

        if !self.dynamic() {
            self.cmd_end_render_pass(f.cmd);
        }

        if !clear_pass {
            self.after_render_pass(f);
        }

        end_command_buffer(device, f.cmd)?;
        submit_commands_and_wait(device, self.context.get_universal_queue(), f.cmd)
    }
}
