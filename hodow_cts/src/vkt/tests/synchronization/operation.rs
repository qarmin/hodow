// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/synchronization/vktSynchronizationOperation.cpp
//   external/vulkancts/modules/vulkan/synchronization/vktSynchronizationUtil.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The synchronization tests are built out of write and read *operations* over a shared
// *resource*. A test picks one of each, has the write op fill the resource, puts one
// synchronization primitive between them, and checks that the read op saw exactly what
// the write op meant to put there. The primitive is what is under test; the operations
// are only there to give it something to order.
//
// Ported so far: the transfer operations - the ones that are pure `vkCmd*` copies,
// fills and clears and need no shader at all.

use vulkanalia::prelude::v1_0::*;

use crate::tcu::TestError;
use crate::tcu::pixel::PixelBufferAccess;
use crate::tcu::texture::{ChannelOrder, TextureChannelClass, map_vk_format};
use crate::vk::VkResultExt;
use crate::vk::image_util::ImageWithMemory;
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{BufferWithMemory, make_buffer_create_info};

/// `SynchronizationType`
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum SyncType {
    /// `SynchronizationType::LEGACY`
    Legacy,
    /// `SynchronizationType::SYNCHRONIZATION2`
    Synchronization2,
}

/// `MAX_UPDATE_BUFFER_SIZE` - the spec's cap on `vkCmdUpdateBuffer`.
pub const MAX_UPDATE_BUFFER_SIZE: i32 = 65536;
/// `MAX_UBO_RANGE` - the guaranteed minimum `maxUniformBufferRange`.
pub const MAX_UBO_RANGE: i32 = 0x4000;
/// `MAX_IMAGE_DIMENSION_2D`
const MAX_IMAGE_DIMENSION_2D: u32 = 0x1000;

/// `ResourceType`
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum ResourceType {
    Buffer,
    Image,
    IndirectBufferDraw,
    IndirectBufferDrawIndexed,
    IndirectBufferDispatch,
    IndexBuffer,
}

impl ResourceType {
    /// `isIndirectBuffer`
    pub fn is_indirect_buffer(self) -> bool {
        matches!(self, Self::IndirectBufferDraw | Self::IndirectBufferDrawIndexed | Self::IndirectBufferDispatch)
    }
}

/// `ResourceDescription`
#[derive(Clone, Copy)]
pub struct ResourceDescription {
    pub kind: ResourceType,
    /// `size` - x is the buffer size in bytes, or the image's width/height/depth.
    pub size: [i32; 4],
    pub image_type: vk::ImageType,
    pub image_format: vk::Format,
    pub image_aspect: vk::ImageAspectFlags,
    pub image_samples: vk::SampleCountFlags,
}

/// `s_resources`
pub static RESOURCES: &[ResourceDescription] = &[
    // 16 KiB (min max UBO range)
    buffer_resource(0x4000),
    // 256 KiB
    buffer_resource(0x40000),
    image_resource([128, 0, 0], vk::ImageType::_1D, vk::Format::R32_UINT, vk::ImageAspectFlags::COLOR, vk::SampleCountFlags::_1),
    image_resource(
        [128, 128, 0],
        vk::ImageType::_2D,
        vk::Format::R8_UNORM,
        vk::ImageAspectFlags::COLOR,
        vk::SampleCountFlags::_1,
    ),
    image_resource(
        [128, 128, 0],
        vk::ImageType::_2D,
        vk::Format::R16_UINT,
        vk::ImageAspectFlags::COLOR,
        vk::SampleCountFlags::_1,
    ),
    image_resource(
        [128, 128, 0],
        vk::ImageType::_2D,
        vk::Format::R8G8B8A8_UNORM,
        vk::ImageAspectFlags::COLOR,
        vk::SampleCountFlags::_1,
    ),
    image_resource(
        [128, 128, 0],
        vk::ImageType::_2D,
        vk::Format::R16G16B16A16_UINT,
        vk::ImageAspectFlags::COLOR,
        vk::SampleCountFlags::_1,
    ),
    image_resource(
        [128, 128, 0],
        vk::ImageType::_2D,
        vk::Format::R32G32B32A32_SFLOAT,
        vk::ImageAspectFlags::COLOR,
        vk::SampleCountFlags::_1,
    ),
    image_resource(
        [64, 64, 8],
        vk::ImageType::_3D,
        vk::Format::R32_SFLOAT,
        vk::ImageAspectFlags::COLOR,
        vk::SampleCountFlags::_1,
    ),
    // Mixed depth/stencil formats add complexity in image<->buffer transfers
    // (packing), so upstream avoids them here.
    image_resource(
        [128, 128, 0],
        vk::ImageType::_2D,
        vk::Format::D16_UNORM,
        vk::ImageAspectFlags::DEPTH,
        vk::SampleCountFlags::_1,
    ),
    image_resource(
        [128, 128, 0],
        vk::ImageType::_2D,
        vk::Format::D32_SFLOAT,
        vk::ImageAspectFlags::DEPTH,
        vk::SampleCountFlags::_1,
    ),
    image_resource(
        [128, 128, 0],
        vk::ImageType::_2D,
        vk::Format::S8_UINT,
        vk::ImageAspectFlags::STENCIL,
        vk::SampleCountFlags::_1,
    ),
    // Special resources, for the cases that are not strictly a copy and a comparison.
    indirect_resource(ResourceType::IndirectBufferDraw, 16),
    indirect_resource(ResourceType::IndirectBufferDrawIndexed, 20),
    indirect_resource(ResourceType::IndirectBufferDispatch, 12),
    indirect_resource(ResourceType::IndexBuffer, 4 * 5),
    // Special multisampled image resource, needed to test resolve.
    image_resource([64, 64, 0], vk::ImageType::_2D, vk::Format::R32_UINT, vk::ImageAspectFlags::COLOR, vk::SampleCountFlags::_4),
];

const fn buffer_resource(size: i32) -> ResourceDescription {
    ResourceDescription {
        kind: ResourceType::Buffer,
        size: [size, 0, 0, 0],
        // `VK_IMAGE_TYPE_LAST` upstream: a buffer has no image type and nothing
        // reads this.
        image_type: vk::ImageType::_1D,
        image_format: vk::Format::UNDEFINED,
        image_aspect: vk::ImageAspectFlags::empty(),
        image_samples: vk::SampleCountFlags::_1,
    }
}

const fn indirect_resource(kind: ResourceType, size: i32) -> ResourceDescription {
    ResourceDescription {
        kind,
        size: [size, 0, 0, 0],
        // `VK_IMAGE_TYPE_LAST` upstream: a buffer has no image type and nothing
        // reads this.
        image_type: vk::ImageType::_1D,
        image_format: vk::Format::UNDEFINED,
        image_aspect: vk::ImageAspectFlags::empty(),
        image_samples: vk::SampleCountFlags::_1,
    }
}

const fn image_resource(
    size: [i32; 3],
    image_type: vk::ImageType,
    image_format: vk::Format,
    image_aspect: vk::ImageAspectFlags,
    image_samples: vk::SampleCountFlags,
) -> ResourceDescription {
    ResourceDescription {
        kind: ResourceType::Image,
        size: [size[0], size[1], size[2], 0],
        image_type,
        image_format,
        image_aspect,
        image_samples,
    }
}

/// `getResourceName`
pub fn get_resource_name(resource: &ResourceDescription) -> String {
    match resource.kind {
        ResourceType::Buffer | ResourceType::IndexBuffer => format!("buffer_{}", resource.size[0]),
        ResourceType::Image => {
            let y = if resource.size[1] > 0 { format!("x{}", resource.size[1]) } else { String::new() };
            let z = if resource.size[2] > 0 { format!("x{}", resource.size[2]) } else { String::new() };
            format!("image_{}{y}{z}_{}", resource.size[0], format_short_name(resource.image_format))
        }
        _ => "indirect_buffer".to_string(),
    }
}

/// `getFormatName(...).substr(10)` lowercased - the `VK_FORMAT_` prefix dropped.
fn format_short_name(format: vk::Format) -> &'static str {
    match format {
        vk::Format::R32_UINT => "r32_uint",
        vk::Format::R8_UNORM => "r8_unorm",
        vk::Format::R16_UINT => "r16_uint",
        vk::Format::R8G8B8A8_UNORM => "r8g8b8a8_unorm",
        vk::Format::R16G16B16A16_UINT => "r16g16b16a16_uint",
        vk::Format::R32G32B32A32_SFLOAT => "r32g32b32a32_sfloat",
        vk::Format::R32_SFLOAT => "r32_sfloat",
        vk::Format::D16_UNORM => "d16_unorm",
        vk::Format::D32_SFLOAT => "d32_sfloat",
        vk::Format::S8_UINT => "s8_uint",
        _ => unreachable!("no other format appears in s_resources"),
    }
}

/// `SyncInfo`
///
/// For a read operation the layout is the one the image must be in *before* the read;
/// for a write it is the one it will be in *after* the write.
#[derive(Clone, Copy)]
pub struct SyncInfo {
    pub stage_mask: vk::PipelineStageFlags2,
    pub access_mask: vk::AccessFlags2,
    pub image_layout: vk::ImageLayout,
}

/// `emptySyncInfo`
pub const EMPTY_SYNC_INFO: SyncInfo = SyncInfo {
    stage_mask: vk::PipelineStageFlags2::empty(),
    access_mask: vk::AccessFlags2::empty(),
    image_layout: vk::ImageLayout::UNDEFINED,
};

/// `BufferResource`
#[derive(Clone, Copy)]
pub struct BufferInfo {
    pub handle: vk::Buffer,
    pub offset: vk::DeviceSize,
    pub size: vk::DeviceSize,
}

/// `ImageResource`
#[derive(Clone, Copy)]
pub struct ImageInfo {
    pub handle: vk::Image,
    pub extent: vk::Extent3D,
    pub image_type: vk::ImageType,
    pub format: vk::Format,
    pub subresource_range: vk::ImageSubresourceRange,
    pub subresource_layers: vk::ImageSubresourceLayers,
}

/// `Resource` - the buffer or image the two operations share.
pub struct Resource<'a> {
    pub kind: ResourceType,
    _buffer: Option<BufferWithMemory<'a>>,
    _image: Option<ImageWithMemory<'a>>,
    buffer_info: Option<BufferInfo>,
    image_info: Option<ImageInfo>,
}

impl<'a> Resource<'a> {
    pub fn new(device: &'a Device, allocator: &crate::vk::mem_util::SimpleAllocator, desc: &ResourceDescription, usage: u32) -> Result<Self, TestError> {
        if desc.kind == ResourceType::Image {
            let extent = vk::Extent3D {
                width: desc.size[0] as u32,
                height: desc.size[1].max(1) as u32,
                depth: desc.size[2].max(1) as u32,
            };
            let info = vk::ImageCreateInfo::builder()
                .image_type(desc.image_type)
                .format(desc.image_format)
                .extent(extent)
                .mip_levels(1)
                .array_layers(1)
                .samples(desc.image_samples)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(vk::ImageUsageFlags::from_bits_truncate(usage))
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build();
            let image = ImageWithMemory::new(device, allocator, info, MemoryRequirement::ANY)?;
            return Ok(Self {
                kind: desc.kind,
                _buffer: None,
                image_info: Some(ImageInfo {
                    handle: image.get(),
                    extent,
                    image_type: desc.image_type,
                    format: desc.image_format,
                    subresource_range: vk::ImageSubresourceRange {
                        aspect_mask: desc.image_aspect,
                        base_mip_level: 0,
                        level_count: 1,
                        base_array_layer: 0,
                        layer_count: 1,
                    },
                    subresource_layers: vk::ImageSubresourceLayers {
                        aspect_mask: desc.image_aspect,
                        mip_level: 0,
                        base_array_layer: 0,
                        layer_count: 1,
                    },
                }),
                _image: Some(image),
                buffer_info: None,
            });
        }

        let size = desc.size[0] as vk::DeviceSize;
        let buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(size, vk::BufferUsageFlags::from_bits_truncate(usage)),
            MemoryRequirement::ANY,
        )?;
        Ok(Self {
            kind: desc.kind,
            buffer_info: Some(BufferInfo {
                handle: buffer.get(),
                offset: 0,
                size,
            }),
            _buffer: Some(buffer),
            _image: None,
            image_info: None,
        })
    }

    pub fn buffer(&self) -> BufferInfo {
        self.buffer_info.expect("this resource is a buffer")
    }

    pub fn image(&self) -> ImageInfo {
        self.image_info.expect("this resource is an image")
    }
}

/// `fillPattern` - primes, so a byte that landed at the wrong offset is visible.
pub fn fill_pattern(data: &mut [u8]) {
    const PRIME_PATTERN: [u8; 11] = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31];
    for (i, byte) in data.iter_mut().enumerate() {
        *byte = PRIME_PATTERN[i % PRIME_PATTERN.len()];
    }
}

/// `getPixelBufferSize`
pub fn get_pixel_buffer_size(format: vk::Format, extent: vk::Extent3D) -> Result<vk::DeviceSize, TestError> {
    let tcu_format = map_vk_format(format).ok_or_else(|| TestError::NotPorted(format!("{format:?}")))?;
    let pixel_size = tcu_format.pixel_size().ok_or_else(|| TestError::NotPorted(format!("pixel size of {format:?}")))?;
    Ok(u64::from(pixel_size) * u64::from(extent.width) * u64::from(extent.height) * u64::from(extent.depth))
}

/// `get2DImageExtentWithSize` - a buffer read back through an image needs a 2D shape
/// to give it; there may be some unused space at the end of the last row.
pub fn get_2d_image_extent_with_size(size_bytes: vk::DeviceSize, pixel_size: u32) -> vk::Extent3D {
    let size = (size_bytes / u64::from(pixel_size)) as u32;
    vk::Extent3D {
        width: size.min(MAX_IMAGE_DIMENSION_2D),
        height: (size / MAX_IMAGE_DIMENSION_2D) + u32::from(!size.is_multiple_of(MAX_IMAGE_DIMENSION_2D)),
        depth: 1,
    }
}

/// `makeBufferImageCopy`
pub fn make_buffer_image_copy(extent: vk::Extent3D, subresource_layers: vk::ImageSubresourceLayers) -> vk::BufferImageCopy {
    vk::BufferImageCopy {
        buffer_offset: 0,
        buffer_row_length: 0,
        buffer_image_height: 0,
        image_subresource: subresource_layers,
        image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
        image_extent: extent,
    }
}

/// `makeClearValue`
pub fn make_clear_value(format: vk::Format) -> vk::ClearValue {
    if is_depth_stencil_format(format) {
        return vk::ClearValue {
            depth_stencil: vk::ClearDepthStencilValue { depth: 0.4, stencil: 21 },
        };
    }
    let class = map_vk_format(format).map(|f| f.channel_class());
    if matches!(class, Some(TextureChannelClass::SignedInteger) | Some(TextureChannelClass::UnsignedInteger)) {
        vk::ClearValue {
            color: vk::ClearColorValue { uint32: [8, 16, 24, 32] },
        }
    } else {
        vk::ClearValue {
            color: vk::ClearColorValue { float32: [0.25, 0.49, 0.75, 1.0] },
        }
    }
}

pub fn is_depth_stencil_format(format: vk::Format) -> bool {
    map_vk_format(format).is_some_and(|f| matches!(f.order, ChannelOrder::D | ChannelOrder::S | ChannelOrder::DS))
}

/// `clearPixelBuffer` - the host's copy of what the clear should have produced.
pub fn clear_pixel_buffer(pixels: &mut PixelBufferAccess<'_>, clear_value: &vk::ClearValue) {
    let format = pixels.format();
    let [w, h, d] = pixels.size();
    let (depth, stencil) = unsafe { (clear_value.depth_stencil.depth, clear_value.depth_stencil.stencil) };

    for z in 0..d {
        for y in 0..h {
            for x in 0..w {
                match format.order {
                    ChannelOrder::D => pixels.set_pix_depth(depth, x, y, z),
                    ChannelOrder::S => pixels.set_pix_stencil(stencil, x, y, z),
                    ChannelOrder::DS => {
                        pixels.set_pix_depth(depth, x, y, z);
                        pixels.set_pix_stencil(stencil, x, y, z);
                    }
                    _ => match format.channel_class() {
                        TextureChannelClass::SignedInteger | TextureChannelClass::UnsignedInteger => {
                            let c = unsafe { clear_value.color.uint32 };
                            let _ = pixels.set_pixel_int(c.map(|v| v as i32), x, y, z);
                        }
                        _ => pixels.set_pixel(unsafe { clear_value.color.float32 }, x, y, z),
                    },
                }
            }
        }
    }
}

// ---------------------------------------------------------------------------------
// Barriers
// ---------------------------------------------------------------------------------

/// `makeBufferMemoryBarrier2`
pub fn make_buffer_memory_barrier2(
    src_stage_mask: vk::PipelineStageFlags2,
    src_access_mask: vk::AccessFlags2,
    dst_stage_mask: vk::PipelineStageFlags2,
    dst_access_mask: vk::AccessFlags2,
    buffer: vk::Buffer,
    offset: vk::DeviceSize,
    size: vk::DeviceSize,
) -> vk::BufferMemoryBarrier2 {
    vk::BufferMemoryBarrier2 {
        s_type: vk::StructureType::BUFFER_MEMORY_BARRIER_2,
        next: std::ptr::null(),
        src_stage_mask,
        src_access_mask,
        dst_stage_mask,
        dst_access_mask,
        src_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
        dst_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
        buffer,
        offset,
        size,
    }
}

/// `makeImageMemoryBarrier2`
#[allow(clippy::too_many_arguments)]
pub fn make_image_memory_barrier2(
    src_stage_mask: vk::PipelineStageFlags2,
    src_access_mask: vk::AccessFlags2,
    dst_stage_mask: vk::PipelineStageFlags2,
    dst_access_mask: vk::AccessFlags2,
    old_layout: vk::ImageLayout,
    new_layout: vk::ImageLayout,
    image: vk::Image,
    subresource_range: vk::ImageSubresourceRange,
) -> vk::ImageMemoryBarrier2 {
    vk::ImageMemoryBarrier2 {
        s_type: vk::StructureType::IMAGE_MEMORY_BARRIER_2,
        next: std::ptr::null(),
        src_stage_mask,
        src_access_mask,
        dst_stage_mask,
        dst_access_mask,
        old_layout,
        new_layout,
        src_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
        dst_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
        image,
        subresource_range,
    }
}

/// `SynchronizationWrapper::cmdPipelineBarrier`.
///
/// The legacy path takes the same barriers and lowers them: the 64-bit stage and
/// access masks are truncated (every value these operations use has a 32-bit
/// equivalent) and the per-barrier stage masks are ORed up into the two the old entry
/// point takes.
pub fn cmd_pipeline_barrier(
    device: &Device,
    sync: SyncType,
    cmd_buffer: vk::CommandBuffer,
    buffer_barriers: &[vk::BufferMemoryBarrier2],
    image_barriers: &[vk::ImageMemoryBarrier2],
) {
    if sync == SyncType::Synchronization2 {
        use vulkanalia::vk::KhrSynchronization2ExtensionDeviceCommands;
        let info = vk::DependencyInfo {
            s_type: vk::StructureType::DEPENDENCY_INFO,
            next: std::ptr::null(),
            dependency_flags: vk::DependencyFlags::empty(),
            memory_barrier_count: 0,
            memory_barriers: std::ptr::null(),
            buffer_memory_barrier_count: buffer_barriers.len() as u32,
            buffer_memory_barriers: buffer_barriers.as_ptr(),
            image_memory_barrier_count: image_barriers.len() as u32,
            image_memory_barriers: image_barriers.as_ptr(),
        };
        unsafe { device.cmd_pipeline_barrier2_khr(cmd_buffer, &info) };
        return;
    }

    let mut src_stage = vk::PipelineStageFlags::empty();
    let mut dst_stage = vk::PipelineStageFlags::empty();
    let legacy_buffers: Vec<vk::BufferMemoryBarrier> = buffer_barriers
        .iter()
        .map(|b| {
            src_stage |= truncate_stage(b.src_stage_mask);
            dst_stage |= truncate_stage(b.dst_stage_mask);
            vk::BufferMemoryBarrier {
                s_type: vk::StructureType::BUFFER_MEMORY_BARRIER,
                next: std::ptr::null(),
                src_access_mask: truncate_access(b.src_access_mask),
                dst_access_mask: truncate_access(b.dst_access_mask),
                src_queue_family_index: b.src_queue_family_index,
                dst_queue_family_index: b.dst_queue_family_index,
                buffer: b.buffer,
                offset: b.offset,
                size: b.size,
            }
        })
        .collect();
    let legacy_images: Vec<vk::ImageMemoryBarrier> = image_barriers
        .iter()
        .map(|b| {
            src_stage |= truncate_stage(b.src_stage_mask);
            dst_stage |= truncate_stage(b.dst_stage_mask);
            vk::ImageMemoryBarrier {
                s_type: vk::StructureType::IMAGE_MEMORY_BARRIER,
                next: std::ptr::null(),
                src_access_mask: truncate_access(b.src_access_mask),
                dst_access_mask: truncate_access(b.dst_access_mask),
                old_layout: b.old_layout,
                new_layout: b.new_layout,
                src_queue_family_index: b.src_queue_family_index,
                dst_queue_family_index: b.dst_queue_family_index,
                image: b.image,
                subresource_range: b.subresource_range,
            }
        })
        .collect();

    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer,
            src_stage,
            dst_stage,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &legacy_buffers,
            &legacy_images,
        );
    }
}

fn truncate_stage(mask: vk::PipelineStageFlags2) -> vk::PipelineStageFlags {
    vk::PipelineStageFlags::from_bits_truncate(mask.bits() as u32)
}

fn truncate_access(mask: vk::AccessFlags2) -> vk::AccessFlags {
    vk::AccessFlags::from_bits_truncate(mask.bits() as u32)
}

// ---------------------------------------------------------------------------------
// Operations
// ---------------------------------------------------------------------------------

/// `Operation`
///
/// `data` means different things on the two sides, as it does upstream: for a write it
/// is what the operation meant to put in the resource, for a read it is what it
/// actually found there.
pub trait Operation {
    fn record_commands(&self, device: &Device, sync: SyncType, cmd_buffer: vk::CommandBuffer);
    fn in_sync_info(&self, sync: SyncType) -> SyncInfo {
        let _ = sync;
        EMPTY_SYNC_INFO
    }
    fn out_sync_info(&self, sync: SyncType) -> SyncInfo {
        let _ = sync;
        EMPTY_SYNC_INFO
    }
    fn data(&self, device: &Device) -> Result<Vec<u8>, TestError>;
}

/// `AccessMode`
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum AccessMode {
    Read,
    Write,
}

/// Reads the host-visible staging buffer back, which is what every copy-based
/// operation's `getData` does.
fn host_buffer_data(device: &Device, buffer: &BufferWithMemory<'_>, size: vk::DeviceSize) -> Result<Vec<u8>, TestError> {
    invalidate_alloc(device, buffer.get_allocation())?;
    let mut out = vec![0u8; size as usize];
    unsafe { std::ptr::copy_nonoverlapping(buffer.get_allocation().get_host_ptr(), out.as_mut_ptr(), out.len()) };
    Ok(out)
}

fn make_host_buffer<'a>(
    device: &'a Device,
    allocator: &crate::vk::mem_util::SimpleAllocator,
    size: vk::DeviceSize,
    usage: vk::BufferUsageFlags,
    mode: AccessMode,
) -> Result<BufferWithMemory<'a>, TestError> {
    let buffer = BufferWithMemory::new(device, allocator, make_buffer_create_info(size, usage), MemoryRequirement::HOST_VISIBLE)?;
    unsafe {
        let ptr = buffer.get_allocation().get_host_ptr();
        let bytes = std::slice::from_raw_parts_mut(ptr, size as usize);
        match mode {
            AccessMode::Read => bytes.fill(0),
            AccessMode::Write => fill_pattern(bytes),
        }
    }
    flush_alloc(device, buffer.get_allocation())?;
    Ok(buffer)
}

/// `FillUpdateBuffer::Implementation`
pub struct FillUpdateBuffer {
    buffer: BufferInfo,
    data: Vec<u8>,
    fill_value: u32,
    is_fill: bool,
}

impl FillUpdateBuffer {
    /// `FillUpdateBuffer::BUFFER_OP_FILL` / `BUFFER_OP_UPDATE`
    pub fn new(resource: &Resource<'_>, is_fill: bool) -> Self {
        const FILL_VALUE: u32 = 0x13;
        let buffer = resource.buffer();
        let mut data = vec![0u8; buffer.size as usize];
        if is_fill {
            for chunk in data.as_chunks_mut::<4>().0 {
                *chunk = FILL_VALUE.to_ne_bytes();
            }
        } else {
            fill_pattern(&mut data);
        }
        Self {
            buffer,
            data,
            fill_value: FILL_VALUE,
            is_fill,
        }
    }
}

impl Operation for FillUpdateBuffer {
    fn record_commands(&self, device: &Device, sync: SyncType, cmd_buffer: vk::CommandBuffer) {
        if self.is_fill {
            unsafe { device.cmd_fill_buffer(cmd_buffer, self.buffer.handle, self.buffer.offset, self.buffer.size, self.fill_value) };
            // vkCmdFillBuffer is not ordered against the read that follows by the test's
            // own synchronization primitive alone, so upstream adds this.
            let barrier = make_buffer_memory_barrier2(
                vk::PipelineStageFlags2::ALL_TRANSFER,
                vk::AccessFlags2::TRANSFER_WRITE,
                vk::PipelineStageFlags2::ALL_TRANSFER,
                vk::AccessFlags2::TRANSFER_READ,
                self.buffer.handle,
                0,
                self.buffer.size,
            );
            cmd_pipeline_barrier(device, sync, cmd_buffer, &[barrier], &[]);
        } else {
            unsafe { device.cmd_update_buffer(cmd_buffer, self.buffer.handle, self.buffer.offset, &self.data) };
        }
    }

    fn out_sync_info(&self, _sync: SyncType) -> SyncInfo {
        SyncInfo {
            stage_mask: vk::PipelineStageFlags2::ALL_TRANSFER,
            access_mask: vk::AccessFlags2::TRANSFER_WRITE,
            image_layout: vk::ImageLayout::UNDEFINED,
        }
    }

    fn data(&self, _device: &Device) -> Result<Vec<u8>, TestError> {
        Ok(self.data.clone())
    }
}

/// `CopyBuffer::Implementation`
pub struct CopyBuffer<'a> {
    buffer: BufferInfo,
    host_buffer: BufferWithMemory<'a>,
    mode: AccessMode,
}

impl<'a> CopyBuffer<'a> {
    pub fn new(device: &'a Device, allocator: &crate::vk::mem_util::SimpleAllocator, resource: &Resource<'_>, mode: AccessMode) -> Result<Self, TestError> {
        let buffer = resource.buffer();
        let usage = if mode == AccessMode::Read {
            vk::BufferUsageFlags::TRANSFER_DST
        } else {
            vk::BufferUsageFlags::TRANSFER_SRC
        };
        Ok(Self {
            host_buffer: make_host_buffer(device, allocator, buffer.size, usage, mode)?,
            buffer,
            mode,
        })
    }
}

impl Operation for CopyBuffer<'_> {
    fn record_commands(&self, device: &Device, sync: SyncType, cmd_buffer: vk::CommandBuffer) {
        let region = [vk::BufferCopy {
            src_offset: 0,
            dst_offset: 0,
            size: self.buffer.size,
        }];

        if self.mode == AccessMode::Read {
            unsafe { device.cmd_copy_buffer(cmd_buffer, self.buffer.handle, self.host_buffer.get(), &region) };
            let barrier = make_buffer_memory_barrier2(
                vk::PipelineStageFlags2::ALL_TRANSFER,
                vk::AccessFlags2::TRANSFER_WRITE,
                vk::PipelineStageFlags2::HOST,
                vk::AccessFlags2::HOST_READ,
                self.host_buffer.get(),
                0,
                self.buffer.size,
            );
            cmd_pipeline_barrier(device, sync, cmd_buffer, &[barrier], &[]);
        } else {
            unsafe { device.cmd_copy_buffer(cmd_buffer, self.host_buffer.get(), self.buffer.handle, &region) };
        }
    }

    fn in_sync_info(&self, _sync: SyncType) -> SyncInfo {
        SyncInfo {
            stage_mask: vk::PipelineStageFlags2::ALL_TRANSFER,
            access_mask: if self.mode == AccessMode::Read {
                vk::AccessFlags2::TRANSFER_READ
            } else {
                vk::AccessFlags2::empty()
            },
            image_layout: vk::ImageLayout::UNDEFINED,
        }
    }

    fn out_sync_info(&self, _sync: SyncType) -> SyncInfo {
        SyncInfo {
            stage_mask: vk::PipelineStageFlags2::ALL_TRANSFER,
            access_mask: if self.mode == AccessMode::Write {
                vk::AccessFlags2::TRANSFER_WRITE
            } else {
                vk::AccessFlags2::empty()
            },
            image_layout: vk::ImageLayout::UNDEFINED,
        }
    }

    fn data(&self, device: &Device) -> Result<Vec<u8>, TestError> {
        host_buffer_data(device, &self.host_buffer, self.buffer.size)
    }
}

/// Which of the three image-to-image transfer commands an operation uses.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum ImageCopyKind {
    Copy,
    Blit,
    Resolve,
}

/// `CopyBlitResolveImage::ImplementationBase` and its three subclasses.
///
/// All three move the resource image through a single-sampled staging image, which is
/// what lets the host see the result: the staging image is copied to or from a
/// host-visible buffer on either side of the transfer under test.
pub struct CopyBlitResolveImage<'a> {
    image: ImageInfo,
    staging: ImageWithMemory<'a>,
    host_buffer: BufferWithMemory<'a>,
    buffer_size: vk::DeviceSize,
    mode: AccessMode,
    kind: ImageCopyKind,
}

impl<'a> CopyBlitResolveImage<'a> {
    pub fn new(device: &'a Device, allocator: &crate::vk::mem_util::SimpleAllocator, resource: &Resource<'_>, kind: ImageCopyKind, mode: AccessMode) -> Result<Self, TestError> {
        let image = resource.image();
        let buffer_size = get_pixel_buffer_size(image.format, image.extent)?;
        let host_buffer = make_host_buffer(
            device,
            allocator,
            buffer_size,
            vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
            mode,
        )?;

        let info = vk::ImageCreateInfo::builder()
            .image_type(image.image_type)
            .format(image.format)
            .extent(image.extent)
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let staging = ImageWithMemory::new(device, allocator, info, MemoryRequirement::ANY)?;

        Ok(Self {
            image,
            staging,
            host_buffer,
            buffer_size,
            mode,
            kind,
        })
    }

    /// `makeExtentOffset` - the far corner of the image, in the dimensions its type has.
    fn extent_offset(&self) -> vk::Offset3D {
        let e = self.image.extent;
        match self.image.image_type {
            vk::ImageType::_1D => vk::Offset3D { x: e.width as i32, y: 1, z: 1 },
            vk::ImageType::_3D => vk::Offset3D {
                x: e.width as i32,
                y: e.height as i32,
                z: e.depth as i32,
            },
            _ => vk::Offset3D {
                x: e.width as i32,
                y: e.height as i32,
                z: 1,
            },
        }
    }

    /// `recordCopyCommand`
    fn record_copy_command(&self, device: &Device, cmd_buffer: vk::CommandBuffer) {
        let (src, dst) = if self.mode == AccessMode::Read {
            (self.image.handle, self.staging.get())
        } else {
            (self.staging.get(), self.image.handle)
        };
        let zero = vk::Offset3D { x: 0, y: 0, z: 0 };

        unsafe {
            match self.kind {
                ImageCopyKind::Blit => {
                    let region = [vk::ImageBlit {
                        src_subresource: self.image.subresource_layers,
                        src_offsets: [zero, self.extent_offset()],
                        dst_subresource: self.image.subresource_layers,
                        dst_offsets: [zero, self.extent_offset()],
                    }];
                    device.cmd_blit_image(
                        cmd_buffer,
                        src,
                        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                        dst,
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        &region,
                        vk::Filter::NEAREST,
                    );
                }
                ImageCopyKind::Copy => {
                    let region = [vk::ImageCopy {
                        src_subresource: self.image.subresource_layers,
                        src_offset: zero,
                        dst_subresource: self.image.subresource_layers,
                        dst_offset: zero,
                        extent: self.image.extent,
                    }];
                    device.cmd_copy_image(cmd_buffer, src, vk::ImageLayout::TRANSFER_SRC_OPTIMAL, dst, vk::ImageLayout::TRANSFER_DST_OPTIMAL, &region);
                }
                ImageCopyKind::Resolve => {
                    let region = [vk::ImageResolve {
                        src_subresource: self.image.subresource_layers,
                        src_offset: zero,
                        dst_subresource: self.image.subresource_layers,
                        dst_offset: zero,
                        extent: self.image.extent,
                    }];
                    device.cmd_resolve_image(cmd_buffer, src, vk::ImageLayout::TRANSFER_SRC_OPTIMAL, dst, vk::ImageLayout::TRANSFER_DST_OPTIMAL, &region);
                }
            }
        }
    }

    /// `getReadSrcStageMask` - synchronization2 has a stage per transfer command, and
    /// naming the precise one is part of what these tests exercise.
    fn read_src_stage_mask(&self, sync: SyncType) -> vk::PipelineStageFlags2 {
        if sync == SyncType::Legacy {
            return vk::PipelineStageFlags2::ALL_TRANSFER;
        }
        match self.kind {
            ImageCopyKind::Copy => vk::PipelineStageFlags2::COPY,
            ImageCopyKind::Blit => vk::PipelineStageFlags2::BLIT,
            ImageCopyKind::Resolve => vk::PipelineStageFlags2::RESOLVE,
        }
    }

    fn sync_info(&self) -> SyncInfo {
        let read = self.mode == AccessMode::Read;
        SyncInfo {
            stage_mask: vk::PipelineStageFlags2::ALL_TRANSFER,
            access_mask: if read { vk::AccessFlags2::TRANSFER_READ } else { vk::AccessFlags2::TRANSFER_WRITE },
            image_layout: if read {
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL
            } else {
                vk::ImageLayout::TRANSFER_DST_OPTIMAL
            },
        }
    }
}

impl Operation for CopyBlitResolveImage<'_> {
    fn record_commands(&self, device: &Device, sync: SyncType, cmd_buffer: vk::CommandBuffer) {
        let buffer_copy = [make_buffer_image_copy(self.image.extent, self.image.subresource_layers)];

        let to_dst = make_image_memory_barrier2(
            vk::PipelineStageFlags2::TOP_OF_PIPE,
            vk::AccessFlags2::empty(),
            vk::PipelineStageFlags2::ALL_TRANSFER,
            vk::AccessFlags2::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            self.staging.get(),
            self.image.subresource_range,
        );
        cmd_pipeline_barrier(device, sync, cmd_buffer, &[], &[to_dst]);

        if self.mode == AccessMode::Read {
            self.record_copy_command(device, cmd_buffer);

            let to_src = make_image_memory_barrier2(
                self.read_src_stage_mask(sync),
                vk::AccessFlags2::TRANSFER_WRITE,
                vk::PipelineStageFlags2::ALL_TRANSFER,
                vk::AccessFlags2::TRANSFER_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                self.staging.get(),
                self.image.subresource_range,
            );
            cmd_pipeline_barrier(device, sync, cmd_buffer, &[], &[to_src]);

            unsafe {
                device.cmd_copy_image_to_buffer(cmd_buffer, self.staging.get(), vk::ImageLayout::TRANSFER_SRC_OPTIMAL, self.host_buffer.get(), &buffer_copy);
            }

            let to_host = make_buffer_memory_barrier2(
                vk::PipelineStageFlags2::ALL_TRANSFER,
                vk::AccessFlags2::TRANSFER_WRITE,
                vk::PipelineStageFlags2::HOST,
                vk::AccessFlags2::HOST_READ,
                self.host_buffer.get(),
                0,
                self.buffer_size,
            );
            cmd_pipeline_barrier(device, sync, cmd_buffer, &[to_host], &[]);
        } else {
            unsafe {
                device.cmd_copy_buffer_to_image(cmd_buffer, self.host_buffer.get(), self.staging.get(), vk::ImageLayout::TRANSFER_DST_OPTIMAL, &buffer_copy);
            }

            let staging_to_src = make_image_memory_barrier2(
                vk::PipelineStageFlags2::ALL_TRANSFER,
                vk::AccessFlags2::TRANSFER_WRITE,
                vk::PipelineStageFlags2::ALL_TRANSFER,
                vk::AccessFlags2::TRANSFER_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                self.staging.get(),
                self.image.subresource_range,
            );
            cmd_pipeline_barrier(device, sync, cmd_buffer, &[], &[staging_to_src]);

            let resource_to_dst = make_image_memory_barrier2(
                vk::PipelineStageFlags2::TOP_OF_PIPE,
                vk::AccessFlags2::empty(),
                vk::PipelineStageFlags2::ALL_TRANSFER,
                vk::AccessFlags2::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                self.image.handle,
                self.image.subresource_range,
            );
            cmd_pipeline_barrier(device, sync, cmd_buffer, &[], &[resource_to_dst]);

            self.record_copy_command(device, cmd_buffer);
        }
    }

    fn in_sync_info(&self, _sync: SyncType) -> SyncInfo {
        self.sync_info()
    }

    fn out_sync_info(&self, _sync: SyncType) -> SyncInfo {
        self.sync_info()
    }

    fn data(&self, device: &Device) -> Result<Vec<u8>, TestError> {
        host_buffer_data(device, &self.host_buffer, self.buffer_size)
    }
}

/// `CopyBufferToImage::WriteImplementation` - the resource is an image, filled from a
/// host buffer.
pub struct CopyBufferToImageWrite<'a> {
    image: ImageInfo,
    host_buffer: BufferWithMemory<'a>,
    buffer_size: vk::DeviceSize,
}

impl<'a> CopyBufferToImageWrite<'a> {
    pub fn new(device: &'a Device, allocator: &crate::vk::mem_util::SimpleAllocator, resource: &Resource<'_>) -> Result<Self, TestError> {
        let image = resource.image();
        let buffer_size = get_pixel_buffer_size(image.format, image.extent)?;
        Ok(Self {
            host_buffer: make_host_buffer(device, allocator, buffer_size, vk::BufferUsageFlags::TRANSFER_SRC, AccessMode::Write)?,
            image,
            buffer_size,
        })
    }
}

impl Operation for CopyBufferToImageWrite<'_> {
    fn record_commands(&self, device: &Device, sync: SyncType, cmd_buffer: vk::CommandBuffer) {
        let to_dst = make_image_memory_barrier2(
            vk::PipelineStageFlags2::TOP_OF_PIPE,
            vk::AccessFlags2::empty(),
            vk::PipelineStageFlags2::ALL_TRANSFER,
            vk::AccessFlags2::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            self.image.handle,
            self.image.subresource_range,
        );
        cmd_pipeline_barrier(device, sync, cmd_buffer, &[], &[to_dst]);

        let region = [make_buffer_image_copy(self.image.extent, self.image.subresource_layers)];
        unsafe {
            device.cmd_copy_buffer_to_image(cmd_buffer, self.host_buffer.get(), self.image.handle, vk::ImageLayout::TRANSFER_DST_OPTIMAL, &region);
        }
    }

    fn out_sync_info(&self, _sync: SyncType) -> SyncInfo {
        SyncInfo {
            stage_mask: vk::PipelineStageFlags2::ALL_TRANSFER,
            access_mask: vk::AccessFlags2::TRANSFER_WRITE,
            image_layout: vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        }
    }

    fn data(&self, device: &Device) -> Result<Vec<u8>, TestError> {
        host_buffer_data(device, &self.host_buffer, self.buffer_size)
    }
}

/// `CopyBufferToImage::ReadImplementation` - the resource is a buffer, read by copying
/// it into a scratch image and that image back into a host buffer.
pub struct CopyBufferToImageRead<'a> {
    buffer: BufferInfo,
    image: ImageWithMemory<'a>,
    image_extent: vk::Extent3D,
    host_buffer: BufferWithMemory<'a>,
    subresource_range: vk::ImageSubresourceRange,
    subresource_layers: vk::ImageSubresourceLayers,
}

impl<'a> CopyBufferToImageRead<'a> {
    pub fn new(device: &'a Device, allocator: &crate::vk::mem_util::SimpleAllocator, resource: &Resource<'_>) -> Result<Self, TestError> {
        let buffer = resource.buffer();
        let image_extent = get_2d_image_extent_with_size(buffer.size, 4);

        let info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(vk::Format::R8G8B8A8_UNORM)
            .extent(image_extent)
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();

        Ok(Self {
            image: ImageWithMemory::new(device, allocator, info, MemoryRequirement::ANY)?,
            host_buffer: BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(buffer.size, vk::BufferUsageFlags::TRANSFER_DST),
                MemoryRequirement::HOST_VISIBLE,
            )?,
            buffer,
            image_extent,
            subresource_range: vk::ImageSubresourceRange {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                base_mip_level: 0,
                level_count: 1,
                base_array_layer: 0,
                layer_count: 1,
            },
            subresource_layers: vk::ImageSubresourceLayers {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                mip_level: 0,
                base_array_layer: 0,
                layer_count: 1,
            },
        })
    }
}

impl Operation for CopyBufferToImageRead<'_> {
    fn record_commands(&self, device: &Device, sync: SyncType, cmd_buffer: vk::CommandBuffer) {
        let region = [make_buffer_image_copy(self.image_extent, self.subresource_layers)];

        let to_dst = make_image_memory_barrier2(
            vk::PipelineStageFlags2::TOP_OF_PIPE,
            vk::AccessFlags2::empty(),
            vk::PipelineStageFlags2::ALL_TRANSFER,
            vk::AccessFlags2::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            self.image.get(),
            self.subresource_range,
        );
        cmd_pipeline_barrier(device, sync, cmd_buffer, &[], &[to_dst]);
        unsafe {
            device.cmd_copy_buffer_to_image(cmd_buffer, self.buffer.handle, self.image.get(), vk::ImageLayout::TRANSFER_DST_OPTIMAL, &region);
        }

        let to_src = make_image_memory_barrier2(
            vk::PipelineStageFlags2::ALL_TRANSFER,
            vk::AccessFlags2::TRANSFER_WRITE,
            vk::PipelineStageFlags2::ALL_TRANSFER,
            vk::AccessFlags2::TRANSFER_READ,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            self.image.get(),
            self.subresource_range,
        );
        cmd_pipeline_barrier(device, sync, cmd_buffer, &[], &[to_src]);
        unsafe {
            device.cmd_copy_image_to_buffer(cmd_buffer, self.image.get(), vk::ImageLayout::TRANSFER_SRC_OPTIMAL, self.host_buffer.get(), &region);
        }

        let to_host = make_buffer_memory_barrier2(
            vk::PipelineStageFlags2::ALL_TRANSFER,
            vk::AccessFlags2::TRANSFER_WRITE,
            vk::PipelineStageFlags2::HOST,
            vk::AccessFlags2::HOST_READ,
            self.host_buffer.get(),
            0,
            self.buffer.size,
        );
        cmd_pipeline_barrier(device, sync, cmd_buffer, &[to_host], &[]);
    }

    fn in_sync_info(&self, _sync: SyncType) -> SyncInfo {
        SyncInfo {
            stage_mask: vk::PipelineStageFlags2::ALL_TRANSFER,
            access_mask: vk::AccessFlags2::TRANSFER_READ,
            image_layout: vk::ImageLayout::UNDEFINED,
        }
    }

    fn data(&self, device: &Device) -> Result<Vec<u8>, TestError> {
        host_buffer_data(device, &self.host_buffer, self.buffer.size)
    }
}

/// `ClearImage::Implementation`
pub struct ClearImage {
    image: ImageInfo,
    clear_value: vk::ClearValue,
    data: Vec<u8>,
    is_color: bool,
}

impl ClearImage {
    pub fn new(resource: &Resource<'_>, is_color: bool) -> Result<Self, TestError> {
        let image = resource.image();
        let clear_value = make_clear_value(image.format);
        let size = get_pixel_buffer_size(image.format, image.extent)?;
        let format = map_vk_format(image.format).ok_or_else(|| TestError::NotPorted(format!("{:?}", image.format)))?;

        // The host's copy of what the clear should have produced, laid out exactly as
        // the image will be read back.
        let mut data = vec![0u8; size as usize];
        {
            let mut pixels = PixelBufferAccess::new(format, [image.extent.width, image.extent.height, image.extent.depth], &mut data);
            clear_pixel_buffer(&mut pixels, &clear_value);
        }

        Ok(Self {
            image,
            clear_value,
            data,
            is_color,
        })
    }

    /// Upstream names the specific clear stage under synchronization2.
    fn stage_mask(sync: SyncType) -> vk::PipelineStageFlags2 {
        if sync == SyncType::Synchronization2 {
            vk::PipelineStageFlags2::CLEAR
        } else {
            vk::PipelineStageFlags2::ALL_TRANSFER
        }
    }
}

impl Operation for ClearImage {
    fn record_commands(&self, device: &Device, sync: SyncType, cmd_buffer: vk::CommandBuffer) {
        let to_dst = make_image_memory_barrier2(
            vk::PipelineStageFlags2::TOP_OF_PIPE,
            vk::AccessFlags2::empty(),
            Self::stage_mask(sync),
            vk::AccessFlags2::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            self.image.handle,
            self.image.subresource_range,
        );
        cmd_pipeline_barrier(device, sync, cmd_buffer, &[], &[to_dst]);

        let ranges = [self.image.subresource_range];
        unsafe {
            if self.is_color {
                device.cmd_clear_color_image(cmd_buffer, self.image.handle, vk::ImageLayout::TRANSFER_DST_OPTIMAL, &self.clear_value.color, &ranges);
            } else {
                device.cmd_clear_depth_stencil_image(
                    cmd_buffer,
                    self.image.handle,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &self.clear_value.depth_stencil,
                    &ranges,
                );
            }
        }
    }

    fn out_sync_info(&self, sync: SyncType) -> SyncInfo {
        SyncInfo {
            stage_mask: Self::stage_mask(sync),
            access_mask: vk::AccessFlags2::TRANSFER_WRITE,
            image_layout: vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        }
    }

    fn data(&self, _device: &Device) -> Result<Vec<u8>, TestError> {
        Ok(self.data.clone())
    }
}

// ---------------------------------------------------------------------------------
// The operation catalogue
// ---------------------------------------------------------------------------------

/// `OperationName`, restricted to the transfer operations.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum OperationName {
    WriteFillBuffer,
    WriteUpdateBuffer,
    WriteCopyBuffer,
    WriteCopyBufferToImage,
    WriteCopyImageToBuffer,
    WriteCopyImage,
    WriteBlitImage,
    WriteClearColorImage,
    WriteClearDepthStencilImage,
    WriteSsboCompute,
    WriteSsboComputeIndirect,
    WriteImageCompute,
    WriteImageComputeIndirect,
    WriteSsboVertex,
    WriteSsboFragment,
    WriteImageVertex,
    WriteImageFragment,
    WriteDraw,
    WriteDrawIndexed,
    WriteDrawIndirect,
    WriteDrawIndexedIndirect,
    WriteClearAttachments,
    ReadCopyBuffer,
    ReadCopyBufferToImage,
    ReadCopyImageToBuffer,
    ReadCopyImage,
    ReadBlitImage,
    ReadResolveImage,
    ReadUboCompute,
    ReadUboComputeIndirect,
    ReadUboTexelCompute,
    ReadUboTexelComputeIndirect,
    ReadSsboCompute,
    ReadSsboComputeIndirect,
    ReadImageCompute,
    ReadImageComputeIndirect,
    ReadSsboVertex,
    ReadSsboFragment,
    ReadImageVertex,
    ReadImageFragment,
    ReadUboVertex,
    ReadUboFragment,
    ReadUboTexelVertex,
    ReadUboTexelFragment,
    ReadVertexInput,
}

impl OperationName {
    /// `getOperationName`
    pub fn as_str(self) -> &'static str {
        match self {
            Self::WriteFillBuffer => "write_fill_buffer",
            Self::WriteUpdateBuffer => "write_update_buffer",
            Self::WriteCopyBuffer => "write_copy_buffer",
            Self::WriteCopyBufferToImage => "write_copy_buffer_to_image",
            Self::WriteCopyImageToBuffer => "write_copy_image_to_buffer",
            Self::WriteCopyImage => "write_copy_image",
            Self::WriteBlitImage => "write_blit_image",
            Self::WriteClearColorImage => "write_clear_color_image",
            Self::WriteClearDepthStencilImage => "write_clear_depth_stencil_image",
            Self::WriteSsboCompute => "write_ssbo_compute",
            Self::WriteSsboComputeIndirect => "write_ssbo_compute_indirect",
            Self::WriteImageCompute => "write_image_compute",
            Self::WriteImageComputeIndirect => "write_image_compute_indirect",
            Self::WriteSsboVertex => "write_ssbo_vertex",
            Self::WriteSsboFragment => "write_ssbo_fragment",
            Self::WriteImageVertex => "write_image_vertex",
            Self::WriteImageFragment => "write_image_fragment",
            Self::WriteDraw => "write_draw",
            Self::WriteDrawIndexed => "write_draw_indexed",
            Self::WriteDrawIndirect => "write_draw_indirect",
            Self::WriteDrawIndexedIndirect => "write_draw_indexed_indirect",
            Self::WriteClearAttachments => "write_clear_attachments",
            Self::ReadCopyBuffer => "read_copy_buffer",
            Self::ReadCopyBufferToImage => "read_copy_buffer_to_image",
            Self::ReadCopyImageToBuffer => "read_copy_image_to_buffer",
            Self::ReadCopyImage => "read_copy_image",
            Self::ReadBlitImage => "read_blit_image",
            Self::ReadResolveImage => "read_resolve_image",
            Self::ReadUboCompute => "read_ubo_compute",
            Self::ReadUboComputeIndirect => "read_ubo_compute_indirect",
            Self::ReadUboTexelCompute => "read_ubo_texel_compute",
            Self::ReadUboTexelComputeIndirect => "read_ubo_texel_compute_indirect",
            Self::ReadSsboCompute => "read_ssbo_compute",
            Self::ReadSsboComputeIndirect => "read_ssbo_compute_indirect",
            Self::ReadImageCompute => "read_image_compute",
            Self::ReadImageComputeIndirect => "read_image_compute_indirect",
            Self::ReadSsboVertex => "read_ssbo_vertex",
            Self::ReadSsboFragment => "read_ssbo_fragment",
            Self::ReadImageVertex => "read_image_vertex",
            Self::ReadImageFragment => "read_image_fragment",
            Self::ReadUboVertex => "read_ubo_vertex",
            Self::ReadUboFragment => "read_ubo_fragment",
            Self::ReadUboTexelVertex => "read_ubo_texel_vertex",
            Self::ReadUboTexelFragment => "read_ubo_texel_fragment",
            Self::ReadVertexInput => "read_vertex_input",
        }
    }

    /// The buffer kind and graphics stage a graphics-pipeline buffer operation uses,
    /// or `None` if this operation is not one.
    fn buffer_graphics_kind(self) -> Option<(BufferType, ShaderStage)> {
        match self {
            Self::WriteSsboVertex | Self::ReadSsboVertex => Some((BufferType::Storage, ShaderStage::Vertex)),
            Self::WriteSsboFragment | Self::ReadSsboFragment => Some((BufferType::Storage, ShaderStage::Fragment)),
            Self::ReadUboVertex => Some((BufferType::Uniform, ShaderStage::Vertex)),
            Self::ReadUboFragment => Some((BufferType::Uniform, ShaderStage::Fragment)),
            Self::ReadUboTexelVertex => Some((BufferType::UniformTexel, ShaderStage::Vertex)),
            Self::ReadUboTexelFragment => Some((BufferType::UniformTexel, ShaderStage::Fragment)),
            _ => None,
        }
    }

    /// The buffer kind and dispatch call a shader-based buffer operation uses, or
    /// `None` if this operation is not one.
    fn buffer_shader_kind(self) -> Option<(BufferType, DispatchCall)> {
        match self {
            Self::WriteSsboCompute | Self::ReadSsboCompute => Some((BufferType::Storage, DispatchCall::Dispatch)),
            Self::WriteSsboComputeIndirect | Self::ReadSsboComputeIndirect => Some((BufferType::Storage, DispatchCall::DispatchIndirect)),
            Self::ReadUboCompute => Some((BufferType::Uniform, DispatchCall::Dispatch)),
            Self::ReadUboComputeIndirect => Some((BufferType::Uniform, DispatchCall::DispatchIndirect)),
            Self::ReadUboTexelCompute => Some((BufferType::UniformTexel, DispatchCall::Dispatch)),
            Self::ReadUboTexelComputeIndirect => Some((BufferType::UniformTexel, DispatchCall::DispatchIndirect)),
            _ => None,
        }
    }

    /// `Draw::DrawCall` for the four draw write operations, or `None` otherwise.
    fn draw_call(self) -> Option<DrawCall> {
        match self {
            Self::WriteDraw => Some(DrawCall::Draw),
            Self::WriteDrawIndexed => Some(DrawCall::DrawIndexed),
            Self::WriteDrawIndirect => Some(DrawCall::DrawIndirect),
            Self::WriteDrawIndexedIndirect => Some(DrawCall::DrawIndexedIndirect),
            _ => None,
        }
    }

    /// The graphics stage an image operation runs its copy in, or `None` if this
    /// operation is not one.
    fn image_graphics_kind(self) -> Option<ShaderStage> {
        match self {
            Self::WriteImageVertex | Self::ReadImageVertex => Some(ShaderStage::Vertex),
            Self::WriteImageFragment | Self::ReadImageFragment => Some(ShaderStage::Fragment),
            _ => None,
        }
    }

    /// The dispatch call an image-shader operation uses, or `None` if this operation
    /// is not one.
    fn image_shader_kind(self) -> Option<DispatchCall> {
        match self {
            Self::WriteImageCompute | Self::ReadImageCompute => Some(DispatchCall::Dispatch),
            Self::WriteImageComputeIndirect | Self::ReadImageComputeIndirect => Some(DispatchCall::DispatchIndirect),
            _ => None,
        }
    }

    /// `isSpecializedAccessFlagSupported` - which operations have a
    /// `_specialized_access_flag` variant under synchronization2.
    pub fn has_specialized_access_flag(self) -> bool {
        matches!(
            self,
            Self::WriteSsboCompute
                | Self::WriteSsboComputeIndirect
                | Self::ReadUboCompute
                | Self::ReadUboComputeIndirect
                | Self::ReadUboTexelCompute
                | Self::ReadUboTexelComputeIndirect
                | Self::ReadSsboCompute
                | Self::ReadSsboComputeIndirect
                | Self::WriteImageCompute
                | Self::WriteImageComputeIndirect
                | Self::ReadImageCompute
                | Self::ReadImageComputeIndirect
                | Self::WriteSsboVertex
                | Self::WriteSsboFragment
                | Self::ReadSsboVertex
                | Self::ReadSsboFragment
                | Self::ReadUboVertex
                | Self::ReadUboFragment
                | Self::ReadUboTexelVertex
                | Self::ReadUboTexelFragment
                | Self::WriteImageVertex
                | Self::WriteImageFragment
                | Self::ReadImageVertex
                | Self::ReadImageFragment
        )
    }

    /// `isResourceSupported` - which resources this operation can act on at all.
    pub fn supports_resource(self, resource: &ResourceDescription) -> bool {
        let single_sampled_color_image =
            resource.kind == ResourceType::Image && resource.image_aspect == vk::ImageAspectFlags::COLOR && resource.image_samples == vk::SampleCountFlags::_1;

        match self {
            Self::WriteFillBuffer
            | Self::WriteCopyBuffer
            | Self::WriteCopyImageToBuffer
            | Self::ReadCopyBuffer
            | Self::ReadCopyBufferToImage
            | Self::WriteSsboCompute
            | Self::WriteSsboComputeIndirect
            | Self::ReadSsboCompute
            | Self::ReadSsboComputeIndirect
            | Self::WriteSsboVertex
            | Self::WriteSsboFragment
            | Self::ReadSsboVertex
            | Self::ReadSsboFragment => resource.kind == ResourceType::Buffer,
            // The uniform kinds, texel included, are capped by the guaranteed
            // maxUniformBufferRange.
            Self::ReadUboCompute
            | Self::ReadUboComputeIndirect
            | Self::ReadUboTexelCompute
            | Self::ReadUboTexelComputeIndirect
            | Self::ReadUboVertex
            | Self::ReadUboFragment
            | Self::ReadUboTexelVertex
            | Self::ReadUboTexelFragment => resource.kind == ResourceType::Buffer && resource.size[0] <= MAX_UBO_RANGE,
            Self::WriteUpdateBuffer => resource.kind == ResourceType::Buffer && resource.size[0] <= MAX_UPDATE_BUFFER_SIZE,
            // `VertexInput::Support` asserts a plain or index buffer; the vertex draw
            // mode takes the plain one.
            Self::ReadVertexInput => resource.kind == ResourceType::Buffer,
            Self::WriteCopyImage | Self::WriteCopyBufferToImage | Self::ReadCopyImage | Self::ReadCopyImageToBuffer => {
                resource.kind == ResourceType::Image && resource.image_samples == vk::SampleCountFlags::_1
            }
            Self::ReadResolveImage => {
                resource.kind == ResourceType::Image && resource.image_aspect == vk::ImageAspectFlags::COLOR && resource.image_samples != vk::SampleCountFlags::_1
            }
            Self::WriteBlitImage
            | Self::ReadBlitImage
            | Self::WriteClearColorImage
            | Self::WriteImageCompute
            | Self::WriteImageComputeIndirect
            | Self::ReadImageCompute
            | Self::ReadImageComputeIndirect
            | Self::WriteImageVertex
            | Self::WriteImageFragment
            | Self::ReadImageVertex
            | Self::ReadImageFragment => single_sampled_color_image,
            // `Draw::Support` asserts a 2D colour image; a 1D or 3D resource cannot
            // be a colour attachment here.
            Self::WriteDraw | Self::WriteDrawIndexed | Self::WriteDrawIndirect | Self::WriteDrawIndexedIndirect => {
                single_sampled_color_image && resource.image_type == vk::ImageType::_2D
            }
            // A 3D image cannot be a framebuffer attachment here.
            Self::WriteClearAttachments => resource.kind == ResourceType::Image && resource.image_type != vk::ImageType::_3D && resource.image_samples == vk::SampleCountFlags::_1,
            Self::WriteClearDepthStencilImage => {
                resource.kind == ResourceType::Image
                    && resource.image_aspect.intersects(vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL)
                    && resource.image_samples == vk::SampleCountFlags::_1
            }
        }
    }

    /// `opCanRunOnCompute` - an allow-list upstream, so a graphics-stage operation
    /// never grows a compute-queue variant by omission.
    pub fn can_run_on_compute(self) -> bool {
        matches!(
            self,
            Self::WriteFillBuffer
                | Self::WriteUpdateBuffer
                | Self::WriteCopyBuffer
                | Self::WriteCopyBufferToImage
                | Self::WriteCopyImageToBuffer
                | Self::WriteCopyImage
                | Self::WriteSsboCompute
                | Self::WriteSsboComputeIndirect
                | Self::WriteImageCompute
                | Self::WriteImageComputeIndirect
                | Self::WriteClearColorImage
                | Self::WriteClearDepthStencilImage
                | Self::ReadCopyBuffer
                | Self::ReadCopyBufferToImage
                | Self::ReadCopyImageToBuffer
                | Self::ReadCopyImage
                | Self::ReadUboCompute
                | Self::ReadUboComputeIndirect
                | Self::ReadUboTexelCompute
                | Self::ReadUboTexelComputeIndirect
                | Self::ReadSsboCompute
                | Self::ReadSsboComputeIndirect
                | Self::ReadImageCompute
                | Self::ReadImageComputeIndirect
        )
    }

    /// `OperationSupport::getInResourceUsageFlags` /`getOutResourceUsageFlags`.
    ///
    /// `VK_BUFFER_USAGE_TRANSFER_SRC_BIT` and `VK_IMAGE_USAGE_TRANSFER_SRC_BIT` are
    /// the same bit, which is why upstream carries the usage as a bare uint32 and
    /// does not have to know whether the resource is a buffer or an image here.
    pub fn in_resource_usage(self, resource: &ResourceDescription) -> u32 {
        if self.image_shader_kind().is_some() || self.image_graphics_kind().is_some() {
            return vk::ImageUsageFlags::STORAGE.bits();
        }
        let _ = resource;
        // A draw or an attachment clear writes the resource and reads nothing.
        if self.draw_call().is_some() || self == Self::WriteClearAttachments {
            return 0;
        }
        if self == Self::ReadVertexInput {
            return vk::BufferUsageFlags::VERTEX_BUFFER.bits();
        }
        match self.buffer_shader_kind().map(|(t, _)| t).or(self.buffer_graphics_kind().map(|(t, _)| t)).map(|t| (t, ())) {
            Some((buffer_type, _)) if self.is_read() => match buffer_type {
                BufferType::Uniform => vk::BufferUsageFlags::UNIFORM_BUFFER.bits(),
                BufferType::UniformTexel => vk::BufferUsageFlags::UNIFORM_TEXEL_BUFFER.bits(),
                BufferType::Storage => vk::BufferUsageFlags::STORAGE_BUFFER.bits(),
            },
            Some(_) => 0,
            None if self.is_read() => vk::BufferUsageFlags::TRANSFER_SRC.bits(),
            None => 0,
        }
    }

    pub fn out_resource_usage(self, resource: &ResourceDescription) -> u32 {
        if self.image_shader_kind().is_some() || self.image_graphics_kind().is_some() {
            return vk::ImageUsageFlags::STORAGE.bits();
        }
        if self.draw_call().is_some() {
            return vk::ImageUsageFlags::COLOR_ATTACHMENT.bits();
        }
        if self == Self::ReadVertexInput {
            return vk::BufferUsageFlags::VERTEX_BUFFER.bits();
        }
        if self == Self::WriteClearAttachments {
            return if resource.image_aspect == vk::ImageAspectFlags::COLOR {
                vk::ImageUsageFlags::COLOR_ATTACHMENT.bits()
            } else {
                vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT.bits()
            };
        }
        match self.buffer_shader_kind().map(|(t, _)| t).or(self.buffer_graphics_kind().map(|(t, _)| t)).map(|t| (t, ())) {
            // Upstream asks for the texel usage on the *read* side here, not the
            // write side, unlike the other two. Kept as it is: the flag is harmless
            // and a resource created without it would differ from upstream's.
            Some((BufferType::UniformTexel, _)) => vk::BufferUsageFlags::UNIFORM_TEXEL_BUFFER.bits(),
            Some((buffer_type, _)) if !self.is_read() => match buffer_type {
                BufferType::Uniform => vk::BufferUsageFlags::UNIFORM_BUFFER.bits(),
                BufferType::UniformTexel => unreachable!("handled above"),
                BufferType::Storage => vk::BufferUsageFlags::STORAGE_BUFFER.bits(),
            },
            Some(_) => 0,
            None if self.is_read() => 0,
            None => vk::BufferUsageFlags::TRANSFER_DST.bits(),
        }
    }

    /// Whether this is one of `s_readOps` rather than one of `s_writeOps`.
    ///
    /// Derived from the name rather than listed: a hand-maintained list silently
    /// classified two newly added read operations as writes, which made the test
    /// compare one operation's fill pattern against the other's and pass.
    pub fn is_read(self) -> bool {
        self.as_str().starts_with("read_")
    }

    /// `OperationSupport::checkSupport` - only the blit path has one: a blit needs the
    /// format to advertise the transfer features it filters with.
    pub fn needs_blit_format_support(self) -> bool {
        matches!(self, Self::WriteBlitImage | Self::ReadBlitImage)
    }

    /// `OperationSupport::getQueueFlags` - the queue capabilities the operation needs.
    ///
    /// A transfer of a depth or stencil aspect may need a format conversion, which the
    /// spec only requires of a queue that also supports graphics; every other pure
    /// transfer is happy on a transfer-only queue.
    pub fn queue_flags(self, resource: &ResourceDescription) -> vk::QueueFlags {
        match self {
            // `FillUpdateBuffer`: without VK_KHR_maintenance1 `vkCmdFillBuffer` is not
            // allowed on a transfer-only queue. maintenance1 is core in 1.1, so this is
            // the 1.0 branch; the check is kept because the queue pairs a case runs on
            // depend on it.
            Self::WriteFillBuffer | Self::WriteUpdateBuffer => vk::QueueFlags::TRANSFER,
            Self::WriteClearColorImage => vk::QueueFlags::GRAPHICS | vk::QueueFlags::COMPUTE,
            Self::WriteClearDepthStencilImage => vk::QueueFlags::GRAPHICS,
            _ => {
                if let Some((_, stage)) = self.buffer_graphics_kind() {
                    let _ = stage;
                    return vk::QueueFlags::GRAPHICS;
                }
                if self.image_graphics_kind().is_some() || self.draw_call().is_some() || self == Self::WriteClearAttachments || self == Self::ReadVertexInput {
                    return vk::QueueFlags::GRAPHICS;
                }
                if self.buffer_shader_kind().is_some() || self.image_shader_kind().is_some() {
                    return vk::QueueFlags::COMPUTE;
                }
                if self.needs_graphics_queue(resource) {
                    vk::QueueFlags::GRAPHICS
                } else {
                    vk::QueueFlags::TRANSFER
                }
            }
        }
    }

    /// The graphics-only half of `getQueueFlags`, kept separate because the event
    /// cases ask it directly when deciding whether a compute-queue variant exists.
    pub fn needs_graphics_queue(self, resource: &ResourceDescription) -> bool {
        match self {
            Self::WriteBlitImage | Self::ReadBlitImage | Self::ReadResolveImage => true,
            Self::WriteClearDepthStencilImage => true,
            Self::WriteCopyImage | Self::ReadCopyImage => resource.kind == ResourceType::Image && is_depth_stencil_format(resource.image_format),
            Self::WriteCopyBufferToImage | Self::ReadCopyBufferToImage | Self::WriteCopyImageToBuffer | Self::ReadCopyImageToBuffer => {
                resource.kind == ResourceType::Image && is_depth_stencil_format(resource.image_format)
            }
            _ => false,
        }
    }
}

/// `OperationSupport::build`
pub fn build_operation<'a>(
    device: &'a Device,
    allocator: &crate::vk::mem_util::SimpleAllocator,
    name: OperationName,
    desc: &ResourceDescription,
    resource: &Resource<'_>,
    specialized_access: bool,
) -> Result<Box<dyn Operation + 'a>, TestError> {
    if name == OperationName::ReadVertexInput {
        return Ok(Box::new(VertexInputAccess::new(device, allocator, resource)?));
    }
    if name == OperationName::WriteClearAttachments {
        return Ok(Box::new(ClearAttachments::new(device, resource)?));
    }
    if let Some(draw_call) = name.draw_call() {
        return Ok(Box::new(DrawOperation::new(device, allocator, resource, draw_call)?));
    }
    if let Some(stage) = name.image_graphics_kind() {
        let mode = if name.is_read() { AccessMode::Read } else { AccessMode::Write };
        return Ok(Box::new(ImageGraphicsAccess::new(device, allocator, desc, resource, mode, stage, specialized_access)?));
    }
    if let Some(dispatch_call) = name.image_shader_kind() {
        let mode = if name.is_read() { AccessMode::Read } else { AccessMode::Write };
        return Ok(Box::new(ImageShaderAccess::new(
            device,
            allocator,
            desc,
            resource,
            mode,
            dispatch_call,
            specialized_access,
        )?));
    }
    if let Some((buffer_type, stage)) = name.buffer_graphics_kind() {
        let mode = if name.is_read() { AccessMode::Read } else { AccessMode::Write };
        return Ok(Box::new(BufferGraphicsAccess::new(
            device,
            allocator,
            resource,
            buffer_type,
            mode,
            stage,
            specialized_access,
        )?));
    }
    if let Some((buffer_type, dispatch_call)) = name.buffer_shader_kind() {
        let mode = if name.is_read() { AccessMode::Read } else { AccessMode::Write };
        return Ok(Box::new(BufferShaderAccess::new(
            device,
            allocator,
            resource,
            buffer_type,
            mode,
            dispatch_call,
            specialized_access,
        )?));
    }
    Ok(match name {
        OperationName::WriteFillBuffer => Box::new(FillUpdateBuffer::new(resource, true)),
        OperationName::WriteUpdateBuffer => Box::new(FillUpdateBuffer::new(resource, false)),
        OperationName::WriteCopyBuffer => Box::new(CopyBuffer::new(device, allocator, resource, AccessMode::Write)?),
        OperationName::ReadCopyBuffer => Box::new(CopyBuffer::new(device, allocator, resource, AccessMode::Read)?),
        OperationName::WriteCopyBufferToImage => Box::new(CopyBufferToImageWrite::new(device, allocator, resource)?),
        OperationName::ReadCopyBufferToImage => Box::new(CopyBufferToImageRead::new(device, allocator, resource)?),
        OperationName::WriteCopyImageToBuffer => Box::new(CopyImageToBufferWrite::new(device, allocator, resource)?),
        OperationName::ReadCopyImageToBuffer => Box::new(CopyImageToBufferRead::new(device, allocator, resource)?),
        OperationName::WriteCopyImage => Box::new(CopyBlitResolveImage::new(device, allocator, resource, ImageCopyKind::Copy, AccessMode::Write)?),
        OperationName::ReadCopyImage => Box::new(CopyBlitResolveImage::new(device, allocator, resource, ImageCopyKind::Copy, AccessMode::Read)?),
        OperationName::WriteBlitImage => Box::new(CopyBlitResolveImage::new(device, allocator, resource, ImageCopyKind::Blit, AccessMode::Write)?),
        OperationName::ReadBlitImage => Box::new(CopyBlitResolveImage::new(device, allocator, resource, ImageCopyKind::Blit, AccessMode::Read)?),
        OperationName::ReadResolveImage => Box::new(CopyBlitResolveImage::new(device, allocator, resource, ImageCopyKind::Resolve, AccessMode::Read)?),
        OperationName::WriteClearColorImage => Box::new(ClearImage::new(resource, true)?),
        OperationName::WriteClearDepthStencilImage => Box::new(ClearImage::new(resource, false)?),
        _ => unreachable!("every shader-based operation is handled above"),
    })
}

/// `s_writeOps`, restricted to the transfer operations.
pub static WRITE_OPS: &[OperationName] = &[
    OperationName::WriteFillBuffer,
    OperationName::WriteUpdateBuffer,
    OperationName::WriteCopyBuffer,
    OperationName::WriteCopyBufferToImage,
    OperationName::WriteCopyImageToBuffer,
    OperationName::WriteCopyImage,
    OperationName::WriteBlitImage,
    OperationName::WriteSsboCompute,
    OperationName::WriteSsboComputeIndirect,
    OperationName::WriteImageCompute,
    OperationName::WriteImageComputeIndirect,
    OperationName::WriteSsboVertex,
    OperationName::WriteSsboFragment,
    OperationName::WriteImageVertex,
    OperationName::WriteImageFragment,
    OperationName::WriteClearColorImage,
    OperationName::WriteDraw,
    OperationName::WriteDrawIndexed,
    OperationName::WriteDrawIndirect,
    OperationName::WriteDrawIndexedIndirect,
    OperationName::WriteClearDepthStencilImage,
    OperationName::WriteClearAttachments,
];

/// `s_readOps`, restricted to the transfer operations.
pub static READ_OPS: &[OperationName] = &[
    OperationName::ReadCopyBuffer,
    OperationName::ReadCopyBufferToImage,
    OperationName::ReadCopyImageToBuffer,
    OperationName::ReadCopyImage,
    OperationName::ReadBlitImage,
    OperationName::ReadResolveImage,
    OperationName::ReadUboCompute,
    OperationName::ReadUboComputeIndirect,
    OperationName::ReadUboTexelCompute,
    OperationName::ReadUboTexelComputeIndirect,
    OperationName::ReadSsboCompute,
    OperationName::ReadSsboComputeIndirect,
    OperationName::ReadImageCompute,
    OperationName::ReadImageComputeIndirect,
    OperationName::ReadSsboVertex,
    OperationName::ReadSsboFragment,
    OperationName::ReadImageVertex,
    OperationName::ReadImageFragment,
    OperationName::ReadUboVertex,
    OperationName::ReadUboFragment,
    OperationName::ReadUboTexelVertex,
    OperationName::ReadUboTexelFragment,
    OperationName::ReadVertexInput,
];

/// `CopyImageToBuffer::WriteImplementation` - the resource is a buffer, written by
/// pushing a host buffer through a scratch image and copying that image back out.
pub struct CopyImageToBufferWrite<'a> {
    buffer: BufferInfo,
    image: ImageWithMemory<'a>,
    image_extent: vk::Extent3D,
    host_buffer: BufferWithMemory<'a>,
    subresource_range: vk::ImageSubresourceRange,
    subresource_layers: vk::ImageSubresourceLayers,
}

impl<'a> CopyImageToBufferWrite<'a> {
    pub fn new(device: &'a Device, allocator: &crate::vk::mem_util::SimpleAllocator, resource: &Resource<'_>) -> Result<Self, TestError> {
        let buffer = resource.buffer();
        let image_extent = get_2d_image_extent_with_size(buffer.size, 4);
        let info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(vk::Format::R8G8B8A8_UNORM)
            .extent(image_extent)
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();

        Ok(Self {
            host_buffer: make_host_buffer(device, allocator, buffer.size, vk::BufferUsageFlags::TRANSFER_SRC, AccessMode::Write)?,
            image: ImageWithMemory::new(device, allocator, info, MemoryRequirement::ANY)?,
            buffer,
            image_extent,
            subresource_range: color_subresource_range(),
            subresource_layers: color_subresource_layers(),
        })
    }
}

impl Operation for CopyImageToBufferWrite<'_> {
    fn record_commands(&self, device: &Device, sync: SyncType, cmd_buffer: vk::CommandBuffer) {
        let region = [make_buffer_image_copy(self.image_extent, self.subresource_layers)];

        // Host buffer -> image
        let to_dst = make_image_memory_barrier2(
            vk::PipelineStageFlags2::TOP_OF_PIPE,
            vk::AccessFlags2::empty(),
            vk::PipelineStageFlags2::ALL_TRANSFER,
            vk::AccessFlags2::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            self.image.get(),
            self.subresource_range,
        );
        cmd_pipeline_barrier(device, sync, cmd_buffer, &[], &[to_dst]);
        unsafe {
            device.cmd_copy_buffer_to_image(cmd_buffer, self.host_buffer.get(), self.image.get(), vk::ImageLayout::TRANSFER_DST_OPTIMAL, &region);
        }

        // Image -> resource buffer
        let to_src = make_image_memory_barrier2(
            vk::PipelineStageFlags2::ALL_TRANSFER,
            vk::AccessFlags2::TRANSFER_WRITE,
            vk::PipelineStageFlags2::ALL_TRANSFER,
            vk::AccessFlags2::TRANSFER_READ,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            self.image.get(),
            self.subresource_range,
        );
        cmd_pipeline_barrier(device, sync, cmd_buffer, &[], &[to_src]);
        unsafe {
            device.cmd_copy_image_to_buffer(cmd_buffer, self.image.get(), vk::ImageLayout::TRANSFER_SRC_OPTIMAL, self.buffer.handle, &region);
        }
    }

    fn out_sync_info(&self, _sync: SyncType) -> SyncInfo {
        SyncInfo {
            stage_mask: vk::PipelineStageFlags2::ALL_TRANSFER,
            access_mask: vk::AccessFlags2::TRANSFER_WRITE,
            image_layout: vk::ImageLayout::UNDEFINED,
        }
    }

    fn data(&self, device: &Device) -> Result<Vec<u8>, TestError> {
        host_buffer_data(device, &self.host_buffer, self.buffer.size)
    }
}

/// `CopyImageToBuffer::ReadImplementation` - the resource is an image, read straight
/// into a host buffer with no staging image in between.
pub struct CopyImageToBufferRead<'a> {
    image: ImageInfo,
    host_buffer: BufferWithMemory<'a>,
    buffer_size: vk::DeviceSize,
}

impl<'a> CopyImageToBufferRead<'a> {
    pub fn new(device: &'a Device, allocator: &crate::vk::mem_util::SimpleAllocator, resource: &Resource<'_>) -> Result<Self, TestError> {
        let image = resource.image();
        let buffer_size = get_pixel_buffer_size(image.format, image.extent)?;
        Ok(Self {
            host_buffer: make_host_buffer(device, allocator, buffer_size, vk::BufferUsageFlags::TRANSFER_DST, AccessMode::Read)?,
            image,
            buffer_size,
        })
    }
}

impl Operation for CopyImageToBufferRead<'_> {
    fn record_commands(&self, device: &Device, sync: SyncType, cmd_buffer: vk::CommandBuffer) {
        let region = [make_buffer_image_copy(self.image.extent, self.image.subresource_layers)];
        unsafe {
            device.cmd_copy_image_to_buffer(cmd_buffer, self.image.handle, vk::ImageLayout::TRANSFER_SRC_OPTIMAL, self.host_buffer.get(), &region);
        }
        let to_host = make_buffer_memory_barrier2(
            vk::PipelineStageFlags2::ALL_TRANSFER,
            vk::AccessFlags2::TRANSFER_WRITE,
            vk::PipelineStageFlags2::HOST,
            vk::AccessFlags2::HOST_READ,
            self.host_buffer.get(),
            0,
            vk::WHOLE_SIZE,
        );
        cmd_pipeline_barrier(device, sync, cmd_buffer, &[to_host], &[]);
    }

    fn in_sync_info(&self, _sync: SyncType) -> SyncInfo {
        SyncInfo {
            stage_mask: vk::PipelineStageFlags2::ALL_TRANSFER,
            access_mask: vk::AccessFlags2::TRANSFER_READ,
            image_layout: vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        }
    }

    fn data(&self, device: &Device) -> Result<Vec<u8>, TestError> {
        host_buffer_data(device, &self.host_buffer, self.buffer_size)
    }
}

fn color_subresource_range() -> vk::ImageSubresourceRange {
    vk::ImageSubresourceRange {
        aspect_mask: vk::ImageAspectFlags::COLOR,
        base_mip_level: 0,
        level_count: 1,
        base_array_layer: 0,
        layer_count: 1,
    }
}

fn color_subresource_layers() -> vk::ImageSubresourceLayers {
    vk::ImageSubresourceLayers {
        aspect_mask: vk::ImageAspectFlags::COLOR,
        mip_level: 0,
        base_array_layer: 0,
        layer_count: 1,
    }
}

// ---------------------------------------------------------------------------------
// Shader-based buffer access
// ---------------------------------------------------------------------------------

/// The manifest declares its shaders with this: the compute program plus what it was
/// generated for, so the host can assert it picked the right one.
pub struct BufferAccessShader {
    pub name: &'static str,
    pub buffer_type: &'static str,
    pub mode: &'static str,
    pub buffer_size: u32,
    pub programs: crate::vk::programs::BinaryCollection,
}

use crate::generated::shaders::synchronization_buffer::ALL_BUFFER_ACCESS_SHADER;

/// `BufferType`
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum BufferType {
    Uniform,
    UniformTexel,
    Storage,
}

impl BufferType {
    fn manifest_name(self) -> &'static str {
        match self {
            Self::Uniform => "ubo",
            Self::UniformTexel => "ubo_texel",
            Self::Storage => "ssbo",
        }
    }

    fn descriptor_type(self) -> vk::DescriptorType {
        match self {
            Self::Uniform => vk::DescriptorType::UNIFORM_BUFFER,
            Self::UniformTexel => vk::DescriptorType::UNIFORM_TEXEL_BUFFER,
            Self::Storage => vk::DescriptorType::STORAGE_BUFFER,
        }
    }
}

/// `DispatchCall`
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum DispatchCall {
    Dispatch,
    DispatchIndirect,
}

/// `BufferImplementation` on a compute pipeline.
///
/// The shader is a passthrough: it copies the whole resource into a host-visible
/// buffer, or the whole host buffer into the resource. Everything interesting is in
/// the sync info it reports, which is what the primitive under test has to honour.
pub struct BufferShaderAccess<'a> {
    buffer: BufferInfo,
    host_buffer: BufferWithMemory<'a>,
    // Held only so the descriptor keeps pointing at a live object.
    _buffer_view: Option<crate::vk::ref_util::Unique<'a, vk::BufferView>>,
    _descriptor_set_layout: crate::vk::ref_util::Unique<'a, vk::DescriptorSetLayout>,
    // Declared before the pool it came from: struct fields drop in declaration order,
    // and freeing a set back into an already-destroyed pool is a use-after-free.
    descriptor_set: crate::vk::ref_util::UniqueDescriptorSet<'a>,
    _descriptor_pool: crate::vk::ref_util::Unique<'a, vk::DescriptorPool>,
    pipeline_layout: crate::vk::ref_util::Unique<'a, vk::PipelineLayout>,
    pipeline: crate::vk::ref_util::Unique<'a, vk::Pipeline>,
    indirect_buffer: Option<BufferWithMemory<'a>>,
    buffer_type: BufferType,
    mode: AccessMode,
    specialized_access: bool,
}

impl<'a> BufferShaderAccess<'a> {
    pub fn new(
        device: &'a Device,
        allocator: &crate::vk::mem_util::SimpleAllocator,
        resource: &Resource<'_>,
        buffer_type: BufferType,
        mode: AccessMode,
        dispatch_call: DispatchCall,
        specialized_access: bool,
    ) -> Result<Self, TestError> {
        use crate::vk::obj_util::make_pipeline_layout;
        use crate::vk::programs::create_shader_module;
        use crate::vk::ref_util::Unique;

        let buffer = resource.buffer();
        let host_buffer = make_host_buffer(device, allocator, buffer.size, vk::BufferUsageFlags::STORAGE_BUFFER, mode)?;

        let d = build_buffer_descriptors(device, &buffer, &host_buffer, buffer_type, mode, vk::ShaderStageFlags::COMPUTE)?;

        // `ComputePipeline`
        let indirect_buffer = if dispatch_call == DispatchCall::DispatchIndirect {
            let size = std::mem::size_of::<vk::DispatchIndirectCommand>() as vk::DeviceSize;
            let indirect = BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(size, vk::BufferUsageFlags::INDIRECT_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            unsafe {
                indirect
                    .get_allocation()
                    .get_host_ptr()
                    .cast::<vk::DispatchIndirectCommand>()
                    .write(vk::DispatchIndirectCommand { x: 1, y: 1, z: 1 });
            }
            flush_alloc(device, indirect.get_allocation())?;
            Some(indirect)
        } else {
            None
        };

        let shader = find_buffer_shader(buffer_type, mode, buffer.size as u32);
        let module = create_shader_module(device, shader.programs.get("comp")?)?;
        let pipeline_layout = make_pipeline_layout(device, &[*d.layout])?;
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*module)
            .name(c"main".to_bytes_with_nul())
            .build();
        let info = vk::ComputePipelineCreateInfo::builder().stage(stage).layout(*pipeline_layout);
        let handle = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[info], None) }
            .vk_check("vkCreateComputePipelines")?
            .0[0];

        Ok(Self {
            buffer,
            host_buffer,
            _buffer_view: d.view,
            _descriptor_set_layout: d.layout,
            descriptor_set: d.set,
            _descriptor_pool: d.pool,
            pipeline_layout,
            pipeline: Unique::new(device, handle),
            indirect_buffer,
            buffer_type,
            mode,
            specialized_access,
        })
    }
}

/// Looks the compute program up by what it was generated for, rather than by a name
/// assembled twice.
fn find_buffer_shader(buffer_type: BufferType, mode: AccessMode, size: u32) -> &'static BufferAccessShader {
    let mode_name = if mode == AccessMode::Read { "read" } else { "write" };
    ALL_BUFFER_ACCESS_SHADER
        .iter()
        .copied()
        .find(|s| s.buffer_type == buffer_type.manifest_name() && s.mode == mode_name && s.buffer_size == size)
        .expect("the generator covers every combination the resource table produces")
}

impl Operation for BufferShaderAccess<'_> {
    fn record_commands(&self, device: &Device, sync: SyncType, cmd_buffer: vk::CommandBuffer) {
        unsafe {
            device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::COMPUTE, *self.pipeline);
            device.cmd_bind_descriptor_sets(cmd_buffer, vk::PipelineBindPoint::COMPUTE, *self.pipeline_layout, 0, &[*self.descriptor_set], &[] as &[u32]);
            match &self.indirect_buffer {
                Some(indirect) => device.cmd_dispatch_indirect(cmd_buffer, indirect.get(), 0),
                None => device.cmd_dispatch(cmd_buffer, 1, 1, 1),
            }
        }

        if self.mode == AccessMode::Read {
            // Make what the shader wrote available to the host.
            let barrier = make_buffer_memory_barrier2(
                vk::PipelineStageFlags2::COMPUTE_SHADER,
                vk::AccessFlags2::SHADER_WRITE,
                vk::PipelineStageFlags2::HOST,
                vk::AccessFlags2::HOST_READ,
                self.host_buffer.get(),
                0,
                self.buffer.size,
            );
            cmd_pipeline_barrier(device, sync, cmd_buffer, &[barrier], &[]);
        }
    }

    fn in_sync_info(&self, _sync: SyncType) -> SyncInfo {
        SyncInfo {
            stage_mask: vk::PipelineStageFlags2::COMPUTE_SHADER,
            access_mask: buffer_access_mask(self.buffer_type, self.mode, self.specialized_access),
            image_layout: vk::ImageLayout::UNDEFINED,
        }
    }

    fn out_sync_info(&self, _sync: SyncType) -> SyncInfo {
        SyncInfo {
            stage_mask: vk::PipelineStageFlags2::COMPUTE_SHADER,
            access_mask: buffer_access_mask(self.buffer_type, self.mode, self.specialized_access),
            image_layout: vk::ImageLayout::UNDEFINED,
        }
    }

    fn data(&self, device: &Device) -> Result<Vec<u8>, TestError> {
        host_buffer_data(device, &self.host_buffer, self.buffer.size)
    }
}

/// `getInSyncInfo`/`getOutSyncInfo`' access mask, shared by both pipeline flavours.
///
/// The `_specialized_access_flag` variants are the point of the distinction:
/// synchronization2 splits SHADER_READ/WRITE into per-resource-kind flags, and naming
/// the narrow one has to order the same things as naming the broad one.
fn buffer_access_mask(buffer_type: BufferType, mode: AccessMode, specialized_access: bool) -> vk::AccessFlags2 {
    if mode == AccessMode::Write {
        return if specialized_access {
            vk::AccessFlags2::SHADER_STORAGE_WRITE
        } else {
            vk::AccessFlags2::SHADER_WRITE
        };
    }
    match buffer_type {
        BufferType::Uniform => vk::AccessFlags2::UNIFORM_READ,
        BufferType::UniformTexel => {
            if specialized_access {
                vk::AccessFlags2::SHADER_SAMPLED_READ
            } else {
                vk::AccessFlags2::SHADER_READ
            }
        }
        BufferType::Storage => {
            if specialized_access {
                vk::AccessFlags2::SHADER_STORAGE_READ
            } else {
                vk::AccessFlags2::SHADER_READ
            }
        }
    }
}

/// What `BufferImplementation`'s "prepare descriptors" block builds. A read binds the
/// resource at 0 and the host buffer at 1; a write binds them the other way round,
/// which is how one shader serves both directions.
struct BufferDescriptors<'a> {
    layout: crate::vk::ref_util::Unique<'a, vk::DescriptorSetLayout>,
    pool: crate::vk::ref_util::Unique<'a, vk::DescriptorPool>,
    set: crate::vk::ref_util::UniqueDescriptorSet<'a>,
    view: Option<crate::vk::ref_util::Unique<'a, vk::BufferView>>,
}

fn build_buffer_descriptors<'a>(
    device: &'a Device,
    buffer: &BufferInfo,
    host_buffer: &BufferWithMemory<'_>,
    buffer_type: BufferType,
    mode: AccessMode,
    stage_flags: vk::ShaderStageFlags,
) -> Result<BufferDescriptors<'a>, TestError> {
    use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
    use crate::vk::obj_util::make_descriptor_set;
    use crate::vk::ref_util::Unique;

    let descriptor_type = buffer_type.descriptor_type();
    let layout = DescriptorSetLayoutBuilder::new()
        .add_indexed_binding(
            if mode == AccessMode::Read {
                descriptor_type
            } else {
                vk::DescriptorType::STORAGE_BUFFER
            },
            stage_flags,
            0,
            1,
        )
        .add_indexed_binding(vk::DescriptorType::STORAGE_BUFFER, stage_flags, 1, 1)
        .build(device)?;
    let pool = DescriptorPoolBuilder::new()
        .add_type(descriptor_type, 1)
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 2)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let set = make_descriptor_set(device, *pool, *layout)?;

    let host_info = [vk::DescriptorBufferInfo {
        buffer: host_buffer.get(),
        offset: 0,
        range: buffer.size,
    }];
    let resource_info = [vk::DescriptorBufferInfo {
        buffer: buffer.handle,
        offset: buffer.offset,
        range: buffer.size,
    }];

    let mut view = None;
    if mode == AccessMode::Read && buffer_type == BufferType::UniformTexel {
        let info = vk::BufferViewCreateInfo::builder()
            .buffer(buffer.handle)
            .format(vk::Format::R32G32B32A32_UINT)
            .offset(buffer.offset)
            .range(buffer.size);
        let handle = unsafe { device.create_buffer_view(&info, None) }.vk_check("vkCreateBufferView")?;
        view = Some(Unique::new(device, handle));
    }
    let views = view.as_ref().map(|v| [**v]);

    let single = |binding: u32, ty: vk::DescriptorType, info: &[vk::DescriptorBufferInfo]| {
        vk::WriteDescriptorSet::builder()
            .dst_set(*set)
            .dst_binding(binding)
            .descriptor_type(ty)
            .buffer_info(info)
            .build()
    };

    let mut writes = Vec::new();
    if mode == AccessMode::Read {
        match &views {
            Some(v) => writes.push(
                vk::WriteDescriptorSet::builder()
                    .dst_set(*set)
                    .dst_binding(0)
                    .descriptor_type(descriptor_type)
                    .texel_buffer_view(v)
                    .build(),
            ),
            None => writes.push(single(0, descriptor_type, &resource_info)),
        }
        writes.push(single(1, vk::DescriptorType::STORAGE_BUFFER, &host_info));
    } else {
        writes.push(single(0, vk::DescriptorType::STORAGE_BUFFER, &host_info));
        writes.push(single(1, vk::DescriptorType::STORAGE_BUFFER, &resource_info));
    }
    unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

    Ok(BufferDescriptors { layout, pool, set, view })
}

/// The manifest declares the image shaders with this. One per single-sampled colour
/// resource: read and write share the GLSL, since which image is the resource is
/// decided by the binding rather than by the shader.
pub struct ImageAccessShader {
    pub name: &'static str,
    pub resource_name: &'static str,
    pub programs: crate::vk::programs::BinaryCollection,
}

use crate::generated::shaders::synchronization_buffer::ALL_IMAGE_ACCESS_SHADER;

/// `ImageImplementation` on a compute pipeline.
///
/// The shader copies one storage image into another; the resource is one of the two
/// and a staging image is the other, so the host can put data in or read it out
/// through a buffer either side of the shader.
pub struct ImageShaderAccess<'a> {
    image: ImageInfo,
    staging: ImageWithMemory<'a>,
    /// The resource is the destination for a write and the source for a read.
    dst_image: vk::Image,
    src_image: vk::Image,
    host_buffer: BufferWithMemory<'a>,
    host_buffer_size: vk::DeviceSize,
    _src_view: crate::vk::ref_util::Unique<'a, vk::ImageView>,
    _dst_view: crate::vk::ref_util::Unique<'a, vk::ImageView>,
    _descriptor_set_layout: crate::vk::ref_util::Unique<'a, vk::DescriptorSetLayout>,
    descriptor_set: crate::vk::ref_util::UniqueDescriptorSet<'a>,
    _descriptor_pool: crate::vk::ref_util::Unique<'a, vk::DescriptorPool>,
    pipeline_layout: crate::vk::ref_util::Unique<'a, vk::PipelineLayout>,
    pipeline: crate::vk::ref_util::Unique<'a, vk::Pipeline>,
    indirect_buffer: Option<BufferWithMemory<'a>>,
    mode: AccessMode,
    specialized_access: bool,
}

impl<'a> ImageShaderAccess<'a> {
    pub fn new(
        device: &'a Device,
        allocator: &crate::vk::mem_util::SimpleAllocator,
        desc: &ResourceDescription,
        resource: &Resource<'_>,
        mode: AccessMode,
        dispatch_call: DispatchCall,
        specialized_access: bool,
    ) -> Result<Self, TestError> {
        use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
        use crate::vk::image_util::make_image_view;
        use crate::vk::obj_util::{make_descriptor_set, make_pipeline_layout};
        use crate::vk::programs::create_shader_module;
        use crate::vk::ref_util::Unique;

        let image = resource.image();
        let host_buffer_size = get_pixel_buffer_size(image.format, image.extent)?;
        let host_buffer = make_host_buffer(
            device,
            allocator,
            host_buffer_size,
            vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
            mode,
        )?;

        let info = vk::ImageCreateInfo::builder()
            .image_type(image.image_type)
            .format(image.format)
            .extent(image.extent)
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::STORAGE)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let staging = ImageWithMemory::new(device, allocator, info, MemoryRequirement::ANY)?;

        let (src_image, dst_image) = if mode == AccessMode::Read {
            (image.handle, staging.get())
        } else {
            (staging.get(), image.handle)
        };

        let view_type = match image.image_type {
            vk::ImageType::_1D => vk::ImageViewType::_1D,
            vk::ImageType::_3D => vk::ImageViewType::_3D,
            _ => vk::ImageViewType::_2D,
        };
        let src_view = make_image_view(device, src_image, view_type, image.format, image.subresource_range)?;
        let dst_view = make_image_view(device, dst_image, view_type, image.format, image.subresource_range)?;

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_indexed_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE, 0, 1)
            .add_indexed_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE, 1, 1)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 2)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let src_info = [vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *src_view,
            image_layout: vk::ImageLayout::GENERAL,
        }];
        let dst_info = [vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *dst_view,
            image_layout: vk::ImageLayout::GENERAL,
        }];
        let writes = [
            vk::WriteDescriptorSet::builder()
                .dst_set(*descriptor_set)
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                .image_info(&src_info)
                .build(),
            vk::WriteDescriptorSet::builder()
                .dst_set(*descriptor_set)
                .dst_binding(1)
                .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                .image_info(&dst_info)
                .build(),
        ];
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        let indirect_buffer = if dispatch_call == DispatchCall::DispatchIndirect {
            let size = std::mem::size_of::<vk::DispatchIndirectCommand>() as vk::DeviceSize;
            let indirect = BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(size, vk::BufferUsageFlags::INDIRECT_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            unsafe {
                indirect
                    .get_allocation()
                    .get_host_ptr()
                    .cast::<vk::DispatchIndirectCommand>()
                    .write(vk::DispatchIndirectCommand { x: 1, y: 1, z: 1 });
            }
            flush_alloc(device, indirect.get_allocation())?;
            Some(indirect)
        } else {
            None
        };

        let shader = find_image_shader(desc);
        let module = create_shader_module(device, shader.programs.get("comp")?)?;
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*module)
            .name(c"main".to_bytes_with_nul())
            .build();
        let create_info = vk::ComputePipelineCreateInfo::builder().stage(stage).layout(*pipeline_layout);
        let handle = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[create_info], None) }
            .vk_check("vkCreateComputePipelines")?
            .0[0];

        Ok(Self {
            image,
            staging,
            dst_image,
            src_image,
            host_buffer,
            host_buffer_size,
            _src_view: src_view,
            _dst_view: dst_view,
            _descriptor_set_layout: descriptor_set_layout,
            descriptor_set,
            _descriptor_pool: descriptor_pool,
            pipeline_layout,
            pipeline: Unique::new(device, handle),
            indirect_buffer,
            mode,
            specialized_access,
        })
    }
}

/// The image shader is picked by the resource it was generated for, so a resource the
/// generator does not know about cannot silently reuse the wrong loop bounds.
fn find_image_shader(desc: &ResourceDescription) -> &'static ImageAccessShader {
    let name = get_resource_name(desc);
    ALL_IMAGE_ACCESS_SHADER
        .iter()
        .copied()
        .find(|s| s.resource_name == name)
        .expect("the generator covers every single-sampled colour image in the resource table")
}

impl Operation for ImageShaderAccess<'_> {
    fn record_commands(&self, device: &Device, sync: SyncType, cmd_buffer: vk::CommandBuffer) {
        let copy = [make_buffer_image_copy(self.image.extent, self.image.subresource_layers)];
        let _ = &self.staging;

        // Destination image layout
        let dst_to_general = make_image_memory_barrier2(
            vk::PipelineStageFlags2::TOP_OF_PIPE,
            vk::AccessFlags2::empty(),
            vk::PipelineStageFlags2::COMPUTE_SHADER,
            vk::AccessFlags2::SHADER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::GENERAL,
            self.dst_image,
            self.image.subresource_range,
        );
        cmd_pipeline_barrier(device, sync, cmd_buffer, &[], &[dst_to_general]);

        if self.mode == AccessMode::Write {
            // The source is the staging image, so it has to be filled first.
            let to_transfer = make_image_memory_barrier2(
                vk::PipelineStageFlags2::TOP_OF_PIPE,
                vk::AccessFlags2::empty(),
                vk::PipelineStageFlags2::ALL_TRANSFER,
                vk::AccessFlags2::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                self.src_image,
                self.image.subresource_range,
            );
            cmd_pipeline_barrier(device, sync, cmd_buffer, &[], &[to_transfer]);

            unsafe {
                device.cmd_copy_buffer_to_image(cmd_buffer, self.host_buffer.get(), self.src_image, vk::ImageLayout::TRANSFER_DST_OPTIMAL, &copy);
            }

            let to_general = make_image_memory_barrier2(
                vk::PipelineStageFlags2::ALL_TRANSFER,
                vk::AccessFlags2::TRANSFER_WRITE,
                vk::PipelineStageFlags2::COMPUTE_SHADER,
                vk::AccessFlags2::SHADER_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::GENERAL,
                self.src_image,
                self.image.subresource_range,
            );
            cmd_pipeline_barrier(device, sync, cmd_buffer, &[], &[to_general]);
        }

        unsafe {
            device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::COMPUTE, *self.pipeline);
            device.cmd_bind_descriptor_sets(cmd_buffer, vk::PipelineBindPoint::COMPUTE, *self.pipeline_layout, 0, &[*self.descriptor_set], &[] as &[u32]);
            match &self.indirect_buffer {
                Some(indirect) => device.cmd_dispatch_indirect(cmd_buffer, indirect.get(), 0),
                None => device.cmd_dispatch(cmd_buffer, 1, 1, 1),
            }
        }

        if self.mode == AccessMode::Read {
            // The destination is the staging image; get it to the host.
            let to_src = make_image_memory_barrier2(
                vk::PipelineStageFlags2::COMPUTE_SHADER,
                vk::AccessFlags2::SHADER_WRITE,
                vk::PipelineStageFlags2::ALL_TRANSFER,
                vk::AccessFlags2::TRANSFER_READ,
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                self.dst_image,
                self.image.subresource_range,
            );
            cmd_pipeline_barrier(device, sync, cmd_buffer, &[], &[to_src]);

            unsafe {
                device.cmd_copy_image_to_buffer(cmd_buffer, self.dst_image, vk::ImageLayout::TRANSFER_SRC_OPTIMAL, self.host_buffer.get(), &copy);
            }

            let to_host = make_buffer_memory_barrier2(
                vk::PipelineStageFlags2::ALL_TRANSFER,
                vk::AccessFlags2::TRANSFER_WRITE,
                vk::PipelineStageFlags2::HOST,
                vk::AccessFlags2::HOST_READ,
                self.host_buffer.get(),
                0,
                self.host_buffer_size,
            );
            cmd_pipeline_barrier(device, sync, cmd_buffer, &[to_host], &[]);
        }
    }

    fn in_sync_info(&self, _sync: SyncType) -> SyncInfo {
        SyncInfo {
            stage_mask: vk::PipelineStageFlags2::COMPUTE_SHADER,
            access_mask: if self.mode == AccessMode::Read {
                if self.specialized_access {
                    vk::AccessFlags2::SHADER_STORAGE_READ
                } else {
                    vk::AccessFlags2::SHADER_READ
                }
            } else {
                vk::AccessFlags2::empty()
            },
            image_layout: vk::ImageLayout::GENERAL,
        }
    }

    fn out_sync_info(&self, _sync: SyncType) -> SyncInfo {
        SyncInfo {
            stage_mask: vk::PipelineStageFlags2::COMPUTE_SHADER,
            access_mask: if self.mode == AccessMode::Write {
                if self.specialized_access {
                    vk::AccessFlags2::SHADER_STORAGE_WRITE
                } else {
                    vk::AccessFlags2::SHADER_WRITE
                }
            } else {
                vk::AccessFlags2::empty()
            },
            image_layout: vk::ImageLayout::GENERAL,
        }
    }

    fn data(&self, device: &Device) -> Result<Vec<u8>, TestError> {
        host_buffer_data(device, &self.host_buffer, self.host_buffer_size)
    }
}

/// The manifest declares the graphics-stage buffer shaders with this.
pub struct BufferGraphicsShader {
    pub name: &'static str,
    pub buffer_type: &'static str,
    pub mode: &'static str,
    pub stage: &'static str,
    pub buffer_size: u32,
    pub programs: crate::vk::programs::BinaryCollection,
}

use crate::generated::shaders::synchronization_buffer::ALL_BUFFER_GRAPHICS_SHADER;

/// `VkShaderStageFlagBits`, restricted to the two graphics stages that can be verified
/// here. Tessellation and geometry are absent rather than present-and-skipped.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum ShaderStage {
    Vertex,
    Fragment,
}

impl ShaderStage {
    fn manifest_name(self) -> &'static str {
        match self {
            Self::Vertex => "vertex",
            Self::Fragment => "fragment",
        }
    }

    /// `pipelineStageFlagsFromShaderStageFlagBits`
    fn pipeline_stage(self) -> vk::PipelineStageFlags2 {
        match self {
            Self::Vertex => vk::PipelineStageFlags2::VERTEX_SHADER,
            Self::Fragment => vk::PipelineStageFlags2::FRAGMENT_SHADER,
        }
    }
}

/// `VertexGrid` - two triangles covering the whole 16x16 target, so a fragment-stage
/// operation's shader runs over every pixel of it.
const GRID_VERTICES: [[f32; 4]; 6] = [
    [1.0, 1.0, 0.0, 1.0],
    [-1.0, 1.0, 0.0, 1.0],
    [-1.0, -1.0, 0.0, 1.0],
    [-1.0, -1.0, 0.0, 1.0],
    [1.0, -1.0, 0.0, 1.0],
    [1.0, 1.0, 0.0, 1.0],
];

const GRAPHICS_TARGET_SIZE: u32 = 16;

/// `GraphicsPipeline`'s render target: a 16x16 colour attachment nothing ever reads.
/// The draw exists to run the shader, not to produce an image.
struct GraphicsTarget<'a> {
    _image: ImageWithMemory<'a>,
    _view: crate::vk::ref_util::Unique<'a, vk::ImageView>,
    render_pass: crate::vk::ref_util::Unique<'a, vk::RenderPass>,
    framebuffer: crate::vk::ref_util::Unique<'a, vk::Framebuffer>,
    vertex_buffer: BufferWithMemory<'a>,
    image_handle: vk::Image,
    subresource_range: vk::ImageSubresourceRange,
}

impl<'a> GraphicsTarget<'a> {
    fn new(device: &'a Device, allocator: &crate::vk::mem_util::SimpleAllocator) -> Result<Self, TestError> {
        use crate::vk::image_util::make_image_view;
        use crate::vk::obj_util::{make_framebuffer, make_render_pass};

        let format = vk::Format::R8G8B8A8_UNORM;
        let subresource_range = vk::ImageSubresourceRange {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            base_mip_level: 0,
            level_count: 1,
            base_array_layer: 0,
            layer_count: 1,
        };
        let info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(format)
            .extent(vk::Extent3D {
                width: GRAPHICS_TARGET_SIZE,
                height: GRAPHICS_TARGET_SIZE,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let image = ImageWithMemory::new(device, allocator, info, MemoryRequirement::ANY)?;
        let image_handle = image.get();
        let view = make_image_view(device, image_handle, vk::ImageViewType::_2D, format, subresource_range)?;
        let render_pass = make_render_pass(device, format)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*view], GRAPHICS_TARGET_SIZE, GRAPHICS_TARGET_SIZE, 1)?;

        let size = std::mem::size_of_val(&GRID_VERTICES) as vk::DeviceSize;
        let vertex_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(size, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(GRID_VERTICES.as_ptr().cast::<u8>(), vertex_buffer.get_allocation().get_host_ptr(), size as usize);
        }
        flush_alloc(device, vertex_buffer.get_allocation())?;

        Ok(Self {
            _image: image,
            _view: view,
            render_pass,
            framebuffer,
            vertex_buffer,
            image_handle,
            subresource_range,
        })
    }
}

/// `BufferImplementation` on a graphics pipeline.
///
/// Same descriptors and the same payload as the compute flavour; only the pipeline and
/// the commands around it differ, which is what `PipelineType` selects upstream.
pub struct BufferGraphicsAccess<'a> {
    buffer: BufferInfo,
    host_buffer: BufferWithMemory<'a>,
    _buffer_view: Option<crate::vk::ref_util::Unique<'a, vk::BufferView>>,
    _descriptor_set_layout: crate::vk::ref_util::Unique<'a, vk::DescriptorSetLayout>,
    descriptor_set: crate::vk::ref_util::UniqueDescriptorSet<'a>,
    _descriptor_pool: crate::vk::ref_util::Unique<'a, vk::DescriptorPool>,
    pipeline_layout: crate::vk::ref_util::Unique<'a, vk::PipelineLayout>,
    pipeline: crate::vk::ref_util::Unique<'a, vk::Pipeline>,
    target: GraphicsTarget<'a>,
    buffer_type: BufferType,
    mode: AccessMode,
    stage: ShaderStage,
    specialized_access: bool,
}

impl<'a> BufferGraphicsAccess<'a> {
    pub fn new(
        device: &'a Device,
        allocator: &crate::vk::mem_util::SimpleAllocator,
        resource: &Resource<'_>,
        buffer_type: BufferType,
        mode: AccessMode,
        stage: ShaderStage,
        specialized_access: bool,
    ) -> Result<Self, TestError> {
        use crate::vk::obj_util::{make_graphics_pipeline_full, make_pipeline_layout};
        use crate::vk::programs::create_shader_module;

        let buffer = resource.buffer();
        let host_buffer = make_host_buffer(device, allocator, buffer.size, vk::BufferUsageFlags::STORAGE_BUFFER, mode)?;
        let stage_flags = match stage {
            ShaderStage::Vertex => vk::ShaderStageFlags::VERTEX,
            ShaderStage::Fragment => vk::ShaderStageFlags::FRAGMENT,
        };
        let d = build_buffer_descriptors(device, &buffer, &host_buffer, buffer_type, mode, stage_flags)?;

        let shader = find_graphics_shader(buffer_type, mode, stage, buffer.size as u32);
        let vert = create_shader_module(device, shader.programs.get("vert")?)?;
        let frag = create_shader_module(device, shader.programs.get("frag")?)?;
        let target = GraphicsTarget::new(device, allocator)?;
        let pipeline_layout = make_pipeline_layout(device, &[*d.layout])?;
        let pipeline = make_graphics_pipeline_full(
            device,
            *pipeline_layout,
            *vert,
            *frag,
            *target.render_pass,
            (GRAPHICS_TARGET_SIZE, GRAPHICS_TARGET_SIZE),
            vk::PrimitiveTopology::TRIANGLE_LIST,
            vk::SampleCountFlags::_1,
            None,
            1,
        )?;

        Ok(Self {
            buffer,
            host_buffer,
            _buffer_view: d.view,
            _descriptor_set_layout: d.layout,
            descriptor_set: d.set,
            _descriptor_pool: d.pool,
            pipeline_layout,
            pipeline,
            target,
            buffer_type,
            mode,
            stage,
            specialized_access,
        })
    }
}

fn find_graphics_shader(buffer_type: BufferType, mode: AccessMode, stage: ShaderStage, size: u32) -> &'static BufferGraphicsShader {
    let mode_name = if mode == AccessMode::Read { "read" } else { "write" };
    ALL_BUFFER_GRAPHICS_SHADER
        .iter()
        .copied()
        .find(|s| s.buffer_type == buffer_type.manifest_name() && s.mode == mode_name && s.stage == stage.manifest_name() && s.buffer_size == size)
        .expect("the generator covers every combination the resource table produces")
}

impl Operation for BufferGraphicsAccess<'_> {
    fn record_commands(&self, device: &Device, sync: SyncType, cmd_buffer: vk::CommandBuffer) {
        let to_attachment = make_image_memory_barrier2(
            vk::PipelineStageFlags2::TOP_OF_PIPE,
            vk::AccessFlags2::empty(),
            vk::PipelineStageFlags2::COLOR_ATTACHMENT_OUTPUT,
            vk::AccessFlags2::COLOR_ATTACHMENT_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            self.target.image_handle,
            self.target.subresource_range,
        );
        cmd_pipeline_barrier(device, sync, cmd_buffer, &[], &[to_attachment]);

        let clear = [vk::ClearValue {
            color: vk::ClearColorValue { float32: [0.0, 0.0, 0.0, 1.0] },
        }];
        let begin = vk::RenderPassBeginInfo::builder()
            .render_pass(*self.target.render_pass)
            .framebuffer(*self.target.framebuffer)
            .render_area(vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D {
                    width: GRAPHICS_TARGET_SIZE,
                    height: GRAPHICS_TARGET_SIZE,
                },
            })
            .clear_values(&clear);

        unsafe {
            device.cmd_begin_render_pass(cmd_buffer, &begin, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *self.pipeline);
            device.cmd_bind_descriptor_sets(
                cmd_buffer,
                vk::PipelineBindPoint::GRAPHICS,
                *self.pipeline_layout,
                0,
                &[*self.descriptor_set],
                &[] as &[u32],
            );
            device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[self.target.vertex_buffer.get()], &[0]);
            device.cmd_draw(cmd_buffer, GRID_VERTICES.len() as u32, 1, 0, 0);
            device.cmd_end_render_pass(cmd_buffer);
        }

        if self.mode == AccessMode::Read {
            let barrier = make_buffer_memory_barrier2(
                self.stage.pipeline_stage(),
                vk::AccessFlags2::SHADER_WRITE,
                vk::PipelineStageFlags2::HOST,
                vk::AccessFlags2::HOST_READ,
                self.host_buffer.get(),
                0,
                self.buffer.size,
            );
            cmd_pipeline_barrier(device, sync, cmd_buffer, &[barrier], &[]);
        }
    }

    fn in_sync_info(&self, _sync: SyncType) -> SyncInfo {
        SyncInfo {
            stage_mask: self.stage.pipeline_stage(),
            access_mask: buffer_access_mask(self.buffer_type, self.mode, self.specialized_access),
            image_layout: vk::ImageLayout::UNDEFINED,
        }
    }

    fn out_sync_info(&self, _sync: SyncType) -> SyncInfo {
        SyncInfo {
            stage_mask: self.stage.pipeline_stage(),
            access_mask: buffer_access_mask(self.buffer_type, self.mode, self.specialized_access),
            image_layout: vk::ImageLayout::UNDEFINED,
        }
    }

    fn data(&self, device: &Device) -> Result<Vec<u8>, TestError> {
        host_buffer_data(device, &self.host_buffer, self.buffer.size)
    }
}

/// The manifest declares the graphics-stage image shaders with this. One pair per
/// resource and stage; read and write share the GLSL, as in the compute case.
pub struct ImageGraphicsShader {
    pub name: &'static str,
    pub resource_name: &'static str,
    pub stage: &'static str,
    pub programs: crate::vk::programs::BinaryCollection,
}

use crate::generated::shaders::synchronization_buffer::ALL_IMAGE_GRAPHICS_SHADER;

/// `ImageImplementation` on a graphics pipeline.
///
/// The same storage-image copy `ImageShaderAccess` does, driven from the vertex or
/// fragment stage instead of a dispatch. The draw itself writes nothing anyone reads;
/// it is there to get the shader executed at that stage, so that the synchronization
/// primitive under test has a graphics-stage access to order.
pub struct ImageGraphicsAccess<'a> {
    image: ImageInfo,
    staging: ImageWithMemory<'a>,
    dst_image: vk::Image,
    src_image: vk::Image,
    host_buffer: BufferWithMemory<'a>,
    host_buffer_size: vk::DeviceSize,
    _src_view: crate::vk::ref_util::Unique<'a, vk::ImageView>,
    _dst_view: crate::vk::ref_util::Unique<'a, vk::ImageView>,
    _descriptor_set_layout: crate::vk::ref_util::Unique<'a, vk::DescriptorSetLayout>,
    descriptor_set: crate::vk::ref_util::UniqueDescriptorSet<'a>,
    _descriptor_pool: crate::vk::ref_util::Unique<'a, vk::DescriptorPool>,
    pipeline_layout: crate::vk::ref_util::Unique<'a, vk::PipelineLayout>,
    pipeline: crate::vk::ref_util::Unique<'a, vk::Pipeline>,
    target: GraphicsTarget<'a>,
    mode: AccessMode,
    stage: ShaderStage,
    specialized_access: bool,
}

impl<'a> ImageGraphicsAccess<'a> {
    pub fn new(
        device: &'a Device,
        allocator: &crate::vk::mem_util::SimpleAllocator,
        desc: &ResourceDescription,
        resource: &Resource<'_>,
        mode: AccessMode,
        stage: ShaderStage,
        specialized_access: bool,
    ) -> Result<Self, TestError> {
        use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
        use crate::vk::image_util::make_image_view;
        use crate::vk::obj_util::{make_descriptor_set, make_graphics_pipeline_full, make_pipeline_layout};
        use crate::vk::programs::create_shader_module;

        let image = resource.image();
        let host_buffer_size = get_pixel_buffer_size(image.format, image.extent)?;
        let host_buffer = make_host_buffer(
            device,
            allocator,
            host_buffer_size,
            vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
            mode,
        )?;

        let info = vk::ImageCreateInfo::builder()
            .image_type(image.image_type)
            .format(image.format)
            .extent(image.extent)
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::STORAGE)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let staging = ImageWithMemory::new(device, allocator, info, MemoryRequirement::ANY)?;

        let (src_image, dst_image) = if mode == AccessMode::Read {
            (image.handle, staging.get())
        } else {
            (staging.get(), image.handle)
        };

        let view_type = match image.image_type {
            vk::ImageType::_1D => vk::ImageViewType::_1D,
            vk::ImageType::_3D => vk::ImageViewType::_3D,
            _ => vk::ImageViewType::_2D,
        };
        let src_view = make_image_view(device, src_image, view_type, image.format, image.subresource_range)?;
        let dst_view = make_image_view(device, dst_image, view_type, image.format, image.subresource_range)?;

        let stage_flags = match stage {
            ShaderStage::Vertex => vk::ShaderStageFlags::VERTEX,
            ShaderStage::Fragment => vk::ShaderStageFlags::FRAGMENT,
        };
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_indexed_binding(vk::DescriptorType::STORAGE_IMAGE, stage_flags, 0, 1)
            .add_indexed_binding(vk::DescriptorType::STORAGE_IMAGE, stage_flags, 1, 1)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 2)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let src_info = [vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *src_view,
            image_layout: vk::ImageLayout::GENERAL,
        }];
        let dst_info = [vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *dst_view,
            image_layout: vk::ImageLayout::GENERAL,
        }];
        let writes = [
            vk::WriteDescriptorSet::builder()
                .dst_set(*descriptor_set)
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                .image_info(&src_info)
                .build(),
            vk::WriteDescriptorSet::builder()
                .dst_set(*descriptor_set)
                .dst_binding(1)
                .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                .image_info(&dst_info)
                .build(),
        ];
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        let shader = find_image_graphics_shader(desc, stage);
        let vert = create_shader_module(device, shader.programs.get("vert")?)?;
        let frag = create_shader_module(device, shader.programs.get("frag")?)?;
        let target = GraphicsTarget::new(device, allocator)?;
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let pipeline = make_graphics_pipeline_full(
            device,
            *pipeline_layout,
            *vert,
            *frag,
            *target.render_pass,
            (GRAPHICS_TARGET_SIZE, GRAPHICS_TARGET_SIZE),
            vk::PrimitiveTopology::TRIANGLE_LIST,
            vk::SampleCountFlags::_1,
            None,
            1,
        )?;

        Ok(Self {
            image,
            staging,
            dst_image,
            src_image,
            host_buffer,
            host_buffer_size,
            _src_view: src_view,
            _dst_view: dst_view,
            _descriptor_set_layout: descriptor_set_layout,
            descriptor_set,
            _descriptor_pool: descriptor_pool,
            pipeline_layout,
            pipeline,
            target,
            mode,
            stage,
            specialized_access,
        })
    }
}

fn find_image_graphics_shader(desc: &ResourceDescription, stage: ShaderStage) -> &'static ImageGraphicsShader {
    let name = get_resource_name(desc);
    ALL_IMAGE_GRAPHICS_SHADER
        .iter()
        .copied()
        .find(|s| s.resource_name == name && s.stage == stage.manifest_name())
        .expect("the generator covers every single-sampled colour image in the resource table")
}

impl Operation for ImageGraphicsAccess<'_> {
    fn record_commands(&self, device: &Device, sync: SyncType, cmd_buffer: vk::CommandBuffer) {
        let copy = [make_buffer_image_copy(self.image.extent, self.image.subresource_layers)];
        let _ = &self.staging;
        let shader_stage = self.stage.pipeline_stage();

        let dst_to_general = make_image_memory_barrier2(
            vk::PipelineStageFlags2::TOP_OF_PIPE,
            vk::AccessFlags2::empty(),
            shader_stage,
            vk::AccessFlags2::SHADER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::GENERAL,
            self.dst_image,
            self.image.subresource_range,
        );
        cmd_pipeline_barrier(device, sync, cmd_buffer, &[], &[dst_to_general]);

        if self.mode == AccessMode::Write {
            let to_transfer = make_image_memory_barrier2(
                vk::PipelineStageFlags2::TOP_OF_PIPE,
                vk::AccessFlags2::empty(),
                vk::PipelineStageFlags2::ALL_TRANSFER,
                vk::AccessFlags2::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                self.src_image,
                self.image.subresource_range,
            );
            cmd_pipeline_barrier(device, sync, cmd_buffer, &[], &[to_transfer]);

            unsafe {
                device.cmd_copy_buffer_to_image(cmd_buffer, self.host_buffer.get(), self.src_image, vk::ImageLayout::TRANSFER_DST_OPTIMAL, &copy);
            }

            let to_general = make_image_memory_barrier2(
                vk::PipelineStageFlags2::ALL_TRANSFER,
                vk::AccessFlags2::TRANSFER_WRITE,
                shader_stage,
                vk::AccessFlags2::SHADER_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::GENERAL,
                self.src_image,
                self.image.subresource_range,
            );
            cmd_pipeline_barrier(device, sync, cmd_buffer, &[], &[to_general]);
        }

        let to_attachment = make_image_memory_barrier2(
            vk::PipelineStageFlags2::TOP_OF_PIPE,
            vk::AccessFlags2::empty(),
            vk::PipelineStageFlags2::COLOR_ATTACHMENT_OUTPUT,
            vk::AccessFlags2::COLOR_ATTACHMENT_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            self.target.image_handle,
            self.target.subresource_range,
        );
        cmd_pipeline_barrier(device, sync, cmd_buffer, &[], &[to_attachment]);

        let clear = [vk::ClearValue {
            color: vk::ClearColorValue { float32: [0.0, 0.0, 0.0, 1.0] },
        }];
        let begin = vk::RenderPassBeginInfo::builder()
            .render_pass(*self.target.render_pass)
            .framebuffer(*self.target.framebuffer)
            .render_area(vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D {
                    width: GRAPHICS_TARGET_SIZE,
                    height: GRAPHICS_TARGET_SIZE,
                },
            })
            .clear_values(&clear);

        unsafe {
            device.cmd_begin_render_pass(cmd_buffer, &begin, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *self.pipeline);
            device.cmd_bind_descriptor_sets(
                cmd_buffer,
                vk::PipelineBindPoint::GRAPHICS,
                *self.pipeline_layout,
                0,
                &[*self.descriptor_set],
                &[] as &[u32],
            );
            device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[self.target.vertex_buffer.get()], &[0]);
            device.cmd_draw(cmd_buffer, GRID_VERTICES.len() as u32, 1, 0, 0);
            device.cmd_end_render_pass(cmd_buffer);
        }

        if self.mode == AccessMode::Read {
            let to_src = make_image_memory_barrier2(
                shader_stage,
                vk::AccessFlags2::SHADER_WRITE,
                vk::PipelineStageFlags2::ALL_TRANSFER,
                vk::AccessFlags2::TRANSFER_READ,
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                self.dst_image,
                self.image.subresource_range,
            );
            cmd_pipeline_barrier(device, sync, cmd_buffer, &[], &[to_src]);

            unsafe {
                device.cmd_copy_image_to_buffer(cmd_buffer, self.dst_image, vk::ImageLayout::TRANSFER_SRC_OPTIMAL, self.host_buffer.get(), &copy);
            }

            let to_host = make_buffer_memory_barrier2(
                vk::PipelineStageFlags2::ALL_TRANSFER,
                vk::AccessFlags2::TRANSFER_WRITE,
                vk::PipelineStageFlags2::HOST,
                vk::AccessFlags2::HOST_READ,
                self.host_buffer.get(),
                0,
                self.host_buffer_size,
            );
            cmd_pipeline_barrier(device, sync, cmd_buffer, &[to_host], &[]);
        }
    }

    fn in_sync_info(&self, _sync: SyncType) -> SyncInfo {
        SyncInfo {
            stage_mask: self.stage.pipeline_stage(),
            access_mask: if self.mode == AccessMode::Read {
                if self.specialized_access {
                    vk::AccessFlags2::SHADER_STORAGE_READ
                } else {
                    vk::AccessFlags2::SHADER_READ
                }
            } else {
                vk::AccessFlags2::empty()
            },
            image_layout: vk::ImageLayout::GENERAL,
        }
    }

    fn out_sync_info(&self, _sync: SyncType) -> SyncInfo {
        SyncInfo {
            stage_mask: self.stage.pipeline_stage(),
            access_mask: if self.mode == AccessMode::Write {
                if self.specialized_access {
                    vk::AccessFlags2::SHADER_STORAGE_WRITE
                } else {
                    vk::AccessFlags2::SHADER_WRITE
                }
            } else {
                vk::AccessFlags2::empty()
            },
            image_layout: vk::ImageLayout::GENERAL,
        }
    }

    fn data(&self, device: &Device) -> Result<Vec<u8>, TestError> {
        host_buffer_data(device, &self.host_buffer, self.host_buffer_size)
    }
}

/// The first byte at which two readbacks differ, or `None` when they are equal or of
/// different lengths. Only used to make a failure message say where.
pub fn first_difference(expected: &[u8], actual: &[u8]) -> Option<usize> {
    if expected.len() != actual.len() {
        return Some(expected.len().min(actual.len()));
    }
    expected.iter().zip(actual).position(|(a, b)| a != b)
}

#[cfg(test)]
mod tests {
    use super::*;

    /// Every operation the catalogue registers has to agree with `is_read` about
    /// which side it is on.
    ///
    /// This is the guard for a failure that is invisible at run time: an operation
    /// classified as a write when it is a read builds the write implementation, which
    /// fills the resource from its own pattern. Paired with another such operation the
    /// test then compares one pattern against the identical other and passes without
    /// having synchronized anything.
    #[test]
    fn write_ops_are_writes_and_read_ops_are_reads() {
        for op in WRITE_OPS {
            assert!(!op.is_read(), "{} is in WRITE_OPS but is_read() says read", op.as_str());
            assert!(op.as_str().starts_with("write_"), "{} is in WRITE_OPS but is not named write_*", op.as_str());
        }
        for op in READ_OPS {
            assert!(op.is_read(), "{} is in READ_OPS but is_read() says write", op.as_str());
            assert!(op.as_str().starts_with("read_"), "{} is in READ_OPS but is not named read_*", op.as_str());
        }
    }

    /// A single-sampled 2D colour image, which every image operation supports.
    fn color_image_2d() -> ResourceDescription {
        ResourceDescription {
            kind: ResourceType::Image,
            size: [128, 128, 0, 0],
            image_type: vk::ImageType::_2D,
            image_format: vk::Format::R8G8B8A8_UNORM,
            image_aspect: vk::ImageAspectFlags::COLOR,
            image_samples: vk::SampleCountFlags::_1,
        }
    }

    /// An operation that touches the resource through a storage image has to say so,
    /// or the resource is created without `VK_IMAGE_USAGE_STORAGE_BIT` and the
    /// descriptor it binds is invalid. That was the second half of the same bug.
    #[test]
    fn shader_image_operations_ask_for_storage_usage() {
        let image = color_image_2d();
        let storage = vk::ImageUsageFlags::STORAGE.bits();
        for op in WRITE_OPS.iter().chain(READ_OPS) {
            if op.image_shader_kind().is_none() && op.image_graphics_kind().is_none() {
                continue;
            }
            assert_eq!(op.in_resource_usage(&image), storage, "{} in_resource_usage", op.as_str());
            assert_eq!(op.out_resource_usage(&image), storage, "{} out_resource_usage", op.as_str());
        }
    }

    /// A graphics-stage operation cannot run on a compute-only queue, and the
    /// compute-queue variants of the event cases are registered from this.
    #[test]
    fn graphics_stage_operations_need_a_graphics_queue() {
        let image = color_image_2d();
        for op in WRITE_OPS.iter().chain(READ_OPS) {
            if op.image_graphics_kind().is_none() && op.buffer_graphics_kind().is_none() && op.draw_call().is_none() {
                continue;
            }
            assert_eq!(op.queue_flags(&image), vk::QueueFlags::GRAPHICS, "{}", op.as_str());
            assert!(!op.can_run_on_compute(), "{} must not have a compute-queue variant", op.as_str());
        }
    }
}

/// The manifest declares the draw shaders with this. Only two exist: the fragment
/// shader writes `makeClearValue`'s colour, which depends only on whether the format
/// is integral.
pub struct DrawShader {
    pub name: &'static str,
    pub integer: bool,
    pub programs: crate::vk::programs::BinaryCollection,
}

use crate::generated::shaders::synchronization_buffer::ALL_DRAW_SHADER;

/// `Draw::DrawCall`
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum DrawCall {
    Draw,
    DrawIndexed,
    DrawIndirect,
    DrawIndexedIndirect,
}

/// `Draw::Implementation` - a write operation whose result is a draw into the resource
/// image as a colour attachment.
///
/// The fragment shader writes the same colour a clear would, so the expected data is
/// the host-side clear pattern; what the operation is really for is to give the
/// synchronization primitive a `COLOR_ATTACHMENT_OUTPUT` write to order.
pub struct DrawOperation<'a> {
    image: ImageInfo,
    expected_data: Vec<u8>,
    draw_call: DrawCall,
    vertex_buffer: BufferWithMemory<'a>,
    index_buffer: BufferWithMemory<'a>,
    indirect_buffer: Option<BufferWithMemory<'a>>,
    _view: crate::vk::ref_util::Unique<'a, vk::ImageView>,
    render_pass: crate::vk::ref_util::Unique<'a, vk::RenderPass>,
    framebuffer: crate::vk::ref_util::Unique<'a, vk::Framebuffer>,
    _pipeline_layout: crate::vk::ref_util::Unique<'a, vk::PipelineLayout>,
    pipeline: crate::vk::ref_util::Unique<'a, vk::Pipeline>,
}

impl<'a> DrawOperation<'a> {
    pub fn new(device: &'a Device, allocator: &crate::vk::mem_util::SimpleAllocator, resource: &Resource<'_>, draw_call: DrawCall) -> Result<Self, TestError> {
        use crate::vk::image_util::make_image_view;
        use crate::vk::obj_util::{make_framebuffer, make_graphics_pipeline_full, make_pipeline_layout, make_render_pass};
        use crate::vk::programs::create_shader_module;

        let image = resource.image();

        // `VertexGrid` - the same six vertices the shader-access grid uses, plus the
        // identity index buffer the indexed draws walk.
        let vertex_size = std::mem::size_of_val(&GRID_VERTICES) as vk::DeviceSize;
        let vertex_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(vertex_size, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(GRID_VERTICES.as_ptr().cast::<u8>(), vertex_buffer.get_allocation().get_host_ptr(), vertex_size as usize);
        }
        flush_alloc(device, vertex_buffer.get_allocation())?;

        let num_vertices = GRID_VERTICES.len() as u32;
        let index_size = (std::mem::size_of::<u32>() * GRID_VERTICES.len()) as vk::DeviceSize;
        let index_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(index_size, vk::BufferUsageFlags::INDEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            let ptr = index_buffer.get_allocation().get_host_ptr().cast::<u32>();
            for i in 0..num_vertices {
                ptr.add(i as usize).write(i);
            }
        }
        flush_alloc(device, index_buffer.get_allocation())?;

        let indirect_buffer = match draw_call {
            DrawCall::DrawIndirect => {
                let size = std::mem::size_of::<vk::DrawIndirectCommand>() as vk::DeviceSize;
                let buffer = BufferWithMemory::new(
                    device,
                    allocator,
                    make_buffer_create_info(size, vk::BufferUsageFlags::INDIRECT_BUFFER),
                    MemoryRequirement::HOST_VISIBLE,
                )?;
                unsafe {
                    buffer.get_allocation().get_host_ptr().cast::<vk::DrawIndirectCommand>().write(vk::DrawIndirectCommand {
                        vertex_count: num_vertices,
                        instance_count: 1,
                        first_vertex: 0,
                        first_instance: 0,
                    });
                }
                flush_alloc(device, buffer.get_allocation())?;
                Some(buffer)
            }
            DrawCall::DrawIndexedIndirect => {
                let size = std::mem::size_of::<vk::DrawIndexedIndirectCommand>() as vk::DeviceSize;
                let buffer = BufferWithMemory::new(
                    device,
                    allocator,
                    make_buffer_create_info(size, vk::BufferUsageFlags::INDIRECT_BUFFER),
                    MemoryRequirement::HOST_VISIBLE,
                )?;
                unsafe {
                    buffer
                        .get_allocation()
                        .get_host_ptr()
                        .cast::<vk::DrawIndexedIndirectCommand>()
                        .write(vk::DrawIndexedIndirectCommand {
                            index_count: num_vertices,
                            instance_count: 1,
                            first_index: 0,
                            vertex_offset: 0,
                            first_instance: 0,
                        });
                }
                flush_alloc(device, buffer.get_allocation())?;
                Some(buffer)
            }
            _ => None,
        };

        // The resource image is the colour attachment.
        let view = make_image_view(device, image.handle, vk::ImageViewType::_2D, image.format, image.subresource_range)?;
        let render_pass = make_render_pass(device, image.format)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*view], image.extent.width, image.extent.height, 1)?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;

        let tcu_format = map_vk_format(image.format).ok_or_else(|| TestError::NotPorted(format!("{:?}", image.format)))?;
        let integer = matches!(tcu_format.channel_class(), TextureChannelClass::SignedInteger | TextureChannelClass::UnsignedInteger);
        let shader = ALL_DRAW_SHADER
            .iter()
            .copied()
            .find(|s| s.integer == integer)
            .expect("the generator emits both the float and the integer fragment shader");
        let vert = create_shader_module(device, shader.programs.get("draw_vert")?)?;
        let frag = create_shader_module(device, shader.programs.get("draw_frag")?)?;

        let pipeline = make_graphics_pipeline_full(
            device,
            *pipeline_layout,
            *vert,
            *frag,
            *render_pass,
            (image.extent.width, image.extent.height),
            vk::PrimitiveTopology::TRIANGLE_LIST,
            vk::SampleCountFlags::_1,
            None,
            1,
        )?;

        // The draw covers the whole attachment with the clear colour, so the expected
        // contents are exactly what a clear of the same value would leave.
        let size = get_pixel_buffer_size(image.format, image.extent)?;
        let mut expected_data = vec![0u8; size as usize];
        {
            let mut pixels = PixelBufferAccess::new(tcu_format, [image.extent.width, image.extent.height, image.extent.depth], &mut expected_data);
            clear_pixel_buffer(&mut pixels, &make_clear_value(image.format));
        }

        Ok(Self {
            image,
            expected_data,
            draw_call,
            vertex_buffer,
            index_buffer,
            indirect_buffer,
            _view: view,
            render_pass,
            framebuffer,
            _pipeline_layout: pipeline_layout,
            pipeline,
        })
    }
}

impl Operation for DrawOperation<'_> {
    fn record_commands(&self, device: &Device, sync: SyncType, cmd_buffer: vk::CommandBuffer) {
        let to_attachment = make_image_memory_barrier2(
            vk::PipelineStageFlags2::TOP_OF_PIPE,
            vk::AccessFlags2::empty(),
            vk::PipelineStageFlags2::COLOR_ATTACHMENT_OUTPUT,
            vk::AccessFlags2::COLOR_ATTACHMENT_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            self.image.handle,
            self.image.subresource_range,
        );
        cmd_pipeline_barrier(device, sync, cmd_buffer, &[], &[to_attachment]);

        let clear = [vk::ClearValue {
            color: vk::ClearColorValue { float32: [0.0, 0.0, 0.0, 1.0] },
        }];
        let begin = vk::RenderPassBeginInfo::builder()
            .render_pass(*self.render_pass)
            .framebuffer(*self.framebuffer)
            .render_area(vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D {
                    width: self.image.extent.width,
                    height: self.image.extent.height,
                },
            })
            .clear_values(&clear);

        let num_vertices = GRID_VERTICES.len() as u32;
        unsafe {
            device.cmd_begin_render_pass(cmd_buffer, &begin, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *self.pipeline);
            device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[self.vertex_buffer.get()], &[0]);

            if matches!(self.draw_call, DrawCall::DrawIndexed | DrawCall::DrawIndexedIndirect) {
                device.cmd_bind_index_buffer(cmd_buffer, self.index_buffer.get(), 0, vk::IndexType::UINT32);
            }

            match self.draw_call {
                DrawCall::Draw => device.cmd_draw(cmd_buffer, num_vertices, 1, 0, 0),
                DrawCall::DrawIndexed => device.cmd_draw_indexed(cmd_buffer, num_vertices, 1, 0, 0, 0),
                DrawCall::DrawIndirect => {
                    device.cmd_draw_indirect(cmd_buffer, self.indirect_buffer.as_ref().expect("built for this draw call").get(), 0, 1, 0);
                }
                DrawCall::DrawIndexedIndirect => {
                    device.cmd_draw_indexed_indirect(cmd_buffer, self.indirect_buffer.as_ref().expect("built for this draw call").get(), 0, 1, 0);
                }
            }
            device.cmd_end_render_pass(cmd_buffer);
        }
    }

    fn in_sync_info(&self, _sync: SyncType) -> SyncInfo {
        EMPTY_SYNC_INFO
    }

    fn out_sync_info(&self, _sync: SyncType) -> SyncInfo {
        SyncInfo {
            stage_mask: vk::PipelineStageFlags2::COLOR_ATTACHMENT_OUTPUT,
            access_mask: vk::AccessFlags2::COLOR_ATTACHMENT_WRITE,
            image_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        }
    }

    fn data(&self, _device: &Device) -> Result<Vec<u8>, TestError> {
        Ok(self.expected_data.clone())
    }
}

/// `ClearAttachments::Implementation` - a write operation that clears the resource
/// image from inside a render pass with `vkCmdClearAttachments`.
///
/// Unlike `vkCmdClearColorImage`, which is a transfer, this is an attachment write:
/// the primitive under test has to order a `COLOR_ATTACHMENT_WRITE` or a
/// `DEPTH_STENCIL_ATTACHMENT_WRITE` against whatever reads the image afterwards.
pub struct ClearAttachments<'a> {
    image: ImageInfo,
    data: Vec<u8>,
    clear_value: vk::ClearValue,
    _view: crate::vk::ref_util::Unique<'a, vk::ImageView>,
    render_pass: crate::vk::ref_util::Unique<'a, vk::RenderPass>,
    framebuffer: crate::vk::ref_util::Unique<'a, vk::Framebuffer>,
}

impl<'a> ClearAttachments<'a> {
    pub fn new(device: &'a Device, resource: &Resource<'_>) -> Result<Self, TestError> {
        use crate::vk::image_util::make_image_view;
        use crate::vk::obj_util::{make_framebuffer, make_render_pass_full};

        let image = resource.image();
        let clear_value = make_clear_value(image.format);
        let tcu_format = map_vk_format(image.format).ok_or_else(|| TestError::NotPorted(format!("{:?}", image.format)))?;

        let size = get_pixel_buffer_size(image.format, image.extent)?;
        let mut data = vec![0u8; size as usize];
        {
            let mut pixels = PixelBufferAccess::new(tcu_format, [image.extent.width, image.extent.height, image.extent.depth], &mut data);
            clear_pixel_buffer(&mut pixels, &clear_value);
        }

        let view_type = match image.image_type {
            vk::ImageType::_1D => vk::ImageViewType::_1D,
            vk::ImageType::_3D => vk::ImageViewType::_3D,
            _ => vk::ImageViewType::_2D,
        };
        let view = make_image_view(device, image.handle, view_type, image.format, image.subresource_range)?;

        let is_color = image.subresource_range.aspect_mask == vk::ImageAspectFlags::COLOR;
        let (color_format, ds_format, final_layout) = if is_color {
            (image.format, vk::Format::UNDEFINED, vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        } else {
            (vk::Format::UNDEFINED, image.format, vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
        };
        let render_pass = make_render_pass_full(device, color_format, ds_format, vk::AttachmentLoadOp::DONT_CARE, final_layout)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*view], image.extent.width, image.extent.height, 1)?;

        Ok(Self {
            image,
            data,
            clear_value,
            _view: view,
            render_pass,
            framebuffer,
        })
    }

    fn is_color(&self) -> bool {
        self.image.subresource_range.aspect_mask == vk::ImageAspectFlags::COLOR
    }
}

impl Operation for ClearAttachments<'_> {
    fn record_commands(&self, device: &Device, _sync: SyncType, cmd_buffer: vk::CommandBuffer) {
        // A depth/stencil attachment has to reach its attachment layout before the
        // render pass begins; upstream emits this as a legacy barrier regardless of
        // the synchronization type, and the layout it names is what the render pass
        // declares as the initial layout for that case.
        if !self.is_color() {
            let barrier = vk::ImageMemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::empty())
                .dst_access_mask(vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE)
                .old_layout(vk::ImageLayout::UNDEFINED)
                .new_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .image(self.image.handle)
                .subresource_range(self.image.subresource_range)
                .build();
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::HOST,
                    vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[barrier],
                );
            }
        }

        let clear = [self.clear_value];
        let begin = vk::RenderPassBeginInfo::builder()
            .render_pass(*self.render_pass)
            .framebuffer(*self.framebuffer)
            .render_area(vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D {
                    width: self.image.extent.width,
                    height: self.image.extent.height,
                },
            })
            .clear_values(&clear);

        let attachment = [vk::ClearAttachment {
            aspect_mask: self.image.subresource_range.aspect_mask,
            color_attachment: 0,
            clear_value: self.clear_value,
        }];
        let rect = [vk::ClearRect {
            rect: vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D {
                    width: self.image.extent.width,
                    height: self.image.extent.height,
                },
            },
            base_array_layer: 0,
            layer_count: self.image.subresource_layers.layer_count,
        }];

        unsafe {
            device.cmd_begin_render_pass(cmd_buffer, &begin, vk::SubpassContents::INLINE);
            device.cmd_clear_attachments(cmd_buffer, &attachment, &rect);
            device.cmd_end_render_pass(cmd_buffer);
        }
    }

    fn in_sync_info(&self, _sync: SyncType) -> SyncInfo {
        EMPTY_SYNC_INFO
    }

    fn out_sync_info(&self, _sync: SyncType) -> SyncInfo {
        let (access_mask, image_layout) = if self.is_color() {
            (vk::AccessFlags2::COLOR_ATTACHMENT_WRITE, vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        } else {
            (vk::AccessFlags2::DEPTH_STENCIL_ATTACHMENT_WRITE, vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
        };
        SyncInfo {
            stage_mask: vk::PipelineStageFlags2::ALL_COMMANDS,
            access_mask,
            image_layout,
        }
    }

    fn data(&self, _device: &Device) -> Result<Vec<u8>, TestError> {
        Ok(self.data.clone())
    }
}

/// The manifest declares the vertex-input shaders with this. The fragment shader is
/// shared; the vertex shader depends only on how many `uvec4` the resource holds.
pub struct VertexInputShader {
    pub name: &'static str,
    pub buffer_size: u32,
    pub programs: crate::vk::programs::BinaryCollection,
}

use crate::generated::shaders::synchronization_buffer::ALL_VERTEX_INPUT_SHADER;

/// `VertexInput::Implementation` in `DRAW_MODE_VERTEX` - a read operation that consumes
/// the resource buffer as vertex attributes.
///
/// This is the only ported read whose access is `VERTEX_ATTRIBUTE_READ` at the
/// `VERTEX_INPUT` stage rather than a shader or transfer read, so it is the only one
/// that makes the primitive order a write against the fixed-function vertex fetch. The
/// vertex shader copies each attribute into an SSBO so the host can see what was read.
pub struct VertexInputAccess<'a> {
    buffer: BufferInfo,
    output_buffer: BufferWithMemory<'a>,
    _descriptor_set_layout: crate::vk::ref_util::Unique<'a, vk::DescriptorSetLayout>,
    descriptor_set: crate::vk::ref_util::UniqueDescriptorSet<'a>,
    _descriptor_pool: crate::vk::ref_util::Unique<'a, vk::DescriptorPool>,
    pipeline_layout: crate::vk::ref_util::Unique<'a, vk::PipelineLayout>,
    pipeline: crate::vk::ref_util::Unique<'a, vk::Pipeline>,
    target: GraphicsTarget<'a>,
}

impl<'a> VertexInputAccess<'a> {
    pub fn new(device: &'a Device, allocator: &crate::vk::mem_util::SimpleAllocator, resource: &Resource<'_>) -> Result<Self, TestError> {
        use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
        use crate::vk::obj_util::{make_descriptor_set, make_graphics_pipeline_full, make_pipeline_layout};
        use crate::vk::programs::create_shader_module;

        let buffer = resource.buffer();

        let output_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(buffer.size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::slice::from_raw_parts_mut(output_buffer.get_allocation().get_host_ptr(), buffer.size as usize).fill(0);
        }
        flush_alloc(device, output_buffer.get_allocation())?;

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::VERTEX)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let info = [vk::DescriptorBufferInfo {
            buffer: output_buffer.get(),
            offset: 0,
            range: buffer.size,
        }];
        let write = vk::WriteDescriptorSet::builder()
            .dst_set(*descriptor_set)
            .dst_binding(0)
            .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
            .buffer_info(&info)
            .build();
        unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

        let shader = ALL_VERTEX_INPUT_SHADER
            .iter()
            .copied()
            .find(|s| u64::from(s.buffer_size) == buffer.size)
            .expect("the generator covers both resource buffer sizes");
        let vert = create_shader_module(device, shader.programs.get("input_vert")?)?;
        let frag = create_shader_module(device, shader.programs.get("input_frag")?)?;

        let target = GraphicsTarget::new(device, allocator)?;
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let pipeline = make_graphics_pipeline_full(
            device,
            *pipeline_layout,
            *vert,
            *frag,
            *target.render_pass,
            (GRAPHICS_TARGET_SIZE, GRAPHICS_TARGET_SIZE),
            vk::PrimitiveTopology::POINT_LIST,
            vk::SampleCountFlags::_1,
            None,
            1,
        )?;

        Ok(Self {
            buffer,
            output_buffer,
            _descriptor_set_layout: descriptor_set_layout,
            descriptor_set,
            _descriptor_pool: descriptor_pool,
            pipeline_layout,
            pipeline,
            target,
        })
    }
}

impl Operation for VertexInputAccess<'_> {
    fn record_commands(&self, device: &Device, sync: SyncType, cmd_buffer: vk::CommandBuffer) {
        let to_attachment = make_image_memory_barrier2(
            vk::PipelineStageFlags2::TOP_OF_PIPE,
            vk::AccessFlags2::empty(),
            vk::PipelineStageFlags2::COLOR_ATTACHMENT_OUTPUT,
            vk::AccessFlags2::COLOR_ATTACHMENT_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            self.target.image_handle,
            self.target.subresource_range,
        );
        cmd_pipeline_barrier(device, sync, cmd_buffer, &[], &[to_attachment]);

        let clear = [vk::ClearValue {
            color: vk::ClearColorValue { float32: [0.0, 0.0, 0.0, 1.0] },
        }];
        let begin = vk::RenderPassBeginInfo::builder()
            .render_pass(*self.target.render_pass)
            .framebuffer(*self.target.framebuffer)
            .render_area(vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D {
                    width: GRAPHICS_TARGET_SIZE,
                    height: GRAPHICS_TARGET_SIZE,
                },
            })
            .clear_values(&clear);

        // One point per uvec4 in the resource, each writing the attribute it fetched.
        let count = (self.buffer.size / 16) as u32;
        unsafe {
            device.cmd_begin_render_pass(cmd_buffer, &begin, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *self.pipeline);
            device.cmd_bind_descriptor_sets(
                cmd_buffer,
                vk::PipelineBindPoint::GRAPHICS,
                *self.pipeline_layout,
                0,
                &[*self.descriptor_set],
                &[] as &[u32],
            );
            device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[self.buffer.handle], &[0]);
            device.cmd_draw(cmd_buffer, count, 1, 0, 0);
            device.cmd_end_render_pass(cmd_buffer);
        }

        let to_host = make_buffer_memory_barrier2(
            vk::PipelineStageFlags2::VERTEX_SHADER,
            vk::AccessFlags2::SHADER_WRITE,
            vk::PipelineStageFlags2::HOST,
            vk::AccessFlags2::HOST_READ,
            self.output_buffer.get(),
            0,
            self.buffer.size,
        );
        cmd_pipeline_barrier(device, sync, cmd_buffer, &[to_host], &[]);
    }

    fn in_sync_info(&self, sync: SyncType) -> SyncInfo {
        // Under synchronization2 the fetch has its own stage; the legacy enum only has
        // the combined VERTEX_INPUT.
        let stage_mask = if sync == SyncType::Synchronization2 {
            vk::PipelineStageFlags2::VERTEX_ATTRIBUTE_INPUT
        } else {
            vk::PipelineStageFlags2::VERTEX_INPUT
        };
        SyncInfo {
            stage_mask,
            access_mask: vk::AccessFlags2::VERTEX_ATTRIBUTE_READ,
            image_layout: vk::ImageLayout::UNDEFINED,
        }
    }

    fn out_sync_info(&self, _sync: SyncType) -> SyncInfo {
        EMPTY_SYNC_INFO
    }

    fn data(&self, device: &Device) -> Result<Vec<u8>, TestError> {
        host_buffer_data(device, &self.output_buffer, self.buffer.size)
    }
}
