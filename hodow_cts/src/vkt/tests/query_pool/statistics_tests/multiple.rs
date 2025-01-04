// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/query_pool/vktQueryPoolStatisticsTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `multiple_queries` (`StatisticMultipleQueryTestInstance`,
// `GraphicBasicMultipleQueryTestInstance`, `VertexShaderMultipleQueryTestInstance` and the case that builds their vertex data)
// and `multiple_geom_stats` (`MultipleGeomStatsTestCase`). The colour of `multiple_geom_stats` is read back through
// `read_color_attachment` after the submission instead of with a `copyImageToBuffer` recorded into the same command buffer, which
// is what the shared helper offers. The shaders are in `shaders/manifest/query_pool_statistics.toml`, found by their key.

use vulkanalia::prelude::v1_0::*;

use super::common::*;
use super::{ALL_STATISTICS_PROGRAM, StatisticsProgram};
use crate::tcu::image_compare::float_threshold_compare;
use crate::tcu::pixel::TextureLevel;
use crate::tcu::rgba::RGBA;
use crate::tcu::{TestError, TestOutcome, TestStatus, Vec4, map_vk_format};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, make_rect_2d, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, GraphicsPipelineStages, allocate_command_buffer, make_buffer_create_info,
    make_buffer_memory_barrier, make_command_pool, make_framebuffer, make_pipeline_layout, make_render_pass,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{default_depth_stencil_state, default_rasterization_state};
use crate::vkt::tests::draw::{
    initial_transition_color_2d_image, initial_transition_depth_2d_image, transition_2d_image,
};
use crate::vkt::tests::pipeline::pipeline_util::read_color_attachment;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `NUM_QUERY_STATISTICS`
const NUM_QUERY_STATISTICS: usize = 4;
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const DEPTH_FORMAT: vk::Format = vk::Format::D16_UNORM;
const TRIANGLE_VERTICES: usize = 3;

fn program_set(key: &str) -> &'static StatisticsProgram {
    ALL_STATISTICS_PROGRAM
        .iter()
        .copied()
        .find(|p| p.key == key)
        .unwrap_or_else(|| panic!("the manifest has no program set {key:?}"))
}

/// `GraphicBasicMultipleQueryTestInstance::VertexData`
#[derive(Clone, Copy)]
#[repr(C)]
struct VertexData {
    position: [f32; 4],
    color: [f32; 4],
}

/// `GraphicBasicMultipleQueryTestInstance::ParametersGraphic`
#[derive(Clone, Copy)]
pub(super) struct ParametersMultiple {
    pub generic: GenericParameters,
    pub query_statistic_flags: vk::QueryPipelineStatisticFlags,
    pub vertex_only_pipe: bool,
    pub query_flags: vk::QueryResultFlags,
    pub query_count: u32,
    pub dst_offset: u32,
}

/// `QueryPoolGraphicMultipleQueryStatisticsTest<VertexShaderMultipleQueryTestInstance>`
pub(super) struct MultipleQueryCase {
    name: String,
    params: ParametersMultiple,
    data: Vec<VertexData>,
}

impl MultipleQueryCase {
    pub(super) fn new(name: String, params: ParametersMultiple) -> Self {
        let quarter_width = (2.0 / super::common::WIDTH as f32) * 0.25;
        let quarter_height = (2.0 / super::common::HEIGHT as f32) * 0.25;

        // These coordinates will be used with different topologies, so we try to avoid drawing points on the edges.
        let left = -1.0 + quarter_width;
        let right = 1.0 - quarter_width;
        let center = (left + right) / 2.0;
        let top = -1.0 + quarter_height;
        let bottom = 1.0 - quarter_height;
        let middle = (top + bottom) / 2.0;

        let color = |rgba: RGBA| {
            let v: Vec4 = rgba.to_vec();
            [v.x(), v.y(), v.z(), v.w()]
        };
        let (red, green, blue, gray) = (
            color(RGBA::red()),
            color(RGBA::green()),
            color(RGBA::blue()),
            color(RGBA::gray()),
        );
        let vertex = |x: f32, y: f32, color: [f32; 4]| VertexData {
            position: [x, y, 1.0, 1.0],
            color,
        };

        let data = vec![
            vertex(left, top, red),
            vertex(left, middle, red),
            vertex(center, top, red),
            vertex(center, middle, red),
            vertex(left, middle, green),
            vertex(left, bottom, green),
            vertex(center, middle, green),
            vertex(center, bottom, green),
            vertex(center, top, blue),
            vertex(center, middle, blue),
            vertex(right, top, blue),
            vertex(right, middle, blue),
            vertex(center, middle, gray),
            vertex(center, bottom, gray),
            vertex(right, middle, gray),
            vertex(right, bottom, gray),
        ];

        Self { name, params, data }
    }
}

impl TestCase for MultipleQueryCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if context.get_device_features().pipeline_statistics_query == vk::FALSE {
            return Err(TestError::NotSupported(
                "Pipeline statistics queries are not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        program_set(if self.params.vertex_only_pipe {
            "multiple_queries_vertex_only"
        } else {
            "multiple_queries"
        })
        .programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MultipleQueryInstance { context, case: self })
    }
}

struct Targets<'a> {
    color: ImageWithMemory<'a>,
    depth: ImageWithMemory<'a>,
    _color_view: Unique<'a, vk::ImageView>,
    _depth_view: Unique<'a, vk::ImageView>,
    render_pass: Unique<'a, vk::RenderPass>,
    framebuffer: Unique<'a, vk::Framebuffer>,
}

struct MultipleQueryInstance<'a> {
    context: &'a Context<'a>,
    case: &'a MultipleQueryCase,
}

impl<'a> MultipleQueryInstance<'a> {
    /// `createColorAttachmentAndRenderPass`
    fn create_targets(&self) -> Result<Targets<'a>, TestError> {
        let context = self.context;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let extent = vk::Extent3D {
            width: super::common::WIDTH,
            height: super::common::HEIGHT,
            depth: 1,
        };

        let image_info = |format: vk::Format, usage: vk::ImageUsageFlags| {
            vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(format)
                .extent(extent)
                .mip_levels(1)
                .array_layers(1)
                .samples(vk::SampleCountFlags::_1)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(usage)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build()
        };

        let color = ImageWithMemory::new(
            device,
            alloc,
            image_info(
                COLOR_FORMAT,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;
        let color_view = make_image_view(
            device,
            *color,
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;
        let depth = ImageWithMemory::new(
            device,
            alloc,
            image_info(DEPTH_FORMAT, vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT),
            MemoryRequirement::ANY,
        )?;
        let depth_view = make_image_view(
            device,
            *depth,
            vk::ImageViewType::_2D,
            DEPTH_FORMAT,
            make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1),
        )?;

        let attachments = [
            vk::AttachmentDescription::builder()
                .format(COLOR_FORMAT)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::STORE)
                .initial_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .build(),
            vk::AttachmentDescription::builder()
                .format(DEPTH_FORMAT)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::DONT_CARE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .build(),
        ];
        let color_reference = [vk::AttachmentReference {
            attachment: 0,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        }];
        let depth_reference = vk::AttachmentReference {
            attachment: 1,
            layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        };
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_reference)
            .depth_stencil_attachment(&depth_reference)
            .build()];
        let info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses);
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
        );
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*color_view, *depth_view],
            super::common::WIDTH,
            super::common::HEIGHT,
            1,
        )?;

        Ok(Targets {
            color,
            depth,
            _color_view: color_view,
            _depth_view: depth_view,
            render_pass,
            framebuffer,
        })
    }

    /// `VertexShaderMultipleQueryTestInstance::createPipeline`
    fn create_pipeline(
        &self,
        targets: &Targets<'a>,
    ) -> Result<(Unique<'a, vk::PipelineLayout>, Unique<'a, vk::Pipeline>), TestError> {
        let device = self.context.get_device();
        let binaries = self.context.get_binary_collection();

        let vs = create_shader_module(device, binaries.get("vertex")?)?;
        let fs = if self.case.params.vertex_only_pipe {
            None
        } else {
            Some(create_shader_module(device, binaries.get("fragment")?)?)
        };

        let mut stages = vec![
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::VERTEX)
                .module(*vs)
                .name(b"main\0")
                .build(),
        ];
        if let Some(fs) = &fs {
            stages.push(
                vk::PipelineShaderStageCreateInfo::builder()
                    .stage(vk::ShaderStageFlags::FRAGMENT)
                    .module(**fs)
                    .name(b"main\0")
                    .build(),
            );
        }

        let pipeline_layout = make_pipeline_layout(device, &[])?;

        let binding_descriptions = [vk::VertexInputBindingDescription {
            binding: 0,
            stride: std::mem::size_of::<VertexData>() as u32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        let attribute_descriptions = [
            vk::VertexInputAttributeDescription {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 0,
            },
            vk::VertexInputAttributeDescription {
                location: 1,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 16,
            },
        ];
        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&binding_descriptions)
            .vertex_attribute_descriptions(&attribute_descriptions);
        let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(vk::PrimitiveTopology::TRIANGLE_LIST)
            .primitive_restart_enable(false);

        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: super::common::WIDTH as f32,
            height: super::common::HEIGHT as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [make_rect_2d(0, 0, super::common::WIDTH, super::common::HEIGHT)];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);
        let rasterization_state = default_rasterization_state();
        let multisample_state =
            vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
        let mut depth_stencil_state = default_depth_stencil_state();
        depth_stencil_state.stencil_test_enable = vk::FALSE;
        let attachment_states = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&attachment_states);

        let pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input_state)
            .input_assembly_state(&input_assembly_state)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization_state)
            .multisample_state(&multisample_state)
            .depth_stencil_state(&depth_stencil_state)
            .color_blend_state(&color_blend_state)
            .layout(*pipeline_layout)
            .render_pass(*targets.render_pass)
            .subpass(0)
            .base_pipeline_index(0);
        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        Ok((pipeline_layout, Unique::new(device, pipelines.0[0])))
    }

    /// `VertexShaderMultipleQueryTestInstance::executeTest`
    fn execute_test(
        &self,
        targets: &Targets<'a>,
        pipeline: vk::Pipeline,
        query_buffer: &BufferWithMemory<'a>,
        query_pool: vk::QueryPool,
    ) -> Result<(), TestError> {
        let context = self.context;
        let device = context.get_device();
        let params = &self.case.params;
        let queue = context.get_universal_queue();

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;

        let data_bytes = std::mem::size_of_val(self.case.data.as_slice());
        let atom_size = context.get_device_properties().limits.non_coherent_atom_size.max(1) as usize;
        let data_size = data_bytes.div_ceil(atom_size) * atom_size;
        let vertex_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(data_size as vk::DeviceSize, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                self.case.data.as_ptr().cast::<u8>(),
                vertex_buffer.get_allocation().get_host_ptr(),
                data_bytes,
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?;

        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, *cmd_buffer)?;

        let clear_values = [
            vk::ClearValue {
                color: vk::ClearColorValue { float32: [0.0; 4] },
            },
            vk::ClearValue {
                depth_stencil: vk::ClearDepthStencilValue { depth: 0.0, stencil: 0 },
            },
        ];

        initial_transition_color_2d_image(
            device,
            *cmd_buffer,
            *targets.color,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            1,
        );
        initial_transition_depth_2d_image(
            device,
            *cmd_buffer,
            *targets.depth,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
            vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
        );

        unsafe { device.cmd_reset_query_pool(*cmd_buffer, query_pool, 0, params.query_count) };

        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*targets.render_pass)
            .framebuffer(*targets.framebuffer)
            .render_area(make_rect_2d(0, 0, super::common::WIDTH, super::common::HEIGHT))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(*cmd_buffer, &begin_info, vk::SubpassContents::INLINE);

            device.cmd_begin_query(*cmd_buffer, query_pool, 0, vk::QueryControlFlags::empty());
            device.cmd_bind_vertex_buffers(*cmd_buffer, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::GRAPHICS, pipeline);

            device.cmd_draw(*cmd_buffer, 16, 1, 0, 0);

            device.cmd_end_query(*cmd_buffer, query_pool, 0);

            device.cmd_end_render_pass(*cmd_buffer);
        }

        if params.generic.copy_type == CopyType::Cmd {
            let mut copy_stride = (NUM_QUERY_STATISTICS * std::mem::size_of::<u64>()) as vk::DeviceSize;
            if params.query_count == 1 && params.generic.stride_type == StrideType::Zero {
                copy_stride = 0;
            }

            unsafe {
                device.cmd_copy_query_pool_results(
                    *cmd_buffer,
                    query_pool,
                    0,
                    params.query_count,
                    query_buffer.get(),
                    vk::DeviceSize::from(params.dst_offset),
                    copy_stride,
                    params.query_flags,
                )
            };

            let buffer_size = (NUM_QUERY_STATISTICS * std::mem::size_of::<u64>()) as vk::DeviceSize
                * vk::DeviceSize::from(params.query_count);
            let barrier = make_buffer_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::HOST_READ,
                query_buffer.get(),
                0,
                buffer_size,
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    *cmd_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }

        transition_2d_image(
            device,
            *cmd_buffer,
            *targets.color,
            vk::ImageAspectFlags::COLOR,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::GENERAL,
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::PipelineStageFlags::TRANSFER,
            1,
        );
        end_command_buffer(device, *cmd_buffer)?;

        submit_commands_and_wait(device, queue, *cmd_buffer)
    }

    /// `calculateExpectedMin`
    fn expected_min(flag: vk::QueryPipelineStatisticFlags) -> u64 {
        use vk::QueryPipelineStatisticFlags as S;
        if flag == S::INPUT_ASSEMBLY_VERTICES {
            15
        } else if flag == S::INPUT_ASSEMBLY_PRIMITIVES {
            5
        } else if flag == S::VERTEX_SHADER_INVOCATIONS {
            15
        } else if flag == S::FRAGMENT_SHADER_INVOCATIONS {
            2016
        } else {
            panic!("Unexpected type of statistics query")
        }
    }

    /// `calculateExpectedMax`: only there to check the driver does not return garbage for the partial, no wait case.
    fn expected_max(flag: vk::QueryPipelineStatisticFlags) -> u64 {
        use vk::QueryPipelineStatisticFlags as S;
        if flag == S::INPUT_ASSEMBLY_VERTICES {
            16
        } else if flag == S::INPUT_ASSEMBLY_PRIMITIVES {
            5
        } else if flag == S::VERTEX_SHADER_INVOCATIONS {
            15
        } else if flag == S::FRAGMENT_SHADER_INVOCATIONS {
            2304
        } else {
            panic!("Unexpected type of statistics query")
        }
    }

    /// `VertexShaderMultipleQueryTestInstance::checkResult`
    fn check_result(&self, query_buffer: &BufferWithMemory<'a>, query_pool: vk::QueryPool) -> TestOutcome {
        let device = self.context.get_device();
        let params = &self.case.params;
        let query_count = params.query_count + u32::from(params.dst_offset != 0);
        let size = NUM_QUERY_STATISTICS * query_count as usize;
        let mut results = vec![0u64; size];

        let has_partial_flag = params.query_flags.contains(vk::QueryResultFlags::PARTIAL);
        let has_wait_flag = params.query_flags.contains(vk::QueryResultFlags::WAIT);

        if params.generic.copy_type == CopyType::Cmd {
            let allocation = query_buffer.get_allocation();
            invalidate_alloc(device, allocation)?;
            let bytes =
                unsafe { std::slice::from_raw_parts(allocation.get_host_ptr(), size * std::mem::size_of::<u64>()) };
            for (value, chunk) in results.iter_mut().zip(bytes.chunks_exact(8)) {
                *value = u64::from_ne_bytes(chunk.try_into().expect("eight bytes"));
            }
        } else {
            let mut bytes = vec![0u8; size * std::mem::size_of::<u64>()];
            let result = unsafe {
                device.get_query_pool_results(
                    query_pool,
                    0,
                    params.query_count,
                    &mut bytes,
                    (NUM_QUERY_STATISTICS * std::mem::size_of::<u64>()) as vk::DeviceSize,
                    params.query_flags,
                )
            }
            .vk_check("vkGetQueryPoolResults")?;
            if !(result == vk::SuccessCode::SUCCESS || (!has_wait_flag && result == vk::SuccessCode::NOT_READY)) {
                return Ok(TestStatus::fail(format!(
                    "Unexpected getQueryPoolResults() returned value: {result:?}"
                )));
            }
            for (value, chunk) in results.iter_mut().zip(bytes.chunks_exact(8)) {
                *value = u64::from_ne_bytes(chunk.try_into().expect("eight bytes"));
            }
        }

        for query_idx in 0..query_count as usize {
            let mut query_mask = params.query_statistic_flags.bits();
            let mut index = query_idx * NUM_QUERY_STATISTICS;
            // Last element of each query is the availability value for the vertexOnlyPipe case.
            let available_query = results[index + (NUM_QUERY_STATISTICS - 1)] != 0;

            // Check dstOffset values were not overwritten.
            if params.dst_offset != 0 && query_idx == 0 {
                let ref_val = 0xffff_ffff_ffff_ffffu64;
                while index < NUM_QUERY_STATISTICS {
                    if results[index] != ref_val {
                        return Ok(TestStatus::fail("dstOffset values were overwritten"));
                    }
                    index += 1;
                }
                continue;
            }

            if has_wait_flag && !has_partial_flag && !available_query {
                return Ok(TestStatus::fail("Results should be available"));
            }

            while query_mask != 0 {
                let statistic_bit = query_mask.trailing_zeros();
                query_mask &= query_mask - 1;
                let flag = vk::QueryPipelineStatisticFlags::from_bits_truncate(1 << statistic_bit);
                let expected_min = Self::expected_min(flag);
                let expected_max = Self::expected_max(flag);

                if available_query && results[index] < expected_min {
                    return Ok(TestStatus::fail(format!(
                        "QueryPoolResults incorrect: wrong value ({}) is lower than expected ({})",
                        results[index], expected_min
                    )));
                }

                // From the spec: if PARTIAL is set, WAIT is not set and the query's status is unavailable, an intermediate result value
                // between zero and the final result value is written to pData for that query.
                if has_partial_flag && !has_wait_flag && !available_query && results[index] > expected_max {
                    return Ok(TestStatus::fail(format!(
                        "QueryPoolResults incorrect: wrong partial value ({}) is greater than expected ({})",
                        results[index], expected_max
                    )));
                }

                index += 1;
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestInstance for MultipleQueryInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let params = &self.case.params;

        // `StatisticMultipleQueryTestInstance`: a buffer of 0xff the copy writes over.
        let query_count = params.query_count + u32::from(params.dst_offset != 0);
        let query_buffer_size = NUM_QUERY_STATISTICS * std::mem::size_of::<u64>() * query_count as usize;
        let query_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(query_buffer_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe { std::ptr::write_bytes(query_buffer.get_allocation().get_host_ptr(), 0xff, query_buffer_size) };
        flush_alloc(device, query_buffer.get_allocation())?;

        let targets = self.create_targets()?;
        let (_pipeline_layout, pipeline) = self.create_pipeline(&targets)?;
        let query_pool = Unique::new(
            device,
            make_query_pool(device, params.query_count, params.query_statistic_flags)?,
        );

        self.execute_test(&targets, *pipeline, &query_buffer, *query_pool)?;
        self.check_result(&query_buffer, *query_pool)
    }
}

/// `MultipleGeomStatsParams`
#[derive(Clone, Copy)]
struct MultipleGeomStatsParams {
    copy: bool,
    availability: bool,
    inheritance: bool,
}

/// `MultipleGeomStatsTestCase`
struct MultipleGeomStatsCase {
    name: String,
    params: MultipleGeomStatsParams,
}

impl TestCase for MultipleGeomStatsCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let features = context.get_device_features();
        if features.geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported("Geometry shader not supported".to_string()));
        }
        if features.pipeline_statistics_query == vk::FALSE {
            return Err(TestError::NotSupported(
                "Pipeline statistics queries are not supported".to_string(),
            ));
        }
        if self.params.inheritance && features.inherited_queries == vk::FALSE {
            return Err(TestError::NotSupported(
                "Inherited queries are not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        program_set("multiple_geom_stats").programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MultipleGeomStatsInstance {
            context,
            params: self.params,
        })
    }
}

struct MultipleGeomStatsInstance<'a> {
    context: &'a Context<'a>,
    params: MultipleGeomStatsParams,
}

impl TestInstance for MultipleGeomStatsInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let params = self.params;
        let (fb_width, fb_height) = (16u32, 16u32);
        let extent = vk::Extent3D {
            width: fb_width,
            height: fb_height,
            depth: 1,
        };
        let clear_color = [0.0f32, 0.0, 0.0, 1.0];
        let geom_color = [0.0f32, 0.0, 1.0, 1.0]; // Must match frag shader.

        // Color buffer.
        let image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(COLOR_FORMAT)
            .extent(extent)
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let color_image = ImageWithMemory::new(device, alloc, image_info, MemoryRequirement::ANY)?;
        let color_view = make_image_view(
            device,
            *color_image,
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;

        // Vertices.
        let mut vertices: Vec<[f32; 4]> = Vec::with_capacity((fb_width * fb_height) as usize * TRIANGLE_VERTICES);
        let image_width = fb_width as f32;
        let image_height = fb_height as f32;
        let pixel_width = 2.0 / image_width;
        let pixel_height = 2.0 / image_height;
        let hor_margin = pixel_width / 4.0;
        let vert_margin = pixel_height / 4.0;

        for y in 0..fb_height {
            for x in 0..fb_width {
                // Pixel center in normalized coordinates.
                let pix_x = (x as f32 + 0.5) / image_width * 2.0 - 1.0;
                let pix_y = (y as f32 + 0.5) / image_height * 2.0 - 1.0;

                // Triangle around pixel center.
                vertices.push([pix_x - hor_margin, pix_y + vert_margin, 0.0, 1.0]);
                vertices.push([pix_x + hor_margin, pix_y + vert_margin, 0.0, 1.0]);
                vertices.push([pix_x, pix_y - vert_margin, 0.0, 1.0]);
            }
        }

        // Vertex buffer
        let vb_size = std::mem::size_of_val(vertices.as_slice());
        let vertex_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(vb_size as vk::DeviceSize, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertices.as_ptr().cast::<u8>(),
                vertex_buffer.get_allocation().get_host_ptr(),
                vb_size,
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?; // strictly speaking, not needed.

        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let render_pass = make_render_pass(device, COLOR_FORMAT)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_view], fb_width, fb_height, 1)?;

        // Modules.
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let geom_module = create_shader_module(device, binaries.get("geom")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        let pipeline = crate::vk::obj_util::make_graphics_pipeline_staged(
            device,
            *pipeline_layout,
            GraphicsPipelineStages {
                vertex: *vert_module,
                fragment: *frag_module,
                tessellation_control: None,
                tessellation_evaluation: None,
                geometry: Some(*geom_module),
            },
            *render_pass,
            (fb_width, fb_height),
            vk::PrimitiveTopology::TRIANGLE_LIST,
            vk::SampleCountFlags::_1,
            None,
            1,
            None,
            None,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        let stats = vk::QueryPipelineStatisticFlags::GEOMETRY_SHADER_INVOCATIONS
            | vk::QueryPipelineStatisticFlags::GEOMETRY_SHADER_PRIMITIVES;
        let query_pool = Unique::new(device, make_query_pool(device, 1, stats)?);
        let per_query_item_count = 2 + usize::from(params.availability);
        let result_flags = vk::QueryResultFlags::WAIT
            | if params.availability {
                vk::QueryResultFlags::WITH_AVAILABILITY
            } else {
                vk::QueryResultFlags::empty()
            };
        let mut query_results = vec![0u32; per_query_item_count];
        let query_results_size = per_query_item_count * std::mem::size_of::<u32>();

        let results_buffer = if params.copy {
            let buffer = BufferWithMemory::new(
                device,
                alloc,
                make_buffer_create_info(query_results_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            unsafe { std::ptr::write_bytes(buffer.get_allocation().get_host_ptr(), 0xff, query_results_size) };
            flush_alloc(device, buffer.get_allocation())?;
            Some(buffer)
        } else {
            None
        };

        let sec_cmd_buffer = if params.inheritance {
            let secondary = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;
            let inheritance_info = vk::CommandBufferInheritanceInfo::builder()
                .render_pass(*render_pass)
                .subpass(0)
                .framebuffer(*framebuffer)
                .occlusion_query_enable(false)
                .query_flags(vk::QueryControlFlags::empty())
                .pipeline_statistics(stats);
            let begin_info = vk::CommandBufferBeginInfo::builder()
                .flags(vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT | vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE)
                .inheritance_info(&inheritance_info);
            unsafe { device.begin_command_buffer(*secondary, &begin_info) }.vk_check("vkBeginCommandBuffer")?;
            Some(secondary)
        } else {
            None
        };

        // Render pass contents command buffer.
        let rp_cmd_buffer = sec_cmd_buffer.as_ref().map_or(*cmd_buffer, |secondary| **secondary);
        let subpass_contents = if params.inheritance {
            vk::SubpassContents::SECONDARY_COMMAND_BUFFERS
        } else {
            vk::SubpassContents::INLINE
        };

        begin_command_buffer(device, *cmd_buffer)?;
        unsafe {
            device.cmd_reset_query_pool(*cmd_buffer, *query_pool, 0, 1);
            device.cmd_begin_query(*cmd_buffer, *query_pool, 0, vk::QueryControlFlags::empty());
        }
        let clear_values = [vk::ClearValue {
            color: vk::ClearColorValue { float32: clear_color },
        }];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(make_rect_2d(0, 0, fb_width, fb_height))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(*cmd_buffer, &begin_info, subpass_contents);
            device.cmd_bind_vertex_buffers(rp_cmd_buffer, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_pipeline(rp_cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_draw(rp_cmd_buffer, vertices.len() as u32, 1, 0, 0);
        }
        if let Some(secondary) = &sec_cmd_buffer {
            end_command_buffer(device, **secondary)?;
            unsafe { device.cmd_execute_commands(*cmd_buffer, &[**secondary]) };
        }
        unsafe {
            device.cmd_end_render_pass(*cmd_buffer);
            device.cmd_end_query(*cmd_buffer, *query_pool, 0);
        }
        if let Some(results_buffer) = &results_buffer {
            unsafe {
                device.cmd_copy_query_pool_results(
                    *cmd_buffer,
                    *query_pool,
                    0,
                    1,
                    results_buffer.get(),
                    0,
                    0,
                    result_flags,
                );
                let barrier = vk::MemoryBarrier::builder()
                    .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
                    .dst_access_mask(vk::AccessFlags::HOST_READ)
                    .build();
                device.cmd_pipeline_barrier(
                    *cmd_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }
        end_command_buffer(device, *cmd_buffer)?;
        submit_commands_and_wait(device, context.get_universal_queue(), *cmd_buffer)?;

        // Verify query results.
        if let Some(results_buffer) = &results_buffer {
            invalidate_alloc(device, results_buffer.get_allocation())?;
            let bytes = unsafe {
                std::slice::from_raw_parts(results_buffer.get_allocation().get_host_ptr(), query_results_size)
            };
            for (value, chunk) in query_results.iter_mut().zip(bytes.chunks_exact(4)) {
                *value = u32::from_ne_bytes(chunk.try_into().expect("four bytes"));
            }
        } else {
            let mut bytes = vec![0u8; query_results_size];
            unsafe { device.get_query_pool_results(*query_pool, 0, 1, &mut bytes, 0, result_flags) }
                .vk_check("vkGetQueryPoolResults")?;
            for (value, chunk) in query_results.iter_mut().zip(bytes.chunks_exact(4)) {
                *value = u32::from_ne_bytes(chunk.try_into().expect("four bytes"));
            }
        }

        for (query_item, &value) in query_results.iter().enumerate() {
            let is_availability_bit = params.availability && query_item == per_query_item_count - 1;
            let min_value = if is_availability_bit {
                1
            } else {
                (vertices.len() / TRIANGLE_VERTICES) as u32
            };
            let max_value = u32::MAX;

            if value < min_value || value > max_value {
                return Err(TestError::Fail(format!(
                    "Unexpected value for query item {query_item}: {value} out of expected range [{min_value}, {max_value}]"
                )));
            }
        }

        // Verify color output.
        let format = map_vk_format(COLOR_FORMAT)
            .ok_or_else(|| TestError::InternalError("no texture format for the colour attachment".to_string()))?;
        let rendered = read_color_attachment(
            context,
            *color_image,
            COLOR_FORMAT,
            (fb_width, fb_height),
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let mut reference = TextureLevel::new(format, fb_width, fb_height, 1)?;
        {
            let mut access = reference.get_access();
            for y in 0..fb_height {
                for x in 0..fb_width {
                    access.set_pixel(geom_color, x, y, 0);
                }
            }
        }
        // When using 0 and 1 only, we expect exact results.
        if !float_threshold_compare(&reference.get_const_access(), &rendered.get_const_access(), [0.0; 4]).ok {
            return Ok(TestStatus::fail(
                "Unexpected color in result buffer; check log for details",
            ));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// The two groups `createTests` adds after the reset type groups: `multiple_queries` and `multiple_geom_stats`.
pub(super) fn create_groups() -> [TestCaseGroup; 2] {
    let mut multiple_queries = TestCaseGroup::new("multiple_queries");
    {
        let partial_flags = [vk::QueryResultFlags::empty(), vk::QueryResultFlags::PARTIAL];
        let partial_flags_str = ["", "_partial"];
        let wait_flags = [vk::QueryResultFlags::empty(), vk::QueryResultFlags::WAIT];
        let wait_flags_str = ["", "_wait"];

        let copy_types = [CopyType::Get, CopyType::Cmd, CopyType::Cmd];
        let copy_types_str = ["", "_cmdcopy", "_cmdcopy_dstoffset"];

        let stride_types = [StrideType::Valid, StrideType::Zero];
        let stride_types_str = ["", "_stride_zero"];

        let statistics_flags = vk::QueryPipelineStatisticFlags::INPUT_ASSEMBLY_VERTICES
            | vk::QueryPipelineStatisticFlags::INPUT_ASSEMBLY_PRIMITIVES;

        for (partial_flags_idx, &partial) in partial_flags.iter().enumerate() {
            for (wait_flags_idx, &wait) in wait_flags.iter().enumerate() {
                for (copy_types_idx, &copy_type) in copy_types.iter().enumerate() {
                    for (stride_types_idx, &stride_type) in stride_types.iter().enumerate() {
                        let dst_offset = if copy_types_idx == 2 {
                            (NUM_QUERY_STATISTICS * std::mem::size_of::<u64>()) as u32
                        } else {
                            0
                        };
                        // Avoid waiting infinite time for the queries, when one of them is not going to be issued in the partial case.
                        if partial.contains(vk::QueryResultFlags::PARTIAL) && wait.contains(vk::QueryResultFlags::WAIT)
                        {
                            continue;
                        }

                        // Skip stride bogus tests when there are more than one query count.
                        if !partial.is_empty() && stride_type == StrideType::Zero {
                            continue;
                        }

                        if stride_type == StrideType::Zero && copy_type != CopyType::Cmd {
                            continue;
                        }

                        let query_flags =
                            vk::QueryResultFlags::_64 | vk::QueryResultFlags::WITH_AVAILABILITY | partial | wait;
                        let query_count = if partial_flags_idx != 0 { 2 } else { 1 };
                        let suffix = format!(
                            "{}{}{}{}",
                            partial_flags_str[partial_flags_idx],
                            wait_flags_str[wait_flags_idx],
                            copy_types_str[copy_types_idx],
                            stride_types_str[stride_types_idx]
                        );
                        let generic = GenericParameters {
                            reset_type: ResetType::Normal,
                            copy_type,
                            query_64_bits: true,
                            dst_offset: dst_offset != 0,
                            stride_type,
                            use_device_address_commands: false,
                        };

                        let params = ParametersMultiple {
                            generic,
                            query_statistic_flags: statistics_flags
                                | vk::QueryPipelineStatisticFlags::FRAGMENT_SHADER_INVOCATIONS,
                            vertex_only_pipe: false,
                            query_flags,
                            query_count,
                            dst_offset,
                        };
                        multiple_queries.add_child(Box::new(MultipleQueryCase::new(
                            format!("input_assembly_vertex_fragment{suffix}"),
                            params,
                        )) as Box<dyn TestCase>);

                        // No fragment shader case
                        let params = ParametersMultiple {
                            query_statistic_flags: statistics_flags
                                | vk::QueryPipelineStatisticFlags::VERTEX_SHADER_INVOCATIONS,
                            vertex_only_pipe: true,
                            ..params
                        };
                        multiple_queries.add_child(Box::new(MultipleQueryCase::new(
                            format!("input_assembly_vertex{suffix}"),
                            params,
                        )) as Box<dyn TestCase>);
                    }
                }
            }
        }
    }

    let mut multiple_geom_stats = TestCaseGroup::new("multiple_geom_stats");
    for copy in [false, true] {
        for availability in [false, true] {
            for inheritance in [false, true] {
                let name = format!(
                    "{}{}{}",
                    if copy { "copy" } else { "get" },
                    if availability { "_with_availability" } else { "" },
                    if inheritance { "_and_inheritance" } else { "" }
                );
                multiple_geom_stats.add_child(Box::new(MultipleGeomStatsCase {
                    name,
                    params: MultipleGeomStatsParams {
                        copy,
                        availability,
                        inheritance,
                    },
                }) as Box<dyn TestCase>);
            }
        }
    }

    [multiple_queries, multiple_geom_stats]
}
