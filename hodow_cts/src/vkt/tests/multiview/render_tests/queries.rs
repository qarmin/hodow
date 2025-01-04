// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/multiview/vktMultiViewRenderTests.cpp (MultiViewQueriesTestInstance)
//
// Modifications: rewritten in Rust for hodow_cts.

use super::*;

const VERTICES_PER_PRIMITIVE: u32 = 4;

/// What `draw` of the queries instance leaves behind for `iterate` to check.
#[derive(Default)]
struct QueryResults {
    occlusion_values: Vec<u64>,
    occlusion_expected_values: Vec<u64>,
    occlusion_availability_values: Vec<u64>,
    counter_series_start: Vec<bool>,
    counter_series_end: Vec<bool>,
    timestamp_start_values: Vec<u64>,
    timestamp_end_values: Vec<u64>,
    timestamp_start_availability_values: Vec<u64>,
    timestamp_end_availability_values: Vec<u64>,
}

/// `unpackValues`: single values, or pairs of (value, availability) when `dst2` is given.
fn unpack_values(src: &[u64], dst1: &mut [u64], dst2: Option<&mut [u64]>) {
    match dst2 {
        None => dst1.copy_from_slice(&src[..dst1.len()]),
        Some(dst2) => {
            for i in (0..src.len()).step_by(2) {
                let j = i / 2;
                dst1[j] = src[i];
                dst2[j] = src[i + 1];
            }
        }
    }
}

/// `verifyAvailabilityBits`
fn verify_availability_bits(bits: &[u64], set_name: &str) -> Result<(), TestError> {
    for (i, &bit) in bits.iter().enumerate() {
        if bit == 0 {
            return Err(TestError::Fail(format!("{set_name} availability bit {i} is 0")));
        }
    }
    Ok(())
}

/// A `u64` vector viewed as the bytes `vkGetQueryPoolResults` fills.
fn as_bytes_mut(values: &mut [u64]) -> &mut [u8] {
    unsafe { std::slice::from_raw_parts_mut(values.as_mut_ptr().cast::<u8>(), std::mem::size_of_val(values)) }
}

impl<'a> Run<'a> {
    /// `getUsedViewsCount`
    fn used_views_count(&self, view_mask_index: usize) -> u32 {
        self.p.view_masks[view_mask_index].count_ones()
    }

    /// `getQueryCountersNumber`
    fn query_counters_number(&self) -> u32 {
        (0..self.p.view_masks.len()).map(|i| self.used_views_count(i)).sum()
    }

    /// `MultiViewQueriesTestInstance::createVertexData`: the four quads, and a zoomed out copy of each that is occluded by it.
    /// Returns the vertices, the offset of the occluded ones and the number of pixels each of those covers.
    fn create_vertex_data_queries(&self) -> (VertexData, u32, Vec<u64>) {
        let mut data = VertexData {
            coord: Vec::new(),
            color: Vec::new(),
            indices: Vec::new(),
        };

        let mut color = [0.2, 0.0, 0.1, 1.0];
        data.append([-1.0, -1.0, 0.0, 1.0], color);
        data.append([-1.0, 0.0, 0.0, 1.0], color);
        data.append([0.0, -1.0, 0.0, 1.0], color);
        data.append([0.0, 0.0, 0.0, 1.0], color);

        color = [0.3, 0.0, 0.2, 1.0];
        data.append([-1.0, 0.0, 0.0, 1.0], color);
        data.append([-1.0, 1.0, 0.0, 1.0], color);
        data.append([0.0, 0.0, 0.0, 1.0], color);
        data.append([0.0, 1.0, 0.0, 1.0], color);

        color = [0.4, 0.2, 0.3, 1.0];
        data.append([0.0, -1.0, 0.0, 1.0], color);
        data.append([0.0, 0.0, 0.0, 1.0], color);
        data.append([1.0, -1.0, 0.0, 1.0], color);
        data.append([1.0, 0.0, 0.0, 1.0], color);

        color = [0.5, 0.0, 0.4, 1.0];
        data.append([0.0, 0.0, 0.0, 1.0], color);
        data.append([0.0, 1.0, 0.0, 1.0], color);
        data.append([1.0, 0.0, 0.0, 1.0], color);
        data.append([1.0, 1.0, 0.0, 1.0], color);

        // Create occluded square objects as zoom out of main
        let main_objects_vertices_count = data.coord.len() as u32;
        let main_objects_count = (main_objects_vertices_count / VERTICES_PER_PRIMITIVE) as usize;
        let occlusion_object_multiplier_x = [1u32, 2, 2, 1];
        let occlusion_object_multiplier_y = [1u32, 1, 3, 3];
        let occlusion_object_divisor_float = 4.0f32;

        let mut occlusion_object_pixels_count = Vec::new();
        for object_ndx in 0..main_objects_count {
            let object_start = object_ndx * VERTICES_PER_PRIMITIVE as usize;
            let x_ratio = occlusion_object_multiplier_x[object_ndx] as f32 / occlusion_object_divisor_float;
            let y_ratio = occlusion_object_multiplier_y[object_ndx] as f32 / occlusion_object_divisor_float;
            let area_ratio = x_ratio as f64 * y_ratio as f64;
            let occluded_pixels_count =
                (area_ratio * (self.p.extent.width / 2) as f64 * (self.p.extent.height / 2) as f64) as u64;

            occlusion_object_pixels_count.push(occluded_pixels_count);

            for vertex_ndx in 0..VERTICES_PER_PRIMITIVE as usize {
                let occluded_object_vertex_x_coord = data.coord[object_start + vertex_ndx][0] * x_ratio;
                let occluded_object_vertex_y_coord = data.coord[object_start + vertex_ndx][1] * y_ratio;
                let color = data.color[object_start + vertex_ndx];
                data.append(
                    [occluded_object_vertex_x_coord, occluded_object_vertex_y_coord, 1.0, 1.0],
                    color,
                );
            }
        }

        (data, main_objects_vertices_count, occlusion_object_pixels_count)
    }

    /// `MultiViewQueriesTestInstance::iterate`
    pub(super) fn iterate_queries(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let p = &self.p;
        let subpass_count = p.view_masks.len() as u32;

        let color_attachment = ImageAttachment::new(context, p.extent, p.color_format, vk::SampleCountFlags::_1)?;

        let mut render_pass = None;
        let mut framebuffer = None;
        if !self.dynamic() {
            let created = self.make_render_pass(&RenderPassOptions {
                use_general_layout: p.use_general_layout,
                ..RenderPassOptions::new(p.view_masks.clone())
            })?;
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

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        let (data, occlusion_objects_offset, occlusion_object_pixels_count) = self.create_vertex_data_queries();
        let vertex_coord_buffer = create_host_buffer(context, &data.coord, vk::BufferUsageFlags::VERTEX_BUFFER)?;
        let vertex_color_buffer = create_host_buffer(context, &data.color, vk::BufferUsageFlags::VERTEX_BUFFER)?;

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
            vertex_buffers: [vertex_coord_buffer.get(), vertex_color_buffer.get()],
            index_buffer: None,
            descriptor_set: None,
        };

        let results = self.draw_queries(&frame, occlusion_objects_offset, &occlusion_object_pixels_count)?;

        let mut occlusion_value = 0u64;
        let mut occlusion_expected_value = 0u64;
        for ndx in 0..results.counter_series_end.len() {
            occlusion_value += results.occlusion_values[ndx];
            occlusion_expected_value += results.occlusion_expected_values[ndx];

            if results.counter_series_end[ndx] {
                if self.kind.precise_queries() {
                    if occlusion_expected_value != occlusion_value {
                        return Ok(TestStatus::fail(format!(
                            "occlusion, result:{occlusion_value}, expected:{occlusion_expected_value}"
                        )));
                    }
                } else if occlusion_value == 0 {
                    // verify non precise occlusion query
                    return Ok(TestStatus::fail("occlusion, result: 0, expected non zero value"));
                }
            }
        }
        verify_availability_bits(&results.occlusion_availability_values, "occlusion")?;

        if self.kind.timestamp_queries() {
            for ndx in 0..results.timestamp_start_values.len() {
                let (start, end) = (results.timestamp_start_values[ndx], results.timestamp_end_values[ndx]);
                if results.counter_series_start[ndx] {
                    if end > 0 && end >= start {
                        continue;
                    }
                } else {
                    if end > 0 && end >= start {
                        continue;
                    }
                    if end == 0 && start == 0 {
                        continue;
                    }
                }

                return Ok(TestStatus::fail("timestamp"));
            }
            verify_availability_bits(&results.timestamp_start_availability_values, "timestamp start")?;
            verify_availability_bits(&results.timestamp_end_availability_values, "timestamp end")?;
        }

        Ok(TestStatus::pass("Pass"))
    }

    /// `MultiViewQueriesTestInstance::draw`
    fn draw_queries(
        &self,
        f: &Frame,
        occlusion_objects_offset: u32,
        occlusion_object_pixels_count: &[u64],
    ) -> Result<QueryResults, TestError> {
        let context = self.context;
        let device = context.get_device();
        let subpass_count = self.p.view_masks.len() as u32;
        let vertex_buffer_offsets = [0u64, 0u64];
        let draw_count_per_subpass = if subpass_count == 1 { SQUARE_COUNT } else { 1 };
        let query_counters_number = if subpass_count == 1 {
            SQUARE_COUNT * self.used_views_count(0)
        } else {
            self.query_counters_number()
        };
        let occlusion_query_flags = if self.kind.precise_queries() {
            vk::QueryControlFlags::PRECISE
        } else {
            vk::QueryControlFlags::empty()
        };

        let occlusion_query_pool_create_info = vk::QueryPoolCreateInfo::builder()
            .query_type(vk::QueryType::OCCLUSION)
            .query_count(query_counters_number);
        let timestamp_query_pool_create_info = vk::QueryPoolCreateInfo::builder()
            .query_type(vk::QueryType::TIMESTAMP)
            .query_count(query_counters_number);
        let occlusion_query_pool = Unique::new(
            device,
            unsafe { device.create_query_pool(&occlusion_query_pool_create_info, None) }
                .vk_check("vkCreateQueryPool")?,
        );
        let timestamp_start_query_pool = Unique::new(
            device,
            unsafe { device.create_query_pool(&timestamp_query_pool_create_info, None) }
                .vk_check("vkCreateQueryPool")?,
        );
        let timestamp_end_query_pool = Unique::new(
            device,
            unsafe { device.create_query_pool(&timestamp_query_pool_create_info, None) }
                .vk_check("vkCreateQueryPool")?,
        );
        let mut query_start_index = 0u32;

        let with_availability = self.kind == TestType::NonPreciseQueriesWithAvailability;
        let values_per_query = if with_availability { 2u32 } else { 1 };
        let values_number = (query_counters_number * values_per_query) as usize;
        let query_stride = (std::mem::size_of::<u64>() as u32 * values_per_query) as vk::DeviceSize;
        let query_flags = vk::QueryResultFlags::_64
            | vk::QueryResultFlags::WAIT
            | if with_availability {
                vk::QueryResultFlags::WITH_AVAILABILITY
            } else {
                vk::QueryResultFlags::empty()
            };

        let query_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(
                (values_number * std::mem::size_of::<u64>()) as vk::DeviceSize,
                vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let mut results = QueryResults::default();

        begin_command_buffer(device, f.cmd)?;
        self.before_render_pass(f, vk::Image::null());

        // Query pools must be reset before use
        unsafe {
            device.cmd_reset_query_pool(f.cmd, *occlusion_query_pool, query_start_index, query_counters_number);
            device.cmd_reset_query_pool(
                f.cmd,
                *timestamp_start_query_pool,
                query_start_index,
                query_counters_number,
            );
            device.cmd_reset_query_pool(
                f.cmd,
                *timestamp_end_query_pool,
                query_start_index,
                query_counters_number,
            );
        }

        if !self.dynamic() {
            self.cmd_begin_render_pass(f, vk::SubpassContents::INLINE);
        }

        for subpass_ndx in 0..subpass_count {
            let query_counters_to_use = self.used_views_count(subpass_ndx as usize);

            unsafe {
                device.cmd_bind_vertex_buffers(f.cmd, 0, &f.vertex_buffers, &vertex_buffer_offsets);
                device.cmd_bind_pipeline(
                    f.cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    f.pipelines[subpass_ndx as usize],
                );
            }

            if self.dynamic() {
                self.begin_subpass_rendering(f, subpass_ndx, vk::RenderingFlags::empty());
            }

            for draw_ndx in 0..draw_count_per_subpass {
                let primitive_number = draw_ndx + subpass_ndx % SQUARE_COUNT;
                let first_vertex = primitive_number * VERTICES_PER_PRIMITIVE;

                unsafe {
                    device.cmd_write_timestamp(
                        f.cmd,
                        vk::PipelineStageFlags::ALL_COMMANDS,
                        *timestamp_start_query_pool,
                        query_start_index,
                    );

                    device.cmd_draw(f.cmd, VERTICES_PER_PRIMITIVE, 1, first_vertex, 0);

                    // Render occluded object
                    device.cmd_begin_query(f.cmd, *occlusion_query_pool, query_start_index, occlusion_query_flags);
                    device.cmd_draw(
                        f.cmd,
                        VERTICES_PER_PRIMITIVE,
                        1,
                        occlusion_objects_offset + first_vertex,
                        0,
                    );
                    device.cmd_end_query(f.cmd, *occlusion_query_pool, query_start_index);
                }

                for view_mask_ndx in 0..query_counters_to_use {
                    results
                        .occlusion_expected_values
                        .push(occlusion_object_pixels_count[primitive_number as usize]);
                    results.counter_series_start.push(view_mask_ndx == 0);
                    results
                        .counter_series_end
                        .push(view_mask_ndx + 1 == query_counters_to_use);
                }

                unsafe {
                    device.cmd_write_timestamp(
                        f.cmd,
                        vk::PipelineStageFlags::ALL_COMMANDS,
                        *timestamp_end_query_pool,
                        query_start_index,
                    )
                };

                query_start_index += query_counters_to_use;
            }

            self.end_subpass(f, subpass_ndx, subpass_count, vk::SubpassContents::INLINE);
        }

        debug_assert_eq!(query_start_index, query_counters_number);

        if !self.dynamic() {
            self.cmd_end_render_pass(f.cmd);
        }

        self.after_render_pass(f);

        let cmd_copy_query_pool_results = self.p.query_type == QueryType::CmdCopyQueryPoolResults;
        if cmd_copy_query_pool_results {
            unsafe {
                device.cmd_copy_query_pool_results(
                    f.cmd,
                    *occlusion_query_pool,
                    0,
                    query_counters_number,
                    query_buffer.get(),
                    0,
                    query_stride,
                    query_flags,
                )
            };
        }

        end_command_buffer(device, f.cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), f.cmd)?;

        // These vectors will temporarily hold results.
        let mut occlusion_query_results_buffer = vec![0u64; values_number];
        let mut timestamp_start_query_results_buffer = vec![0u64; values_number];
        let mut timestamp_end_query_results_buffer = vec![0u64; values_number];

        let use_ts = self.kind.timestamp_queries();

        results.occlusion_values.resize(query_counters_number as usize, 0);

        if use_ts {
            results.timestamp_start_values.resize(query_counters_number as usize, 0);
            results.timestamp_end_values.resize(query_counters_number as usize, 0);
        }

        if with_availability {
            results
                .occlusion_availability_values
                .resize(query_counters_number as usize, 0);

            if use_ts {
                results
                    .timestamp_start_availability_values
                    .resize(query_counters_number as usize, 0);
                results
                    .timestamp_end_availability_values
                    .resize(query_counters_number as usize, 0);
            }
        }

        if cmd_copy_query_pool_results {
            invalidate_alloc(device, query_buffer.get_allocation())?;
            let host_values = unsafe {
                std::slice::from_raw_parts(
                    query_buffer.get_allocation().get_host_ptr().cast::<u64>(),
                    values_number,
                )
            };
            occlusion_query_results_buffer.copy_from_slice(host_values);

            if use_ts {
                timestamp_start_query_results_buffer.copy_from_slice(host_values);
                timestamp_end_query_results_buffer.copy_from_slice(host_values);
            }
        } else {
            unsafe {
                device.get_query_pool_results(
                    *occlusion_query_pool,
                    0,
                    query_counters_number,
                    as_bytes_mut(&mut occlusion_query_results_buffer),
                    query_stride,
                    query_flags,
                )
            }
            .vk_check("vkGetQueryPoolResults")?;

            if use_ts {
                unsafe {
                    device.get_query_pool_results(
                        *timestamp_start_query_pool,
                        0,
                        query_counters_number,
                        as_bytes_mut(&mut timestamp_start_query_results_buffer),
                        query_stride,
                        query_flags,
                    )
                }
                .vk_check("vkGetQueryPoolResults")?;
                unsafe {
                    device.get_query_pool_results(
                        *timestamp_end_query_pool,
                        0,
                        query_counters_number,
                        as_bytes_mut(&mut timestamp_end_query_results_buffer),
                        query_stride,
                        query_flags,
                    )
                }
                .vk_check("vkGetQueryPoolResults")?;
            }
        }

        unpack_values(
            &occlusion_query_results_buffer,
            &mut results.occlusion_values,
            if with_availability {
                Some(&mut results.occlusion_availability_values)
            } else {
                None
            },
        );

        if use_ts {
            unpack_values(
                &timestamp_start_query_results_buffer,
                &mut results.timestamp_start_values,
                if with_availability {
                    Some(&mut results.timestamp_start_availability_values)
                } else {
                    None
                },
            );
            unpack_values(
                &timestamp_end_query_results_buffer,
                &mut results.timestamp_end_values,
                if with_availability {
                    Some(&mut results.timestamp_end_availability_values)
                } else {
                    None
                },
            );

            // Generate the timestamp mask
            let queue_properties = unsafe {
                context
                    .get_instance()
                    .get_physical_device_queue_family_properties(context.get_physical_device())
            };
            let valid_bits = queue_properties[context.get_universal_queue_family_index() as usize].timestamp_valid_bits;
            let timestamp_mask = u64::MAX >> (64 - valid_bits);

            for value in results
                .timestamp_start_values
                .iter_mut()
                .chain(results.timestamp_end_values.iter_mut())
            {
                *value &= timestamp_mask;
            }
        }

        Ok(results)
    }
}
