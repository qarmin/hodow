// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/ycbcr/vktYCbCrImageOffsetTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::DeviceV1_1;

use super::format_lists::DISJOINT_PLANES_FORMATS;
use super::util::{format_description, plane_aspect};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::mem_util::{Allocation, MemoryRequirement};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy)]
struct ImageOffsetCase {
    name: &'static str,
    format: vk::Format,
}

/// `de::toLower(getFormatName(format).substr(10))`
fn format_case_name(format: vk::Format) -> String {
    format!("{format:?}").to_lowercase()
}

/// `vk::deAlign64`
fn align64(value: u64, alignment: u64) -> u64 {
    value.div_ceil(alignment) * alignment
}

impl TestCase for ImageOffsetCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        // Required for image query
        context.require_device_functionality("VK_KHR_sampler_ycbcr_conversion")?;
        let properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), self.format)
        };

        if !properties
            .linear_tiling_features
            .contains(vk::FormatFeatureFlags::DISJOINT)
        {
            return Err(TestError::NotSupported(
                "Format doesn't support disjoint planes".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ImageOffsetInstance {
            context,
            format: self.format,
        })
    }
}

struct ImageOffsetInstance<'a> {
    context: &'a Context<'a>,
    format: vk::Format,
}

/// `createImage`
fn create_image<'a>(vkd: &'a Device, format: vk::Format, size: (u32, u32)) -> Result<Unique<'a, vk::Image>, TestError> {
    let create_info = vk::ImageCreateInfo {
        s_type: vk::StructureType::IMAGE_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::ImageCreateFlags::DISJOINT,
        image_type: vk::ImageType::_2D,
        format,
        extent: vk::Extent3D {
            width: size.0,
            height: size.1,
            depth: 1,
        },
        mip_levels: 1,
        array_layers: 1,
        samples: vk::SampleCountFlags::_1,
        tiling: vk::ImageTiling::LINEAR,
        usage: vk::ImageUsageFlags::TRANSFER_SRC,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
        initial_layout: vk::ImageLayout::PREINITIALIZED,
    };

    Ok(Unique::new(
        vkd,
        unsafe { vkd.create_image(&create_info, None) }.vk_check("vkCreateImage")?,
    ))
}

impl TestInstance for ImageOffsetInstance<'_> {
    /// `imageOffsetTest`
    fn iterate(&mut self) -> TestOutcome {
        let vkd = self.context.get_device();

        let src_image = create_image(vkd, self.format, (8, 8))?;
        let src_memory_requirement = MemoryRequirement::HOST_VISIBLE;
        let mut src_image_memory: Vec<Allocation<'_>> = Vec::new();

        let num_planes = format_description(self.format).planes.len();
        let mut plane_infos: Vec<vk::BindImagePlaneMemoryInfo> = Vec::with_capacity(num_planes);
        let mut offsets: Vec<u64> = Vec::with_capacity(num_planes);

        for plane_ndx in 0..num_planes {
            let plane_aspect = plane_aspect(plane_ndx);
            let mut plane_reqs_info = vk::ImagePlaneMemoryRequirementsInfo::builder().plane_aspect(plane_aspect);
            let info = vk::ImageMemoryRequirementsInfo2::builder()
                .image(*src_image)
                .push_next(&mut plane_reqs_info);
            let mut reqs2 = vk::MemoryRequirements2::default();
            unsafe { vkd.get_image_memory_requirements2(&info, &mut reqs2) };
            let mut reqs = reqs2.memory_requirements;
            let offset = align64(reqs.size, reqs.alignment);
            reqs.size *= 2;

            src_image_memory.push(
                self.context
                    .get_default_allocator()
                    .allocate(vkd, reqs, src_memory_requirement)?,
            );

            plane_infos.push(
                vk::BindImagePlaneMemoryInfo::builder()
                    .plane_aspect(plane_aspect)
                    .build(),
            );
            offsets.push(offset);
        }

        let core_infos: Vec<vk::BindImageMemoryInfo> = src_image_memory
            .iter()
            .zip(plane_infos.iter_mut())
            .zip(offsets.iter())
            .map(|((alloc, plane_info), offset)| {
                vk::BindImageMemoryInfo::builder()
                    .image(*src_image)
                    .memory(alloc.get_memory())
                    .memory_offset(*offset)
                    .push_next(plane_info)
                    .build()
            })
            .collect();

        unsafe { vkd.bind_image_memory2(&core_infos) }.vk_check("vkBindImageMemory2")?;

        let aspect_masks = [
            vk::ImageAspectFlags::PLANE_0,
            vk::ImageAspectFlags::PLANE_1,
            vk::ImageAspectFlags::PLANE_2,
        ];
        for aspect_mask in aspect_masks.iter().take(num_planes) {
            let subresource = vk::ImageSubresource {
                aspect_mask: *aspect_mask,
                mip_level: 0,
                array_layer: 0,
            };
            let subresource_layout = unsafe { vkd.get_image_subresource_layout(*src_image, &subresource) };

            // VkSubresourceLayout::offset is the byte offset from the start of the image or the plane
            // where the image subresource begins. For disjoint images, it should be 0 since each plane
            // has been separately bound to memory.
            if subresource_layout.offset != 0 {
                return Ok(TestStatus::fail("Failed, subresource layout offset != 0"));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createImageOffsetTests` / `initYcbcrImageOffsetTests`
pub fn create_image_offset_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("subresource_offset");

    for &src_format in DISJOINT_PLANES_FORMATS {
        // The name has to outlive the case, which holds a `&'static str`.
        let name: &'static str = Box::leak(format_case_name(src_format).into_boxed_str());
        group.add_child(Box::new(ImageOffsetCase {
            name,
            format: src_format,
        }) as Box<dyn TestCase>);
    }

    group
}
