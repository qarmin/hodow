// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/multiview/vktMultiViewRenderTests.cpp (MultiViewDepthStencilTestInstance)
//
// Modifications: rewritten in Rust for hodow_cts.

use vulkanalia::vk::DeviceV1_3;

use super::*;

const DS_FORMATS: [vk::Format; 2] = [vk::Format::D24_UNORM_S8_UINT, vk::Format::D32_SFLOAT_S8_UINT];

/// `VK_IMAGE_ASPECT_DEPTH_BIT | VK_IMAGE_ASPECT_STENCIL_BIT` over all layers.
fn ds_range(layers: u32) -> vk::ImageSubresourceRange {
    make_image_subresource_range(
        vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL,
        0,
        1,
        0,
        layers,
    )
}

impl<'a> Run<'a> {
    fn depth_test(&self) -> bool {
        matches!(
            self.kind,
            TestType::Depth | TestType::DepthWithoutFragmentShader | TestType::DepthDifferentRanges
        )
    }

    fn stencil_test(&self) -> bool {
        self.kind == TestType::Stencil
    }

    /// The depth the quads of a subpass are drawn at (`getQuarterRefColor(0, 0, 0, true, subpass)[0]`).
    fn quad_depth(&self, subpass_ndx: u32) -> f32 {
        let no_vertices = VertexData {
            coord: Vec::new(),
            color: Vec::new(),
            indices: Vec::new(),
        };
        self.quarter_ref_color(&no_vertices, 0, 0, 0, true, subpass_ndx)[0]
    }

    /// `getDepthRanges`
    fn get_depth_ranges(&self) -> Vec<[f32; 2]> {
        if self.kind == TestType::DepthDifferentRanges {
            return vec![
                // ranges used when four quads from part A are drawn
                [0.0, 1.0],
                [0.5, 1.0],
                [0.0, 0.5],
                [0.0, 1.0],
                // ranges used when four quads from part B are drawn
                [0.0, 0.5],
                [0.0, 1.0],
                [0.5, 1.0],
                [0.0, 0.5],
                // ranges used when part B is drawn once again
                [0.5, 1.0],
                [0.0, 0.5],
                [0.0, 0.5],
                [0.0, 1.0],
            ];
        }

        // by defaul use <0; 1> range for all subpasses
        vec![[0.0, 1.0]; self.p.view_masks.len()]
    }

    /// `MultiViewDepthStencilTestInstance::createVertexData`: eight quads, the four horizontal ones of part A and the four vertical
    /// ones of part B, each at the depth of its subpass.
    fn create_vertex_data_depth_stencil(&self) -> VertexData {
        let mut data = VertexData {
            coord: Vec::new(),
            color: Vec::new(),
            indices: Vec::new(),
        };
        let color = [0.0, 0.0, 0.0, 1.0]; // is not essential in this test

        // (x0, y0, x1, y1) of each quad; the vertices run (x0, y0), (x0, y1), (x1, y0), (x1, y1).
        let quads = [
            // part A - four horizontal quads
            (-1.0, -0.5, 0.0, 0.0), // when testing TEST_TYPE_DEPTH_DIFFERENT_RANGES this quad will have depth 1.2 and will be clipped in all views
            (-1.0, 0.0, 0.0, 0.5),
            (0.0, -0.5, 1.0, 0.0),
            (0.0, 0.0, 1.0, 0.5),
            // part B - four vertical quads
            (-0.5, -1.0, 0.0, 0.0),
            (-0.5, 0.0, 0.0, 1.0),
            (0.0, -1.0, 0.5, 0.0),
            (0.0, 0.0, 0.5, 1.0), // when testing TEST_TYPE_DEPTH_DIFFERENT_RANGES this quad will have depth -0.05 and will be clipped in all views
        ];
        for (subpass_ndx, (x0, y0, x1, y1)) in quads.into_iter().enumerate() {
            let depth = self.quad_depth(subpass_ndx as u32);
            data.append([x0, y0, depth, 1.0], color);
            data.append([x0, y1, depth, 1.0], color);
            data.append([x1, y0, depth, 1.0], color);
            data.append([x1, y1, depth, 1.0], color);
        }
        data
    }

    /// `getVerificationFormat`
    fn verification_format(&self) -> vk::Format {
        if self.p.color_format == vk::Format::UNDEFINED {
            vk::Format::R8G8B8A8_UNORM
        } else {
            self.p.color_format
        }
    }

    /// `fillQuarter` for the depth and stencil tests: the quarter is narrowed to a bar, and the stencil value adds up while the
    /// depth is the lesser of what is there and what is drawn.
    fn fill_quarter_depth_stencil(
        &self,
        reference: &mut Reference,
        color: [f32; 4],
        layer: i32,
        quarter: u32,
        subpass_ndx: u32,
    ) {
        let h = self.p.extent.height as i32;
        let h2 = h / 2;
        let w = self.p.extent.width as i32;
        let w2 = w / 2;

        let (mut x_start, mut x_end, mut y_start, mut y_end) = match quarter {
            0 => (0, w2, 0, h2),
            1 => (0, w2, h2, h),
            2 => (w2, w, 0, h2),
            _ => (w2, w, h2, h),
        };

        if subpass_ndx < 4 {
            // Part A: Horizontal bars near X axis
            y_start = h2 + (y_start - h2) / 2;
            y_end = h2 + (y_end - h2) / 2;
        } else {
            // Part B: Vertical bars near Y axis (drawn twice)
            x_start = w2 + (x_start - w2) / 2;
            x_end = w2 + (x_end - w2) / 2;
        }

        // Update pixels in area
        if self.kind == TestType::Stencil {
            for y in y_start..y_end {
                for x in x_start..x_end {
                    let current = reference.get_pixel(x, y, layer);
                    reference.set_pixel(add4(current, color), x, y, layer);
                }
            }
        } else {
            for y in y_start..y_end {
                for x in x_start..x_end {
                    let current_color = reference.get_pixel(x, y, layer);
                    let new_color = if current_color[0] < color[0] {
                        current_color
                    } else {
                        color
                    };
                    reference.set_pixel(new_color, x, y, layer);
                }
            }
        }
    }

    /// `MultiViewDepthStencilTestInstance::imageData`
    fn image_data_depth_stencil(&self) -> Reference {
        let mut reference = Reference::new(self.p.extent, self.verification_format());
        let subpass_count = self.p.view_masks.len() as u32;
        let depth_ranges = self.get_depth_ranges();
        let no_vertices = VertexData {
            coord: Vec::new(),
            color: Vec::new(),
            indices: Vec::new(),
        };

        for layer_ndx in 0..self.p.extent.depth {
            reference.fill_layer(
                self.quarter_ref_color(&no_vertices, 0, 0, 0, false, 0),
                layer_ndx as i32,
            );
        }

        for subpass_ndx in 0..subpass_count {
            let mut layer_ndx = 0i32;
            let mut mask = self.p.view_masks[subpass_ndx as usize];
            let [depth_min, depth_max] = depth_ranges[subpass_ndx as usize];

            // iterate over image layers
            while mask > 0 {
                if mask & 1 != 0 {
                    let subpass_quarter_ndx = subpass_ndx % SQUARE_COUNT;
                    let color_ndx = (subpass_quarter_ndx * 4) as usize;
                    let mut color = self.quarter_ref_color(
                        &no_vertices,
                        subpass_quarter_ndx,
                        color_ndx,
                        layer_ndx,
                        true,
                        subpass_ndx,
                    );

                    if self.kind == TestType::DepthDifferentRanges {
                        // quads with depth out of range should be cliiped to simplify code we are drawing them with background color
                        if color[0] < 0.0 || color[0] > 1.0 {
                            color[0] = 1.0;
                        } else {
                            let depth_clamped = color[0].clamp(0.0, 1.0);
                            color[0] = depth_clamped * depth_max + (1.0 - depth_clamped) * depth_min;
                        }
                    }

                    self.fill_quarter_depth_stencil(&mut reference, color, layer_ndx, subpass_quarter_ndx, subpass_ndx);
                }

                mask >>= 1;
                layer_ndx += 1;
            }
        }
        reference
    }

    /// `MultiViewDepthStencilTestInstance::readImage`: the depth or the stencil aspect, translated into colour space.
    fn read_image_depth_stencil(&self, f: &Frame, ds_format: vk::Format) -> Result<Vec<[f32; 4]>, TestError> {
        let context = self.context;
        let device = context.get_device();
        let extent = self.p.extent;
        let depth_test = self.depth_test();
        let pixel_size = if depth_test { 4usize } else { 1 };
        let pixel_data_size = (extent.width * extent.height * extent.depth) as usize * pixel_size;

        let buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(pixel_data_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe { std::ptr::write_bytes(buffer.get_allocation().get_host_ptr(), 0xCC, pixel_data_size) };
        flush_alloc(device, buffer.get_allocation())?;

        let buffer_barrier = vk::BufferMemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
            .dst_access_mask(vk::AccessFlags::HOST_READ)
            .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .buffer(buffer.get())
            .offset(0)
            .size(pixel_data_size as vk::DeviceSize)
            .build();
        let aspect = if depth_test {
            vk::ImageAspectFlags::DEPTH
        } else {
            vk::ImageAspectFlags::STENCIL
        };
        let copy_region = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: extent.width,
            buffer_image_height: extent.height,
            image_subresource: vk::ImageSubresourceLayers {
                aspect_mask: aspect,
                mip_level: 0,
                base_array_layer: 0,
                layer_count: extent.depth,
            },
            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            image_extent: vk::Extent3D {
                width: extent.width,
                height: extent.height,
                depth: 1,
            },
        };

        begin_command_buffer(device, f.cmd)?;
        unsafe {
            device.cmd_copy_image_to_buffer(
                f.cmd,
                f.ds_image,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                buffer.get(),
                &[copy_region],
            );
            device.cmd_pipeline_barrier(
                f.cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[buffer_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, f.cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), f.cmd)?;

        invalidate_alloc(device, buffer.get_allocation())?;
        let bytes = unsafe { std::slice::from_raw_parts(buffer.get_allocation().get_host_ptr(), pixel_data_size) };
        let quantize = self.verification_format() == vk::Format::R8G8B8A8_UNORM;
        let to_color_space = |color: [f32; 4]| {
            if quantize {
                color.map(|c| to_unorm8(c) as f32 / 255.0)
            } else {
                color
            }
        };

        if depth_test {
            // Translate depth into color space
            return Ok(bytes
                .chunks_exact(4)
                .map(|texel| {
                    let depth = if ds_format == vk::Format::D24_UNORM_S8_UINT {
                        (u32::from_le_bytes([texel[0], texel[1], texel[2], texel[3]]) & 0x00ff_ffff) as f32
                            / 16_777_215.0
                    } else {
                        f32::from_le_bytes([texel[0], texel[1], texel[2], texel[3]])
                    };
                    to_color_space([depth, 0.0, 0.0, 1.0])
                })
                .collect());
        }

        // Translate stencil into color space
        let no_vertices = VertexData {
            coord: Vec::new(),
            color: Vec::new(),
            indices: Vec::new(),
        };
        let base_color = self.quarter_ref_color(&no_vertices, 0, 0, 0, false, 0);
        let color_step = self.quarter_ref_color(&no_vertices, 0, 0, 0, true, 0);
        let color_map = [
            base_color,
            [color_step[0], 0.0, 0.0, 1.0],
            [2.0 * color_step[0], 0.0, 0.0, 1.0],
            [3.0 * color_step[0], 0.0, 0.0, 1.0],
        ];
        let invalid_color = [0.0; 4];
        Ok(bytes
            .iter()
            .map(|&stencil| to_color_space(color_map.get(stencil as usize).copied().unwrap_or(invalid_color)))
            .collect())
    }

    /// `MultiViewDepthStencilTestInstance::beforeRenderPass`
    fn before_render_pass_depth_stencil(&self, f: &Frame) -> Result<(), TestError> {
        let device = self.context.get_device();
        self.before_render_pass(f, vk::Image::null());

        let subresource_range = ds_range(self.p.extent.depth);
        let barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            f.ds_image,
            subresource_range,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                f.cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            );
        }

        let depth_range_unrestricted_enabled = self
            .context
            .get_device_extensions()
            .iter()
            .any(|extension| extension == "VK_EXT_depth_range_unrestricted");
        let base_color = self.quarter_ref_color(
            &VertexData {
                coord: Vec::new(),
                color: Vec::new(),
                indices: Vec::new(),
            },
            0,
            0,
            0,
            false,
            0,
        );
        let clear_depth = base_color[0];
        if clear_depth > 1.0 && !depth_range_unrestricted_enabled {
            return Err(TestError::NotSupported(
                "VK_EXT_depth_range_unrestricted not supported".to_string(),
            ));
        }
        let clear_value = vk::ClearDepthStencilValue {
            depth: clear_depth,
            stencil: 0,
        };
        unsafe {
            device.cmd_clear_depth_stencil_image(
                f.cmd,
                f.ds_image,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &clear_value,
                &[subresource_range],
            )
        };

        let barrier = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            f.ds_image,
            subresource_range,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                f.cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            );
        }
        Ok(())
    }

    /// `MultiViewDepthStencilTestInstance::addRenderingSubpassDependencyIfRequired`
    fn add_rendering_subpass_dependency_depth_stencil(&self, f: &Frame, current_subpass_ndx: u32) {
        self.add_rendering_subpass_dependency_if_required(f, current_subpass_ndx, vk::Image::null());

        // Get the combined view mask since the last pipeline barrier.
        let mut view_mask = 0u32;
        for subpass_ndx in 0..current_subpass_ndx {
            if view_mask & self.p.view_masks[subpass_ndx as usize] != 0 {
                view_mask = 0; // This subpass should have a pipeline barrier so reset the view mask.
            }
            view_mask |= self.p.view_masks[subpass_ndx as usize];
        }

        // Add a pipeline barrier if the view mask for this subpass contains bits used in previous subpasses since the last pipeline
        // barrier.
        if view_mask & self.p.view_masks[current_subpass_ndx as usize] != 0 {
            let barrier = make_image_memory_barrier(
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                f.ds_image,
                ds_range(self.p.extent.depth),
            );
            unsafe {
                self.context.get_device().cmd_pipeline_barrier(
                    f.cmd,
                    vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                    vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[barrier],
                );
            }
        }
    }

    /// `MultiViewDepthStencilTestInstance::draw` and `afterRenderPass`
    fn draw_depth_stencil(&self, f: &Frame) -> Result<(), TestError> {
        let device = self.context.get_device();
        let subpass_count = self.p.view_masks.len() as u32;
        let draw_count_per_subpass = if subpass_count == 1 { SQUARE_COUNT } else { 1 };
        let vertex_per_primitive = 4u32;
        let vertex_buffer_offsets = [0u64, 0u64];

        begin_command_buffer(device, f.cmd)?;
        self.before_render_pass_depth_stencil(f)?;

        if !self.dynamic() {
            self.cmd_begin_render_pass(f, vk::SubpassContents::INLINE);
        }

        for subpass_ndx in 0..subpass_count {
            let first_vertex_offset = if subpass_ndx < 4 {
                0
            } else {
                SQUARE_COUNT * vertex_per_primitive
            };

            unsafe {
                device.cmd_bind_vertex_buffers(f.cmd, 0, &f.vertex_buffers, &vertex_buffer_offsets);
                device.cmd_bind_pipeline(
                    f.cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    f.pipelines[subpass_ndx as usize],
                );
            }

            if self.dynamic() {
                self.add_rendering_subpass_dependency_depth_stencil(f, subpass_ndx);

                let mut color_attachments = Vec::new();
                if f.color_image != vk::Image::null() {
                    color_attachments.push(
                        vk::RenderingAttachmentInfo::builder()
                            .image_view(f.color_view)
                            .image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                            .resolve_mode(vk::ResolveModeFlags::NONE)
                            .resolve_image_layout(vk::ImageLayout::UNDEFINED)
                            .load_op(vk::AttachmentLoadOp::LOAD)
                            .store_op(vk::AttachmentStoreOp::STORE)
                            .clear_value(clear_value_color([0.0; 4]))
                            .build(),
                    );
                }

                let ds_attachment = vk::RenderingAttachmentInfo::builder()
                    .image_view(f.ds_view)
                    .image_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                    .resolve_mode(vk::ResolveModeFlags::NONE)
                    .resolve_image_layout(vk::ImageLayout::UNDEFINED)
                    .load_op(vk::AttachmentLoadOp::LOAD)
                    .store_op(vk::AttachmentStoreOp::STORE)
                    .clear_value(vk::ClearValue {
                        depth_stencil: vk::ClearDepthStencilValue { depth: 0.0, stencil: 0 },
                    })
                    .build();

                let mut rendering_info = vk::RenderingInfo::builder()
                    .flags(vk::RenderingFlags::empty())
                    .render_area(self.render_area())
                    .layer_count(self.p.extent.depth)
                    .view_mask(self.p.view_masks[subpass_ndx as usize])
                    .color_attachments(&color_attachments);
                if self.depth_test() {
                    rendering_info = rendering_info.depth_attachment(&ds_attachment);
                }
                if self.stencil_test() {
                    rendering_info = rendering_info.stencil_attachment(&ds_attachment);
                }
                unsafe { device.cmd_begin_rendering(f.cmd, &rendering_info) };
            }

            for draw_ndx in 0..draw_count_per_subpass {
                unsafe {
                    device.cmd_draw(
                        f.cmd,
                        vertex_per_primitive,
                        1,
                        first_vertex_offset + (draw_ndx + subpass_ndx % SQUARE_COUNT) * vertex_per_primitive,
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
        self.after_render_pass(f);
        self.image_barrier_depth_stencil(f);

        end_command_buffer(device, f.cmd)?;
        submit_commands_and_wait(device, self.context.get_universal_queue(), f.cmd)
    }

    /// The depth/stencil half of `MultiViewDepthStencilTestInstance::afterRenderPass`.
    fn image_barrier_depth_stencil(&self, f: &Frame) {
        let barrier = make_image_memory_barrier(
            vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            f.ds_image,
            ds_range(self.p.extent.depth),
        );
        unsafe {
            self.context.get_device().cmd_pipeline_barrier(
                f.cmd,
                vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            );
        }
    }

    /// `MultiViewDepthStencilTestInstance::iterate`
    pub(super) fn iterate_depth_stencil(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let p = &self.p;
        let subpass_count = p.view_masks.len() as u32;

        // The first of the two formats the device can use as a depth/stencil attachment.
        let mut ds_format = vk::Format::UNDEFINED;
        for format in DS_FORMATS {
            let format_properties = unsafe {
                context
                    .get_instance()
                    .get_physical_device_format_properties(context.get_physical_device(), format)
            };
            if format_properties
                .optimal_tiling_features
                .contains(vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT)
            {
                ds_format = format;
                break;
            }
        }
        if ds_format == vk::Format::UNDEFINED {
            return Err(TestError::Fail(
                "Supported depth/stencil format not found, that violates specification".to_string(),
            ));
        }

        let color_attachment = if p.color_format != vk::Format::UNDEFINED {
            Some(ImageAttachment::new(
                context,
                p.extent,
                p.color_format,
                vk::SampleCountFlags::_1,
            )?)
        } else {
            None
        };
        let ds_attachment = ImageAttachment::new(context, p.extent, ds_format, vk::SampleCountFlags::_1)?;

        let mut render_pass = None;
        let mut framebuffer = None;
        if !self.dynamic() {
            let opts = RenderPassOptions {
                ds_format,
                use_general_layout: p.use_general_layout,
                ..RenderPassOptions::new(p.view_masks.clone())
            };
            let created = self.make_render_pass(&opts)?;
            let mut views = Vec::new();
            if let Some(color) = &color_attachment {
                views.push(*color.view);
            }
            views.push(*ds_attachment.view);
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

        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let depth_ranges = self.get_depth_ranges();
        let modules = self.load_stage_modules()?;
        let stage_infos = stage_infos(&modules);
        let mut pipelines = Vec::new();
        for subpass_ndx in 0..subpass_count {
            let [depth_min, depth_max] = depth_ranges[subpass_ndx as usize];
            let opts = PipelineOptions {
                use_depth_test: self.depth_test(),
                use_stencil_test: self.stencil_test(),
                min_depth: depth_min,
                max_depth: depth_max,
                ds_format,
            };
            pipelines.push(self.make_graphics_pipeline(
                render_pass_handle,
                *pipeline_layout,
                &stage_infos,
                subpass_ndx,
                &opts,
            )?);
        }

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        let data = self.create_vertex_data_depth_stencil();
        let vertex_coord_buffer = create_host_buffer(context, &data.coord, vk::BufferUsageFlags::VERTEX_BUFFER)?;
        let vertex_color_buffer = create_host_buffer(context, &data.color, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        let frame = Frame {
            cmd: *cmd_buffer,
            render_pass: render_pass_handle,
            framebuffer: framebuffer_handle,
            color_image: color_attachment
                .as_ref()
                .map_or_else(vk::Image::null, |color| color.image.get()),
            color_view: color_attachment
                .as_ref()
                .map_or_else(vk::ImageView::null, |color| *color.view),
            resolve_image: vk::Image::null(),
            resolve_view: vk::ImageView::null(),
            ds_image: ds_attachment.image.get(),
            ds_view: *ds_attachment.view,
            pipelines: pipelines.iter().map(|pipeline| pipeline.get()).collect(),
            pipeline_layout: *pipeline_layout,
            vertex_buffers: [vertex_coord_buffer.get(), vertex_color_buffer.get()],
            index_buffer: None,
            descriptor_set: None,
        };

        self.draw_depth_stencil(&frame)?;

        let result = self.read_image_depth_stencil(&frame, ds_format)?;
        let reference = self.image_data_depth_stencil();
        if !self.check_image(&result, &reference) {
            return Ok(TestStatus::fail("Fail"));
        }
        Ok(TestStatus::pass("Pass"))
    }
}
