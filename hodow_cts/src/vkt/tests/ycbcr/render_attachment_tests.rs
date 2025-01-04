// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/ycbcr/vktYCbCrRenderAttachmentTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The plane contents are checked as raw
// bytes: every format this group covers is 8 bits per channel UNORM, so 1.0 is 0xFF and
// 0.0 is 0x00 exactly and no pixel-format decoding is needed.

use vulkanalia::prelude::v1_0::*;

use super::util::{
    MultiPlaneImageData, allocate_and_bind_image_memory, aspect_plane_ndx, download_image, plane_extent, upload_image,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::mem_util::MemoryRequirement;
use crate::vk::obj_util::{
    allocate_command_buffer, make_command_pool, make_framebuffer, make_graphics_pipeline, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const IMAGE_SIZE: (u32, u32) = (256, 256);

#[derive(Clone, Copy)]
struct RenderAttachmentCase {
    name: &'static str,
    format: vk::Format,
    aspect: vk::ImageAspectFlags,
    disjoint: bool,
    programs: BinaryCollection,
}

fn usage_flags() -> vk::ImageUsageFlags {
    vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST
}

fn create_flags(disjoint: bool) -> vk::ImageCreateFlags {
    let mut create_flags = vk::ImageCreateFlags::EXTENDED_USAGE | vk::ImageCreateFlags::MUTABLE_FORMAT;
    if disjoint {
        create_flags |= vk::ImageCreateFlags::DISJOINT;
    }
    create_flags
}

impl TestCase for RenderAttachmentCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        // These multiplanar formats are provided by this extension
        context.require_device_functionality("VK_KHR_sampler_ycbcr_conversion")?;

        // Check if this combination of format and flags are supported
        let properties = unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                self.format,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                usage_flags(),
                create_flags(self.disjoint),
            )
        };
        if properties.is_err() {
            return Err(TestError::NotSupported("Image format is not supported".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(RenderAttachmentTestInstance { context, case: *self })
    }
}

struct RenderAttachmentTestInstance<'a> {
    context: &'a Context<'a>,
    case: RenderAttachmentCase,
}

impl RenderAttachmentTestInstance<'_> {
    /// `createImage`
    fn create_image(&self, size: (u32, u32)) -> Result<Unique<'_, vk::Image>, TestError> {
        let vkd = self.context.get_device();
        let create_info = vk::ImageCreateInfo {
            s_type: vk::StructureType::IMAGE_CREATE_INFO,
            next: std::ptr::null(),
            flags: create_flags(self.case.disjoint),
            image_type: vk::ImageType::_2D,
            format: self.case.format,
            extent: vk::Extent3D {
                width: size.0,
                height: size.1,
                depth: 1,
            },
            mip_levels: 1,
            array_layers: 1,
            samples: vk::SampleCountFlags::_1,
            tiling: vk::ImageTiling::OPTIMAL,
            usage: usage_flags(),
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 0,
            queue_family_indices: std::ptr::null(),
            initial_layout: vk::ImageLayout::UNDEFINED,
        };

        Ok(Unique::new(
            vkd,
            unsafe { vkd.create_image(&create_info, None) }.vk_check("vkCreateImage")?,
        ))
    }

    /// `createImageView`
    fn create_image_view(
        &self,
        image: vk::Image,
        aspect_format: vk::Format,
    ) -> Result<Unique<'_, vk::ImageView>, TestError> {
        let vkd = self.context.get_device();
        let view_info = vk::ImageViewCreateInfo {
            s_type: vk::StructureType::IMAGE_VIEW_CREATE_INFO,
            next: std::ptr::null(),
            flags: vk::ImageViewCreateFlags::empty(),
            image,
            view_type: vk::ImageViewType::_2D,
            format: aspect_format,
            components: vk::ComponentMapping {
                r: vk::ComponentSwizzle::IDENTITY,
                g: vk::ComponentSwizzle::IDENTITY,
                b: vk::ComponentSwizzle::IDENTITY,
                a: vk::ComponentSwizzle::IDENTITY,
            },
            subresource_range: vk::ImageSubresourceRange {
                aspect_mask: self.case.aspect,
                base_mip_level: 0,
                level_count: 1,
                base_array_layer: 0,
                layer_count: 1,
            },
        };

        Ok(Unique::new(
            vkd,
            unsafe { vkd.create_image_view(&view_info, None) }.vk_check("vkCreateImageView")?,
        ))
    }

    /// `createRenderPass`
    fn create_render_pass(&self, aspect_format: vk::Format) -> Result<Unique<'_, vk::RenderPass>, TestError> {
        let vkd = self.context.get_device();
        let dst_attachment_ref = [vk::AttachmentReference {
            attachment: 0,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        }];

        let dst_attachment = [vk::AttachmentDescription::builder()
            .format(aspect_format)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::DONT_CARE)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build()];

        let subpass = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&dst_attachment_ref)
            .build()];

        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&dst_attachment)
            .subpasses(&subpass);

        Ok(Unique::new(
            vkd,
            unsafe { vkd.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        ))
    }

    /// `verifyPlane` - returns false and logs at the first mismatch.
    fn verify_plane(&self, plane: &[u8], channels: usize, size: (u32, u32), plane_idx: usize, is_target: bool) -> bool {
        for x in 0..size.0 as usize {
            for y in 0..size.1 as usize {
                // If this is the target plane, check for the sanity pattern,
                // otherwise the plane should be all zeros
                let pixel = &plane[(y * size.0 as usize + x) * channels..][..channels];
                if channels == 2 {
                    // Tests the second component (if the plane holds two channels)
                    let expect = if is_target && y % 2 == 0 { 0xFF } else { 0x00 };
                    if pixel[1] != expect {
                        log::info!(
                            "Comparison failed at: planes[{plane_idx}].pixels[{x}][{y}].values[1]: {} != {}",
                            pixel[1],
                            expect
                        );
                        return false;
                    }
                }
                // Tests the first component
                let expect = if is_target && x % 2 == 0 { 0xFF } else { 0x00 };
                if pixel[0] != expect {
                    log::info!(
                        "Comparison failed at: planes[{plane_idx}].pixels[{x}][{y}].values[0]: {} != {}",
                        pixel[0],
                        expect
                    );
                    return false;
                }
            }
        }
        true
    }

    /// `verify` - the plane at `plane_idx` is checked for the sanity pattern drawn by the
    /// shader, the other planes are checked for zeros.
    fn verify(&self, image_data: &MultiPlaneImageData, plane_idx: usize) -> TestOutcome {
        let description = image_data.description();
        for i in 0..description.planes.len() {
            let plane_size = plane_extent(&description, image_data.size(), i);
            let channels = description.planes[i].element_size as usize;
            if !self.verify_plane(image_data.plane(i), channels, plane_size, i, i == plane_idx) {
                return Ok(TestStatus::fail(format!("Comparison failed: PLANE_{i}")));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestInstance for RenderAttachmentTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let vkd = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue = self.context.get_universal_queue();
        let qf_index = self.context.get_universal_queue_family_index();
        let image_size = IMAGE_SIZE;
        let plane_idx = aspect_plane_ndx(self.case.aspect);

        // create the image
        let test_image = self.create_image(image_size)?;
        let _allocations = allocate_and_bind_image_memory(
            vkd,
            allocator,
            *test_image,
            self.case.format,
            self.case.disjoint,
            MemoryRequirement::ANY,
        )?;

        // initialize all planes with zeros
        let mut image_data = MultiPlaneImageData::new(self.case.format, image_size);
        upload_image(
            vkd,
            allocator,
            queue,
            qf_index,
            *test_image,
            &image_data,
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;

        let plane_desc = image_data.description().planes[plane_idx];
        let render_size = (
            image_size.0 / plane_desc.width_divisor,
            image_size.1 / plane_desc.height_divisor,
        );

        // create the render pass for the target plane
        let image_view = self.create_image_view(*test_image, plane_desc.compatible_format)?;
        let render_pass = self.create_render_pass(plane_desc.compatible_format)?;
        let framebuffer = make_framebuffer(vkd, *render_pass, &[*image_view], render_size.0, render_size.1, 1)?;

        // create the pipeline to render the quad
        let pipeline_layout = make_pipeline_layout(vkd, &[])?;
        let pipeline = {
            let bc = self.context.get_binary_collection();
            let vertex_shader_module = create_shader_module(vkd, bc.get("vert")?)?;
            let fragment_shader_module = create_shader_module(vkd, bc.get("frag")?)?;
            make_graphics_pipeline(
                vkd,
                *pipeline_layout,
                *vertex_shader_module,
                *fragment_shader_module,
                *render_pass,
                render_size,
                vk::PrimitiveTopology::TRIANGLE_LIST,
            )?
        };

        let command_pool = make_command_pool(vkd, qf_index)?;
        let command_buffer = allocate_command_buffer(vkd, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let command_buffer = command_buffer.get();

        begin_command_buffer(vkd, command_buffer)?;

        begin_render_pass(
            vkd,
            command_buffer,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, render_size.0, render_size.1),
            vk::ClearValue {
                color: vk::ClearColorValue { float32: [0.0; 4] },
            },
        );

        // renders the test quad and pattern
        unsafe {
            vkd.cmd_bind_pipeline(command_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            vkd.cmd_draw(command_buffer, 6, 1, 0, 0);
        }

        end_render_pass(vkd, command_buffer);

        end_command_buffer(vkd, command_buffer)?;

        submit_commands_and_wait(vkd, queue, command_buffer)?;

        // refresh local plane pointers
        download_image(
            vkd,
            allocator,
            queue,
            qf_index,
            *test_image,
            &mut image_data,
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;

        // verify the plane contents
        self.verify(&image_data, plane_idx)
    }
}

/// `createRenderAttachmentTests`
pub fn create_render_attachment_tests() -> TestCaseGroup {
    use crate::generated::shaders::ycbcr_render_attachment as g;

    struct YcbcrFormatData {
        name: &'static str,
        format: vk::Format,
        planes: &'static [vk::ImageAspectFlags],
    }

    const THREE_PLANES: &[vk::ImageAspectFlags] = &[
        vk::ImageAspectFlags::PLANE_0,
        vk::ImageAspectFlags::PLANE_1,
        vk::ImageAspectFlags::PLANE_2,
    ];
    const TWO_PLANES: &[vk::ImageAspectFlags] = &[vk::ImageAspectFlags::PLANE_0, vk::ImageAspectFlags::PLANE_1];

    let ycbcr_formats = [
        YcbcrFormatData {
            name: "g8_b8_r8_3plane_420_unorm",
            format: vk::Format::G8_B8_R8_3PLANE_420_UNORM,
            planes: THREE_PLANES,
        },
        YcbcrFormatData {
            name: "g8_b8r8_2plane_420_unorm",
            format: vk::Format::G8_B8R8_2PLANE_420_UNORM,
            planes: TWO_PLANES,
        },
        YcbcrFormatData {
            name: "g8_b8_r8_3plane_422_unorm",
            format: vk::Format::G8_B8_R8_3PLANE_422_UNORM,
            planes: THREE_PLANES,
        },
        YcbcrFormatData {
            name: "g8_b8r8_2plane_422_unorm",
            format: vk::Format::G8_B8R8_2PLANE_422_UNORM,
            planes: TWO_PLANES,
        },
        YcbcrFormatData {
            name: "g8_b8_r8_3plane_444_unorm",
            format: vk::Format::G8_B8_R8_3PLANE_444_UNORM,
            planes: THREE_PLANES,
        },
    ];

    let mut render_attachment_tests = TestCaseGroup::new("render_attachment");
    let programs = g::RENDER_ATTACHMENT_PROGRAMS.programs;

    for ycbcr_format in &ycbcr_formats {
        let mut joint_group = TestCaseGroup::new("joint");
        let mut disjoint_group = TestCaseGroup::new("disjoint");

        for &ycbcr_plane in ycbcr_format.planes {
            let plane = match ycbcr_plane {
                vk::ImageAspectFlags::PLANE_0 => "plane0",
                vk::ImageAspectFlags::PLANE_1 => "plane1",
                vk::ImageAspectFlags::PLANE_2 => "plane2",
                _ => unreachable!(),
            };
            joint_group.add_child(Box::new(RenderAttachmentCase {
                name: plane,
                format: ycbcr_format.format,
                aspect: ycbcr_plane,
                disjoint: false,
                programs,
            }) as Box<dyn TestCase>);
            disjoint_group.add_child(Box::new(RenderAttachmentCase {
                name: plane,
                format: ycbcr_format.format,
                aspect: ycbcr_plane,
                disjoint: true,
                programs,
            }) as Box<dyn TestCase>);
        }

        let mut format_group = TestCaseGroup::new(ycbcr_format.name);
        format_group.add_child(joint_group);
        format_group.add_child(disjoint_group);
        render_attachment_tests.add_child(format_group);
    }

    render_attachment_tests
}
