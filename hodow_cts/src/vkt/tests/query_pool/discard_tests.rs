// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/query_pool/vktQueryPoolDiscardTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The shaders are in `shaders/manifest/query_pool_discard.toml`; upstream's `initPrograms`
// builds six distinct fragment shaders, which is what the manifest declares.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtExtendedDynamicState3ExtensionDeviceCommands, InstanceV1_1};

use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{end_command_buffer, make_rect_2d, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_framebuffer, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The manifest declares its cases with this: the shader pair plus the two axes it was built from.
pub struct DiscardProgram {
    pub name: &'static str,
    pub early: bool,
    pub kind: u32,
    pub programs: BinaryCollection,
}

use crate::generated::shaders::query_pool_discard::ALL_DISCARD_PROGRAM;

const IMAGE_SIZE: u32 = 32;
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const DEPTH_FORMAT: vk::Format = vk::Format::D16_UNORM;

/// `DiscardType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum DiscardType {
    Discard,
    SampleMask,
    AlphaToCoverage,
    AlphaToCoverageDynamic,
}

/// `TestParameters`
#[derive(Clone, Copy)]
struct TestParameters {
    early_fragment_tests: bool,
    use_depth: bool,
    precise: bool,
    discard_type: DiscardType,
}

impl TestParameters {
    fn is_alpha_to_coverage(&self) -> bool {
        matches!(
            self.discard_type,
            DiscardType::AlphaToCoverage | DiscardType::AlphaToCoverageDynamic
        )
    }

    fn program(&self) -> &'static DiscardProgram {
        let kind = match self.discard_type {
            DiscardType::Discard => 0,
            DiscardType::SampleMask => 1,
            DiscardType::AlphaToCoverage | DiscardType::AlphaToCoverageDynamic => 2,
        };
        ALL_DISCARD_PROGRAM
            .iter()
            .copied()
            .find(|p| p.early == self.early_fragment_tests && p.kind == kind)
            .expect("the manifest covers every early/kind pair")
    }
}

/// `QueryPoolDiscardTestCase`
struct QueryPoolDiscardTestCase {
    name: &'static str,
    params: TestParameters,
}

impl TestCase for QueryPoolDiscardTestCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.params.discard_type == DiscardType::AlphaToCoverageDynamic {
            context.require_device_functionality("VK_EXT_extended_dynamic_state3")?;
            let mut eds3_features = vk::PhysicalDeviceExtendedDynamicState3FeaturesEXT::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut eds3_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if eds3_features.extended_dynamic_state3_alpha_to_coverage_enable == vk::FALSE {
                return Err(TestError::NotSupported(
                    "extendedDynamicState3AlphaToCoverageEnable not supported".to_string(),
                ));
            }
        }
        if self.params.precise && context.get_device_features().occlusion_query_precise == vk::FALSE {
            return Err(TestError::NotSupported(
                "occlusionQueryPrecise not supported".to_string(),
            ));
        }
        if self.params.early_fragment_tests {
            context.require_device_functionality("VK_KHR_maintenance5")?;
            let mut maintenance5 = vk::PhysicalDeviceMaintenance5Properties::default();
            let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut maintenance5);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
            };
            if maintenance5.early_fragment_sample_mask_test_before_sample_counting == vk::FALSE {
                return Err(TestError::NotSupported(
                    "earlyFragmentSampleMaskTestBeforeSampleCounting not supported".to_string(),
                ));
            }
            if self.params.is_alpha_to_coverage()
                && maintenance5.early_fragment_multisample_coverage_after_sample_counting == vk::FALSE
            {
                return Err(TestError::NotSupported(
                    "earlyFragmentMultisampleCoverageAfterSampleCounting not supported".to_string(),
                ));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.params.program().programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(QueryPoolDiscardTestInstance {
            context,
            params: self.params,
        })
    }
}

/// `QueryPoolDiscardTestInstance`
struct QueryPoolDiscardTestInstance<'a> {
    context: &'a Context<'a>,
    params: TestParameters,
}

impl TestInstance for QueryPoolDiscardTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let vk = context.get_device();
        let queue_family_index = context.get_universal_queue_family_index();
        let queue = context.get_universal_queue();
        let alloc = context.get_default_allocator();
        let alpha_to_coverage = self.params.is_alpha_to_coverage();

        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        let query_pool_create_info = vk::QueryPoolCreateInfo::builder()
            .query_type(vk::QueryType::OCCLUSION)
            .query_count(1);
        let query_pool = Unique::new(
            vk,
            unsafe { vk.create_query_pool(&query_pool_create_info, None) }.vk_check("vkCreateQueryPool")?,
        );

        // createRenderPass()
        let image_extent = vk::Extent3D {
            width: IMAGE_SIZE,
            height: IMAGE_SIZE,
            depth: 1,
        };
        let color_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let depth_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1);

        let make_image_info = |format: vk::Format, samples: vk::SampleCountFlags, usage: vk::ImageUsageFlags| {
            vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(format)
                .extent(image_extent)
                .mip_levels(1)
                .array_layers(1)
                .samples(samples)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(usage)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build()
        };

        let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
        let color_image = ImageWithMemory::new(
            vk,
            alloc,
            make_image_info(COLOR_FORMAT, vk::SampleCountFlags::_1, color_usage),
            MemoryRequirement::ANY,
        )?;
        let color_image_view = make_image_view(
            vk,
            *color_image,
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            color_subresource_range,
        )?;

        let msaa_image = if alpha_to_coverage {
            Some(ImageWithMemory::new(
                vk,
                alloc,
                make_image_info(COLOR_FORMAT, vk::SampleCountFlags::_4, color_usage),
                MemoryRequirement::ANY,
            )?)
        } else {
            None
        };
        let msaa_image_view = match &msaa_image {
            Some(image) => Some(make_image_view(
                vk,
                **image,
                vk::ImageViewType::_2D,
                COLOR_FORMAT,
                color_subresource_range,
            )?),
            None => None,
        };

        let depth_sample_count = if alpha_to_coverage {
            vk::SampleCountFlags::_4
        } else {
            vk::SampleCountFlags::_1
        };
        let depth_image = ImageWithMemory::new(
            vk,
            alloc,
            make_image_info(
                DEPTH_FORMAT,
                depth_sample_count,
                vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT,
            ),
            MemoryRequirement::ANY,
        )?;
        let depth_image_view = make_image_view(
            vk,
            *depth_image,
            vk::ImageViewType::_2D,
            DEPTH_FORMAT,
            depth_subresource_range,
        )?;

        let attachment_descriptions = [
            vk::AttachmentDescription::builder()
                .format(COLOR_FORMAT)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .build(),
            vk::AttachmentDescription::builder()
                .format(DEPTH_FORMAT)
                .samples(depth_sample_count)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::DONT_CARE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .build(),
            vk::AttachmentDescription::builder()
                .format(COLOR_FORMAT)
                .samples(vk::SampleCountFlags::_4)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .build(),
        ];

        let color_attachment_references = [vk::AttachmentReference {
            attachment: if alpha_to_coverage { 2 } else { 0 },
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        }];
        let resolve_attachment_references = [vk::AttachmentReference {
            attachment: 0,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        }];
        let depth_attachment_reference = vk::AttachmentReference {
            attachment: 1,
            layout: vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        };

        let mut subpass_description = vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_attachment_references)
            .depth_stencil_attachment(&depth_attachment_reference);
        if alpha_to_coverage {
            subpass_description = subpass_description.resolve_attachments(&resolve_attachment_references);
        }
        let subpasses = [subpass_description.build()];

        let attachment_count = if alpha_to_coverage { 3 } else { 2 };
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachment_descriptions[..attachment_count])
            .subpasses(&subpasses);
        let render_pass = Unique::new(
            vk,
            unsafe { vk.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );

        let mut attachments = vec![*color_image_view, *depth_image_view];
        if let Some(view) = &msaa_image_view {
            attachments.push(**view);
        }
        let framebuffer = make_framebuffer(vk, *render_pass, &attachments, IMAGE_SIZE, IMAGE_SIZE, 1)?;

        // createPipeline()
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(vk, binaries.get("vert")?)?;
        let frag_module = create_shader_module(vk, binaries.get("frag")?)?;

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
            width: IMAGE_SIZE as f32,
            height: IMAGE_SIZE as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [make_rect_2d(0, 0, IMAGE_SIZE, IMAGE_SIZE)];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);
        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder();
        let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(vk::PrimitiveTopology::TRIANGLE_STRIP)
            .primitive_restart_enable(false);
        let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
            .depth_clamp_enable(false)
            .rasterizer_discard_enable(false)
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .depth_bias_enable(false)
            .line_width(1.0);

        // Upstream names this variable alphaToOneCoverage but passes it as alphaToCoverageEnable.
        let sample_count = if alpha_to_coverage {
            vk::SampleCountFlags::_4
        } else {
            vk::SampleCountFlags::_1
        };
        let multisample_state = vk::PipelineMultisampleStateCreateInfo::builder()
            .rasterization_samples(sample_count)
            .sample_shading_enable(false)
            .min_sample_shading(1.0)
            .alpha_to_coverage_enable(alpha_to_coverage)
            .alpha_to_one_enable(false);

        let stencil_op = vk::StencilOpState {
            fail_op: vk::StencilOp::ZERO,
            pass_op: vk::StencilOp::KEEP,
            depth_fail_op: vk::StencilOp::ZERO,
            compare_op: vk::CompareOp::GREATER,
            compare_mask: 0xFF,
            write_mask: 0xFF,
            reference: 128,
        };
        let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(self.params.use_depth)
            .depth_write_enable(self.params.use_depth)
            .depth_compare_op(vk::CompareOp::LESS)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(false)
            .front(stencil_op)
            .back(stencil_op)
            .min_depth_bounds(0.0)
            .max_depth_bounds(0.0);

        let color_blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&color_blend_attachments);

        let dynamic_states = [vk::DynamicState::ALPHA_TO_COVERAGE_ENABLE_EXT];
        let dynamic_state_info = if self.params.discard_type == DiscardType::AlphaToCoverageDynamic {
            vk::PipelineDynamicStateCreateInfo::builder().dynamic_states(&dynamic_states)
        } else {
            vk::PipelineDynamicStateCreateInfo::builder()
        };

        let pipeline_layout = make_pipeline_layout(vk, &[])?;
        let pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input_state)
            .input_assembly_state(&input_assembly_state)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization_state)
            .multisample_state(&multisample_state)
            .depth_stencil_state(&depth_stencil_state)
            .color_blend_state(&color_blend_state)
            .dynamic_state(&dynamic_state_info)
            .layout(*pipeline_layout)
            .render_pass(*render_pass)
            .subpass(0)
            .base_pipeline_index(0);
        let pipelines = unsafe { vk.create_graphics_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        let pipeline = Unique::new(vk, pipelines.0[0]);

        let color_output_buffer = BufferWithMemory::new(
            vk,
            alloc,
            make_buffer_create_info(
                (IMAGE_SIZE * IMAGE_SIZE) as vk::DeviceSize * std::mem::size_of::<u32>() as vk::DeviceSize,
                vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let begin_info = vk::CommandBufferBeginInfo::builder();
        unsafe { vk.begin_command_buffer(*cmd_buffer, &begin_info) }.vk_check("vkBeginCommandBuffer")?;
        unsafe {
            vk.cmd_reset_query_pool(*cmd_buffer, *query_pool, 0, 1);
            let control_flags = if self.params.precise {
                vk::QueryControlFlags::PRECISE
            } else {
                vk::QueryControlFlags::empty()
            };
            vk.cmd_begin_query(*cmd_buffer, *query_pool, 0, control_flags);

            let clear_values = [
                vk::ClearValue {
                    color: vk::ClearColorValue {
                        float32: [0.0, 0.0, 0.0, 0.0],
                    },
                },
                vk::ClearValue {
                    depth_stencil: vk::ClearDepthStencilValue { depth: 1.0, stencil: 0 },
                },
                vk::ClearValue {
                    color: vk::ClearColorValue {
                        float32: [0.0, 0.0, 0.0, 0.0],
                    },
                },
            ];
            let render_pass_begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(make_rect_2d(0, 0, IMAGE_SIZE, IMAGE_SIZE))
                .clear_values(&clear_values);
            vk.cmd_begin_render_pass(*cmd_buffer, &render_pass_begin_info, vk::SubpassContents::INLINE);
            vk.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            if self.params.discard_type == DiscardType::AlphaToCoverageDynamic {
                vk.cmd_set_alpha_to_coverage_enable_ext(*cmd_buffer, true);
            }
            vk.cmd_draw(*cmd_buffer, 4, 1, 0, 0);
            vk.cmd_end_render_pass(*cmd_buffer);

            vk.cmd_end_query(*cmd_buffer, *query_pool, 0);

            let image_barrier = make_image_memory_barrier(
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                *color_image,
                make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
            );
            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[image_barrier],
            );

            let copy_region = make_buffer_image_copy(
                image_extent,
                make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
            );
            vk.cmd_copy_image_to_buffer(
                *cmd_buffer,
                *color_image,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                *color_output_buffer,
                &[copy_region],
            );

            let buffer_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::HOST_READ,
                *color_output_buffer,
                0,
                vk::WHOLE_SIZE,
            );
            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[buffer_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(vk, *cmd_buffer)?;
        submit_commands_and_wait(vk, queue, *cmd_buffer)?;
        invalidate_alloc(vk, color_output_buffer.get_allocation())?;

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

        if self.params.precise {
            let mut expected_occlusion_result = IMAGE_SIZE * IMAGE_SIZE;
            if !self.params.early_fragment_tests {
                expected_occlusion_result /= 2;
            }
            if alpha_to_coverage {
                expected_occlusion_result *= 4;
            }

            if query_result != expected_occlusion_result {
                log::info!(
                    "Expected occlusion query result {expected_occlusion_result}, but actual value is {query_result}"
                );
                return Ok(TestStatus::fail("Unexpected query result"));
            }
        } else if query_result == 0 {
            log::info!("Expected occlusion query result 0, but actual value is {query_result}");
            return Ok(TestStatus::fail("Unexpected query result"));
        }

        let pixels = unsafe {
            std::slice::from_raw_parts(
                color_output_buffer.get_allocation().get_host_ptr(),
                (IMAGE_SIZE * IMAGE_SIZE * 4) as usize,
            )
        };
        for j in 0..IMAGE_SIZE {
            for i in 0..IMAGE_SIZE {
                let offset = ((j * IMAGE_SIZE + i) * 4) as usize;
                let pixel = &pixels[offset..offset + 4];
                let expected: [u8; 4] = if (i & 1) == 1 { [255; 4] } else { [0; 4] };
                if pixel != expected {
                    log::info!("At ({i}, {j}) expected {expected:?}, but actual value is {pixel:?}");
                    return Ok(TestStatus::fail("Fail"));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createDiscardTests`
pub fn create_discard_tests() -> TestCaseGroup {
    let mut discard_tests = TestCaseGroup::new("discard");

    const DISCARD_TYPES: [(DiscardType, &str); 4] = [
        (DiscardType::Discard, "discard"),
        (DiscardType::SampleMask, "sample_mask"),
        (DiscardType::AlphaToCoverage, "alpha_to_coverage"),
        (DiscardType::AlphaToCoverageDynamic, "alpha_to_coverage_dynamic"),
    ];

    for early_fragment_test in [false, true] {
        let mut early_fragment_group = TestCaseGroup::new(if early_fragment_test { "early" } else { "normal" });
        for depth in [false, true] {
            let mut depth_group = TestCaseGroup::new(if depth { "with_depth" } else { "no_depth" });
            for precise in [false, true] {
                let mut precise_group = TestCaseGroup::new(if precise { "precise" } else { "none" });
                for (discard_type, name) in DISCARD_TYPES {
                    let params = TestParameters {
                        early_fragment_tests: early_fragment_test,
                        use_depth: depth,
                        precise,
                        discard_type,
                    };
                    precise_group.add_child(Box::new(QueryPoolDiscardTestCase { name, params }) as Box<dyn TestCase>);
                }
                depth_group.add_child(precise_group);
            }
            early_fragment_group.add_child(depth_group);
        }
        discard_tests.add_child(early_fragment_group);
    }

    discard_tests
}
