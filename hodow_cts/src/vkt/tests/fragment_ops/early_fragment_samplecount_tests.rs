// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/fragment_ops/vktFragmentOperationsEarlyFragmentTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `EarlyFragmentSampleCountTest`, the `sample_count_*` cases for 2, 4, 8 and 16 samples. The
// shaders are in shaders/manifest/fragment_ops_early_fragment_samplecount.toml, one program set per combination of earlyAndLate and
// alphaToCoverage. The comparison of the colour of the run without early tests is not done, as upstream only logs it.
//
// A multisampled colour and depth image are rendered twice with an occlusion query around each draw: without early fragment tests the
// shader writes half of the samples out of gl_SampleMask, with them the pipeline's sample mask takes half and the shader kills the rest after
// sample counting. Both counts must be about a quarter of the pixels times the sample count; an implementation that counts after the kill
// or tests the mask after counting is allowed, with a quality warning, unless maintenance5 says which one it does.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::copy_image_to_buffer;
use super::early_fragment_tests::{COLOR_FORMAT, FLAG_TEST_DEPTH, RENDER_SIZE, check_early_fragment_support};
use crate::generated::shaders::fragment_ops_early_fragment_samplecount::{
    SC_ALPHA_TO_COVERAGE, SC_EARLY_AND_LATE, SC_PLAIN,
};
use crate::tcu::{TestError, TestOutcome, TestResult, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const DEPTH_FORMAT: vk::Format = vk::Format::D16_UNORM;

#[derive(Clone, Copy)]
struct SampleCountTestParams {
    sample_count: u32,
    early_and_late: bool,
    alpha_to_coverage: bool,
    use_maintenance5: bool,
}

fn sample_count_of(samples: u32) -> vk::SampleCountFlags {
    match samples {
        2 => vk::SampleCountFlags::_2,
        4 => vk::SampleCountFlags::_4,
        8 => vk::SampleCountFlags::_8,
        _ => vk::SampleCountFlags::_16,
    }
}

struct EarlyFragmentSampleCountTest {
    name: String,
    params: SampleCountTestParams,
}

impl TestCase for EarlyFragmentSampleCountTest {
    fn name(&self) -> &str {
        &self.name
    }

    /// `EarlyFragmentSampleCountTest::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_early_fragment_support(context, FLAG_TEST_DEPTH)?;

        // Check support for MSAA image formats used in the test.
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let samples = sample_count_of(self.params.sample_count);

        let color_properties = unsafe {
            instance.get_physical_device_image_format_properties(
                physical_device,
                COLOR_FORMAT,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
                vk::ImageCreateFlags::empty(),
            )
        }
        .vk_check("vkGetPhysicalDeviceImageFormatProperties")?;
        if !color_properties.sample_counts.contains(samples) {
            return Err(TestError::NotSupported(
                "Format does not support this number of samples for color format".to_string(),
            ));
        }

        let depth_properties = unsafe {
            instance.get_physical_device_image_format_properties(
                physical_device,
                DEPTH_FORMAT,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
                vk::ImageCreateFlags::empty(),
            )
        }
        .vk_check("vkGetPhysicalDeviceImageFormatProperties")?;
        if !depth_properties.sample_counts.contains(samples) {
            return Err(TestError::NotSupported(
                "Format does not support this number of samples for depth format".to_string(),
            ));
        }

        if context.get_device_features().occlusion_query_precise == vk::FALSE {
            return Err(TestError::NotSupported(
                "Precise occlusion queries are not supported".to_string(),
            ));
        }

        if self.params.early_and_late {
            context.require_device_functionality("VK_AMD_shader_early_and_late_fragment_tests")?;
            let mut features = vk::PhysicalDeviceShaderEarlyAndLateFragmentTestsFeaturesAMD::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
            unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };
            if features.shader_early_and_late_fragment_tests == vk::FALSE {
                return Err(TestError::NotSupported(
                    "shaderEarlyAndLateFragmentTests is not supported".to_string(),
                ));
            }
        }

        if self.params.use_maintenance5 {
            context.require_device_functionality("VK_KHR_maintenance5")?;
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let program: &SharedProgram = if self.params.early_and_late {
            &SC_EARLY_AND_LATE
        } else if self.params.alpha_to_coverage {
            &SC_ALPHA_TO_COVERAGE
        } else {
            &SC_PLAIN
        };
        program.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(EarlyFragmentSampleCountInstance {
            context,
            params: self.params,
        })
    }
}

struct EarlyFragmentSampleCountInstance<'a> {
    context: &'a Context<'a>,
    params: SampleCountTestParams,
}

impl TestInstance for EarlyFragmentSampleCountInstance<'_> {
    /// `EarlyFragmentSampleCountTestInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let queue = context.get_universal_queue();
        let samples = sample_count_of(self.params.sample_count);
        const QUERY_COUNT: u32 = 2;
        const QUERY_INDEX_NO_EARLY_FRAG: usize = 0;
        const QUERY_INDEX_EARLY_FRAG: usize = 1;

        // Create a query pool for storing the occlusion query result
        let query_pool_info = vk::QueryPoolCreateInfo::builder()
            .query_type(vk::QueryType::OCCLUSION)
            .query_count(QUERY_COUNT);
        let query_pool = Unique::new(
            device,
            unsafe { device.create_query_pool(&query_pool_info, None) }.vk_check("vkCreateQueryPool")?,
        );

        log::info!("Using depth format {DEPTH_FORMAT:?}");

        let image_info = |format: vk::Format, samples: vk::SampleCountFlags, usage: vk::ImageUsageFlags| {
            vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(format)
                .extent(vk::Extent3D {
                    width: RENDER_SIZE,
                    height: RENDER_SIZE,
                    depth: 1,
                })
                .mip_levels(1)
                .array_layers(1)
                .samples(samples)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(usage)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build()
        };

        // Color attachment
        let color_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let color_image = ImageWithMemory::new(
            device,
            allocator,
            image_info(COLOR_FORMAT, samples, vk::ImageUsageFlags::COLOR_ATTACHMENT),
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
            image_info(
                COLOR_FORMAT,
                vk::SampleCountFlags::_1,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;
        let resolve_color_image_view = make_image_view(
            device,
            resolve_color_image.get(),
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            color_subresource_range,
        )?;

        // Depth-Stencil attachment
        let depth_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1);
        let depth_image = ImageWithMemory::new(
            device,
            allocator,
            image_info(DEPTH_FORMAT, samples, vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT),
            MemoryRequirement::ANY,
        )?;
        let depth_image_view = make_image_view(
            device,
            depth_image.get(),
            vk::ImageViewType::_2D,
            DEPTH_FORMAT,
            depth_subresource_range,
        )?;

        let attachment_images = [*color_image_view, *depth_image_view, *resolve_color_image_view];

        // Vertex buffer
        let vertices: [[f32; 4]; 6] = [
            [1.0, -1.0, 0.0, 1.0],
            [-1.0, -1.0, 0.0, 1.0],
            [-1.0, 1.0, 0.0, 1.0],
            [-1.0, 1.0, 1.0, 1.0],
            [1.0, 1.0, 1.0, 1.0],
            [1.0, -1.0, 1.0, 1.0],
        ];
        let num_vertices = vertices.len() as u32;
        let vertex_buffer_size_bytes = 256 * vk::DeviceSize::from(num_vertices);
        let vertex_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(vertex_buffer_size_bytes, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertices.as_ptr().cast::<u8>(),
                vertex_buffer.get_allocation().get_host_ptr(),
                std::mem::size_of_val(&vertices),
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?;

        // Render result buffers (to retrieve color attachment contents)
        let color_buffer_size_bytes = vk::DeviceSize::from(4 * RENDER_SIZE * RENDER_SIZE);
        let color_buffer_no_early_results = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(color_buffer_size_bytes, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let color_buffer_early_results = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(color_buffer_size_bytes, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Pipeline
        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let fragment_module_no_early = create_shader_module(device, binaries.get("frag")?)?;
        let fragment_module_early_frag = create_shader_module(device, binaries.get("frag_early")?)?;

        let attachment_template = vk::AttachmentDescription::builder()
            .samples(samples)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build();
        let attachment_descriptions = [
            vk::AttachmentDescription {
                format: COLOR_FORMAT,
                ..attachment_template
            },
            vk::AttachmentDescription {
                format: DEPTH_FORMAT,
                stencil_load_op: vk::AttachmentLoadOp::CLEAR,
                stencil_store_op: vk::AttachmentStoreOp::STORE,
                initial_layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                final_layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                ..attachment_template
            },
            vk::AttachmentDescription {
                format: COLOR_FORMAT,
                samples: vk::SampleCountFlags::_1,
                ..attachment_template
            },
        ];
        let color_attachment_refs = [vk::AttachmentReference {
            attachment: 0,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        }];
        let depth_stencil_attachment_ref = vk::AttachmentReference {
            attachment: 1,
            layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        };
        let resolve_attachment_refs = [vk::AttachmentReference {
            attachment: 2,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        }];
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_attachment_refs)
            .resolve_attachments(&resolve_attachment_refs)
            .depth_stencil_attachment(&depth_stencil_attachment_ref)
            .build()];
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachment_descriptions)
            .subpasses(&subpasses);
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );
        let framebuffer = make_framebuffer(device, *render_pass, &attachment_images, RENDER_SIZE, RENDER_SIZE, 1)?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;

        let make_pipeline = |fragment_module: vk::ShaderModule, sample_mask: vk::SampleMask| {
            let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST)
                .with_position_input()
                .with_full_viewport(RENDER_SIZE, RENDER_SIZE);
            state.depth_stencil = vk::PipelineDepthStencilStateCreateInfo {
                depth_test_enable: vk::TRUE,
                depth_write_enable: vk::TRUE,
                depth_compare_op: vk::CompareOp::LESS,
                depth_bounds_test_enable: vk::FALSE,
                stencil_test_enable: vk::FALSE,
                min_depth_bounds: 0.0,
                max_depth_bounds: 1.0,
                ..Default::default()
            };
            state.samples = samples;
            state.sample_mask = Some(sample_mask);
            state.alpha_to_coverage_enable = self.params.alpha_to_coverage;
            create_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &[
                    (vk::ShaderStageFlags::VERTEX, *vertex_module),
                    (vk::ShaderStageFlags::FRAGMENT, fragment_module),
                ],
                &state,
            )
        };

        // When we are creating a pipeline for runs without early fragment test, we are enabling all the samples for full coverage. Sample mask will be modified in a fragment shader.
        let pipeline_no_early_frag = make_pipeline(*fragment_module_no_early, 0xFFFF_FFFF)?;
        // For early fragment tests, we are enabling only half of the samples.
        let pipeline_early_frag = make_pipeline(*fragment_module_early_frag, 0xAAAA_AAAA)?;

        // Build a command buffer
        let command_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *command_buffer;

        begin_command_buffer(device, cmd)?;

        // transition images to proper layouts - this cant be done with renderpass as we will use same renderpass twice
        let initial_image_barriers = [
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                color_image.get(),
                color_subresource_range,
            ),
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                resolve_color_image.get(),
                color_subresource_range,
            ),
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                depth_image.get(),
                depth_subresource_range,
            ),
        ];
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &initial_image_barriers[..2],
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &initial_image_barriers[2..],
            );
        }

        let clear_color = vk::ClearValue {
            color: vk::ClearColorValue {
                float32: [0.0, 0.0, 0.0, 1.0],
            },
        };
        let clear_depth_stencil = vk::ClearValue {
            depth_stencil: vk::ClearDepthStencilValue { depth: 0.5, stencil: 3 },
        };
        let clear_values = [clear_color, clear_depth_stencil, clear_color, clear_depth_stencil];
        let render_area = vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: RENDER_SIZE,
                height: RENDER_SIZE,
            },
        };
        let render_pass_begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(render_area)
            .clear_values(&clear_values);

        // Reset query pool. Must be done outside of render pass
        unsafe { device.cmd_reset_query_pool(cmd, *query_pool, 0, QUERY_COUNT) };

        let draw = |pipeline: vk::Pipeline, query_index: u32| unsafe {
            device.cmd_begin_render_pass(cmd, &render_pass_begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline);
            device.cmd_begin_query(cmd, *query_pool, query_index, vk::QueryControlFlags::PRECISE);
            device.cmd_draw(cmd, num_vertices, 1, 0, 0);
            device.cmd_end_query(cmd, *query_pool, query_index);
            device.cmd_end_render_pass(cmd);
        };

        // Run without early fragment test.
        draw(*pipeline_no_early_frag, QUERY_INDEX_NO_EARLY_FRAG as u32);
        copy_image_to_buffer(
            device,
            cmd,
            resolve_color_image.get(),
            color_buffer_no_early_results.get(),
            RENDER_SIZE,
            RENDER_SIZE,
        );

        // after copying from resolved image we need to switch its layout back to color attachment optimal
        let post_resolve_image_barrier = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_READ,
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            resolve_color_image.get(),
            color_subresource_range,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[post_resolve_image_barrier],
            );
        }

        // Run with early fragment test.
        draw(*pipeline_early_frag, QUERY_INDEX_EARLY_FRAG as u32);
        copy_image_to_buffer(
            device,
            cmd,
            resolve_color_image.get(),
            color_buffer_early_results.get(),
            RENDER_SIZE,
            RENDER_SIZE,
        );

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        // When early fragment test is enabled, all samples are killed in fragment shader. The result color should be black.
        invalidate_alloc(device, color_buffer_early_results.get_allocation())?;
        let early_pixels = unsafe {
            std::slice::from_raw_parts(
                color_buffer_early_results.get_allocation().get_host_ptr().cast_const(),
                color_buffer_size_bytes as usize,
            )
        };
        let threshold = (0.02f32 * 255.0).ceil() as i32;
        let reference_pixel = [0i32, 0, 0, 255];
        if early_pixels.chunks_exact(4).any(|pixel| {
            pixel
                .iter()
                .zip(reference_pixel)
                .any(|(&value, reference)| (i32::from(value) - reference).abs() > threshold)
        }) {
            return Ok(TestStatus::fail("Rendered color image is not correct"));
        }

        // The image has 32x32 pixels and each pixel has sampleCount samples. Half of these samples are discarded before sample counting.
        // This means the reference value for passed samples is ((32 x 32) / 2 / 2) * sampleCount.
        let ref_value = u64::from((RENDER_SIZE * RENDER_SIZE) / 4 * self.params.sample_count);
        let tolerance = ref_value * 5 / 100;
        let min_value = ref_value - tolerance;
        let max_value = ref_value + tolerance;

        let mut query_bytes = [0u8; 16];
        unsafe {
            device.get_query_pool_results(
                *query_pool,
                0,
                QUERY_COUNT,
                &mut query_bytes,
                8,
                vk::QueryResultFlags::_64 | vk::QueryResultFlags::WAIT,
            )
        }
        .vk_check("vkGetQueryPoolResults")?;
        let sample_counts = [
            u64::from_ne_bytes(query_bytes[0..8].try_into().expect("eight bytes")),
            u64::from_ne_bytes(query_bytes[8..16].try_into().expect("eight bytes")),
        ];

        log::info!("Acceptable range: {min_value} - {max_value}");
        log::info!("Passed Samples (without early fragment test) : {}", sample_counts[0]);
        log::info!("Passed Samples (with early fragment test)    : {}", sample_counts[1]);

        let no_early = sample_counts[QUERY_INDEX_NO_EARLY_FRAG];
        let early = sample_counts[QUERY_INDEX_EARLY_FRAG];

        // Check that number of the all passed samples are within an acceptable range.
        if no_early >= min_value && no_early <= max_value && early >= min_value && early <= max_value {
            return Ok(TestStatus::pass("Success"));
        }

        if no_early >= min_value && no_early <= max_value && early == 0 {
            if self.params.use_maintenance5 {
                let mut maintenance5 = vk::PhysicalDeviceMaintenance5Properties::default();
                let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut maintenance5);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
                };
                if maintenance5.early_fragment_multisample_coverage_after_sample_counting != vk::FALSE {
                    return Ok(TestStatus::fail("Fail"));
                }
                return Ok(TestStatus::pass("Pass"));
            }

            // since the specification says 'should', the opposite behavior is allowed, but not preferred
            return Ok(TestStatus::new(
                TestResult::QualityWarning,
                "Sample count is 0 - sample counting performed after multisample coverage and fragment shading",
            ));
        }

        if no_early >= min_value && no_early <= max_value && early >= min_value * 2 && early <= max_value * 2 {
            // If the sample count returned is double the expected value, the sample mask test has been executed after sample counting.
            if self.params.use_maintenance5 {
                let mut maintenance5 = vk::PhysicalDeviceMaintenance5Properties::default();
                let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut maintenance5);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
                };
                if maintenance5.early_fragment_sample_mask_test_before_sample_counting != vk::FALSE {
                    return Ok(TestStatus::fail("Fail"));
                }
                return Ok(TestStatus::pass("Pass"));
            }

            // since the specification says 'may', the opposite behavior is allowed, but not preferred
            return Ok(TestStatus::new(
                TestResult::QualityWarning,
                "Sample count is greater than expected - sample mask test performed after sample counting",
            ));
        }

        Ok(TestStatus::fail("Sample count value outside expected range."))
    }
}

/// The `sample_count_*` cases of `createEarlyFragmentTests`
pub fn add_sample_count_cases(group: &mut TestCaseGroup) {
    for sample_count in [2, 4, 8, 16] {
        let sample_counts_str = format!("samples_{sample_count}");
        let mut params = SampleCountTestParams {
            sample_count,
            early_and_late: false,
            alpha_to_coverage: false,
            use_maintenance5: false,
        };
        let add = |group: &mut TestCaseGroup, name: String, params: SampleCountTestParams| {
            group.add_child(Box::new(EarlyFragmentSampleCountTest { name, params }) as Box<dyn TestCase>);
        };

        add(
            group,
            format!("sample_count_early_fragment_tests_depth_{sample_counts_str}"),
            params,
        );

        params.early_and_late = true;
        add(
            group,
            format!("sample_count_early_and_late_fragment_tests_depth_{sample_counts_str}"),
            params,
        );

        params.use_maintenance5 = true;
        add(
            group,
            format!("sample_count_early_and_late_fragment_tests_depth_{sample_counts_str}_maintenance5"),
            params,
        );
        params.early_and_late = false;
        add(
            group,
            format!("sample_count_early_fragment_tests_depth_{sample_counts_str}_maintenance5"),
            params,
        );
        params.alpha_to_coverage = true;
        add(
            group,
            format!("sample_count_early_fragment_tests_depth_alpha_to_coverage_{sample_counts_str}_maintenance5"),
            params,
        );
    }
}
