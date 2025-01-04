// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktRenderPassMultisampleResolveTests.cpp (`MsaaMixedSampleCountTest`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// A reference render pass draws a triangle into a 4 sample image resolved into image A. The test render pass draws the same
// triangle in a first subpass the same way and a second triangle in a 1 sample subpass over the same attachment; the resolved
// image B must still match A on the half the 4 sample subpass drew. A third pass samples both and writes green where they agree
// and red where they do not, and the staging copy of its output is scanned on the host. Monolithic pipelines only, and the render
// pass and renderpass2 variants (the dynamic rendering one is skipped upstream). Upstream writes the three render passes
// through the AttachmentDescription1/2 wrapper templates; here one description is built into either form.
// The shaders are in `shaders/manifest/renderpass_mixed_sample_count.toml`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;

use super::group_params::{GroupParams, RenderingType};
use crate::generated::shaders::renderpass_mixed_sample_count::MIXED_SAMPLE_COUNT;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const RENDER_WIDTH: u32 = 256;
const RENDER_HEIGHT: u32 = 256;
const CLEAR_COLOR: [f32; 4] = [0.02, 0.02, 0.05, 1.0];

/// One attachment of the three render passes: always R8G8B8A8_UNORM, cleared on load, with undefined initial layout.
struct AttDesc {
    samples: vk::SampleCountFlags,
    store_op: vk::AttachmentStoreOp,
    final_layout: vk::ImageLayout,
}

/// A subpass with a single colour attachment and optionally the attachment it resolves into.
struct SubpassDesc {
    color: u32,
    resolve: Option<u32>,
}

struct SubpassDep {
    src_subpass: u32,
    dst_subpass: u32,
    src_stage_mask: vk::PipelineStageFlags,
    dst_stage_mask: vk::PipelineStageFlags,
    src_access_mask: vk::AccessFlags,
    dst_access_mask: vk::AccessFlags,
    dependency_flags: vk::DependencyFlags,
}

/// The `RenderPass1Trait`/`RenderPass2Trait` construction of `createMsaaToggleRenderPassA/B/Compare`.
fn create_render_pass<'a>(
    device: &'a Device,
    rendering_type: RenderingType,
    attachments: &[AttDesc],
    subpasses: &[SubpassDesc],
    dependencies: &[SubpassDep],
) -> Result<Unique<'a, vk::RenderPass>, TestError> {
    if rendering_type == RenderingType::RenderPass2 {
        let descriptions: Vec<vk::AttachmentDescription2> = attachments
            .iter()
            .map(|a| vk::AttachmentDescription2 {
                s_type: vk::StructureType::ATTACHMENT_DESCRIPTION_2,
                next: std::ptr::null(),
                flags: vk::AttachmentDescriptionFlags::empty(),
                format: FORMAT,
                samples: a.samples,
                load_op: vk::AttachmentLoadOp::CLEAR,
                store_op: a.store_op,
                stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
                stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
                initial_layout: vk::ImageLayout::UNDEFINED,
                final_layout: a.final_layout,
            })
            .collect();
        let reference = |attachment: u32| vk::AttachmentReference2 {
            s_type: vk::StructureType::ATTACHMENT_REFERENCE_2,
            next: std::ptr::null(),
            attachment,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            aspect_mask: vk::ImageAspectFlags::empty(),
        };
        let color_references: Vec<vk::AttachmentReference2> = subpasses.iter().map(|s| reference(s.color)).collect();
        let resolve_references: Vec<Option<vk::AttachmentReference2>> =
            subpasses.iter().map(|s| s.resolve.map(reference)).collect();
        let subpass_descriptions: Vec<vk::SubpassDescription2> = subpasses
            .iter()
            .enumerate()
            .map(|(ndx, _)| vk::SubpassDescription2 {
                s_type: vk::StructureType::SUBPASS_DESCRIPTION_2,
                next: std::ptr::null(),
                flags: vk::SubpassDescriptionFlags::empty(),
                pipeline_bind_point: vk::PipelineBindPoint::GRAPHICS,
                view_mask: 0,
                input_attachment_count: 0,
                input_attachments: std::ptr::null(),
                color_attachment_count: 1,
                color_attachments: &color_references[ndx],
                resolve_attachments: resolve_references[ndx]
                    .as_ref()
                    .map_or(std::ptr::null(), |r| r as *const _),
                depth_stencil_attachment: std::ptr::null(),
                preserve_attachment_count: 0,
                preserve_attachments: std::ptr::null(),
            })
            .collect();
        let dependency_descriptions: Vec<vk::SubpassDependency2> = dependencies
            .iter()
            .map(|d| vk::SubpassDependency2 {
                s_type: vk::StructureType::SUBPASS_DEPENDENCY_2,
                next: std::ptr::null(),
                src_subpass: d.src_subpass,
                dst_subpass: d.dst_subpass,
                src_stage_mask: d.src_stage_mask,
                dst_stage_mask: d.dst_stage_mask,
                src_access_mask: d.src_access_mask,
                dst_access_mask: d.dst_access_mask,
                dependency_flags: d.dependency_flags,
                view_offset: 0,
            })
            .collect();
        let info = vk::RenderPassCreateInfo2 {
            s_type: vk::StructureType::RENDER_PASS_CREATE_INFO_2,
            next: std::ptr::null(),
            flags: vk::RenderPassCreateFlags::empty(),
            attachment_count: descriptions.len() as u32,
            attachments: descriptions.as_ptr(),
            subpass_count: subpass_descriptions.len() as u32,
            subpasses: subpass_descriptions.as_ptr(),
            dependency_count: dependency_descriptions.len() as u32,
            dependencies: dependency_descriptions.as_ptr(),
            correlated_view_mask_count: 0,
            correlated_view_masks: std::ptr::null(),
        };
        let handle = unsafe { device.create_render_pass2_khr(&info, None) }.vk_check("vkCreateRenderPass2KHR")?;
        return Ok(Unique::new(device, handle));
    }

    let descriptions: Vec<vk::AttachmentDescription> = attachments
        .iter()
        .map(|a| {
            vk::AttachmentDescription::builder()
                .format(FORMAT)
                .samples(a.samples)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(a.store_op)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .final_layout(a.final_layout)
                .build()
        })
        .collect();
    let reference = |attachment: u32| {
        [vk::AttachmentReference::builder()
            .attachment(attachment)
            .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build()]
    };
    let color_references: Vec<[vk::AttachmentReference; 1]> = subpasses.iter().map(|s| reference(s.color)).collect();
    let resolve_references: Vec<Option<[vk::AttachmentReference; 1]>> =
        subpasses.iter().map(|s| s.resolve.map(reference)).collect();
    let subpass_descriptions: Vec<vk::SubpassDescription> = (0..subpasses.len())
        .map(|ndx| {
            let mut subpass = vk::SubpassDescription::builder()
                .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                .color_attachments(&color_references[ndx]);
            if let Some(resolve) = &resolve_references[ndx] {
                subpass = subpass.resolve_attachments(resolve);
            }
            subpass.build()
        })
        .collect();
    let dependency_descriptions: Vec<vk::SubpassDependency> = dependencies
        .iter()
        .map(|d| {
            vk::SubpassDependency::builder()
                .src_subpass(d.src_subpass)
                .dst_subpass(d.dst_subpass)
                .src_stage_mask(d.src_stage_mask)
                .dst_stage_mask(d.dst_stage_mask)
                .src_access_mask(d.src_access_mask)
                .dst_access_mask(d.dst_access_mask)
                .dependency_flags(d.dependency_flags)
                .build()
        })
        .collect();
    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&descriptions)
        .subpasses(&subpass_descriptions)
        .dependencies(&dependency_descriptions);
    let handle = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, handle))
}

fn color_msaa_attachment() -> AttDesc {
    AttDesc {
        samples: vk::SampleCountFlags::_4,
        store_op: vk::AttachmentStoreOp::DONT_CARE,
        final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    }
}

fn resolve_attachment() -> AttDesc {
    AttDesc {
        samples: vk::SampleCountFlags::_1,
        store_op: vk::AttachmentStoreOp::STORE,
        final_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
    }
}

/// `createMsaaToggleRenderPassA`
fn create_render_pass_reference(
    device: &Device,
    rendering_type: RenderingType,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    create_render_pass(
        device,
        rendering_type,
        &[color_msaa_attachment(), resolve_attachment()],
        &[SubpassDesc {
            color: 0,
            resolve: Some(1),
        }],
        &[
            SubpassDep {
                src_subpass: vk::SUBPASS_EXTERNAL,
                dst_subpass: 0,
                src_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                dst_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                src_access_mask: vk::AccessFlags::empty(),
                dst_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                dependency_flags: vk::DependencyFlags::empty(),
            },
            SubpassDep {
                src_subpass: 0,
                dst_subpass: vk::SUBPASS_EXTERNAL,
                src_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                dst_stage_mask: vk::PipelineStageFlags::FRAGMENT_SHADER,
                src_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                dst_access_mask: vk::AccessFlags::SHADER_READ,
                dependency_flags: vk::DependencyFlags::empty(),
            },
        ],
    )
}

/// `createMsaaToggleRenderPassB` - the second subpass draws with one sample into the attachment the first one resolved into.
fn create_render_pass_test(
    device: &Device,
    rendering_type: RenderingType,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    create_render_pass(
        device,
        rendering_type,
        &[color_msaa_attachment(), resolve_attachment()],
        &[
            SubpassDesc {
                color: 0,
                resolve: Some(1),
            },
            SubpassDesc {
                color: 1,
                resolve: None,
            },
        ],
        &[
            SubpassDep {
                src_subpass: vk::SUBPASS_EXTERNAL,
                dst_subpass: 0,
                src_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                dst_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                src_access_mask: vk::AccessFlags::empty(),
                dst_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                dependency_flags: vk::DependencyFlags::BY_REGION,
            },
            SubpassDep {
                src_subpass: 0,
                dst_subpass: 1,
                src_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                dst_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                src_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                dst_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE | vk::AccessFlags::COLOR_ATTACHMENT_READ,
                dependency_flags: vk::DependencyFlags::BY_REGION,
            },
            SubpassDep {
                src_subpass: 1,
                dst_subpass: vk::SUBPASS_EXTERNAL,
                src_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                dst_stage_mask: vk::PipelineStageFlags::FRAGMENT_SHADER,
                src_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                dst_access_mask: vk::AccessFlags::SHADER_READ,
                dependency_flags: vk::DependencyFlags::BY_REGION,
            },
        ],
    )
}

/// `createMsaaToggleRenderPassCompare`
fn create_render_pass_compare(
    device: &Device,
    rendering_type: RenderingType,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    create_render_pass(
        device,
        rendering_type,
        &[AttDesc {
            samples: vk::SampleCountFlags::_1,
            store_op: vk::AttachmentStoreOp::STORE,
            final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        }],
        &[SubpassDesc {
            color: 0,
            resolve: None,
        }],
        &[
            SubpassDep {
                src_subpass: vk::SUBPASS_EXTERNAL,
                dst_subpass: 0,
                src_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                dst_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                src_access_mask: vk::AccessFlags::empty(),
                dst_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                dependency_flags: vk::DependencyFlags::empty(),
            },
            SubpassDep {
                src_subpass: 0,
                dst_subpass: vk::SUBPASS_EXTERNAL,
                src_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                dst_stage_mask: vk::PipelineStageFlags::BOTTOM_OF_PIPE,
                src_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                dst_access_mask: vk::AccessFlags::empty(),
                dependency_flags: vk::DependencyFlags::empty(),
            },
        ],
    )
}

/// A pipeline of the test: no vertex input, triangle list, default rasterization and colour blend state, one scissor.
#[allow(clippy::too_many_arguments)]
fn create_pipeline<'a>(
    device: &'a Device,
    layout: vk::PipelineLayout,
    render_pass: vk::RenderPass,
    subpass: u32,
    vertex_module: vk::ShaderModule,
    fragment_module: vk::ShaderModule,
    samples: vk::SampleCountFlags,
    scissor: vk::Rect2D,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let entry = c"main";
    let stages = [
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::VERTEX)
            .module(vertex_module)
            .name(entry.to_bytes_with_nul())
            .build(),
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::FRAGMENT)
            .module(fragment_module)
            .name(entry.to_bytes_with_nul())
            .build(),
    ];
    let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder();
    let input_assembly_state =
        vk::PipelineInputAssemblyStateCreateInfo::builder().topology(vk::PrimitiveTopology::TRIANGLE_LIST);
    let viewports = [vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: RENDER_WIDTH as f32,
        height: RENDER_HEIGHT as f32,
        min_depth: 0.0,
        max_depth: 1.0,
    }];
    let scissors = [scissor];
    let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
        .viewports(&viewports)
        .scissors(&scissors);
    let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .line_width(1.0);
    let multisample_state = vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(samples);
    let blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
        .color_write_mask(vk::ColorComponentFlags::all())
        .build()];
    let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&blend_attachments);

    let info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&stages)
        .vertex_input_state(&vertex_input_state)
        .input_assembly_state(&input_assembly_state)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization_state)
        .multisample_state(&multisample_state)
        .color_blend_state(&color_blend_state)
        .layout(layout)
        .render_pass(render_pass)
        .subpass(subpass);
    let pipeline = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateGraphicsPipelines")?
        .0[0];
    Ok(Unique::new(device, pipeline))
}

/// `MsaaMixedSampleCountTest`
struct MsaaMixedSampleCountTest {
    name: &'static str,
    group_params: GroupParams,
}

impl TestCase for MsaaMixedSampleCountTest {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        match self.group_params.rendering_type {
            RenderingType::DynamicRendering => {
                return Err(TestError::NotSupported(
                    "Dynamic rendering is not supported in this test".to_string(),
                ));
            }
            RenderingType::RenderPass2 => context.require_device_functionality("VK_KHR_create_renderpass2")?,
            RenderingType::Legacy => {}
        }

        // Check format properties to verify 4x MSAA is supported for optimal tiling color attachments
        let properties = unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                FORMAT,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSIENT_ATTACHMENT,
                vk::ImageCreateFlags::empty(),
            )
        };
        match properties {
            Ok(properties) if properties.sample_counts.contains(vk::SampleCountFlags::_4) => Ok(()),
            _ => Err(TestError::NotSupported(
                "Format R8G8B8A8_UNORM does not support 4x MSAA optimal tiling transient color attachments".to_string(),
            )),
        }
    }

    fn programs(&self) -> BinaryCollection {
        MIXED_SAMPLE_COUNT.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MsaaMixedSampleCountTestInstance {
            context,
            group_params: self.group_params,
        })
    }
}

/// `MsaaMixedSampleCountTestInstance`
struct MsaaMixedSampleCountTestInstance<'a> {
    context: &'a Context<'a>,
    group_params: GroupParams,
}

fn begin_render_pass(
    device: &Device,
    rendering_type: RenderingType,
    cmd: vk::CommandBuffer,
    render_pass: vk::RenderPass,
    framebuffer: vk::Framebuffer,
    clear_values: &[vk::ClearValue],
) {
    let begin_info = vk::RenderPassBeginInfo::builder()
        .render_pass(render_pass)
        .framebuffer(framebuffer)
        .render_area(vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: RENDER_WIDTH,
                height: RENDER_HEIGHT,
            },
        })
        .clear_values(clear_values);
    unsafe {
        if rendering_type == RenderingType::RenderPass2 {
            let subpass_begin_info = vk::SubpassBeginInfo::builder().contents(vk::SubpassContents::INLINE);
            device.cmd_begin_render_pass2_khr(cmd, &begin_info, &subpass_begin_info);
        } else {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
        }
    }
}

fn next_subpass(device: &Device, rendering_type: RenderingType, cmd: vk::CommandBuffer) {
    unsafe {
        if rendering_type == RenderingType::RenderPass2 {
            let subpass_begin_info = vk::SubpassBeginInfo::builder().contents(vk::SubpassContents::INLINE);
            let subpass_end_info = vk::SubpassEndInfo::builder();
            device.cmd_next_subpass2_khr(cmd, &subpass_begin_info, &subpass_end_info);
        } else {
            device.cmd_next_subpass(cmd, vk::SubpassContents::INLINE);
        }
    }
}

fn end_render_pass(device: &Device, rendering_type: RenderingType, cmd: vk::CommandBuffer) {
    unsafe {
        if rendering_type == RenderingType::RenderPass2 {
            device.cmd_end_render_pass2_khr(cmd, &vk::SubpassEndInfo::builder());
        } else {
            device.cmd_end_render_pass(cmd);
        }
    }
}

impl TestInstance for MsaaMixedSampleCountTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let rendering_type = self.group_params.rendering_type;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let queue_family_index = context.get_universal_queue_family_index();
        let queue = context.get_universal_queue();

        let image_extent = vk::Extent3D {
            width: RENDER_WIDTH,
            height: RENDER_HEIGHT,
            depth: 1,
        };

        // 1. Create images and memory
        let create_image = |samples: vk::SampleCountFlags, usage: vk::ImageUsageFlags| {
            let info = vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(FORMAT)
                .extent(image_extent)
                .mip_levels(1)
                .array_layers(1)
                .samples(samples)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(usage)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build();
            ImageWithMemory::new(device, alloc, info, MemoryRequirement::ANY)
        };
        let verify_msaa_image = create_image(
            vk::SampleCountFlags::_4,
            vk::ImageUsageFlags::TRANSIENT_ATTACHMENT | vk::ImageUsageFlags::COLOR_ATTACHMENT,
        )?;
        let verify_image_ref = create_image(
            vk::SampleCountFlags::_1,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::SAMPLED,
        )?;
        let verify_image_test = create_image(
            vk::SampleCountFlags::_1,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::SAMPLED,
        )?;
        let verify_image_compare = create_image(
            vk::SampleCountFlags::_1,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        )?;

        // 2. Create image views
        let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let view =
            |image: &ImageWithMemory<'_>| make_image_view(device, image.get(), vk::ImageViewType::_2D, FORMAT, range);
        let verify_msaa_image_view = view(&verify_msaa_image)?;
        let verify_image_view_ref = view(&verify_image_ref)?;
        let verify_image_view_test = view(&verify_image_test)?;
        let verify_image_view_compare = view(&verify_image_compare)?;

        // 3. Create the staging buffer
        let verify_buffer_compare = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(
                (RENDER_WIDTH * RENDER_HEIGHT * 4) as vk::DeviceSize,
                vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // 4. Create the render passes and their framebuffers
        let render_pass_reference = create_render_pass_reference(device, rendering_type)?;
        let framebuffer_reference = make_framebuffer(
            device,
            *render_pass_reference,
            &[*verify_msaa_image_view, *verify_image_view_ref],
            RENDER_WIDTH,
            RENDER_HEIGHT,
            1,
        )?;
        let render_pass_test = create_render_pass_test(device, rendering_type)?;
        let framebuffer_test = make_framebuffer(
            device,
            *render_pass_test,
            &[*verify_msaa_image_view, *verify_image_view_test],
            RENDER_WIDTH,
            RENDER_HEIGHT,
            1,
        )?;
        let render_pass_compare = create_render_pass_compare(device, rendering_type)?;
        let framebuffer_compare = make_framebuffer(
            device,
            *render_pass_compare,
            &[*verify_image_view_compare],
            RENDER_WIDTH,
            RENDER_HEIGHT,
            1,
        )?;

        // 6. Create the sampler
        let sampler_info = vk::SamplerCreateInfo::builder()
            .mag_filter(vk::Filter::NEAREST)
            .min_filter(vk::Filter::NEAREST)
            .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
            .address_mode_u(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .address_mode_v(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .address_mode_w(vk::SamplerAddressMode::CLAMP_TO_EDGE)
            .mip_lod_bias(0.0)
            .anisotropy_enable(false)
            .max_anisotropy(1.0)
            .compare_enable(false)
            .compare_op(vk::CompareOp::ALWAYS)
            .min_lod(0.0)
            .max_lod(0.0)
            .border_color(vk::BorderColor::FLOAT_OPAQUE_BLACK)
            .unnormalized_coordinates(false);
        let sampler = Unique::new(
            device,
            unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
        );

        // 7. Create the descriptors
        let bindings = [
            vk::DescriptorSetLayoutBinding::builder()
                .binding(0)
                .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
                .descriptor_count(1)
                .stage_flags(vk::ShaderStageFlags::FRAGMENT)
                .build(),
            vk::DescriptorSetLayoutBinding::builder()
                .binding(1)
                .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
                .descriptor_count(1)
                .stage_flags(vk::ShaderStageFlags::FRAGMENT)
                .build(),
        ];
        let layout_info = vk::DescriptorSetLayoutCreateInfo::builder().bindings(&bindings);
        let descriptor_set_layout_compare = Unique::new(
            device,
            unsafe { device.create_descriptor_set_layout(&layout_info, None) }
                .vk_check("vkCreateDescriptorSetLayout")?,
        );

        let pool_sizes = [vk::DescriptorPoolSize {
            type_: vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
            descriptor_count: 2,
        }];
        let pool_info = vk::DescriptorPoolCreateInfo::builder()
            .flags(vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET)
            .max_sets(1)
            .pool_sizes(&pool_sizes);
        let descriptor_pool = Unique::new(
            device,
            unsafe { device.create_descriptor_pool(&pool_info, None) }.vk_check("vkCreateDescriptorPool")?,
        );

        let set_layouts = [*descriptor_set_layout_compare];
        let allocate_info = vk::DescriptorSetAllocateInfo::builder()
            .descriptor_pool(*descriptor_pool)
            .set_layouts(&set_layouts);
        let descriptor_set_compare =
            unsafe { device.allocate_descriptor_sets(&allocate_info) }.vk_check("vkAllocateDescriptorSets")?[0];

        let rtv_test_info = [vk::DescriptorImageInfo {
            sampler: *sampler,
            image_view: *verify_image_view_test,
            image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        }];
        let rtv_ref_info = [vk::DescriptorImageInfo {
            sampler: *sampler,
            image_view: *verify_image_view_ref,
            image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        }];
        let writes = [
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set_compare)
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
                .image_info(&rtv_test_info)
                .build(),
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set_compare)
                .dst_binding(1)
                .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
                .image_info(&rtv_ref_info)
                .build(),
        ];
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        // 8. Create the shaders
        let binaries = context.get_binary_collection();
        let draw_vert_module = create_shader_module(device, binaries.get("draw-vert")?)?;
        let draw_frag_module = create_shader_module(device, binaries.get("draw-frag")?)?;
        let compare_vert_module = create_shader_module(device, binaries.get("compare-vert")?)?;
        let compare_frag_module = create_shader_module(device, binaries.get("compare-frag")?)?;

        // 9. Create the pipeline layouts
        let pipeline_layout_draw = make_pipeline_layout(device, &[])?;
        let pipeline_layout_compare = make_pipeline_layout(device, &[*descriptor_set_layout_compare])?;

        // 10. Create the pipelines
        let half_width = RENDER_WIDTH / 2;
        let rect = |x: u32, width: u32| vk::Rect2D {
            offset: vk::Offset2D { x: x as i32, y: 0 },
            extent: vk::Extent2D {
                width,
                height: RENDER_HEIGHT,
            },
        };

        // MSAA pipeline for the reference (subpass 0, 4 samples), scissor clipped to the left half
        let pipeline_msaa_ref = create_pipeline(
            device,
            *pipeline_layout_draw,
            *render_pass_reference,
            0,
            *draw_vert_module,
            *draw_frag_module,
            vk::SampleCountFlags::_4,
            rect(0, half_width),
        )?;
        // MSAA pipeline for the test (subpass 0, 4 samples), scissor clipped to the left half
        let pipeline_msaa_test_sub0 = create_pipeline(
            device,
            *pipeline_layout_draw,
            *render_pass_test,
            0,
            *draw_vert_module,
            *draw_frag_module,
            vk::SampleCountFlags::_4,
            rect(0, half_width),
        )?;
        // 1x pipeline for the test (subpass 1, 1 sample), scissor clipped to the right half
        let pipeline_no_msaa_test_sub1 = create_pipeline(
            device,
            *pipeline_layout_draw,
            *render_pass_test,
            1,
            *draw_vert_module,
            *draw_frag_module,
            vk::SampleCountFlags::_1,
            rect(half_width, half_width),
        )?;
        // Compare pipeline (1 sample), scissor set to the full width
        let pipeline_compare = create_pipeline(
            device,
            *pipeline_layout_compare,
            *render_pass_compare,
            0,
            *compare_vert_module,
            *compare_frag_module,
            vk::SampleCountFlags::_1,
            rect(0, RENDER_WIDTH),
        )?;

        let clear_value = vk::ClearValue {
            color: vk::ClearColorValue { float32: CLEAR_COLOR },
        };

        // 11. Record and submit the first command buffer (the reference) and wait
        let cmd_pool_reference = make_command_pool(device, queue_family_index)?;
        let cmd_reference = allocate_command_buffer(device, *cmd_pool_reference, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, *cmd_reference)?;
        begin_render_pass(
            device,
            rendering_type,
            *cmd_reference,
            *render_pass_reference,
            *framebuffer_reference,
            &[clear_value, clear_value],
        );
        unsafe {
            device.cmd_bind_pipeline(*cmd_reference, vk::PipelineBindPoint::GRAPHICS, *pipeline_msaa_ref);
            device.cmd_draw(*cmd_reference, 3, 1, 0, 0); // Draw left triangle
        }
        end_render_pass(device, rendering_type, *cmd_reference);
        end_command_buffer(device, *cmd_reference)?;
        submit_commands_and_wait(device, queue, *cmd_reference)?;

        // 12. Record and submit the second command buffer (the test and the comparison) and wait
        let cmd_pool_test_compare = make_command_pool(device, queue_family_index)?;
        let cmd_test_compare =
            allocate_command_buffer(device, *cmd_pool_test_compare, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_test_compare;
        begin_command_buffer(device, cmd)?;
        begin_render_pass(
            device,
            rendering_type,
            cmd,
            *render_pass_test,
            *framebuffer_test,
            &[clear_value, clear_value],
        );

        // Subpass 0 (4x MSAA left side)
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline_msaa_test_sub0);
            device.cmd_draw(cmd, 3, 1, 0, 0);
        }

        // Subpass 1 (1x MSAA right side)
        next_subpass(device, rendering_type, cmd);
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline_no_msaa_test_sub1);
            device.cmd_draw(cmd, 3, 1, 3, 0);
        }
        end_render_pass(device, rendering_type, cmd);

        // The comparison pass
        begin_render_pass(
            device,
            rendering_type,
            cmd,
            *render_pass_compare,
            *framebuffer_compare,
            &[clear_value],
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline_compare);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout_compare,
                0,
                &[descriptor_set_compare],
                &[],
            );
            device.cmd_draw(cmd, 3, 1, 0, 0);
        }
        end_render_pass(device, rendering_type, cmd);

        // Copy the comparison image to the staging buffer
        copy_image_to_buffer(
            device,
            cmd,
            verify_image_compare.get(),
            verify_buffer_compare.get(),
            RENDER_WIDTH,
            RENDER_HEIGHT,
        );

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        // 13. Programmatic verification scan on the CPU
        let allocation = verify_buffer_compare.get_allocation();
        invalidate_alloc(device, allocation)?;
        let mapped_data = unsafe {
            std::slice::from_raw_parts(allocation.get_host_ptr(), (RENDER_WIDTH * RENDER_HEIGHT * 4) as usize)
        };
        let mut found_any = false;

        // Robust threshold ranges (>150 and <100) instead of exact colour equality accommodate permitted hardware rounding
        // tolerances, float-to-integer quantization differences, or driver-level dithering across different GPU architectures.
        let is_green_enough = |p: &[u8]| p[1] > 150 && p[0] < 100 && p[2] < 100;
        let is_red_enough = |p: &[u8]| p[0] > 150 && p[1] < 100 && p[2] < 100;

        for y in 0..RENDER_HEIGHT {
            for x in 0..RENDER_WIDTH {
                let offset = ((y * RENDER_WIDTH + x) * 4) as usize;
                let pixel = &mapped_data[offset..offset + 4];

                if is_red_enough(pixel) {
                    return Ok(TestStatus::fail(format!(
                        "Resolved tile mismatch detected at pixel ({x}, {y})! RTV B color does not match RTV A reference."
                    )));
                } else if is_green_enough(pixel) {
                    found_any = true;
                }
            }
        }

        if !found_any {
            return Ok(TestStatus::fail(
                "Staging buffer contains only background clear color (Triangles failed to render).",
            ));
        }

        Ok(TestStatus::pass("Pass (Dynamic MSAA resolve is compliant)."))
    }
}

/// The `mixed_sample_count` group `createRenderPassMultisampleResolveTests` adds beside the others for a render pass or renderpass2.
pub fn create_mixed_sample_count_tests(group_params: GroupParams) -> TestCaseGroup {
    let mut mixed_sample_group = TestCaseGroup::new("mixed_sample_count");
    mixed_sample_group.add_child(Box::new(MsaaMixedSampleCountTest {
        name: "mixed_sample_count_subpasses",
        group_params,
    }) as Box<dyn TestCase>);
    mixed_sample_group
}
