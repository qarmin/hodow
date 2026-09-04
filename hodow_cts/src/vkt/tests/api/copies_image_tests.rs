// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiCopyBufferToImageTests.cpp
//   external/vulkancts/modules/vulkan/api/vktApiCopiesAndBlittingUtil.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// These tests compare against a reference image built on the host with a threshold of
// zero, so every byte of the source data and of the expected result has to be produced
// the same way twice - once uploaded to the driver, once computed here.

use vulkanalia::prelude::v1_0::*;
// vkCmdCopyBufferToImage2 is core in 1.3; the copy_commands2 group also accepts the
// KHR alias, but vulkanalia exposes the promoted name.
use vulkanalia::vk::DeviceV1_3;

use super::copies_buffer_tests::{AllocationKind, CopyCommandVariant, QueueSelection, bind_buffer_memory, select_queue};
use crate::tcu::pixel::{
    ConstPixelBufferAccess, PixelBufferAccess, TextureLevel, fill_with_component_gradients2, get_texture_format_bit_depth, has_depth_component, has_stencil_component,
};
use crate::tcu::texture::TextureChannelClass;
use crate::tcu::{self, TestError, TestOutcome, TestStatus, map_vk_format};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_memory_barrier, make_image_subresource_range};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestInstance};

/// `defaultSize`
const DEFAULT_SIZE: u32 = 64;
/// `defaultHalfSize`
const DEFAULT_HALF_SIZE: u32 = DEFAULT_SIZE / 2;
/// `defaultQuarterSize`
const DEFAULT_QUARTER_SIZE: u32 = DEFAULT_SIZE / 4;
/// `default1dExtent`
const DEFAULT_1D_EXTENT: [u32; 3] = [DEFAULT_SIZE, 1, 1];
/// `defaultExtent`
const DEFAULT_EXTENT: [u32; 3] = [DEFAULT_SIZE, DEFAULT_SIZE, 1];
/// `defaultHalfExtent`
const DEFAULT_HALF_EXTENT: [u32; 3] = [DEFAULT_HALF_SIZE, DEFAULT_HALF_SIZE, 1];

/// `de::roundUp`
fn round_up(value: u32, alignment: u32) -> u32 {
    value.div_ceil(alignment) * alignment
}

/// `FillMode`, narrowed to the modes the ported groups use.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum FillMode {
    Gradient,
    White,
    Red,
}

/// `ImageParms`
#[derive(Clone, Copy)]
pub struct ImageParms {
    pub image_type: vk::ImageType,
    pub format: vk::Format,
    pub extent: [u32; 3],
    pub tiling: vk::ImageTiling,
    pub fill_mode: FillMode,
}

impl ImageParms {
    /// `getArraySize`
    fn array_size(&self) -> u32 {
        if self.image_type != vk::ImageType::_3D { self.extent[2] } else { 1 }
    }

    /// `getExtent3D`
    fn extent_3d(&self) -> vk::Extent3D {
        vk::Extent3D {
            width: self.extent[0],
            height: if self.image_type != vk::ImageType::_1D { self.extent[1] } else { 1 },
            depth: if self.image_type == vk::ImageType::_3D { self.extent[2] } else { 1 },
        }
    }

    /// `getCreateFlags` - a 2D image whose layer count is a multiple of six is made
    /// cube-compatible, which upstream relies on for the cube array cases.
    fn create_flags(&self) -> vk::ImageCreateFlags {
        if self.image_type == vk::ImageType::_2D && self.extent[2].is_multiple_of(6) {
            vk::ImageCreateFlags::CUBE_COMPATIBLE
        } else {
            vk::ImageCreateFlags::empty()
        }
    }
}

/// `vk::getAspectFlags`
fn get_aspect_flags(format: vk::Format) -> vk::ImageAspectFlags {
    let Some(f) = map_vk_format(format) else {
        return vk::ImageAspectFlags::COLOR;
    };
    let mut mask = vk::ImageAspectFlags::empty();
    if has_depth_component(f.order) {
        mask |= vk::ImageAspectFlags::DEPTH;
    }
    if has_stencil_component(f.order) {
        mask |= vk::ImageAspectFlags::STENCIL;
    }
    if mask.is_empty() { vk::ImageAspectFlags::COLOR } else { mask }
}

/// `CopyRegion::bufferImageCopy`
#[derive(Clone, Copy)]
pub struct BufferImageCopy {
    pub buffer_offset: u64,
    pub buffer_row_length: u32,
    pub buffer_image_height: u32,
    pub base_array_layer: u32,
    pub layer_count: u32,
    pub image_offset: [i32; 3],
    pub image_extent: [u32; 3],
}

impl BufferImageCopy {
    fn to_vk(self) -> vk::BufferImageCopy {
        vk::BufferImageCopy {
            buffer_offset: self.buffer_offset,
            buffer_row_length: self.buffer_row_length,
            buffer_image_height: self.buffer_image_height,
            image_subresource: vk::ImageSubresourceLayers {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                mip_level: 0,
                base_array_layer: self.base_array_layer,
                layer_count: self.layer_count,
            },
            image_offset: vk::Offset3D {
                x: self.image_offset[0],
                y: self.image_offset[1],
                z: self.image_offset[2],
            },
            image_extent: vk::Extent3D {
                width: self.image_extent[0],
                height: self.image_extent[1],
                depth: self.image_extent[2],
            },
        }
    }
}

/// `CopiesAndBlittingTestInstance::generateBuffer`
fn generate_buffer(access: &mut PixelBufferAccess<'_>, width: u32, height: u32, depth: u32, mode: FillMode) {
    let format = access.format();
    let channel_class = format.channel_class();
    let mut max_value = [1.0f32; 4];

    if matches!(channel_class, TextureChannelClass::SignedInteger | TextureChannelClass::UnsignedInteger) {
        // The tcu::Vectors we use as pixels are 32-bit, so clamp to that.
        let bits = get_texture_format_bit_depth(format);
        let sign_bit = i32::from(channel_class == TextureChannelClass::SignedInteger);
        for i in 0..4 {
            let b = bits[i].min(32);
            if b != 0 {
                max_value[i] = ((1u64 << (b - sign_bit)) - 1) as f32;
            }
        }
    }

    match mode {
        FillMode::Gradient => fill_with_component_gradients2(access, [0.0; 4], max_value),
        FillMode::White | FillMode::Red => {
            let color = if mode == FillMode::White { max_value } else { [max_value[0], 0.0, 0.0, max_value[3]] };
            for z in 0..depth {
                for y in 0..height {
                    for x in 0..width {
                        access.set_pixel(color, x, y, z);
                    }
                }
            }
        }
    }
}

/// `CopyBufferToImage::copyRegionToTextureLevel`
fn copy_region_to_texture_level(src: &ConstPixelBufferAccess<'_>, dst: &mut PixelBufferAccess<'_>, region: BufferImageCopy, texel_size: usize) {
    let row_length = if region.buffer_row_length == 0 {
        region.image_extent[0]
    } else {
        region.buffer_row_length
    };
    let image_height = if region.buffer_image_height == 0 {
        region.image_extent[1]
    } else {
        region.buffer_image_height
    };

    let texel_offset = (region.buffer_offset / texel_size as u64) as u32;

    for z in 0..region.image_extent[2] {
        for y in 0..region.image_extent[1] {
            let texel_index = texel_offset + (z * image_height + y) * row_length;
            let dst_z = (region.image_offset[2] as u32) + z + region.base_array_layer;
            let dst_y = (region.image_offset[1] as u32) + y;
            let dst_x = region.image_offset[0] as u32;
            dst.copy_texels_from(src, texel_index as usize, (dst_x, dst_y, dst_z), region.image_extent[0] as usize);
        }
    }
}

/// `m_queueFamilyIndices` as a buffer create info: upstream switches the staging
/// buffers to CONCURRENT sharing whenever a second queue family is in play. Sharing
/// mode is not verdict-visible on a correct driver, but it can change which internal
/// path a driver takes, so it is worth matching rather than always using EXCLUSIVE.
fn staging_buffer_create_info(size: u64, usage: vk::BufferUsageFlags, families: &[u32]) -> vk::BufferCreateInfo {
    let mut info = make_buffer_create_info(size, usage);
    if families.len() > 1 {
        info.sharing_mode = vk::SharingMode::CONCURRENT;
        info.queue_family_index_count = families.len() as u32;
        info.queue_family_indices = families.as_ptr();
    }
    info
}

/// `CopiesAndBlittingTestInstance::uploadImage`, colour aspect and one mip level.
#[allow(clippy::too_many_arguments)]
fn upload_image(context: &Context<'_>, src: &ConstPixelBufferAccess<'_>, image: vk::Image, parms: &ImageParms, general_layout: bool, families: &[u32]) -> Result<(), TestError> {
    let vk_device = context.get_device();
    let queue = context.get_universal_queue();
    let queue_family_index = context.get_universal_queue_family_index();

    let bytes = src.raw().len() as u64;
    let staging = BufferWithMemory::new(
        vk_device,
        context.get_default_allocator(),
        staging_buffer_create_info(bytes, vk::BufferUsageFlags::TRANSFER_SRC, families),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe { std::ptr::copy_nonoverlapping(src.raw().as_ptr(), staging.get_allocation().get_host_ptr(), bytes as usize) };
    flush_alloc(vk_device, staging.get_allocation())?;

    let layout = if general_layout {
        vk::ImageLayout::GENERAL
    } else {
        vk::ImageLayout::TRANSFER_DST_OPTIMAL
    };
    let extent = parms.extent_3d();
    let aspect = get_aspect_flags(parms.format);
    let range = make_image_subresource_range(aspect, 0, 1, 0, parms.array_size());

    let cmd_pool = make_command_pool(vk_device, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    begin_command_buffer(vk_device, *cmd_buffer)?;
    unsafe {
        let pre = make_image_memory_barrier(vk::AccessFlags::empty(), vk::AccessFlags::TRANSFER_WRITE, vk::ImageLayout::UNDEFINED, layout, image, range);
        vk_device.cmd_pipeline_barrier(
            *cmd_buffer,
            vk::PipelineStageFlags::HOST,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[pre],
        );

        let region = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: extent.width,
            buffer_image_height: extent.height,
            image_subresource: vk::ImageSubresourceLayers {
                aspect_mask: aspect,
                mip_level: 0,
                base_array_layer: 0,
                layer_count: parms.array_size(),
            },
            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            image_extent: extent,
        };
        vk_device.cmd_copy_buffer_to_image(*cmd_buffer, staging.get(), image, layout, &[region]);

        let post = make_image_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::TRANSFER_WRITE, layout, layout, image, range);
        vk_device.cmd_pipeline_barrier(
            *cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[post],
        );
    }
    end_command_buffer(vk_device, *cmd_buffer)?;
    submit_commands_and_wait(vk_device, queue, *cmd_buffer)
}

/// `CopiesAndBlittingTestInstance::readImage`, colour aspect and one mip level.
fn read_image(context: &Context<'_>, image: vk::Image, parms: &ImageParms, dst: &mut TextureLevel, general_layout: bool, families: &[u32]) -> Result<(), TestError> {
    let vk_device = context.get_device();
    let queue = context.get_universal_queue();
    let queue_family_index = context.get_universal_queue_family_index();

    let bytes = dst.data().len() as u64;
    let staging = BufferWithMemory::new(
        vk_device,
        context.get_default_allocator(),
        staging_buffer_create_info(bytes, vk::BufferUsageFlags::TRANSFER_DST, families),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let src_layout = if general_layout {
        vk::ImageLayout::GENERAL
    } else {
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL
    };
    let old_layout = if general_layout {
        vk::ImageLayout::GENERAL
    } else {
        vk::ImageLayout::TRANSFER_DST_OPTIMAL
    };
    let extent = parms.extent_3d();
    let aspect = get_aspect_flags(parms.format);
    let range = make_image_subresource_range(aspect, 0, 1, 0, parms.array_size());

    let cmd_pool = make_command_pool(vk_device, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    begin_command_buffer(vk_device, *cmd_buffer)?;
    unsafe {
        let pre = make_image_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::TRANSFER_READ, old_layout, src_layout, image, range);
        vk_device.cmd_pipeline_barrier(
            *cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[pre],
        );

        let region = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: extent.width,
            buffer_image_height: extent.height,
            image_subresource: vk::ImageSubresourceLayers {
                aspect_mask: aspect,
                mip_level: 0,
                base_array_layer: 0,
                layer_count: parms.array_size(),
            },
            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            image_extent: extent,
        };
        vk_device.cmd_copy_image_to_buffer(*cmd_buffer, image, src_layout, staging.get(), &[region]);
    }
    end_command_buffer(vk_device, *cmd_buffer)?;
    submit_commands_and_wait(vk_device, queue, *cmd_buffer)?;

    invalidate_alloc(vk_device, staging.get_allocation())?;
    unsafe { std::ptr::copy_nonoverlapping(staging.get_allocation().get_host_ptr().cast_const(), dst.data_mut().as_mut_ptr(), bytes as usize) };
    Ok(())
}

/// `CopiesAndBlittingTestInstance::checkTestResult` - the copy tests compare exactly,
/// so any difference at all is a failure.
fn check_test_result(expected: &ConstPixelBufferAccess<'_>, result: &ConstPixelBufferAccess<'_>) -> TestStatus {
    if expected.raw() == result.raw() {
        return TestStatus::pass("CopiesAndBlitting test");
    }
    let at = expected.raw().iter().zip(result.raw()).position(|(a, b)| a != b).unwrap_or(0);
    TestStatus::fail(format!("CopiesAndBlitting test: first difference at byte {at}"))
}

/// `TestParams`, narrowed to what the buffer-to-image cases carry.
pub struct CopyBufferToImageCase {
    name: String,
    src_buffer_size: u32,
    src_fill_mode: FillMode,
    dst: ImageParms,
    regions: Vec<BufferImageCopy>,
    allocation_kind: AllocationKind,
    command_variant: CopyCommandVariant,
    queue_selection: QueueSelection,
    general_layout: bool,
    /// Set when a region asks for `VK_REMAINING_ARRAY_LAYERS`, which only became legal
    /// for a copy subresource with VK_KHR_maintenance5.
    needs_maintenance5: bool,
    /// Set for the relaxed buffer offset on a transfer-only queue, where the loosened
    /// alignment rule comes from VK_KHR_maintenance11.
    needs_maintenance11: bool,
}

impl TestCase for CopyBufferToImageCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.command_variant == CopyCommandVariant::CopyCommands2 {
            context.require_device_functionality("VK_KHR_copy_commands2")?;
        }
        if self.allocation_kind == AllocationKind::Dedicated {
            context.require_device_functionality("VK_KHR_dedicated_allocation")?;
        }
        if self.needs_maintenance5 {
            context.require_device_functionality("VK_KHR_maintenance5")?;
        }
        if self.needs_maintenance11 {
            context.require_device_functionality("VK_KHR_maintenance11")?;
        }
        select_queue(context, self.queue_selection)?;

        let usage = vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
        let properties = unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                self.dst.format,
                self.dst.image_type,
                self.dst.tiling,
                usage,
                self.dst.create_flags(),
            )
        }
        .map_err(|_| TestError::NotSupported("Format does not support the required parameters".to_string()))?;

        if properties.max_array_layers < self.dst.array_size() {
            return Err(TestError::NotSupported("maxArrayLayers too small".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CopyBufferToImageInstance { context, params: self })
    }
}

struct CopyBufferToImageInstance<'a> {
    context: &'a Context<'a>,
    params: &'a CopyBufferToImageCase,
}

impl TestInstance for CopyBufferToImageInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let p = self.params;
        let vk_device = self.context.get_device();
        let allocator = self.context.get_default_allocator();

        // `m_queueFamilyIndices` - the universal queue always, plus the copy's own queue
        // when it is a different family.
        let (queue, queue_family_index) = select_queue(self.context, p.queue_selection)?;
        let mut families = vec![self.context.get_universal_queue_family_index()];
        if queue_family_index != families[0] {
            families.push(queue_family_index);
        }

        let texture_format = map_vk_format(p.dst.format).ok_or_else(|| TestError::NotSupported("format has no tcu mapping".to_string()))?;
        let texel_size = texture_format.pixel_size().ok_or_else(|| TestError::NotSupported("format has no pixel size".to_string()))? as usize;

        // Host-side source data, expected result, and the image's starting contents.
        let mut source_level = TextureLevel::new(texture_format, p.src_buffer_size, 1, 1)?;
        generate_buffer(&mut source_level.get_access(), p.src_buffer_size, 1, 1, p.src_fill_mode);

        let mut destination_level = TextureLevel::new(texture_format, p.dst.extent[0], p.dst.extent[1], p.dst.extent[2])?;
        generate_buffer(&mut destination_level.get_access(), p.dst.extent[0], p.dst.extent[1], p.dst.extent[2], p.dst.fill_mode);

        // `generateExpectedResult` - start from the destination contents, then replay
        // each region on the host.
        let mut expected_level = TextureLevel::new(texture_format, p.dst.extent[0], p.dst.extent[1], p.dst.extent[2])?;
        expected_level.data_mut().copy_from_slice(destination_level.data());
        {
            let source_access = source_level.get_const_access();
            let mut expected_access = expected_level.get_access();
            for region in &p.regions {
                copy_region_to_texture_level(&source_access, &mut expected_access, *region, texel_size);
            }
        }

        // Source buffer.
        let buffer_size = u64::from(p.src_buffer_size) * texel_size as u64;
        let source_info = make_buffer_create_info(buffer_size, vk::BufferUsageFlags::TRANSFER_SRC);
        let source_buffer = unsafe { vk_device.create_buffer(&source_info, None) }.vk_check("vkCreateBuffer")?;
        let source_buffer = Unique::new(vk_device, source_buffer);
        let source_alloc = bind_buffer_memory(self.context, *source_buffer, p.allocation_kind)?;
        unsafe { std::ptr::copy_nonoverlapping(source_level.data().as_ptr(), source_alloc.get_host_ptr(), source_level.data().len()) };
        flush_alloc(vk_device, &source_alloc)?;

        // Destination image.
        let image_info = vk::ImageCreateInfo {
            s_type: vk::StructureType::IMAGE_CREATE_INFO,
            next: std::ptr::null(),
            flags: p.dst.create_flags(),
            image_type: p.dst.image_type,
            format: p.dst.format,
            extent: p.dst.extent_3d(),
            mip_levels: 1,
            array_layers: p.dst.array_size(),
            samples: vk::SampleCountFlags::_1,
            tiling: p.dst.tiling,
            usage: vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST,
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 0,
            queue_family_indices: std::ptr::null(),
            initial_layout: vk::ImageLayout::UNDEFINED,
        };
        let destination = if p.allocation_kind == AllocationKind::Dedicated {
            ImageWithMemory::new_dedicated(vk_device, allocator, image_info, MemoryRequirement::ANY)?
        } else {
            ImageWithMemory::new(vk_device, allocator, image_info, MemoryRequirement::ANY)?
        };

        upload_image(self.context, &destination_level.get_const_access(), destination.get(), &p.dst, p.general_layout, &families)?;

        // The copy under test.
        let cmd_pool = make_command_pool(vk_device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        let layout = if p.general_layout {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::TRANSFER_DST_OPTIMAL
        };
        let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, p.dst.array_size());

        begin_command_buffer(vk_device, *cmd_buffer)?;
        unsafe {
            let barrier = make_image_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::TRANSFER_WRITE, layout, layout, destination.get(), range);
            vk_device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            );

            let copies: Vec<vk::BufferImageCopy> = p.regions.iter().map(|r| r.to_vk()).collect();
            if p.command_variant == CopyCommandVariant::CopyCommands2 {
                let copies2: Vec<vk::BufferImageCopy2> = copies
                    .iter()
                    .map(|c| vk::BufferImageCopy2 {
                        s_type: vk::StructureType::BUFFER_IMAGE_COPY_2,
                        next: std::ptr::null(),
                        buffer_offset: c.buffer_offset,
                        buffer_row_length: c.buffer_row_length,
                        buffer_image_height: c.buffer_image_height,
                        image_subresource: c.image_subresource,
                        image_offset: c.image_offset,
                        image_extent: c.image_extent,
                    })
                    .collect();
                let info = vk::CopyBufferToImageInfo2 {
                    s_type: vk::StructureType::COPY_BUFFER_TO_IMAGE_INFO_2,
                    next: std::ptr::null(),
                    src_buffer: *source_buffer,
                    dst_image: destination.get(),
                    dst_image_layout: layout,
                    region_count: copies2.len() as u32,
                    regions: copies2.as_ptr(),
                };
                vk_device.cmd_copy_buffer_to_image2(*cmd_buffer, &info);
            } else {
                vk_device.cmd_copy_buffer_to_image(*cmd_buffer, *source_buffer, destination.get(), layout, &copies);
            }
        }
        end_command_buffer(vk_device, *cmd_buffer)?;
        submit_commands_and_wait(vk_device, queue, *cmd_buffer)?;

        let mut result_level = TextureLevel::new(texture_format, p.dst.extent[0], p.dst.extent[1], p.dst.extent[2])?;
        read_image(self.context, destination.get(), &p.dst, &mut result_level, p.general_layout, &families)?;

        Ok(check_test_result(&expected_level.get_const_access(), &result_level.get_const_access()))
    }
}

/// `restrictedFormatList` - deliberately short, so the matrix does not explode. The
/// 96-bit format appears twice because some implementations do not support it natively
/// with optimal tiling and take a different path for linear.
static RESTRICTED_FORMAT_LIST: &[(vk::Format, vk::ImageTiling, &str)] = &[
    (vk::Format::R8G8B8A8_UNORM, vk::ImageTiling::OPTIMAL, ""),
    (vk::Format::R8G8B8A8_UINT, vk::ImageTiling::OPTIMAL, "_rgba8_uint"),
    (vk::Format::R32G32B32_SFLOAT, vk::ImageTiling::OPTIMAL, "_rgb32_sfloat"),
    (vk::Format::R32G32B32_SFLOAT, vk::ImageTiling::LINEAR, "_rgb32_sfloat_linear"),
];

/// `VK_REMAINING_ARRAY_LAYERS`
const REMAINING_ARRAY_LAYERS: u32 = u32::MAX;

struct GroupParams {
    allocation_kind: AllocationKind,
    command_variant: CopyCommandVariant,
    queue_selection: QueueSelection,
    general_layout: bool,
}

/// `add1dBufferToImageTests`
fn add_1d_buffer_to_image_tests(group: &mut tcu::TestCaseGroup, gp: &GroupParams) {
    let image_type = vk::ImageType::_1D;

    for &(format, tiling, suffix) in RESTRICTED_FORMAT_LIST {
        let Some(tcu_format) = map_vk_format(format) else { continue };
        let Some(pixel_size) = tcu_format.pixel_size() else { continue };

        let make =
            |name: String, src_buffer_size: u32, src_fill_mode: FillMode, dst_fill_mode: FillMode, extent: [u32; 3], regions: Vec<BufferImageCopy>, needs_maintenance5: bool| {
                Box::new(CopyBufferToImageCase {
                    name,
                    src_buffer_size,
                    src_fill_mode,
                    dst: ImageParms {
                        image_type,
                        format,
                        extent,
                        tiling,
                        fill_mode: dst_fill_mode,
                    },
                    regions,
                    allocation_kind: gp.allocation_kind,
                    command_variant: gp.command_variant,
                    queue_selection: gp.queue_selection,
                    general_layout: gp.general_layout,
                    needs_maintenance5,
                    needs_maintenance11: false,
                }) as Box<dyn TestCase>
            };

        let whole_1d = |buffer_image_height: u32, buffer_offset: u64, base_array_layer: u32, layer_count: u32| BufferImageCopy {
            buffer_offset,
            buffer_row_length: 0,
            buffer_image_height,
            base_array_layer,
            layer_count,
            image_offset: [0, 0, 0],
            image_extent: DEFAULT_1D_EXTENT,
        };

        group.add_child(make(
            format!("tightly_sized_buffer{suffix}"),
            DEFAULT_SIZE,
            FillMode::Gradient,
            FillMode::Gradient,
            DEFAULT_1D_EXTENT,
            vec![whole_1d(0, 0, 0, 1)],
            false,
        ));

        group.add_child(make(
            format!("larger_buffer{suffix}"),
            DEFAULT_SIZE + 1,
            FillMode::Gradient,
            FillMode::Gradient,
            DEFAULT_1D_EXTENT,
            vec![whole_1d(DEFAULT_SIZE + 1, 0, 0, 1)],
            false,
        ));

        {
            let array_layers = 16u32;
            let regions = (0..array_layers).map(|n| whole_1d(0, u64::from(DEFAULT_SIZE * pixel_size * n), n, 1)).collect();
            group.add_child(make(
                format!("array_tightly_sized_buffer{suffix}"),
                DEFAULT_SIZE * array_layers,
                FillMode::Gradient,
                FillMode::Gradient,
                [DEFAULT_SIZE, 1, array_layers],
                regions,
                false,
            ));
        }

        // Both sides are filled red, so the reference stays correct however many layers
        // the driver writes - which is what lets upstream keep the host-side replay of
        // a VK_REMAINING_ARRAY_LAYERS region down to a single layer.
        for (name, base_layer) in [("array_all_remaining_layers", 0u32), ("array_not_all_remaining_layers", 2)] {
            group.add_child(make(
                format!("{name}{suffix}"),
                DEFAULT_SIZE * 16,
                FillMode::Red,
                FillMode::Red,
                [DEFAULT_SIZE, 1, 16],
                vec![whole_1d(0, 0, base_layer, REMAINING_ARRAY_LAYERS)],
                true,
            ));
        }

        {
            let array_layers = 16u32;
            let regions = (0..array_layers)
                .map(|n| whole_1d(DEFAULT_SIZE + 1, u64::from(DEFAULT_SIZE * pixel_size * n), n, 1))
                .collect();
            group.add_child(make(
                format!("array_larger_buffer{suffix}"),
                DEFAULT_SIZE * array_layers,
                FillMode::Gradient,
                FillMode::Gradient,
                [DEFAULT_SIZE, 1, array_layers],
                regions,
                false,
            ));
        }
    }
}

/// `add2dBufferToImageTests`'s format list. Longer than the 1D one: R8_UNORM covers
/// the single-byte texel path and R64_UINT the 64-bit one.
static RESTRICTED_FORMAT_LIST_2D: &[(vk::Format, vk::ImageTiling, &str)] = &[
    (vk::Format::R8G8B8A8_UNORM, vk::ImageTiling::OPTIMAL, ""),
    (vk::Format::R8_UNORM, vk::ImageTiling::OPTIMAL, "_r8_unorm"),
    (vk::Format::R8_UNORM, vk::ImageTiling::LINEAR, "_r8_unorm_linear"),
    (vk::Format::R8G8B8A8_UINT, vk::ImageTiling::OPTIMAL, "_rgba8_uint"),
    (vk::Format::R32G32B32_SFLOAT, vk::ImageTiling::OPTIMAL, "_rgb32_sfloat"),
    (vk::Format::R32G32B32_SFLOAT, vk::ImageTiling::LINEAR, "_rgb32_sfloat_linear"),
    (vk::Format::R64_UINT, vk::ImageTiling::OPTIMAL, "_r64_uint"),
];

/// `add2dBufferToImageTests`
fn add_2d_buffer_to_image_tests(group: &mut tcu::TestCaseGroup, gp: &GroupParams) {
    let image_type = vk::ImageType::_2D;

    for &(format, tiling, suffix) in RESTRICTED_FORMAT_LIST_2D {
        let Some(tcu_format) = map_vk_format(format) else { continue };
        let Some(pixel_size) = tcu_format.pixel_size() else { continue };

        let make = |name: String, src_buffer_size: u32, fill: FillMode, extent: [u32; 3], regions: Vec<BufferImageCopy>, needs_maintenance5: bool, needs_maintenance11: bool| {
            Box::new(CopyBufferToImageCase {
                name,
                src_buffer_size,
                src_fill_mode: fill,
                dst: ImageParms {
                    image_type,
                    format,
                    extent,
                    tiling,
                    fill_mode: fill,
                },
                regions,
                allocation_kind: gp.allocation_kind,
                command_variant: gp.command_variant,
                queue_selection: gp.queue_selection,
                general_layout: gp.general_layout,
                needs_maintenance5,
                needs_maintenance11,
            }) as Box<dyn TestCase>
        };

        let region = |buffer_offset: u64, row_length: u32, image_height: u32, base_layer: u32, layer_count: u32, image_offset: [i32; 3], image_extent: [u32; 3]| BufferImageCopy {
            buffer_offset,
            buffer_row_length: row_length,
            buffer_image_height: image_height,
            base_array_layer: base_layer,
            layer_count,
            image_offset,
            image_extent,
        };

        group.add_child(make(
            format!("whole{suffix}"),
            DEFAULT_SIZE * DEFAULT_SIZE,
            FillMode::Gradient,
            DEFAULT_EXTENT,
            vec![region(0, 0, 0, 0, 1, [0, 0, 0], DEFAULT_EXTENT)],
            false,
            false,
        ));

        {
            let buffer_width = DEFAULT_SIZE + 1;
            let buffer_height = DEFAULT_SIZE + 1;
            group.add_child(make(
                format!("whole_unaligned{suffix}"),
                buffer_width * buffer_height,
                FillMode::Gradient,
                DEFAULT_EXTENT,
                vec![region(0, buffer_width, buffer_height, 0, 1, [0, 0, 0], DEFAULT_EXTENT)],
                false,
                false,
            ));
        }

        {
            // Upstream's loop shrinks each region as it walks right; `divisor` is
            // post-incremented inside the step expression, so the body always sees the
            // value the condition was tested with.
            let mut regions = Vec::new();
            let mut divisor = 1u32;
            let mut offset = 0u32;
            while offset + DEFAULT_QUARTER_SIZE / divisor < DEFAULT_SIZE && DEFAULT_QUARTER_SIZE > divisor {
                let side = DEFAULT_QUARTER_SIZE / divisor;
                regions.push(region(0, 0, 0, 0, 1, [offset as i32, DEFAULT_HALF_SIZE as i32, 0], [side, side, 1]));
                offset += side;
                divisor += 1;
            }
            group.add_child(make(
                format!("regions{suffix}"),
                DEFAULT_SIZE * DEFAULT_SIZE,
                FillMode::Gradient,
                DEFAULT_EXTENT,
                regions,
                false,
                false,
            ));
        }

        {
            let offset = u64::from(round_up(DEFAULT_QUARTER_SIZE, pixel_size));
            let row = DEFAULT_HALF_SIZE + DEFAULT_QUARTER_SIZE;
            group.add_child(make(
                format!("buffer_offset{suffix}"),
                DEFAULT_SIZE * DEFAULT_SIZE,
                FillMode::Gradient,
                DEFAULT_EXTENT,
                vec![region(
                    offset,
                    row,
                    row,
                    0,
                    1,
                    [DEFAULT_QUARTER_SIZE as i32, DEFAULT_QUARTER_SIZE as i32, 0],
                    DEFAULT_HALF_EXTENT,
                )],
                false,
                false,
            ));
        }

        // The relaxed-offset case is not registered for a compute queue upstream, which
        // is the whole of the 115-vs-108 difference between those groups.
        if gp.queue_selection != QueueSelection::ComputeOnly {
            let offset = u64::from(round_up(DEFAULT_QUARTER_SIZE + 1, pixel_size));
            let row = DEFAULT_HALF_SIZE + DEFAULT_QUARTER_SIZE;
            group.add_child(make(
                format!("buffer_offset_relaxed{suffix}"),
                DEFAULT_SIZE * DEFAULT_SIZE,
                FillMode::Gradient,
                DEFAULT_EXTENT,
                vec![region(
                    offset,
                    row,
                    row,
                    0,
                    1,
                    [DEFAULT_QUARTER_SIZE as i32, DEFAULT_QUARTER_SIZE as i32, 0],
                    DEFAULT_HALF_EXTENT,
                )],
                false,
                gp.queue_selection == QueueSelection::TransferOnly,
            ));
        }

        group.add_child(make(
            format!("tightly_sized_buffer{suffix}"),
            (DEFAULT_HALF_SIZE - 1) * DEFAULT_SIZE + DEFAULT_HALF_SIZE,
            FillMode::Gradient,
            DEFAULT_EXTENT,
            vec![region(
                0,
                DEFAULT_SIZE,
                DEFAULT_SIZE,
                0,
                1,
                [DEFAULT_QUARTER_SIZE as i32, DEFAULT_QUARTER_SIZE as i32, 0],
                DEFAULT_HALF_EXTENT,
            )],
            false,
            false,
        ));

        {
            let buffer_image_height = DEFAULT_SIZE + 1;
            group.add_child(make(
                format!("larger_buffer{suffix}"),
                DEFAULT_SIZE * buffer_image_height,
                FillMode::Gradient,
                DEFAULT_EXTENT,
                vec![region(0, DEFAULT_SIZE, buffer_image_height, 0, 1, [0, 0, 0], DEFAULT_HALF_EXTENT)],
                false,
                false,
            ));
        }

        group.add_child(make(
            format!("tightly_sized_buffer_offset{suffix}"),
            (DEFAULT_HALF_SIZE - 1) * DEFAULT_SIZE + DEFAULT_HALF_SIZE + DEFAULT_QUARTER_SIZE,
            FillMode::Gradient,
            DEFAULT_EXTENT,
            vec![region(
                u64::from(DEFAULT_QUARTER_SIZE * pixel_size),
                DEFAULT_SIZE,
                DEFAULT_SIZE,
                0,
                1,
                [DEFAULT_QUARTER_SIZE as i32, DEFAULT_QUARTER_SIZE as i32, 0],
                DEFAULT_HALF_EXTENT,
            )],
            false,
            false,
        ));

        let array_layers = 16u32;
        let array_extent = [DEFAULT_HALF_SIZE, DEFAULT_HALF_SIZE, array_layers];

        {
            let regions = (0..array_layers)
                .map(|n| {
                    region(
                        u64::from(DEFAULT_HALF_SIZE * DEFAULT_HALF_SIZE * pixel_size * n),
                        0,
                        0,
                        n,
                        1,
                        [0, 0, 0],
                        DEFAULT_HALF_EXTENT,
                    )
                })
                .collect();
            group.add_child(make(
                format!("array{suffix}"),
                DEFAULT_HALF_SIZE * DEFAULT_HALF_SIZE * array_layers,
                FillMode::Gradient,
                array_extent,
                regions,
                false,
                false,
            ));
        }

        {
            let buffer_image_height = DEFAULT_HALF_SIZE + 1;
            let regions = (0..array_layers)
                .map(|n| {
                    region(
                        u64::from(DEFAULT_HALF_SIZE * buffer_image_height * pixel_size * n),
                        DEFAULT_HALF_SIZE,
                        buffer_image_height,
                        n,
                        1,
                        [0, 0, 0],
                        DEFAULT_HALF_EXTENT,
                    )
                })
                .collect();
            group.add_child(make(
                format!("array_larger_buffer{suffix}"),
                DEFAULT_HALF_SIZE * buffer_image_height * array_layers,
                FillMode::Gradient,
                array_extent,
                regions,
                false,
                false,
            ));
        }

        {
            let regions = (0..array_layers)
                .map(|n| {
                    region(
                        u64::from(DEFAULT_HALF_SIZE * DEFAULT_HALF_SIZE * pixel_size * n),
                        DEFAULT_HALF_SIZE,
                        DEFAULT_HALF_SIZE,
                        n,
                        1,
                        [0, 0, 0],
                        DEFAULT_HALF_EXTENT,
                    )
                })
                .collect();
            group.add_child(make(
                format!("array_tightly_sized_buffer{suffix}"),
                DEFAULT_HALF_SIZE * DEFAULT_HALF_SIZE * array_layers,
                FillMode::Gradient,
                array_extent,
                regions,
                false,
                false,
            ));
        }

        for (name, base_layer) in [("array_all_remaining_layers", 0u32), ("array_not_all_remaining_layers", 2)] {
            group.add_child(make(
                format!("{name}{suffix}"),
                DEFAULT_HALF_SIZE * DEFAULT_HALF_SIZE * array_layers,
                FillMode::Red,
                array_extent,
                vec![region(0, 0, 0, base_layer, REMAINING_ARRAY_LAYERS, [0, 0, 0], DEFAULT_HALF_EXTENT)],
                true,
                false,
            ));
        }
    }
}

/// `addCopyBufferToImageTests`
fn add_copy_buffer_to_image_tests(group: &mut tcu::TestCaseGroup, gp: &GroupParams) {
    let mut images_1d = tcu::TestCaseGroup::new("1d_images");
    add_1d_buffer_to_image_tests(&mut images_1d, gp);
    group.add_child(images_1d);
    let mut images_2d = tcu::TestCaseGroup::new("2d_images");
    add_2d_buffer_to_image_tests(&mut images_2d, gp);
    group.add_child(images_2d);
    // 3d_images is not ported yet.
}

/// The `buffer_to_image*` groups of `createCopiesAndBlittingTests`.
pub fn add_buffer_to_image_groups(
    parent: &mut tcu::TestCaseGroup,
    name: &str,
    allocation_kind: AllocationKind,
    command_variant: CopyCommandVariant,
    queue_selection: QueueSelection,
    general_layout: bool,
) {
    let mut group = tcu::TestCaseGroup::new(name);
    add_copy_buffer_to_image_tests(
        &mut group,
        &GroupParams {
            allocation_kind,
            command_variant,
            queue_selection,
            general_layout,
        },
    );
    parent.add_child(group);
}

// ---------------------------------------------------------------------------------
// CopyImageToBuffer - the same machinery with source and destination swapped.
// ---------------------------------------------------------------------------------

/// `CopyImageToBuffer::copyRegionToTextureLevel`
fn copy_region_to_buffer_level(src: &ConstPixelBufferAccess<'_>, dst: &mut PixelBufferAccess<'_>, region: BufferImageCopy, texel_size: usize) {
    let row_length = if region.buffer_row_length == 0 {
        region.image_extent[0]
    } else {
        region.buffer_row_length
    };
    let image_height = if region.buffer_image_height == 0 {
        region.image_extent[1]
    } else {
        region.buffer_image_height
    };

    let texel_offset = (region.buffer_offset / texel_size as u64) as u32;

    for z in 0..region.image_extent[2] {
        for y in 0..region.image_extent[1] {
            let texel_index = texel_offset + (z * image_height + y) * row_length;
            let src_z = (region.image_offset[2] as u32) + z + region.base_array_layer;
            let src_y = (region.image_offset[1] as u32) + y;
            let src_x = region.image_offset[0] as u32;
            dst.copy_texels_from_position(src, (src_x, src_y, src_z), texel_index as usize, region.image_extent[0] as usize);
        }
    }
}

/// `CopyImageToBufferTestCase`
pub struct CopyImageToBufferCase {
    name: String,
    src: ImageParms,
    dst_buffer_size: u32,
    dst_fill_mode: FillMode,
    regions: Vec<BufferImageCopy>,
    allocation_kind: AllocationKind,
    command_variant: CopyCommandVariant,
    queue_selection: QueueSelection,
    general_layout: bool,
    needs_maintenance5: bool,
    needs_maintenance11: bool,
}

impl TestCase for CopyImageToBufferCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.command_variant == CopyCommandVariant::CopyCommands2 {
            context.require_device_functionality("VK_KHR_copy_commands2")?;
        }
        if self.allocation_kind == AllocationKind::Dedicated {
            context.require_device_functionality("VK_KHR_dedicated_allocation")?;
        }
        if self.needs_maintenance5 {
            context.require_device_functionality("VK_KHR_maintenance5")?;
        }
        if self.needs_maintenance11 {
            context.require_device_functionality("VK_KHR_maintenance11")?;
        }
        select_queue(context, self.queue_selection)?;

        let usage = vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
        let properties = unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                self.src.format,
                self.src.image_type,
                self.src.tiling,
                usage,
                self.src.create_flags(),
            )
        }
        .map_err(|_| TestError::NotSupported("Format does not support the required parameters".to_string()))?;

        if properties.max_array_layers < self.src.array_size() {
            return Err(TestError::NotSupported("maxArrayLayers too small".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CopyImageToBufferInstance { context, params: self })
    }
}

struct CopyImageToBufferInstance<'a> {
    context: &'a Context<'a>,
    params: &'a CopyImageToBufferCase,
}

impl TestInstance for CopyImageToBufferInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let p = self.params;
        let vk_device = self.context.get_device();
        let allocator = self.context.get_default_allocator();

        let (queue, queue_family_index) = select_queue(self.context, p.queue_selection)?;
        let mut families = vec![self.context.get_universal_queue_family_index()];
        if queue_family_index != families[0] {
            families.push(queue_family_index);
        }

        let texture_format = map_vk_format(p.src.format).ok_or_else(|| TestError::NotSupported("format has no tcu mapping".to_string()))?;
        let texel_size = texture_format.pixel_size().ok_or_else(|| TestError::NotSupported("format has no pixel size".to_string()))? as usize;

        let mut source_level = TextureLevel::new(texture_format, p.src.extent[0], p.src.extent[1], p.src.extent[2])?;
        generate_buffer(&mut source_level.get_access(), p.src.extent[0], p.src.extent[1], p.src.extent[2], p.src.fill_mode);

        let mut destination_level = TextureLevel::new(texture_format, p.dst_buffer_size, 1, 1)?;
        generate_buffer(&mut destination_level.get_access(), p.dst_buffer_size, 1, 1, p.dst_fill_mode);

        let mut expected_level = TextureLevel::new(texture_format, p.dst_buffer_size, 1, 1)?;
        expected_level.data_mut().copy_from_slice(destination_level.data());
        {
            let source_access = source_level.get_const_access();
            let mut expected_access = expected_level.get_access();
            for region in &p.regions {
                copy_region_to_buffer_level(&source_access, &mut expected_access, *region, texel_size);
            }
        }

        // Source image.
        let image_info = vk::ImageCreateInfo {
            s_type: vk::StructureType::IMAGE_CREATE_INFO,
            next: std::ptr::null(),
            flags: p.src.create_flags(),
            image_type: p.src.image_type,
            format: p.src.format,
            extent: p.src.extent_3d(),
            mip_levels: 1,
            array_layers: p.src.array_size(),
            samples: vk::SampleCountFlags::_1,
            tiling: p.src.tiling,
            usage: vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST,
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 0,
            queue_family_indices: std::ptr::null(),
            initial_layout: vk::ImageLayout::UNDEFINED,
        };
        let source = if p.allocation_kind == AllocationKind::Dedicated {
            ImageWithMemory::new_dedicated(vk_device, allocator, image_info, MemoryRequirement::ANY)?
        } else {
            ImageWithMemory::new(vk_device, allocator, image_info, MemoryRequirement::ANY)?
        };

        // Destination buffer, pre-filled so a region the copy must not touch is checked.
        let buffer_bytes = u64::from(p.dst_buffer_size) * texel_size as u64;
        let dst_info = staging_buffer_create_info(buffer_bytes, vk::BufferUsageFlags::TRANSFER_DST, &families);
        let destination = unsafe { vk_device.create_buffer(&dst_info, None) }.vk_check("vkCreateBuffer")?;
        let destination = Unique::new(vk_device, destination);
        let destination_alloc = bind_buffer_memory(self.context, *destination, p.allocation_kind)?;
        unsafe { std::ptr::copy_nonoverlapping(destination_level.data().as_ptr(), destination_alloc.get_host_ptr(), destination_level.data().len()) };
        flush_alloc(vk_device, &destination_alloc)?;

        upload_image(self.context, &source_level.get_const_access(), source.get(), &p.src, p.general_layout, &families)?;

        let cmd_pool = make_command_pool(vk_device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        let layout = if p.general_layout {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL
        };
        let old_layout = if p.general_layout {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::TRANSFER_DST_OPTIMAL
        };
        let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, p.src.array_size());

        begin_command_buffer(vk_device, *cmd_buffer)?;
        unsafe {
            let barrier = make_image_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::TRANSFER_READ, old_layout, layout, source.get(), range);
            vk_device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            );

            let copies: Vec<vk::BufferImageCopy> = p.regions.iter().map(|r| r.to_vk()).collect();
            if p.command_variant == CopyCommandVariant::CopyCommands2 {
                let copies2: Vec<vk::BufferImageCopy2> = copies
                    .iter()
                    .map(|c| vk::BufferImageCopy2 {
                        s_type: vk::StructureType::BUFFER_IMAGE_COPY_2,
                        next: std::ptr::null(),
                        buffer_offset: c.buffer_offset,
                        buffer_row_length: c.buffer_row_length,
                        buffer_image_height: c.buffer_image_height,
                        image_subresource: c.image_subresource,
                        image_offset: c.image_offset,
                        image_extent: c.image_extent,
                    })
                    .collect();
                let info = vk::CopyImageToBufferInfo2 {
                    s_type: vk::StructureType::COPY_IMAGE_TO_BUFFER_INFO_2,
                    next: std::ptr::null(),
                    src_image: source.get(),
                    src_image_layout: layout,
                    dst_buffer: *destination,
                    region_count: copies2.len() as u32,
                    regions: copies2.as_ptr(),
                };
                vk_device.cmd_copy_image_to_buffer2(*cmd_buffer, &info);
            } else {
                vk_device.cmd_copy_image_to_buffer(*cmd_buffer, source.get(), layout, *destination, &copies);
            }
        }
        end_command_buffer(vk_device, *cmd_buffer)?;
        submit_commands_and_wait(vk_device, queue, *cmd_buffer)?;

        invalidate_alloc(vk_device, &destination_alloc)?;
        // Copied out of the mapping in one go; scattered reads through host-visible
        // device memory cost an order of magnitude more.
        let result = unsafe { std::slice::from_raw_parts(destination_alloc.get_host_ptr().cast_const(), destination_level.data().len()) }.to_vec();
        let result_access = ConstPixelBufferAccess::new(texture_format, [p.dst_buffer_size, 1, 1], &result);

        Ok(check_test_result(&expected_level.get_const_access(), &result_access))
    }
}

/// `add2dImageToBufferTests`' format list, crossed with both tilings.
static IMAGE_TO_BUFFER_FORMATS_2D: &[vk::Format] = &[vk::Format::R8G8B8A8_UNORM, vk::Format::R8_UNORM, vk::Format::R32G32B32_UINT, vk::Format::R32G32B32_SFLOAT];

/// `getFormatCaseName` for the formats above - the enum name lowercased, minus the
/// VK_FORMAT_ prefix.
fn image_to_buffer_format_name(format: vk::Format) -> &'static str {
    match format {
        vk::Format::R8_UNORM => "r8_unorm",
        vk::Format::R32G32B32_UINT => "r32g32b32_uint",
        vk::Format::R32G32B32_SFLOAT => "r32g32b32_sfloat",
        _ => "r8g8b8a8_unorm",
    }
}

/// `add1dImageToBufferTests`, minus the compressed mip_copies cases.
fn add_1d_image_to_buffer_tests(group: &mut tcu::TestCaseGroup, gp: &GroupParams) {
    let format = vk::Format::R8G8B8A8_UNORM;
    let Some(tcu_format) = map_vk_format(format) else { return };
    let Some(pixel_size) = tcu_format.pixel_size() else { return };

    let make = |name: &str, extent: [u32; 3], fill: FillMode, dst_buffer_size: u32, regions: Vec<BufferImageCopy>, needs_maintenance5: bool| {
        Box::new(CopyImageToBufferCase {
            name: name.to_string(),
            src: ImageParms {
                image_type: vk::ImageType::_1D,
                format,
                extent,
                tiling: vk::ImageTiling::OPTIMAL,
                fill_mode: fill,
            },
            dst_buffer_size,
            dst_fill_mode: fill,
            regions,
            allocation_kind: gp.allocation_kind,
            command_variant: gp.command_variant,
            queue_selection: gp.queue_selection,
            general_layout: gp.general_layout,
            needs_maintenance5,
            needs_maintenance11: false,
        }) as Box<dyn TestCase>
    };

    let region = |buffer_offset: u64, image_height: u32, base_layer: u32, layer_count: u32| BufferImageCopy {
        buffer_offset,
        buffer_row_length: 0,
        buffer_image_height: image_height,
        base_array_layer: base_layer,
        layer_count,
        image_offset: [0, 0, 0],
        image_extent: DEFAULT_1D_EXTENT,
    };

    group.add_child(make(
        "tightly_sized_buffer",
        DEFAULT_1D_EXTENT,
        FillMode::Gradient,
        DEFAULT_SIZE,
        vec![region(0, 0, 0, 1)],
        false,
    ));

    let larger = DEFAULT_SIZE + 1;
    group.add_child(make("larger_buffer", DEFAULT_1D_EXTENT, FillMode::Gradient, larger, vec![region(0, larger, 0, 1)], false));

    let array_layers = 16u32;
    let array_extent = [DEFAULT_SIZE, 1, array_layers];

    group.add_child(make(
        "array_tightly_sized_buffer",
        array_extent,
        FillMode::Gradient,
        DEFAULT_SIZE * array_layers,
        (0..array_layers).map(|n| region(u64::from(DEFAULT_SIZE * pixel_size * n), DEFAULT_SIZE, n, 1)).collect(),
        false,
    ));

    group.add_child(make(
        "array_larger_buffer",
        array_extent,
        FillMode::Gradient,
        larger * array_layers,
        (0..array_layers).map(|n| region(u64::from(larger * pixel_size * n), larger, n, 1)).collect(),
        false,
    ));

    for (name, base_layer) in [("array_all_remaining_layers", 0u32), ("array_not_all_remaining_layers", 2)] {
        group.add_child(make(
            name,
            array_extent,
            FillMode::Red,
            DEFAULT_SIZE * array_layers,
            vec![region(0, 0, base_layer, REMAINING_ARRAY_LAYERS)],
            true,
        ));
    }
}

/// `add2dImageToBufferTests`, minus the compressed mip_copies cases and `padding_bytes`
/// (which needs FILL_MODE_RANDOM_GRAY).
fn add_2d_image_to_buffer_tests(group: &mut tcu::TestCaseGroup, gp: &GroupParams) {
    for &format in IMAGE_TO_BUFFER_FORMATS_2D {
        for tiling in [vk::ImageTiling::OPTIMAL, vk::ImageTiling::LINEAR] {
            let Some(tcu_format) = map_vk_format(format) else { continue };
            let Some(pixel_size) = tcu_format.pixel_size() else { continue };

            let suffix = format!(
                "{}{}",
                if format == vk::Format::R8G8B8A8_UNORM {
                    String::new()
                } else {
                    format!("_{}", image_to_buffer_format_name(format))
                },
                if tiling == vk::ImageTiling::LINEAR { "_linear" } else { "" }
            );

            let make =
                |name: String, extent: [u32; 3], fill: FillMode, dst_buffer_size: u32, regions: Vec<BufferImageCopy>, needs_maintenance5: bool, needs_maintenance11: bool| {
                    Box::new(CopyImageToBufferCase {
                        name,
                        src: ImageParms {
                            image_type: vk::ImageType::_2D,
                            format,
                            extent,
                            tiling,
                            fill_mode: fill,
                        },
                        dst_buffer_size,
                        dst_fill_mode: fill,
                        regions,
                        allocation_kind: gp.allocation_kind,
                        command_variant: gp.command_variant,
                        queue_selection: gp.queue_selection,
                        general_layout: gp.general_layout,
                        needs_maintenance5,
                        needs_maintenance11,
                    }) as Box<dyn TestCase>
                };

            let region =
                |buffer_offset: u64, row_length: u32, image_height: u32, base_layer: u32, layer_count: u32, image_offset: [i32; 3], image_extent: [u32; 3]| BufferImageCopy {
                    buffer_offset,
                    buffer_row_length: row_length,
                    buffer_image_height: image_height,
                    base_array_layer: base_layer,
                    layer_count,
                    image_offset,
                    image_extent,
                };

            group.add_child(make(
                format!("whole{suffix}"),
                DEFAULT_EXTENT,
                FillMode::Gradient,
                DEFAULT_SIZE * DEFAULT_SIZE,
                vec![region(0, 0, 0, 0, 1, [0, 0, 0], DEFAULT_EXTENT)],
                false,
                false,
            ));

            {
                let bw = DEFAULT_SIZE + 1;
                let bh = DEFAULT_SIZE + 1;
                group.add_child(make(
                    format!("whole_unaligned{suffix}"),
                    DEFAULT_EXTENT,
                    FillMode::Gradient,
                    bw * bh,
                    vec![region(0, bw, bh, 0, 1, [0, 0, 0], DEFAULT_EXTENT)],
                    false,
                    false,
                ));
            }

            {
                let offset = u64::from(round_up(DEFAULT_SIZE * DEFAULT_HALF_SIZE, pixel_size));
                group.add_child(make(
                    format!("buffer_offset{suffix}"),
                    DEFAULT_EXTENT,
                    FillMode::Gradient,
                    DEFAULT_SIZE * DEFAULT_SIZE,
                    vec![region(
                        offset,
                        0,
                        0,
                        0,
                        1,
                        [DEFAULT_QUARTER_SIZE as i32, DEFAULT_QUARTER_SIZE as i32, 0],
                        DEFAULT_HALF_EXTENT,
                    )],
                    false,
                    false,
                ));
            }

            if gp.queue_selection != QueueSelection::ComputeOnly {
                let offset = u64::from(round_up(DEFAULT_SIZE * DEFAULT_HALF_SIZE + 1, pixel_size));
                group.add_child(make(
                    format!("buffer_offset_relaxed{suffix}"),
                    DEFAULT_EXTENT,
                    FillMode::Gradient,
                    DEFAULT_SIZE * DEFAULT_SIZE,
                    vec![region(
                        offset,
                        0,
                        0,
                        0,
                        1,
                        [DEFAULT_QUARTER_SIZE as i32, DEFAULT_QUARTER_SIZE as i32, 0],
                        DEFAULT_HALF_EXTENT,
                    )],
                    false,
                    gp.queue_selection == QueueSelection::TransferOnly,
                ));
            }

            {
                // The buffer offset walks forward in fixed steps while the copied width
                // shrinks; the divisor advances once per step, so the body sees 1, 2, 3...
                let buffer_size = u64::from(pixel_size) * u64::from(DEFAULT_SIZE * DEFAULT_SIZE);
                let offset_size = u64::from(pixel_size) * u64::from(DEFAULT_QUARTER_SIZE * DEFAULT_QUARTER_SIZE);
                let mut regions = Vec::new();
                let mut divisor = 1u32;
                let mut offset = 0u64;
                while offset < buffer_size - offset_size {
                    regions.push(region(
                        offset,
                        DEFAULT_QUARTER_SIZE,
                        DEFAULT_QUARTER_SIZE,
                        0,
                        1,
                        [0, 0, 0],
                        [DEFAULT_QUARTER_SIZE / divisor, DEFAULT_QUARTER_SIZE, 1],
                    ));
                    offset += offset_size;
                    divisor += 1;
                }
                group.add_child(make(
                    format!("regions{suffix}"),
                    DEFAULT_EXTENT,
                    FillMode::Gradient,
                    DEFAULT_SIZE * DEFAULT_SIZE,
                    regions,
                    false,
                    false,
                ));
            }

            group.add_child(make(
                format!("tightly_sized_buffer{suffix}"),
                DEFAULT_EXTENT,
                FillMode::Gradient,
                (DEFAULT_HALF_SIZE - 1) * DEFAULT_SIZE + DEFAULT_HALF_SIZE,
                vec![region(
                    0,
                    DEFAULT_SIZE,
                    DEFAULT_SIZE,
                    0,
                    1,
                    [DEFAULT_QUARTER_SIZE as i32, DEFAULT_QUARTER_SIZE as i32, 0],
                    DEFAULT_HALF_EXTENT,
                )],
                false,
                false,
            ));

            {
                let bh = DEFAULT_SIZE + 1;
                group.add_child(make(
                    format!("larger_buffer{suffix}"),
                    DEFAULT_EXTENT,
                    FillMode::Gradient,
                    bh * DEFAULT_SIZE,
                    vec![region(0, DEFAULT_SIZE, bh, 0, 1, [0, 0, 0], DEFAULT_EXTENT)],
                    false,
                    false,
                ));
            }

            {
                // Here the offset is a texel count as well as a byte offset: upstream adds
                // it to `dst.buffer.size`, which is measured in texels.
                let offset = round_up(DEFAULT_QUARTER_SIZE, pixel_size);
                group.add_child(make(
                    format!("tightly_sized_buffer_offset{suffix}"),
                    DEFAULT_EXTENT,
                    FillMode::Gradient,
                    (DEFAULT_HALF_SIZE - 1) * DEFAULT_SIZE + DEFAULT_HALF_SIZE + offset,
                    vec![region(
                        u64::from(offset),
                        DEFAULT_SIZE,
                        DEFAULT_SIZE,
                        0,
                        1,
                        [DEFAULT_QUARTER_SIZE as i32, DEFAULT_QUARTER_SIZE as i32, 0],
                        DEFAULT_HALF_EXTENT,
                    )],
                    false,
                    false,
                ));
            }

            let array_layers = 16u32;
            let array_extent = [DEFAULT_HALF_SIZE, DEFAULT_HALF_SIZE, array_layers];

            group.add_child(make(
                format!("array{suffix}"),
                array_extent,
                FillMode::Gradient,
                DEFAULT_HALF_SIZE * DEFAULT_HALF_SIZE * array_layers,
                (0..array_layers)
                    .map(|n| {
                        region(
                            u64::from(DEFAULT_HALF_SIZE * DEFAULT_HALF_SIZE * pixel_size * n),
                            0,
                            0,
                            n,
                            1,
                            [0, 0, 0],
                            DEFAULT_HALF_EXTENT,
                        )
                    })
                    .collect(),
                false,
                false,
            ));

            {
                let bh = DEFAULT_HALF_SIZE + 1;
                group.add_child(make(
                    format!("array_larger_buffer{suffix}"),
                    array_extent,
                    FillMode::Gradient,
                    DEFAULT_HALF_SIZE * bh * array_layers,
                    (0..array_layers)
                        .map(|n| {
                            region(
                                u64::from(DEFAULT_HALF_SIZE * bh * pixel_size * n),
                                DEFAULT_HALF_SIZE,
                                bh,
                                n,
                                1,
                                [0, 0, 0],
                                DEFAULT_HALF_EXTENT,
                            )
                        })
                        .collect(),
                    false,
                    false,
                ));
            }

            group.add_child(make(
                format!("array_tightly_sized_buffer{suffix}"),
                array_extent,
                FillMode::Gradient,
                DEFAULT_HALF_SIZE * DEFAULT_HALF_SIZE * array_layers,
                (0..array_layers)
                    .map(|n| {
                        region(
                            u64::from(DEFAULT_HALF_SIZE * DEFAULT_HALF_SIZE * pixel_size * n),
                            DEFAULT_HALF_SIZE,
                            DEFAULT_HALF_SIZE,
                            n,
                            1,
                            [0, 0, 0],
                            DEFAULT_HALF_EXTENT,
                        )
                    })
                    .collect(),
                false,
                false,
            ));

            for (name, base_layer) in [("array_all_remaining_layers", 0u32), ("array_not_all_remaining_layers", 2)] {
                group.add_child(make(
                    format!("{name}{suffix}"),
                    array_extent,
                    FillMode::Red,
                    DEFAULT_HALF_SIZE * DEFAULT_HALF_SIZE * array_layers,
                    vec![region(0, 0, 0, base_layer, REMAINING_ARRAY_LAYERS, [0, 0, 0], DEFAULT_HALF_EXTENT)],
                    true,
                    false,
                ));
            }

            // `padding_bytes` is not registered: it fills the destination with
            // FILL_MODE_RANDOM_GRAY, which is not ported yet.
        }
    }
}

/// The `image_to_buffer*` groups of `createCopiesAndBlittingTests`.
pub fn add_image_to_buffer_groups(
    parent: &mut tcu::TestCaseGroup,
    name: &str,
    allocation_kind: AllocationKind,
    command_variant: CopyCommandVariant,
    queue_selection: QueueSelection,
    general_layout: bool,
) {
    let gp = GroupParams {
        allocation_kind,
        command_variant,
        queue_selection,
        general_layout,
    };
    let mut group = tcu::TestCaseGroup::new(name);
    let mut images_1d = tcu::TestCaseGroup::new("1d_images");
    add_1d_image_to_buffer_tests(&mut images_1d, &gp);
    group.add_child(images_1d);
    let mut images_2d = tcu::TestCaseGroup::new("2d_images");
    add_2d_image_to_buffer_tests(&mut images_2d, &gp);
    group.add_child(images_2d);
    // 3d_images is entirely compressed mip_copies upstream, so nothing is registered.
    parent.add_child(group);
}

// ---------------------------------------------------------------------------------
// CopyImageToImage
// ---------------------------------------------------------------------------------

/// `CopyRegion::imageCopy`
#[derive(Clone, Copy)]
pub struct ImageCopy {
    pub src_offset: [i32; 3],
    pub dst_offset: [i32; 3],
    pub extent: [u32; 3],
    pub aspect_mask: vk::ImageAspectFlags,
    pub src_base_layer: u32,
    pub src_layer_count: u32,
    pub dst_base_layer: u32,
    pub dst_layer_count: u32,
}

impl ImageCopy {
    /// The offsets and extent as `copyRegionToTextureLevel` adjusts them.
    ///
    /// A 2D array layer and a 3D slice are the same axis in the host reference, so when
    /// one side addresses a layer through the subresource and the other through the z
    /// offset, upstream aligns them by copying the addressed side's z onto the other.
    fn adjusted(self) -> ([i32; 3], [i32; 3], [u32; 3]) {
        let (mut src_offset, mut dst_offset, mut extent) = (self.src_offset, self.dst_offset, self.extent);
        if self.dst_base_layer > self.src_base_layer {
            dst_offset[2] = src_offset[2];
            extent[2] = extent[2].max(self.src_layer_count);
        }
        if self.dst_base_layer < self.src_base_layer {
            src_offset[2] = dst_offset[2];
            extent[2] = extent[2].max(self.src_layer_count);
        }
        (src_offset, dst_offset, extent)
    }

    fn to_vk(self) -> vk::ImageCopy {
        let layers = vk::ImageSubresourceLayers {
            aspect_mask: self.aspect_mask,
            mip_level: 0,
            base_array_layer: self.src_base_layer,
            layer_count: self.src_layer_count,
        };
        vk::ImageCopy {
            src_subresource: layers,
            src_offset: vk::Offset3D {
                x: self.src_offset[0],
                y: self.src_offset[1],
                z: self.src_offset[2],
            },
            dst_subresource: vk::ImageSubresourceLayers {
                aspect_mask: self.aspect_mask,
                mip_level: 0,
                base_array_layer: self.dst_base_layer,
                layer_count: self.dst_layer_count,
            },
            dst_offset: vk::Offset3D {
                x: self.dst_offset[0],
                y: self.dst_offset[1],
                z: self.dst_offset[2],
            },
            extent: vk::Extent3D {
                width: self.extent[0],
                height: self.extent[1],
                depth: self.extent[2],
            },
        }
    }
}

/// `CopyImageToImageTestCase`
pub struct CopyImageToImageCase {
    name: String,
    src: ImageParms,
    dst: ImageParms,
    regions: Vec<ImageCopy>,
    /// `TestParams::clearDestinationWithRed` - the destination is cleared to opaque red
    /// on the device and filled red on the host, so a copy that writes outside its
    /// region is caught against a known background rather than a gradient.
    clear_destination_with_red: bool,
    allocation_kind: AllocationKind,
    command_variant: CopyCommandVariant,
    queue_selection: QueueSelection,
    general_layout: bool,
}

impl TestCase for CopyImageToImageCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.command_variant == CopyCommandVariant::CopyCommands2 {
            context.require_device_functionality("VK_KHR_copy_commands2")?;
        }
        if self.allocation_kind == AllocationKind::Dedicated {
            context.require_device_functionality("VK_KHR_dedicated_allocation")?;
        }
        select_queue(context, self.queue_selection)?;

        let usage = vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
        for parms in [&self.src, &self.dst] {
            let props = unsafe {
                context.get_instance().get_physical_device_image_format_properties(
                    context.get_physical_device(),
                    parms.format,
                    parms.image_type,
                    parms.tiling,
                    usage,
                    parms.create_flags(),
                )
            }
            .map_err(|_| TestError::NotSupported("Format does not support the required parameters".to_string()))?;

            if props.max_array_layers < parms.array_size() {
                return Err(TestError::NotSupported("maxArrayLayers too small".to_string()));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CopyImageToImageInstance { context, params: self })
    }
}

struct CopyImageToImageInstance<'a> {
    context: &'a Context<'a>,
    params: &'a CopyImageToImageCase,
}

impl CopyImageToImageInstance<'_> {
    fn make_image(&self, parms: &ImageParms) -> Result<ImageWithMemory<'_>, TestError> {
        let vk_device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let info = vk::ImageCreateInfo {
            s_type: vk::StructureType::IMAGE_CREATE_INFO,
            next: std::ptr::null(),
            flags: parms.create_flags(),
            image_type: parms.image_type,
            format: parms.format,
            extent: parms.extent_3d(),
            mip_levels: 1,
            array_layers: parms.array_size(),
            samples: vk::SampleCountFlags::_1,
            tiling: parms.tiling,
            usage: vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST,
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 0,
            queue_family_indices: std::ptr::null(),
            initial_layout: vk::ImageLayout::UNDEFINED,
        };
        if self.params.allocation_kind == AllocationKind::Dedicated {
            ImageWithMemory::new_dedicated(vk_device, allocator, info, MemoryRequirement::ANY)
        } else {
            ImageWithMemory::new(vk_device, allocator, info, MemoryRequirement::ANY)
        }
    }
}

impl TestInstance for CopyImageToImageInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let p = self.params;
        let vk_device = self.context.get_device();

        let (queue, queue_family_index) = select_queue(self.context, p.queue_selection)?;
        let mut families = vec![self.context.get_universal_queue_family_index()];
        if queue_family_index != families[0] {
            families.push(queue_family_index);
        }

        let src_format = map_vk_format(p.src.format).ok_or_else(|| TestError::NotSupported("format has no tcu mapping".to_string()))?;
        let dst_format = map_vk_format(p.dst.format).ok_or_else(|| TestError::NotSupported("format has no tcu mapping".to_string()))?;

        let mut source_level = TextureLevel::new(src_format, p.src.extent[0], p.src.extent[1], p.src.extent[2])?;
        generate_buffer(&mut source_level.get_access(), p.src.extent[0], p.src.extent[1], p.src.extent[2], p.src.fill_mode);

        let dst_fill = if p.clear_destination_with_red { FillMode::Red } else { p.dst.fill_mode };
        let mut destination_level = TextureLevel::new(dst_format, p.dst.extent[0], p.dst.extent[1], p.dst.extent[2])?;
        generate_buffer(&mut destination_level.get_access(), p.dst.extent[0], p.dst.extent[1], p.dst.extent[2], dst_fill);

        // `generateExpectedResult`. The copy is a memcpy even across formats, so the
        // expected level is viewed in the *source* format while the region lands.
        let mut expected_level = TextureLevel::new(src_format, p.dst.extent[0], p.dst.extent[1], p.dst.extent[2])?;
        expected_level.data_mut().copy_from_slice(destination_level.data());
        {
            let source_access = source_level.get_const_access();
            let mut expected_access = expected_level.get_access();
            for r in &p.regions {
                let (src_offset, dst_offset, extent) = r.adjusted();
                expected_access.copy_region_from(
                    &source_access,
                    (src_offset[0] as u32, src_offset[1] as u32, src_offset[2] as u32),
                    (dst_offset[0] as u32, dst_offset[1] as u32, dst_offset[2] as u32),
                    (extent[0], extent[1], extent[2]),
                );
            }
        }

        let source = self.make_image(&p.src)?;
        let destination = self.make_image(&p.dst)?;

        upload_image(self.context, &source_level.get_const_access(), source.get(), &p.src, p.general_layout, &families)?;
        upload_image(self.context, &destination_level.get_const_access(), destination.get(), &p.dst, p.general_layout, &families)?;

        let cmd_pool = make_command_pool(vk_device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        let src_layout = if p.general_layout {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL
        };
        let dst_layout = if p.general_layout {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::TRANSFER_DST_OPTIMAL
        };
        let uploaded = if p.general_layout {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::TRANSFER_DST_OPTIMAL
        };
        let src_range = make_image_subresource_range(get_aspect_flags(p.src.format), 0, 1, 0, p.src.array_size());
        let dst_range = make_image_subresource_range(get_aspect_flags(p.dst.format), 0, 1, 0, p.dst.array_size());

        begin_command_buffer(vk_device, *cmd_buffer)?;
        unsafe {
            let barriers = [
                make_image_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::TRANSFER_READ,
                    uploaded,
                    src_layout,
                    source.get(),
                    src_range,
                ),
                make_image_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::TRANSFER_WRITE,
                    uploaded,
                    dst_layout,
                    destination.get(),
                    dst_range,
                ),
            ];
            vk_device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &barriers,
            );

            if p.clear_destination_with_red {
                let clear = vk::ClearColorValue { float32: [1.0, 0.0, 0.0, 1.0] };
                let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
                vk_device.cmd_clear_color_image(*cmd_buffer, destination.get(), dst_layout, &clear, &[range]);

                let after_clear = make_image_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::TRANSFER_WRITE,
                    dst_layout,
                    dst_layout,
                    destination.get(),
                    dst_range,
                );
                vk_device.cmd_pipeline_barrier(
                    *cmd_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[after_clear],
                );
            }

            let copies: Vec<vk::ImageCopy> = p.regions.iter().map(|r| r.to_vk()).collect();
            if p.command_variant == CopyCommandVariant::CopyCommands2 {
                let copies2: Vec<vk::ImageCopy2> = copies
                    .iter()
                    .map(|c| vk::ImageCopy2 {
                        s_type: vk::StructureType::IMAGE_COPY_2,
                        next: std::ptr::null(),
                        src_subresource: c.src_subresource,
                        src_offset: c.src_offset,
                        dst_subresource: c.dst_subresource,
                        dst_offset: c.dst_offset,
                        extent: c.extent,
                    })
                    .collect();
                let info = vk::CopyImageInfo2 {
                    s_type: vk::StructureType::COPY_IMAGE_INFO_2,
                    next: std::ptr::null(),
                    src_image: source.get(),
                    src_image_layout: src_layout,
                    dst_image: destination.get(),
                    dst_image_layout: dst_layout,
                    region_count: copies2.len() as u32,
                    regions: copies2.as_ptr(),
                };
                vk_device.cmd_copy_image2(*cmd_buffer, &info);
            } else {
                vk_device.cmd_copy_image(*cmd_buffer, source.get(), src_layout, destination.get(), dst_layout, &copies);
            }
        }
        end_command_buffer(vk_device, *cmd_buffer)?;
        submit_commands_and_wait(vk_device, queue, *cmd_buffer)?;

        // Read back in the destination's own format, then compare the raw bytes -
        // upstream's bitwiseCompare, which is what makes a cross-format copy checkable.
        let mut result_level = TextureLevel::new(dst_format, p.dst.extent[0], p.dst.extent[1], p.dst.extent[2])?;
        read_image(self.context, destination.get(), &p.dst, &mut result_level, p.general_layout, &families)?;

        Ok(check_test_result(&expected_level.get_const_access(), &result_level.get_const_access()))
    }
}

/// `addImageToImageSimpleTests`
fn add_image_to_image_simple_tests(group: &mut tcu::TestCaseGroup, gp: &GroupParams) {
    let parms = |format: vk::Format, extent: [u32; 3], tiling: vk::ImageTiling, fill: FillMode| ImageParms {
        image_type: vk::ImageType::_2D,
        format,
        extent,
        tiling,
        fill_mode: fill,
    };
    let make = |name: String, src: ImageParms, dst: ImageParms, regions: Vec<ImageCopy>, clear: bool| {
        Box::new(CopyImageToImageCase {
            name,
            src,
            dst,
            regions,
            clear_destination_with_red: clear,
            allocation_kind: gp.allocation_kind,
            command_variant: gp.command_variant,
            queue_selection: gp.queue_selection,
            general_layout: gp.general_layout,
        }) as Box<dyn TestCase>
    };
    let color = |src_offset: [i32; 3], dst_offset: [i32; 3], extent: [u32; 3]| ImageCopy {
        src_offset,
        dst_offset,
        extent,
        aspect_mask: vk::ImageAspectFlags::COLOR,
        src_base_layer: 0,
        src_layer_count: 1,
        dst_base_layer: 0,
        dst_layer_count: 1,
    };

    // The destination defaults to FILL_MODE_WHITE and the source to FILL_MODE_GRADIENT
    // in TestParams' constructor, which is where these two come from.
    const SRC_FILL: FillMode = FillMode::Gradient;
    const DST_FILL: FillMode = FillMode::White;

    let suffix = |format: vk::Format, tiling: vk::ImageTiling| {
        format!(
            "{}{}",
            if format == vk::Format::R8G8B8A8_UINT {
                String::new()
            } else {
                format!("_{}", image_to_buffer_format_name(format))
            },
            if tiling == vk::ImageTiling::LINEAR { "_linear" } else { "" }
        )
    };
    static SIMPLE_FORMATS: &[vk::Format] = &[vk::Format::R8G8B8A8_UINT, vk::Format::R32G32B32_UINT, vk::Format::R32G32B32_SFLOAT];

    for &format in SIMPLE_FORMATS {
        for tiling in [vk::ImageTiling::OPTIMAL, vk::ImageTiling::LINEAR] {
            group.add_child(make(
                format!("whole_image{}", suffix(format, tiling)),
                parms(format, DEFAULT_EXTENT, tiling, SRC_FILL),
                parms(format, DEFAULT_EXTENT, tiling, DST_FILL),
                vec![color([0, 0, 0], [0, 0, 0], DEFAULT_EXTENT)],
                false,
            ));
        }
    }

    // A copy is a memcpy even across formats, so this pair only has to be size
    // compatible - 32 bits either way.
    group.add_child(make(
        "whole_image_diff_format".to_string(),
        parms(vk::Format::R8G8B8A8_UINT, DEFAULT_EXTENT, vk::ImageTiling::OPTIMAL, SRC_FILL),
        parms(vk::Format::R32_UINT, DEFAULT_EXTENT, vk::ImageTiling::OPTIMAL, DST_FILL),
        vec![color([0, 0, 0], [0, 0, 0], DEFAULT_EXTENT)],
        false,
    ));

    for &format in SIMPLE_FORMATS {
        for tiling in [vk::ImageTiling::OPTIMAL, vk::ImageTiling::LINEAR] {
            group.add_child(make(
                format!("partial_image{}", suffix(format, tiling)),
                parms(format, DEFAULT_EXTENT, tiling, SRC_FILL),
                parms(format, DEFAULT_EXTENT, tiling, DST_FILL),
                vec![color(
                    [0, 0, 0],
                    [DEFAULT_QUARTER_SIZE as i32, (DEFAULT_QUARTER_SIZE / 2) as i32, 0],
                    [DEFAULT_QUARTER_SIZE / 2, DEFAULT_QUARTER_SIZE / 2, 1],
                )],
                false,
            ));
        }
    }

    // The pot/npot matrix is not registered for a transfer-only queue upstream.
    if gp.queue_selection != QueueSelection::TransferOnly {
        for (format_name, format1, format2) in [
            ("diff_format", vk::Format::R32_UINT, vk::Format::R8G8B8A8_UNORM),
            ("same_format", vk::Format::R8G8B8A8_UNORM, vk::Format::R8G8B8A8_UNORM),
        ] {
            for (clear_name, clear) in [("clear", true), ("noclear", false)] {
                for (extent_name, extent) in [("npot", [65u32, 63, 1]), ("pot", [64, 64, 1])] {
                    let region = if extent_name == "pot" {
                        color([16, 16, 0], [0, 0, 0], [32, 32, 1])
                    } else {
                        color([34, 34, 0], [0, 0, 0], [31, 29, 1])
                    };
                    group.add_child(make(
                        format!("partial_image_{extent_name}_{format_name}_{clear_name}"),
                        parms(format1, extent, vk::ImageTiling::OPTIMAL, SRC_FILL),
                        parms(format2, extent, vk::ImageTiling::OPTIMAL, DST_FILL),
                        vec![region],
                        clear,
                    ));
                }
            }
        }
    }

    for (name, format, aspect) in [
        ("depth", vk::Format::D32_SFLOAT, vk::ImageAspectFlags::DEPTH),
        ("stencil", vk::Format::S8_UINT, vk::ImageAspectFlags::STENCIL),
    ] {
        group.add_child(make(
            name.to_string(),
            parms(format, DEFAULT_EXTENT, vk::ImageTiling::OPTIMAL, SRC_FILL),
            parms(format, DEFAULT_EXTENT, vk::ImageTiling::OPTIMAL, DST_FILL),
            vec![ImageCopy {
                src_offset: [0, 0, 0],
                dst_offset: [DEFAULT_QUARTER_SIZE as i32, (DEFAULT_QUARTER_SIZE / 2) as i32, 0],
                extent: [DEFAULT_QUARTER_SIZE / 2, DEFAULT_QUARTER_SIZE / 2, 1],
                aspect_mask: aspect,
                src_base_layer: 0,
                src_layer_count: 1,
                dst_base_layer: 0,
                dst_layer_count: 1,
            }],
            false,
        ));
    }
}

/// `addImageToImage3dImagesTests`
fn add_image_to_image_3d_tests(group: &mut tcu::TestCaseGroup, gp: &GroupParams) {
    const SLICES_LAYERS: u32 = 16;
    let extent = [DEFAULT_HALF_SIZE, DEFAULT_HALF_SIZE, SLICES_LAYERS];

    let parms = |image_type: vk::ImageType, fill: FillMode| ImageParms {
        image_type,
        format: vk::Format::R8G8B8A8_UINT,
        extent,
        tiling: vk::ImageTiling::OPTIMAL,
        fill_mode: fill,
    };
    let make = |name: &str, src_type: vk::ImageType, dst_type: vk::ImageType, regions: Vec<ImageCopy>| {
        Box::new(CopyImageToImageCase {
            name: name.to_string(),
            src: parms(src_type, FillMode::Gradient),
            dst: parms(dst_type, FillMode::White),
            regions,
            clear_destination_with_red: false,
            allocation_kind: gp.allocation_kind,
            command_variant: gp.command_variant,
            queue_selection: gp.queue_selection,
            general_layout: gp.general_layout,
        }) as Box<dyn TestCase>
    };
    let copy = |src_offset: [i32; 3], dst_offset: [i32; 3], extent: [u32; 3], src_base: u32, src_count: u32, dst_base: u32, dst_count: u32| ImageCopy {
        src_offset,
        dst_offset,
        extent,
        aspect_mask: vk::ImageAspectFlags::COLOR,
        src_base_layer: src_base,
        src_layer_count: src_count,
        dst_base_layer: dst_base,
        dst_layer_count: dst_count,
    };
    let half = [DEFAULT_HALF_SIZE, DEFAULT_HALF_SIZE, 1];

    group.add_child(make(
        "3d_to_2d_by_slices",
        vk::ImageType::_3D,
        vk::ImageType::_2D,
        (0..SLICES_LAYERS).map(|n| copy([0, 0, n as i32], [0, 0, 0], half, 0, 1, n, 1)).collect(),
    ));

    group.add_child(make(
        "2d_to_3d_by_layers",
        vk::ImageType::_2D,
        vk::ImageType::_3D,
        (0..SLICES_LAYERS).map(|n| copy([0, 0, 0], [0, 0, n as i32], half, n, 1, 0, 1)).collect(),
    ));

    group.add_child(make(
        "3d_to_2d_whole",
        vk::ImageType::_3D,
        vk::ImageType::_2D,
        vec![copy([0, 0, 0], [0, 0, 0], extent, 0, 1, 0, SLICES_LAYERS)],
    ));

    group.add_child(make(
        "2d_to_3d_whole",
        vk::ImageType::_2D,
        vk::ImageType::_3D,
        vec![copy([0, 0, 0], [0, 0, 0], extent, 0, SLICES_LAYERS, 0, 1)],
    ));

    // The regions shrink as the slice index grows, so each one starts further into the
    // source and covers less of it.
    let region_width = DEFAULT_HALF_SIZE / SLICES_LAYERS - 1;
    let region_height = DEFAULT_HALF_SIZE / SLICES_LAYERS - 1;

    group.add_child(make(
        "3d_to_2d_regions",
        vk::ImageType::_3D,
        vk::ImageType::_2D,
        (0..SLICES_LAYERS)
            .map(|n| {
                copy(
                    [0, (region_height * n) as i32, n as i32],
                    [(region_width * n) as i32, 0, 0],
                    [DEFAULT_HALF_SIZE - region_width * n, DEFAULT_HALF_SIZE - region_height * n, 1],
                    0,
                    1,
                    n,
                    1,
                )
            })
            .collect(),
    ));

    group.add_child(make(
        "2d_to_3d_regions",
        vk::ImageType::_2D,
        vk::ImageType::_3D,
        (0..SLICES_LAYERS)
            .map(|n| {
                copy(
                    [(region_width * n) as i32, 0, 0],
                    [0, (region_height * n) as i32, n as i32],
                    [DEFAULT_HALF_SIZE - region_width * n, DEFAULT_HALF_SIZE - region_height * n, 1],
                    n,
                    1,
                    0,
                    1,
                )
            })
            .collect(),
    ));
}

/// The `image_to_image*` groups.
pub fn add_image_to_image_groups(
    parent: &mut tcu::TestCaseGroup,
    name: &str,
    allocation_kind: AllocationKind,
    command_variant: CopyCommandVariant,
    queue_selection: QueueSelection,
    general_layout: bool,
) {
    let gp = GroupParams {
        allocation_kind,
        command_variant,
        queue_selection,
        general_layout,
    };
    let mut group = tcu::TestCaseGroup::new(name);
    let mut simple = tcu::TestCaseGroup::new("simple_tests");
    add_image_to_image_simple_tests(&mut simple, &gp);
    group.add_child(simple);

    // `image_to_image_general_layout` goes through addCopyImageToImageTestsSimpleOnly
    // upstream, so it gets simple_tests and nothing else.
    if !general_layout {
        let mut images_3d = tcu::TestCaseGroup::new("3d_images");
        add_image_to_image_3d_tests(&mut images_3d, &gp);
        group.add_child(images_3d);
    }
    // all_formats needs a compressed-format model in tcu; dimensions, array and cube
    // are not ported yet either.
    parent.add_child(group);
}
