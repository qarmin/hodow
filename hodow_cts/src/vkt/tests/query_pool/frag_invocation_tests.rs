// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/query_pool/vktQueryPoolFragInvocationTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The shaders are in `shaders/manifest/query_pool_frag_invocation.toml`; the query type and
// the primary/secondary axes do not change them, so three programs serve all twelve cases.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, make_rect_2d, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_framebuffer, make_memory_barrier, make_pipeline_layout, make_render_pass,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The manifest declares its cases with this: the shader pair plus the two axes it was built from.
pub struct FragInvocationProgram {
    pub name: &'static str,
    pub vertex_color: bool,
    pub atomic: bool,
    pub programs: BinaryCollection,
}

use crate::generated::shaders::query_pool_frag_invocation::{
    FRAG_INVOCATION_ATOMIC_COUNTER, FRAG_INVOCATION_FLAT, FRAG_INVOCATION_VERTEX_COLOR,
};

/// `QueryType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum QueryType {
    Invocations,
    Occlusion,
}

/// `getQueryTypeName`
fn get_query_type_name(query_type: QueryType) -> &'static str {
    match query_type {
        QueryType::Invocations => "frag_invs",
        QueryType::Occlusion => "occlusion",
    }
}

/// `FragShaderVariant`
#[derive(Clone, Copy, PartialEq, Eq)]
enum FragShaderVariant {
    Flat,
    VertexColor,
    AtomicCounter,
}

/// `TestParams`
#[derive(Clone, Copy)]
struct TestParams {
    query_type: QueryType,
    secondary: bool,
    frag_shader_variant: FragShaderVariant,
}

/// `getGeometryColor`
const GEOMETRY_COLOR: [f32; 4] = [0.0, 0.0, 1.0, 1.0];
/// The RGBA8 bytes `GEOMETRY_COLOR` is expected to land as; the threshold upstream compares with is zero.
const GEOMETRY_COLOR_BYTES: [u8; 4] = [0, 0, 255, 255];
/// `getClearColor`
const CLEAR_COLOR: [f32; 4] = [0.0, 0.0, 0.0, 0.0];

/// A case of the group.
struct FragInvocationTestCase {
    name: String,
    params: TestParams,
    program: &'static FragInvocationProgram,
}

impl TestCase for FragInvocationTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let features = context.get_device_features();
        if self.params.secondary && features.inherited_queries == vk::FALSE {
            return Err(TestError::NotSupported("inheritedQueries not supported".to_string()));
        }
        match self.params.query_type {
            QueryType::Occlusion if features.occlusion_query_precise == vk::FALSE => {
                return Err(TestError::NotSupported(
                    "occlusionQueryPrecise not supported".to_string(),
                ));
            }
            QueryType::Invocations if features.pipeline_statistics_query == vk::FALSE => {
                return Err(TestError::NotSupported(
                    "pipelineStatisticsQuery not supported".to_string(),
                ));
            }
            _ => {}
        }
        if self.params.frag_shader_variant == FragShaderVariant::AtomicCounter
            && features.fragment_stores_and_atomics == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "fragmentStoresAndAtomics not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.program.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(FragInvocationTestInstance {
            context,
            params: self.params,
        })
    }
}

/// `recordRenderPassCommands`
fn record_render_pass_commands(
    vk: &Device,
    cmd_buffer: vk::CommandBuffer,
    bind_point: vk::PipelineBindPoint,
    pipeline: vk::Pipeline,
    pipeline_layout: vk::PipelineLayout,
    descriptor_set: Option<vk::DescriptorSet>,
    vertex_buffer: vk::Buffer,
    vertex_buffer_offset: vk::DeviceSize,
) {
    unsafe {
        vk.cmd_bind_pipeline(cmd_buffer, bind_point, pipeline);
        if let Some(set) = descriptor_set {
            vk.cmd_bind_descriptor_sets(cmd_buffer, bind_point, pipeline_layout, 0, &[set], &[]);
        }
        vk.cmd_bind_vertex_buffers(cmd_buffer, 0, &[vertex_buffer], &[vertex_buffer_offset]);
        vk.cmd_draw(cmd_buffer, 3, 1, 0, 0);
    }
}

/// `testInvocations`
struct FragInvocationTestInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for FragInvocationTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let vk = context.get_device();
        let queue_family_index = context.get_universal_queue_family_index();
        let queue = context.get_universal_queue();
        let alloc = context.get_default_allocator();

        let fb_width = 64u32;
        let fb_height = 64u32;
        let vk_extent = vk::Extent3D {
            width: fb_width,
            height: fb_height,
            depth: 1,
        };
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let color_srl = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1);
        let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
        let bind_point = vk::PipelineBindPoint::GRAPHICS;
        let is_atomic = params.frag_shader_variant == FragShaderVariant::AtomicCounter;
        let res_shader_stages = vk::ShaderStageFlags::FRAGMENT;

        // ImageWithBuffer
        let color_image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(color_format)
            .extent(vk_extent)
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(color_usage)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let color_image = ImageWithMemory::new(vk, alloc, color_image_info, MemoryRequirement::ANY)?;
        let color_image_view = make_image_view(vk, *color_image, vk::ImageViewType::_2D, color_format, color_srr)?;
        let color_buffer_size = (fb_width * fb_height) as vk::DeviceSize * 4;
        let color_buffer = BufferWithMemory::new(
            vk,
            alloc,
            make_buffer_create_info(color_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(vk, binaries.get("vert")?)?;
        let frag_module = create_shader_module(vk, binaries.get("frag")?)?;

        // Interleaved pairs of positions and colors.
        let vertices: [[f32; 4]; 6] = [
            [-1.0, -1.0, 0.0, 1.0],
            GEOMETRY_COLOR,
            [3.0, -1.0, 0.0, 1.0],
            GEOMETRY_COLOR,
            [-1.0, 3.0, 0.0, 1.0],
            GEOMETRY_COLOR,
        ];
        let vec4_size = std::mem::size_of::<[f32; 4]>() as u32;
        let vertex_stride = vec4_size * 2;
        let position_offset = 0u32;
        let color_offset = vec4_size;

        let vb_size = std::mem::size_of_val(&vertices) as vk::DeviceSize;
        let vertex_buffer = BufferWithMemory::new(
            vk,
            alloc,
            make_buffer_create_info(vb_size, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let vb_alloc = vertex_buffer.get_allocation();
        let vb_offset: vk::DeviceSize = 0;
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertices.as_ptr() as *const u8,
                vb_alloc.get_host_ptr(),
                vb_size as usize,
            )
        };
        flush_alloc(vk, vb_alloc)?;

        // Used in the atomic buffer case.
        let atomic_buffer_type = vk::DescriptorType::STORAGE_BUFFER;
        let atomic_buffer_size = std::mem::size_of::<u32>() as vk::DeviceSize;
        let mut set_layout = None;
        let mut descriptor_pool = None;
        let mut descriptor_set = None;
        let mut atomic_buffer = None;

        if is_atomic {
            // Zero-out atomic counter.
            let buffer = BufferWithMemory::new(
                vk,
                alloc,
                make_buffer_create_info(atomic_buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            unsafe { std::ptr::write_bytes(buffer.get_allocation().get_host_ptr(), 0, atomic_buffer_size as usize) };

            let layout = DescriptorSetLayoutBuilder::new()
                .add_single_binding(atomic_buffer_type, res_shader_stages)
                .build(vk)?;
            let pool = DescriptorPoolBuilder::new().add_type(atomic_buffer_type, 1).build(
                vk,
                vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
                1,
            )?;
            let set = make_descriptor_set(vk, *pool, *layout)?;

            let buffer_info = make_descriptor_buffer_info(buffer.get(), 0, atomic_buffer_size);
            DescriptorSetUpdateBuilder::new()
                .write_single(*set, Location::binding(0), atomic_buffer_type, &buffer_info)
                .update(vk);

            set_layout = Some(layout);
            descriptor_pool = Some(pool);
            descriptor_set = Some(set);
            atomic_buffer = Some(buffer);
        }
        let set_layout_handles: Vec<vk::DescriptorSetLayout> = set_layout.iter().map(|layout| **layout).collect();
        let bound_set = descriptor_set.as_ref().map(|set| **set);

        // Pipeline layout, render pass and framebuffer.
        let pipeline_layout = make_pipeline_layout(vk, &set_layout_handles)?;
        let render_pass = make_render_pass(vk, color_format)?;
        let framebuffer = make_framebuffer(vk, *render_pass, &[*color_image_view], fb_width, fb_height, 1)?;

        let is_inv_query = params.query_type == QueryType::Invocations;
        let query_type = if is_inv_query {
            vk::QueryType::PIPELINE_STATISTICS
        } else {
            vk::QueryType::OCCLUSION
        };
        let stat_flags = if is_inv_query {
            vk::QueryPipelineStatisticFlags::FRAGMENT_SHADER_INVOCATIONS
        } else {
            vk::QueryPipelineStatisticFlags::empty()
        };
        let control_flags = if is_inv_query {
            vk::QueryControlFlags::empty()
        } else {
            vk::QueryControlFlags::PRECISE
        };

        let query_pool_create_info = vk::QueryPoolCreateInfo::builder()
            .query_type(query_type)
            .query_count(1)
            .pipeline_statistics(stat_flags);
        let query_pool = Unique::new(
            vk,
            unsafe { vk.create_query_pool(&query_pool_create_info, None) }.vk_check("vkCreateQueryPool")?,
        );

        let stages = [
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::VERTEX)
                .module(*vert_module)
                .name(b"main\0")
                .build(),
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(*frag_module)
                .name(b"main\0")
                .build(),
        ];
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: fb_width as f32,
            height: fb_height as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [make_rect_2d(0, 0, fb_width, fb_height)];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);

        // Vertex buffer description.
        let vtx_bindings = [vk::VertexInputBindingDescription::builder()
            .binding(0)
            .stride(vertex_stride)
            .input_rate(vk::VertexInputRate::VERTEX)
            .build()];
        let vtx_attribs = [
            vk::VertexInputAttributeDescription::builder()
                .location(0)
                .binding(0)
                .format(vk::Format::R32G32B32A32_SFLOAT)
                .offset(position_offset)
                .build(),
            vk::VertexInputAttributeDescription::builder()
                .location(1)
                .binding(0)
                .format(vk::Format::R32G32B32A32_SFLOAT)
                .offset(color_offset)
                .build(),
        ];
        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&vtx_bindings)
            .vertex_attribute_descriptions(&vtx_attribs);
        let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(vk::PrimitiveTopology::TRIANGLE_LIST)
            .primitive_restart_enable(false);
        let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
            .depth_clamp_enable(false)
            .rasterizer_discard_enable(false)
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .depth_bias_enable(false)
            .line_width(1.0);
        let multisample_state =
            vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
        let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder();
        let color_blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&color_blend_attachments);

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
            .render_pass(*render_pass)
            .subpass(0)
            .base_pipeline_index(0);
        let pipelines = unsafe { vk.create_graphics_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        let pipeline = Unique::new(vk, pipelines.0[0]);

        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let primary_cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let mut sec_cmd_buffer = None;

        if params.secondary {
            let sec = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;
            let inheritance_info = vk::CommandBufferInheritanceInfo::builder()
                .render_pass(*render_pass)
                .subpass(0)
                .framebuffer(*framebuffer)
                .occlusion_query_enable(query_type == vk::QueryType::OCCLUSION)
                .query_flags(control_flags)
                .pipeline_statistics(stat_flags);
            let begin_info = vk::CommandBufferBeginInfo::builder()
                .flags(vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT | vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE)
                .inheritance_info(&inheritance_info);
            unsafe { vk.begin_command_buffer(*sec, &begin_info) }.vk_check("vkBeginCommandBuffer")?;
            record_render_pass_commands(
                vk,
                *sec,
                bind_point,
                *pipeline,
                *pipeline_layout,
                bound_set,
                vertex_buffer.get(),
                vb_offset,
            );
            end_command_buffer(vk, *sec)?;
            sec_cmd_buffer = Some(sec);
        }

        let subpass_contents = if params.secondary {
            vk::SubpassContents::SECONDARY_COMMAND_BUFFERS
        } else {
            vk::SubpassContents::INLINE
        };
        let clear_values = [vk::ClearValue {
            color: vk::ClearColorValue { float32: CLEAR_COLOR },
        }];
        let primary = *primary_cmd_buffer;

        begin_command_buffer(vk, primary)?;
        unsafe {
            vk.cmd_reset_query_pool(primary, *query_pool, 0, 1);
            vk.cmd_begin_query(primary, *query_pool, 0, control_flags);
            let render_pass_begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(scissors[0])
                .clear_values(&clear_values);
            vk.cmd_begin_render_pass(primary, &render_pass_begin_info, subpass_contents);
            match &sec_cmd_buffer {
                None => record_render_pass_commands(
                    vk,
                    primary,
                    bind_point,
                    *pipeline,
                    *pipeline_layout,
                    bound_set,
                    vertex_buffer.get(),
                    vb_offset,
                ),
                Some(sec) => vk.cmd_execute_commands(primary, &[**sec]),
            }
            vk.cmd_end_render_pass(primary);
            vk.cmd_end_query(primary, *query_pool, 0);

            let pre_transfer_barrier = make_image_memory_barrier(
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                *color_image,
                color_srr,
            );
            vk.cmd_pipeline_barrier(
                primary,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[pre_transfer_barrier],
            );

            let copy_region = make_buffer_image_copy(vk_extent, color_srl);
            vk.cmd_copy_image_to_buffer(
                primary,
                *color_image,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                *color_buffer,
                &[copy_region],
            );

            // Synchronize color buffer copy, and possible atomic writes from the frag shader, to the host.
            let mut src_access = vk::AccessFlags::TRANSFER_WRITE;
            let mut src_stages = vk::PipelineStageFlags::TRANSFER;
            if is_atomic {
                src_access |= vk::AccessFlags::SHADER_WRITE;
                src_stages |= vk::PipelineStageFlags::FRAGMENT_SHADER;
            }
            let pre_host_barrier = make_memory_barrier(src_access, vk::AccessFlags::HOST_READ);
            vk.cmd_pipeline_barrier(
                primary,
                src_stages,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[pre_host_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(vk, primary)?;
        submit_commands_and_wait(vk, queue, primary)?;

        let result_allocation = color_buffer.get_allocation();
        invalidate_alloc(vk, result_allocation)?;

        let mut query_result_bytes = [0u8; 4];
        unsafe {
            vk.get_query_pool_results(
                *query_pool,
                0,
                1,
                &mut query_result_bytes,
                4,
                vk::QueryResultFlags::WAIT,
            )
            .vk_check("vkGetQueryPoolResults")?;
        }
        let query_result = u32::from_ne_bytes(query_result_bytes);

        let pixel_count = vk_extent.width * vk_extent.height * vk_extent.depth;

        // Check query results.
        if is_inv_query {
            let min_count = if params.frag_shader_variant == FragShaderVariant::Flat {
                // Implementations may reuse invocations for fragments that statically compute the same value and write no
                // storage; the floor is the framebuffer divided into maxFragmentSize areas, as upstream states.
                let mut max_fragment_size = vk::Extent2D { width: 1, height: 1 };
                if context.is_device_functionality_supported("VK_KHR_fragment_shading_rate") {
                    let mut fsr_properties = vk::PhysicalDeviceFragmentShadingRatePropertiesKHR::default();
                    let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut fsr_properties);
                    unsafe {
                        context
                            .get_instance()
                            .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
                    };
                    max_fragment_size = fsr_properties.max_fragment_size;
                }
                let max_fragment_width = max_fragment_size.width.max(1);
                let max_fragment_height = max_fragment_size.height.max(1);
                let min_cols = vk_extent.width / max_fragment_width;
                let min_rows = vk_extent.height / max_fragment_height;
                min_cols * min_rows * vk_extent.depth
            } else {
                pixel_count
            };

            if query_result < min_count {
                let msg = format!(
                    "Framebuffer size: {}x{}; expected query result to be at least {} but found {}",
                    vk_extent.width, vk_extent.height, min_count, query_result
                );
                return Ok(TestStatus::fail(msg));
            }
        } else if pixel_count != query_result {
            let msg = format!(
                "Framebuffer size: {}x{}; expected query result to be {} but found {}",
                vk_extent.width, vk_extent.height, pixel_count, query_result
            );
            return Ok(TestStatus::fail(msg));
        }

        if let Some(buffer) = &atomic_buffer {
            // Verify atomic counter.
            let atomic_buffer_alloc = buffer.get_allocation();
            invalidate_alloc(vk, atomic_buffer_alloc)?;

            let atomic_counter = unsafe { std::ptr::read_unaligned(atomic_buffer_alloc.get_host_ptr() as *const u32) };
            if atomic_counter != pixel_count {
                let msg = format!(
                    "Framebuffer size: {}x{}; expected atomic counter to be {} but found {}",
                    vk_extent.width, vk_extent.height, pixel_count, atomic_counter
                );
                return Ok(TestStatus::fail(msg));
            }
        }

        // Check color buffer: exact result expected.
        let pixels =
            unsafe { std::slice::from_raw_parts(result_allocation.get_host_ptr(), color_buffer_size as usize) };
        if pixels.chunks_exact(4).any(|pixel| pixel != GEOMETRY_COLOR_BYTES) {
            return Ok(TestStatus::fail("Unexpected results in color buffer"));
        }

        // The pool and layout handles above only need to outlive the submission.
        let _ = (&descriptor_pool, &set_layout);
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createFragInvocationTests`
pub fn create_frag_invocation_tests() -> TestCaseGroup {
    let mut main_group = TestCaseGroup::new("frag_invocations");

    let frag_shader_variant_cases: [(FragShaderVariant, &str, &'static FragInvocationProgram); 3] = [
        (FragShaderVariant::Flat, "", &FRAG_INVOCATION_FLAT),
        (
            FragShaderVariant::VertexColor,
            "_with_vertex_color",
            &FRAG_INVOCATION_VERTEX_COLOR,
        ),
        (
            FragShaderVariant::AtomicCounter,
            "_with_atomic_counter",
            &FRAG_INVOCATION_ATOMIC_COUNTER,
        ),
    ];

    for query_type in [QueryType::Occlusion, QueryType::Invocations] {
        let mut query_type_group = TestCaseGroup::new(get_query_type_name(query_type));

        for secondary_case in [false, true] {
            for (variant, suffix, program) in frag_shader_variant_cases {
                let test_name = format!("{}{}", if secondary_case { "secondary" } else { "primary" }, suffix);
                let params = TestParams {
                    query_type,
                    secondary: secondary_case,
                    frag_shader_variant: variant,
                };
                query_type_group.add_child(Box::new(FragInvocationTestCase {
                    name: test_name,
                    params,
                    program,
                }) as Box<dyn TestCase>);
            }
        }

        main_group.add_child(query_type_group);
    }

    main_group
}
