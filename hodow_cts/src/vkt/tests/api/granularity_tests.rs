// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiGranularityTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `dEQP-VK.api.granularity.*`: the render area granularity a render pass (or a dynamic rendering description)
// reports must be at least 1x1, must not change once the pass has begun, and must fit in the framebuffer limits.
// The shared pointers upstream keeps "to prevent object free" are plain locals of `iterate` here.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_3, KhrMaintenance5ExtensionDeviceCommands};

use super::object_tests::format_name;
use crate::tcu::pixel::{has_depth_component, has_stencil_component};
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome, TestStatus, map_vk_format};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, make_rect_2d};
use crate::vk::image_util::{make_image_memory_barrier, make_image_subresource_range};
use crate::vk::mem_util::MemoryRequirement;
use crate::vk::obj_util::{allocate_command_buffer, make_framebuffer};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NO_PROGRAMS: BinaryCollection = BinaryCollection::new(&[]);

/// `TestMode`
#[derive(Clone, Copy, PartialEq, Eq)]
enum TestMode {
    NoRenderPass,
    UseRenderPass,
    UseDynamicRenderPass,
}

/// `AttachmentInfo`
#[derive(Clone, Copy)]
struct AttachmentInfo {
    format: vk::Format,
    extent: vk::Extent3D,
}

impl AttachmentInfo {
    fn new(format: vk::Format, width: u32, height: u32, depth: u32) -> Self {
        Self {
            format,
            extent: vk::Extent3D { width, height, depth },
        }
    }
}

/// One attachment image with the memory and view that keep it alive; fields drop view first, memory last.
struct AttachmentImage<'a> {
    view: Unique<'a, vk::ImageView>,
    image: Unique<'a, vk::Image>,
    _alloc: crate::vk::mem_util::Allocation<'a>,
}

/// `tcu::hasDepthComponent(mapVkFormat(format).order)` and the stencil twin.
fn depth_stencil_of(format: vk::Format) -> (bool, bool) {
    match map_vk_format(format) {
        Some(tcu_format) => (
            has_depth_component(tcu_format.order),
            has_stencil_component(tcu_format.order),
        ),
        None => (false, false),
    }
}

/// `GranularityInstance::initAttachmentDescriptions`
fn init_attachment_descriptions(attachments: &[AttachmentInfo]) -> Vec<vk::AttachmentDescription> {
    attachments
        .iter()
        .map(|it| {
            vk::AttachmentDescription::builder()
                .format(it.format)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::DONT_CARE)
                .store_op(vk::AttachmentStoreOp::DONT_CARE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .final_layout(vk::ImageLayout::GENERAL)
                .build()
        })
        .collect()
}

/// `GranularityInstance::initImages`
fn init_images<'a>(
    context: &'a Context<'a>,
    attachments: &[AttachmentInfo],
) -> Result<Vec<AttachmentImage<'a>>, TestError> {
    let vk = context.get_device();
    let queue_family_index = context.get_universal_queue_family_index();
    let queue_family_indices = [queue_family_index];
    let mut result = Vec::new();

    for it in attachments {
        let mut aspect_flags = vk::ImageAspectFlags::empty();
        let mut usage = vk::ImageUsageFlags::empty();
        let (has_depth, has_stencil) = depth_stencil_of(it.format);

        if has_depth {
            aspect_flags |= vk::ImageAspectFlags::DEPTH;
            usage = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT;
        }

        if has_stencil {
            aspect_flags |= vk::ImageAspectFlags::STENCIL;
            usage = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT;
        }

        if aspect_flags.is_empty() {
            aspect_flags = vk::ImageAspectFlags::COLOR;
            usage = vk::ImageUsageFlags::COLOR_ATTACHMENT;
        }

        let image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(it.format)
            .extent(it.extent)
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(usage)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .queue_family_indices(&queue_family_indices)
            .initial_layout(vk::ImageLayout::UNDEFINED);

        let image = Unique::new(
            vk,
            unsafe { vk.create_image(&image_info, None) }.vk_check("vkCreateImage")?,
        );
        let mem_reqs = unsafe { vk.get_image_memory_requirements(*image) };
        let image_alloc = context
            .get_default_allocator()
            .allocate(vk, mem_reqs, MemoryRequirement::ANY)?;
        unsafe { vk.bind_image_memory(*image, image_alloc.get_memory(), image_alloc.get_offset()) }
            .vk_check("vkBindImageMemory")?;

        let view_info = vk::ImageViewCreateInfo::builder()
            .image(*image)
            .view_type(vk::ImageViewType::_2D)
            .format(it.format)
            .components(vk::ComponentMapping {
                r: vk::ComponentSwizzle::R,
                g: vk::ComponentSwizzle::G,
                b: vk::ComponentSwizzle::B,
                a: vk::ComponentSwizzle::A,
            })
            .subresource_range(make_image_subresource_range(aspect_flags, 0, 1, 0, 1));
        let view = Unique::new(
            vk,
            unsafe { vk.create_image_view(&view_info, None) }.vk_check("vkCreateImageView")?,
        );

        result.push(AttachmentImage {
            view,
            image,
            _alloc: image_alloc,
        });
    }

    Ok(result)
}

/// `GranularityInstance`
struct GranularityInstance<'a> {
    context: &'a Context<'a>,
    attachments: Vec<AttachmentInfo>,
    test_mode: TestMode,
}

impl TestInstance for GranularityInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let vk = self.context.get_device();
        let device_properties = self.context.get_device_properties();
        let render_area = make_rect_2d(0, 0, 1, 1);

        let mut pre_pass_granularity = vk::Extent2D {
            width: !0u32,
            height: !0u32,
        };
        let mut granularity = vk::Extent2D { width: 0, height: 0 };

        // initObjects
        let images = init_images(self.context, &self.attachments)?;

        let mut render_pass = None;
        let mut frame_buffer = None;
        if self.test_mode != TestMode::UseDynamicRenderPass {
            let attachment_descriptions = init_attachment_descriptions(&self.attachments);
            let subpass_desc = vk::SubpassDescription::builder().pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS);
            let subpasses = [subpass_desc];
            let render_pass_params = vk::RenderPassCreateInfo::builder()
                .attachments(&attachment_descriptions)
                .subpasses(&subpasses);
            let rp = Unique::new(
                vk,
                unsafe { vk.create_render_pass(&render_pass_params, None) }.vk_check("vkCreateRenderPass")?,
            );

            let image_views: Vec<vk::ImageView> = images.iter().map(|i| *i.view).collect();
            frame_buffer = Some(make_framebuffer(vk, *rp, &image_views, 1, 1, 1)?);
            render_pass = Some(rp);
        }

        let cmd_pool_info = vk::CommandPoolCreateInfo::builder()
            .flags(vk::CommandPoolCreateFlags::TRANSIENT)
            .queue_family_index(self.context.get_universal_queue_family_index());
        let cmd_pool = Unique::new(
            vk,
            unsafe { vk.create_command_pool(&cmd_pool_info, None) }.vk_check("vkCreateCommandPool")?,
        );
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(vk, cmd)?;

        if self.test_mode == TestMode::UseDynamicRenderPass {
            let mut color_attachment_formats: Vec<vk::Format> = Vec::new();
            let mut depth_attachment_format = vk::Format::UNDEFINED;
            let mut stencil_attachment_format = vk::Format::UNDEFINED;

            let default_attachment = vk::RenderingAttachmentInfo::builder()
                .image_layout(vk::ImageLayout::GENERAL)
                .load_op(vk::AttachmentLoadOp::DONT_CARE)
                .store_op(vk::AttachmentStoreOp::DONT_CARE)
                .build();

            let mut color_attachment_info: Vec<vk::RenderingAttachmentInfo> = Vec::new();
            let mut depth_attachment_info = default_attachment;
            let mut stencil_attachment_info = default_attachment;

            for (i, attachment) in self.attachments.iter().enumerate() {
                let format = attachment.format;
                let (has_depth, has_stencil) = depth_stencil_of(format);
                let mut is_color_format = true;
                let mut aspect_mask = vk::ImageAspectFlags::empty();

                if has_depth {
                    aspect_mask = vk::ImageAspectFlags::DEPTH;
                    depth_attachment_format = format;
                    depth_attachment_info.image_view = *images[i].view;
                    is_color_format = false;
                }
                if has_stencil {
                    aspect_mask |= vk::ImageAspectFlags::STENCIL;
                    stencil_attachment_format = format;
                    stencil_attachment_info.image_view = *images[i].view;
                    is_color_format = false;
                }
                if is_color_format {
                    aspect_mask = vk::ImageAspectFlags::COLOR;
                    color_attachment_formats.push(format);
                    let mut info = default_attachment;
                    info.image_view = *images[i].view;
                    color_attachment_info.push(info);
                }

                let layout_barrier = make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::SHADER_READ,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::GENERAL,
                    *images[i].image,
                    make_image_subresource_range(aspect_mask, 0, 1, 0, 1),
                );
                unsafe {
                    vk.cmd_pipeline_barrier(
                        cmd,
                        vk::PipelineStageFlags::HOST,
                        vk::PipelineStageFlags::FRAGMENT_SHADER,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[layout_barrier],
                    )
                };
            }

            let rendering_area_info = vk::RenderingAreaInfo::builder()
                .view_mask(0)
                .color_attachment_formats(&color_attachment_formats)
                .depth_attachment_format(depth_attachment_format)
                .stencil_attachment_format(stencil_attachment_format);

            pre_pass_granularity = unsafe { vk.get_rendering_area_granularity_khr(&rendering_area_info) };

            // start dynamic render pass
            let mut rendering_info = vk::RenderingInfo::builder()
                .render_area(render_area)
                .layer_count(1)
                .view_mask(0)
                .color_attachments(&color_attachment_info);
            if depth_attachment_format != vk::Format::UNDEFINED {
                rendering_info = rendering_info.depth_attachment(&depth_attachment_info);
            }
            if stencil_attachment_format != vk::Format::UNDEFINED {
                rendering_info = rendering_info.stencil_attachment(&stencil_attachment_info);
            }
            unsafe { vk.cmd_begin_rendering(cmd, &rendering_info) };

            granularity = unsafe { vk.get_rendering_area_granularity_khr(&rendering_area_info) };
        }

        if self.test_mode != TestMode::UseDynamicRenderPass {
            let rp = **render_pass
                .as_ref()
                .expect("render pass is created for every mode but the dynamic one");
            pre_pass_granularity = unsafe { vk.get_render_area_granularity(rp) };

            if self.test_mode == TestMode::UseRenderPass {
                let fb = **frame_buffer
                    .as_ref()
                    .expect("framebuffer is created with the render pass");
                let begin_info = vk::RenderPassBeginInfo::builder()
                    .render_pass(rp)
                    .framebuffer(fb)
                    .render_area(render_area);
                unsafe { vk.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE) };
            }

            granularity = unsafe { vk.get_render_area_granularity(rp) };
        }

        if !(granularity.width >= 1 && granularity.height >= 1) {
            return Err(TestError::Fail(
                "granularity.width >= 1 && granularity.height >= 1".to_string(),
            ));
        }
        if !(pre_pass_granularity.width == granularity.width && pre_pass_granularity.height == granularity.height) {
            return Err(TestError::Fail(
                "prePassGranularity differs from granularity".to_string(),
            ));
        }
        if !(granularity.width <= device_properties.limits.max_framebuffer_width
            && granularity.height <= device_properties.limits.max_framebuffer_height)
        {
            return Err(TestError::Fail(
                "granularity exceeds maxFramebufferWidth/Height".to_string(),
            ));
        }

        if self.test_mode == TestMode::UseRenderPass {
            unsafe { vk.cmd_end_render_pass(cmd) };
        }

        if self.test_mode == TestMode::UseDynamicRenderPass {
            unsafe { vk.cmd_end_rendering(cmd) };
        }

        end_command_buffer(vk, cmd)?;

        log::info!(
            "Horizontal granularity: {} Vertical granularity: {}",
            granularity.width,
            granularity.height
        );
        Ok(TestStatus::pass("Granularity test"))
    }
}

/// `GranularityCase`
struct GranularityCase {
    name: String,
    attachments: Vec<AttachmentInfo>,
    test_mode: TestMode,
}

impl TestCase for GranularityCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let required_features =
            vk::FormatFeatureFlags::COLOR_ATTACHMENT | vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT;

        for attachment_info in &self.attachments {
            let format_properties = unsafe {
                context
                    .get_instance()
                    .get_physical_device_format_properties(context.get_physical_device(), attachment_info.format)
            };
            if (format_properties.optimal_tiling_features & required_features).is_empty() {
                return Err(TestError::NotSupported("Format not supported".to_string()));
            }
        }

        if self.test_mode == TestMode::UseDynamicRenderPass {
            context.require_device_functionality("VK_KHR_maintenance5")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        NO_PROGRAMS
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(GranularityInstance {
            context,
            attachments: self.attachments.clone(),
            test_mode: self.test_mode,
        })
    }
}

fn case(name: &str, attachments: Vec<AttachmentInfo>, test_mode: TestMode) -> Box<dyn TestCase> {
    Box::new(GranularityCase {
        name: name.to_string(),
        attachments,
        test_mode,
    })
}

/// `createGranularityQueryTests`
pub fn create_granularity_query_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("granularity");
    let mut single = TestCaseGroup::new("single");
    let mut multi = TestCaseGroup::new("multi");
    let mut random = TestCaseGroup::new("random");
    let mut in_render_pass = TestCaseGroup::new("in_render_pass");
    let mut in_dynamic_render_pass = TestCaseGroup::new("in_dynamic_render_pass");

    let mut rnd = Random::new(215);

    let mandatory_formats = [
        vk::Format::B4G4R4A4_UNORM_PACK16,
        vk::Format::R5G6B5_UNORM_PACK16,
        vk::Format::A1R5G5B5_UNORM_PACK16,
        vk::Format::R8_UNORM,
        vk::Format::R8_SNORM,
        vk::Format::R8_UINT,
        vk::Format::R8_SINT,
        vk::Format::R8G8_UNORM,
        vk::Format::R8G8_SNORM,
        vk::Format::R8G8_UINT,
        vk::Format::R8G8_SINT,
        vk::Format::R8G8B8A8_UNORM,
        vk::Format::R8G8B8A8_SNORM,
        vk::Format::R8G8B8A8_UINT,
        vk::Format::R8G8B8A8_SINT,
        vk::Format::R8G8B8A8_SRGB,
        vk::Format::B8G8R8A8_UNORM,
        vk::Format::B8G8R8A8_SRGB,
        vk::Format::A8B8G8R8_UNORM_PACK32,
        vk::Format::A8B8G8R8_SNORM_PACK32,
        vk::Format::A8B8G8R8_UINT_PACK32,
        vk::Format::A8B8G8R8_SINT_PACK32,
        vk::Format::A8B8G8R8_SRGB_PACK32,
        vk::Format::A2B10G10R10_UNORM_PACK32,
        vk::Format::A2B10G10R10_UINT_PACK32,
        vk::Format::R16_UINT,
        vk::Format::R16_SINT,
        vk::Format::R16_SFLOAT,
        vk::Format::R16G16_UINT,
        vk::Format::R16G16_SINT,
        vk::Format::R16G16_SFLOAT,
        vk::Format::R16G16B16A16_UINT,
        vk::Format::R16G16B16A16_SINT,
        vk::Format::R16G16B16A16_SFLOAT,
        vk::Format::R32_UINT,
        vk::Format::R32_SINT,
        vk::Format::R32_SFLOAT,
        vk::Format::R32G32_UINT,
        vk::Format::R32G32_SINT,
        vk::Format::R32G32_SFLOAT,
        vk::Format::R32G32B32A32_UINT,
        vk::Format::R32G32B32A32_SINT,
        vk::Format::R32G32B32A32_SFLOAT,
        vk::Format::B10G11R11_UFLOAT_PACK32,
        vk::Format::E5B9G9R9_UFLOAT_PACK32,
        vk::Format::D16_UNORM,
        vk::Format::D32_SFLOAT,
    ];

    let max_dimension = 500;
    let min_iteration = 2;
    let max_iteration = 10;

    for format_idx in 1..=vk::Format::D32_SFLOAT_S8_UINT.as_raw() {
        let format = vk::Format::from_raw(format_idx);
        let name = format_name(format);

        {
            let i0 = rnd.get_int(1, max_dimension) as u32;
            let i1 = rnd.get_int(1, max_dimension) as u32;
            single.add_child(case(
                name,
                vec![AttachmentInfo::new(format, i0, i1, 1)],
                TestMode::NoRenderPass,
            ));
        }

        {
            let iterations = rnd.get_int(min_iteration, max_iteration);
            let i0 = rnd.get_int(1, max_dimension) as u32;
            let i1 = rnd.get_int(1, max_dimension) as u32;
            let attachments = (0..iterations)
                .map(|_| AttachmentInfo::new(format, i0, i1, 1))
                .collect();
            multi.add_child(case(name, attachments, TestMode::NoRenderPass));
        }

        {
            let iterations = rnd.get_int(min_iteration, max_iteration);
            let i0 = rnd.get_int(1, max_dimension) as u32;
            let i1 = rnd.get_int(1, max_dimension) as u32;
            let mut attachments = vec![AttachmentInfo::new(format, i0, i1, 1)];
            for _ in 0..iterations {
                let i2 = rnd.get_int(0, mandatory_formats.len() as i32 - 1) as usize;
                let i3 = rnd.get_int(1, max_dimension) as u32;
                let i4 = rnd.get_int(1, max_dimension) as u32;
                attachments.push(AttachmentInfo::new(mandatory_formats[i2], i3, i4, 1));
            }
            random.add_child(case(name, attachments, TestMode::NoRenderPass));
        }

        {
            let i0 = rnd.get_int(1, max_dimension) as u32;
            let i1 = rnd.get_int(1, max_dimension) as u32;
            let attachments = vec![AttachmentInfo::new(format, i0, i1, 1)];
            in_render_pass.add_child(case(name, attachments.clone(), TestMode::UseRenderPass));
            in_dynamic_render_pass.add_child(case(name, attachments, TestMode::UseDynamicRenderPass));
        }
    }

    group.add_child(single);
    group.add_child(multi);
    group.add_child(random);
    group.add_child(in_render_pass);
    group.add_child(in_dynamic_render_pass);

    group
}
