// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/memory/vktMemoryExternalMemoryAcquireUnmodifiedTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. No shaders. The case tree and the support check of `TestCase::checkSupport` are ported. The `android_hardware_buffer`
// cases end in NotSupported ("Android Hardware Buffer not supported", as upstream's `AndroidHardwareBufferExternalApi::getInstance()` check) on every Linux or Windows
// device. The `dma_buf` cases create the image with the DRM format modifiers the driver offers (no dma_buf is imported, as upstream) and run the release/acquire-unmodified copy.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_1, InstanceV1_1};

use crate::tcu::pixel::{PixelBufferAccess, fill_with_component_gradients2};
use crate::tcu::{TestError, TestOutcome, TestStatus, map_vk_format};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::tests::api::object_tests::format_name;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const FORMATS: [vk::Format; 5] = [
    vk::Format::R8G8B8A8_UNORM,
    vk::Format::B8G8R8A8_UNORM,
    vk::Format::R16G16B16A16_UNORM,
    vk::Format::R16G16B16A16_SFLOAT,
    vk::Format::R32G32B32A32_SFLOAT,
];

#[derive(Clone, Copy, PartialEq, Eq)]
enum ExternalMemoryType {
    DmaBuf,
    AndroidHardwareBuffer,
}

struct AcquireUnmodifiedCase {
    name: String,
    external_memory_type: ExternalMemoryType,
    format: vk::Format,
}

impl TestCase for AcquireUnmodifiedCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_external_memory_acquire_unmodified")?;
        match self.external_memory_type {
            ExternalMemoryType::DmaBuf => {
                context.require_device_functionality("VK_EXT_external_memory_dma_buf")?;
                context.require_device_functionality("VK_EXT_image_drm_format_modifier")
            }
            ExternalMemoryType::AndroidHardwareBuffer => {
                context.require_device_functionality("VK_ANDROID_external_memory_android_hardware_buffer")
            }
        }
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(AcquireUnmodifiedInstance {
            context,
            external_memory_type: self.external_memory_type,
            format: self.format,
        })
    }
}

const IMAGE_EXTENT: vk::Extent3D = vk::Extent3D {
    width: 256,
    height: 256,
    depth: 1,
};
const SUBRESOURCE_RANGE: vk::ImageSubresourceRange = vk::ImageSubresourceRange {
    aspect_mask: vk::ImageAspectFlags::COLOR,
    base_mip_level: 0,
    level_count: 1,
    base_array_layer: 0,
    layer_count: 1,
};

fn image_usage() -> vk::ImageUsageFlags {
    vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST
}

fn format_features() -> vk::FormatFeatureFlags {
    vk::FormatFeatureFlags::TRANSFER_SRC | vk::FormatFeatureFlags::TRANSFER_DST
}

struct AcquireUnmodifiedInstance<'a> {
    context: &'a Context<'a>,
    external_memory_type: ExternalMemoryType,
    format: vk::Format,
}

/// `DmaBufImageWithMemory`: the memory goes before the image is destroyed, so the image is declared first.
struct DmaBufImage<'d> {
    image: Unique<'d, vk::Image>,
    _memory: Unique<'d, vk::DeviceMemory>,
}

/// `DmaBufImageWithMemory::getDrmFormatModifiersForFormat`
fn drm_format_modifiers_for_format(context: &Context<'_>, format: vk::Format) -> Vec<u64> {
    let vki = context.get_instance();
    let physical_device = context.get_physical_device();

    let mut modifier_list = vk::DrmFormatModifierPropertiesListEXT::default();
    {
        let mut format_properties2 = vk::FormatProperties2::builder().push_next(&mut modifier_list);
        unsafe { vki.get_physical_device_format_properties2(physical_device, format, &mut format_properties2) };
    }

    let mut modifier_properties =
        vec![vk::DrmFormatModifierPropertiesEXT::default(); modifier_list.drm_format_modifier_count as usize];
    modifier_list.drm_format_modifier_properties = modifier_properties.as_mut_ptr();
    {
        let mut format_properties2 = vk::FormatProperties2::builder().push_next(&mut modifier_list);
        unsafe { vki.get_physical_device_format_properties2(physical_device, format, &mut format_properties2) };
    }

    modifier_properties
        .iter()
        .filter(|properties| {
            properties
                .drm_format_modifier_tiling_features
                .contains(format_features())
        })
        .map(|properties| properties.drm_format_modifier)
        .collect()
}

/// `DmaBufImageWithMemory::isDrmFormatModifierCompatible`
fn is_drm_format_modifier_compatible(context: &Context<'_>, format: vk::Format, modifier: u64) -> bool {
    let modifier_info = vk::PhysicalDeviceImageDrmFormatModifierInfoEXT {
        drm_format_modifier: modifier,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
        ..Default::default()
    };
    let external_image_info = vk::PhysicalDeviceExternalImageFormatInfo {
        next: (&raw const modifier_info).cast(),
        handle_type: vk::ExternalMemoryHandleTypeFlags::DMA_BUF_EXT,
        ..Default::default()
    };
    let image_info2 = vk::PhysicalDeviceImageFormatInfo2 {
        next: (&raw const external_image_info).cast(),
        format,
        type_: vk::ImageType::_2D,
        tiling: vk::ImageTiling::DRM_FORMAT_MODIFIER_EXT,
        usage: image_usage(),
        flags: vk::ImageCreateFlags::empty(),
        ..Default::default()
    };
    let mut external_image_properties = vk::ExternalImageFormatProperties::default();
    let max_extent = {
        let mut image_properties2 = vk::ImageFormatProperties2::builder().push_next(&mut external_image_properties);
        let result = unsafe {
            context.get_instance().get_physical_device_image_format_properties2(
                context.get_physical_device(),
                &image_info2,
                &mut image_properties2,
            )
        };
        if result.is_err() {
            return false;
        }
        image_properties2.image_format_properties.max_extent
    };
    if !external_image_properties
        .external_memory_properties
        .external_memory_features
        .contains(vk::ExternalMemoryFeatureFlags::IMPORTABLE)
    {
        return false;
    }
    IMAGE_EXTENT.width <= max_extent.width
        && IMAGE_EXTENT.height <= max_extent.height
        && IMAGE_EXTENT.depth <= max_extent.depth
}

/// `DmaBufImageWithMemory::DmaBufImageWithMemory`: a DRM format modifier image with memory of the best matching type (no dma_buf import).
fn create_dma_buf_image<'d>(
    context: &'d Context<'d>,
    format: vk::Format,
    modifier: u64,
) -> Result<DmaBufImage<'d>, TestError> {
    let device = context.get_device();

    let modifier_info = vk::ImageDrmFormatModifierListCreateInfoEXT {
        drm_format_modifier_count: 1,
        drm_format_modifiers: &raw const modifier,
        ..Default::default()
    };
    let external_info = vk::ExternalMemoryImageCreateInfo {
        next: (&raw const modifier_info).cast(),
        handle_types: vk::ExternalMemoryHandleTypeFlags::DMA_BUF_EXT,
        ..Default::default()
    };
    let image_info = vk::ImageCreateInfo {
        next: (&raw const external_info).cast(),
        flags: vk::ImageCreateFlags::empty(),
        image_type: vk::ImageType::_2D,
        format,
        extent: IMAGE_EXTENT,
        mip_levels: 1,
        array_layers: 1,
        samples: vk::SampleCountFlags::_1,
        tiling: vk::ImageTiling::DRM_FORMAT_MODIFIER_EXT,
        usage: image_usage(),
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
        initial_layout: vk::ImageLayout::UNDEFINED,
        ..Default::default()
    };
    let image = Unique::new(
        device,
        unsafe { device.create_image(&image_info, None) }.vk_check("vkCreateImage")?,
    );

    let memory_requirements_info = vk::ImageMemoryRequirementsInfo2 {
        image: *image,
        ..Default::default()
    };
    let mut dedicated_requirements = vk::MemoryDedicatedRequirements::default();
    let requirements = {
        let mut memory_requirements2 = vk::MemoryRequirements2::builder().push_next(&mut dedicated_requirements);
        unsafe { device.get_image_memory_requirements2(&memory_requirements_info, &mut memory_requirements2) };
        memory_requirements2.memory_requirements
    };

    // chooseMemoryType: nothing required, DEVICE_LOCAL preferred
    let memory_properties = context.get_default_allocator().memory_properties();
    let memory_type_index = (0..memory_properties.memory_type_count)
        .filter(|index| requirements.memory_type_bits & (1 << index) != 0)
        .max_by_key(|&index| {
            let flags = memory_properties.memory_types[index as usize].property_flags;
            (
                flags.contains(vk::MemoryPropertyFlags::DEVICE_LOCAL) as u32,
                std::cmp::Reverse(index),
            )
        })
        .ok_or_else(|| TestError::InternalError("no memory type for the DRM format modifier image".to_string()))?;

    let dedicated_info = vk::MemoryDedicatedAllocateInfo {
        image: *image,
        ..Default::default()
    };
    let allocate_info = vk::MemoryAllocateInfo {
        next: if dedicated_requirements.requires_dedicated_allocation != vk::FALSE {
            (&raw const dedicated_info).cast()
        } else {
            std::ptr::null()
        },
        allocation_size: requirements.size,
        memory_type_index,
        ..Default::default()
    };
    let memory = Unique::new(
        device,
        unsafe { device.allocate_memory(&allocate_info, None) }.vk_check("vkAllocateMemory")?,
    );
    unsafe { device.bind_image_memory(*image, *memory, 0) }.vk_check("vkBindImageMemory")?;
    Ok(DmaBufImage { image, _memory: memory })
}

fn image_barrier(
    image: vk::Image,
    src_access: vk::AccessFlags,
    dst_access: vk::AccessFlags,
    old_layout: vk::ImageLayout,
    new_layout: vk::ImageLayout,
    src_family: u32,
    dst_family: u32,
) -> vk::ImageMemoryBarrier {
    vk::ImageMemoryBarrier {
        src_access_mask: src_access,
        dst_access_mask: dst_access,
        old_layout,
        new_layout,
        src_queue_family_index: src_family,
        dst_queue_family_index: dst_family,
        image,
        subresource_range: SUBRESOURCE_RANGE,
        ..Default::default()
    }
}

fn buffer_barrier(
    buffer: vk::Buffer,
    src_access: vk::AccessFlags,
    dst_access: vk::AccessFlags,
) -> vk::BufferMemoryBarrier {
    vk::BufferMemoryBarrier {
        src_access_mask: src_access,
        dst_access_mask: dst_access,
        src_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
        dst_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
        buffer,
        offset: 0,
        size: vk::WHOLE_SIZE,
        ..Default::default()
    }
}

fn buffer_image_copy(
    buffer_offset: vk::DeviceSize,
    row_length: u32,
    image_height: u32,
    offset: (i32, i32),
    extent: (u32, u32),
) -> vk::BufferImageCopy {
    vk::BufferImageCopy {
        buffer_offset,
        buffer_row_length: row_length,
        buffer_image_height: image_height,
        image_subresource: vk::ImageSubresourceLayers {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            mip_level: 0,
            base_array_layer: 0,
            layer_count: 1,
        },
        image_offset: vk::Offset3D {
            x: offset.0,
            y: offset.1,
            z: 0,
        },
        image_extent: vk::Extent3D {
            width: extent.0,
            height: extent.1,
            depth: 1,
        },
    }
}

impl AcquireUnmodifiedInstance<'_> {
    /// `TestInstance::testImage` on one image: release it to the foreign queue after a full copy, acquire it back with
    /// `VkExternalMemoryAcquireUnmodifiedEXT`, copy the updated sub-rectangle and compare the whole image
    fn test_image(&self, image: vk::Image, buffers: &Buffers<'_>) -> Result<bool, TestError> {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();
        let (width, height) = (IMAGE_EXTENT.width, IMAGE_EXTENT.height);

        unsafe { std::ptr::write_bytes(buffers.result_ptr, 0, buffers.size) };
        invalidate_alloc(device, buffers.result.get_allocation())?;

        let cmd_pool = make_command_pool(device, queue_family_index)?;

        // Copy the gradient to the whole image, then release ownership to the foreign queue
        {
            let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            let cmd = *cmd_buffer;
            begin_command_buffer(device, cmd)?;
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::HOST,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[buffer_barrier(
                        buffers.src1.get(),
                        vk::AccessFlags::HOST_WRITE,
                        vk::AccessFlags::TRANSFER_READ,
                    )],
                    &[image_barrier(
                        image,
                        vk::AccessFlags::empty(),
                        vk::AccessFlags::TRANSFER_WRITE,
                        vk::ImageLayout::UNDEFINED,
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        vk::QUEUE_FAMILY_IGNORED,
                        vk::QUEUE_FAMILY_IGNORED,
                    )],
                );
                device.cmd_copy_buffer_to_image(
                    cmd,
                    buffers.src1.get(),
                    image,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &[buffer_image_copy(0, width, height, (0, 0), (width, height))],
                );
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::empty(),
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[image_barrier(
                        image,
                        vk::AccessFlags::TRANSFER_WRITE,
                        vk::AccessFlags::empty(),
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        vk::ImageLayout::GENERAL,
                        queue_family_index,
                        vk::QUEUE_FAMILY_FOREIGN_EXT,
                    )],
                );
            }
            end_command_buffer(device, cmd)?;
            submit_commands_and_wait(device, queue, cmd)?;
        }

        // Acquire the image back as unmodified, copy the updated region only, read the whole image back
        {
            let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            let cmd = *cmd_buffer;
            begin_command_buffer(device, cmd)?;

            let acquire_unmodified = vk::ExternalMemoryAcquireUnmodifiedEXT {
                acquire_unmodified_memory: vk::TRUE,
                ..Default::default()
            };
            let mut acquire_barrier = image_barrier(
                image,
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::QUEUE_FAMILY_FOREIGN_EXT,
                queue_family_index,
            );
            acquire_barrier.next = (&raw const acquire_unmodified).cast();

            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::HOST,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[buffer_barrier(
                        buffers.src2.get(),
                        vk::AccessFlags::HOST_WRITE,
                        vk::AccessFlags::TRANSFER_READ,
                    )],
                    &[] as &[vk::ImageMemoryBarrier],
                );
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[acquire_barrier],
                );
                device.cmd_copy_buffer_to_image(
                    cmd,
                    buffers.src2.get(),
                    image,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &[buffer_image_copy(
                        buffers.update_offset,
                        width,
                        height,
                        (buffers.update_rect.0, buffers.update_rect.1),
                        (buffers.update_rect.2, buffers.update_rect.3),
                    )],
                );
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[image_barrier(
                        image,
                        vk::AccessFlags::TRANSFER_WRITE,
                        vk::AccessFlags::TRANSFER_READ,
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                        vk::QUEUE_FAMILY_IGNORED,
                        vk::QUEUE_FAMILY_IGNORED,
                    )],
                );
                device.cmd_copy_image_to_buffer(
                    cmd,
                    image,
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    buffers.result.get(),
                    &[buffer_image_copy(0, 0, 0, (0, 0), (width, height))],
                );
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[buffer_barrier(
                        buffers.result.get(),
                        vk::AccessFlags::TRANSFER_WRITE,
                        vk::AccessFlags::HOST_READ,
                    )],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
            end_command_buffer(device, cmd)?;
            submit_commands_and_wait(device, queue, cmd)?;
        }

        invalidate_alloc(device, buffers.result.get_allocation())?;
        // The thresholds of upstream are zero for float and unorm formats alike: the texels have to be identical
        let reference = unsafe { std::slice::from_raw_parts(buffers.src2_ptr.cast_const(), buffers.size) };
        let result = unsafe { std::slice::from_raw_parts(buffers.result_ptr.cast_const(), buffers.size) };
        let same = reference == result;
        if same {
            log::info!("Image comparison passed");
        } else {
            log::error!("Image comparison failed");
        }
        Ok(same)
    }
}

/// The three host visible buffers of `TestInstance::iterate`
struct Buffers<'d> {
    src1: BufferWithMemory<'d>,
    src2: BufferWithMemory<'d>,
    result: BufferWithMemory<'d>,
    src2_ptr: *mut u8,
    result_ptr: *mut u8,
    size: usize,
    /// byte offset of the updated sub-rectangle inside `src2`
    update_offset: vk::DeviceSize,
    /// x, y, width, height
    update_rect: (i32, i32, u32, u32),
}

impl TestInstance for AcquireUnmodifiedInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        if self.external_memory_type == ExternalMemoryType::AndroidHardwareBuffer {
            return Err(TestError::NotSupported(
                "Android Hardware Buffer not supported".to_string(),
            ));
        }

        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let texture_format = map_vk_format(self.format)
            .ok_or_else(|| TestError::NotPorted(format!("no texture format for {:?}", self.format)))?;
        let pixel_size = texture_format.pixel_size().expect("a texture format has a pixel size") as usize;
        let (width, height) = (IMAGE_EXTENT.width, IMAGE_EXTENT.height);
        let buffer_size = pixel_size * (width * height) as usize;
        let pitch = [
            pixel_size,
            pixel_size * width as usize,
            pixel_size * (width * height) as usize,
        ];

        let make_buffer = |usage: vk::BufferUsageFlags| {
            BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(buffer_size as vk::DeviceSize, usage),
                MemoryRequirement::HOST_VISIBLE,
            )
        };
        let src1 = make_buffer(vk::BufferUsageFlags::TRANSFER_SRC)?;
        let src2 = make_buffer(vk::BufferUsageFlags::TRANSFER_SRC)?;
        let result = make_buffer(vk::BufferUsageFlags::TRANSFER_DST)?;
        let src1_ptr = src1.get_allocation().get_host_ptr().cast::<u8>();
        let src2_ptr = src2.get_allocation().get_host_ptr().cast::<u8>();
        let result_ptr = result.get_allocation().get_host_ptr().cast::<u8>();

        let update_rect = ((width / 4) as i32, (height / 4) as i32, width / 2, height / 2);
        let update_offset = (update_rect.1 as usize * width as usize + update_rect.0 as usize) * pixel_size;

        // The first source buffer is a gradient
        {
            let data = unsafe { std::slice::from_raw_parts_mut(src1_ptr, buffer_size) };
            let mut access = PixelBufferAccess::new_with_pitch(texture_format, [width, height, 1], pitch, data);
            fill_with_component_gradients2(&mut access, [0.1, 0.0, 0.8, 1.0], [0.9, 0.7, 0.2, 1.0]);
            flush_alloc(device, src1.get_allocation())?;
        }
        // The second one is a copy of the first with a different gradient in the sub-rectangle
        {
            unsafe { std::ptr::copy_nonoverlapping(src1_ptr, src2_ptr, buffer_size) };
            let data = unsafe { std::slice::from_raw_parts_mut(src2_ptr, buffer_size) };
            let mut access = PixelBufferAccess::new_with_pitch(
                texture_format,
                [update_rect.2, update_rect.3, 1],
                pitch,
                &mut data[update_offset..],
            );
            fill_with_component_gradients2(&mut access, [0.9, 0.2, 0.1, 1.0], [0.3, 0.4, 0.5, 1.0]);
            flush_alloc(device, src2.get_allocation())?;
        }

        let buffers = Buffers {
            src1,
            src2,
            result,
            src2_ptr,
            result_ptr,
            size: buffer_size,
            update_offset: update_offset as vk::DeviceSize,
            update_rect,
        };

        let modifiers: Vec<u64> = drm_format_modifiers_for_format(context, self.format)
            .into_iter()
            .filter(|&modifier| is_drm_format_modifier_compatible(context, self.format, modifier))
            .collect();
        if modifiers.is_empty() {
            return Err(TestError::NotSupported(
                "failed to find compatible DRM format modifier".to_string(),
            ));
        }

        // Every modifier is tested, a failing one does not stop the others (for the benefit of the log)
        let mut all_passed = true;
        for modifier in modifiers {
            log::info!("Test DRM format modifier {modifier:#x}");
            let image = create_dma_buf_image(context, self.format, modifier)?;
            let passed = self.test_image(*image.image, &buffers)?;
            log::info!(
                "DRM format modifier {modifier:#x} {}",
                if passed { "passed" } else { "failed" }
            );
            all_passed &= passed;
        }
        Ok(if all_passed {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `createExternalMemoryAcquireUnmodifiedTests`
pub fn create_external_memory_acquire_unmodified_tests() -> TestCaseGroup {
    let mut root_group = TestCaseGroup::new("external_memory_acquire_unmodified");
    for (group_name, external_memory_type) in [
        ("dma_buf", ExternalMemoryType::DmaBuf),
        ("android_hardware_buffer", ExternalMemoryType::AndroidHardwareBuffer),
    ] {
        let mut group = TestCaseGroup::new(group_name);
        for format in FORMATS {
            group.add_child(Box::new(AcquireUnmodifiedCase {
                name: format_name(format).to_string(),
                external_memory_type,
                format,
            }) as Box<dyn TestCase>);
        }
        root_group.add_child(group);
    }
    root_group
}
