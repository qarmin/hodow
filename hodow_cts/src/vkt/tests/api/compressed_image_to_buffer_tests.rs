// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiCopyImageToBufferTests.cpp
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineImageUtil.cpp   (TestTexture)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `mip_copies_*` - a whole compressed mip pyramid is uploaded in one
// vkCmdCopyBufferToImage, then every (level, layer) is copied back into a buffer on its
// own and compared with memcmp against the bytes that went in. Nothing is
// decompressed: a copy moves compressed blocks verbatim, so the check is byte-exact and
// the content of the blocks cannot change a verdict.
//
// That last point is why the block data here is plain deterministic random bytes.
// Upstream generates *valid* ASTC blocks, because its shared TestTexture is also used
// by tests that decompress; this one only ever memcmps, so the distinction is invisible
// to it. The BC7 mode-8 guard is kept anyway, since it costs nothing and keeps the
// generator recognisable against the C++.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::DeviceV1_3;

use super::copies_buffer_tests::{AllocationKind, CopyCommandVariant, QueueSelection, select_queue};
use super::copies_image_tests::GroupParams;
use super::copy_format_lists::COMPRESSED_FORMATS_FLOATS;
use crate::tcu::random::Random;
use crate::tcu::{self, TestError, TestOutcome, TestStatus};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::compressed_formats::{get_block_depth, get_block_height, get_block_size_in_bytes, get_block_width};
use crate::vk::image_util::{ImageWithMemory, make_image_memory_barrier, make_image_subresource_range};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_memory_barrier};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestInstance};

/// `tcu::computeMipPyramidLevels`
fn compute_mip_pyramid_levels(size: u32) -> u32 {
    size.ilog2() + 1
}

/// `vk::mipLevelExtents`
fn mip_level_extents(base: [u32; 3], mip_level: u32) -> [u32; 3] {
    [(base[0] >> mip_level).max(1), (base[1] >> mip_level).max(1), (base[2] >> mip_level).max(1)]
}

/// `getNextMultiple(divisor, value)`
fn next_multiple(divisor: u32, value: u32) -> u32 {
    if value.is_multiple_of(divisor) { value } else { value + divisor - (value % divisor) }
}

/// `getNextMultiple(divisors, value)` - the next value that is a multiple of all of
/// them. The two divisors here are 4 and the block size, so this is their lcm.
fn next_multiple_of_all(divisors: [u32; 2], value: u32) -> u32 {
    let mut v = value;
    loop {
        if divisors.iter().all(|d| v.is_multiple_of(*d)) {
            return v;
        }
        v = next_multiple(divisors[0], v + 1);
    }
}

/// One `tcu::CompressedTexture` - a single mip level of a single array layer.
struct CompressedLevel {
    width: u32,
    height: u32,
    depth: u32,
    data: Vec<u8>,
}

/// How one mip level's extent shrinks - the three `TestTexture` subclasses differ only
/// in this and in whether they have array layers.
type LevelExtentFn = fn([u32; 3], u32) -> [u32; 3];

/// `pipeline::TestTexture` narrowed to the compressed case, which is all this test
/// uses. Levels are stored in `level * array_size + layer` order, as upstream does.
struct CompressedTestTexture {
    format: vk::Format,
    num_levels: u32,
    array_size: u32,
    levels: Vec<CompressedLevel>,
}

impl CompressedTestTexture {
    /// `makeCompressedTestTextureFromSrcImage`
    fn new(image_type: vk::ImageType, format: vk::Format, extent: [u32; 3], array_layers: u32) -> Self {
        let [width, height, depth] = extent;
        let (num_levels, array_size, level_extent): (u32, u32, LevelExtentFn) = match image_type {
            // TestTexture1DArray: every layer of a level is one row.
            vk::ImageType::_1D => (compute_mip_pyramid_levels(width), array_layers, |e, l| [(e[0] >> l).max(1), 1, 1]),
            // TestTexture2DArray: every layer of a level is one 2D image.
            vk::ImageType::_2D => (compute_mip_pyramid_levels(width.max(height)), array_layers, |e, l| {
                [(e[0] >> l).max(1), (e[1] >> l).max(1), 1]
            }),
            // TestTexture3D: one layer, whose depth shrinks with the level.
            _ => (compute_mip_pyramid_levels(width.max(height).max(depth)), 1, mip_level_extents),
        };

        let block_bytes = get_block_size_in_bytes(format);
        let (bw, bh, bd) = (get_block_width(format), get_block_height(format), get_block_depth(format));

        // `de::Random(123)` in populateCompressedLevels, one stream across all levels.
        let mut random = Random::new(123);
        let mut levels = Vec::with_capacity((num_levels * array_size) as usize);
        for level_ndx in 0..num_levels {
            for _layer_ndx in 0..array_size {
                let [w, h, d] = level_extent(extent, level_ndx);
                let size = (w.div_ceil(bw) * h.div_ceil(bh) * d.div_ceil(bd) * block_bytes) as usize;
                let mut data = vec![0u8; size];
                for byte in data.iter_mut() {
                    *byte = (random.get_uint32() & 0xFF) as u8;
                }
                // BC7 mode 8 (LSB == 0x00) is underspecified and upstream avoids it.
                if matches!(format, vk::Format::BC7_UNORM_BLOCK | vk::Format::BC7_SRGB_BLOCK) {
                    for block in data.chunks_mut(block_bytes as usize) {
                        while block[0] == 0x00 {
                            block[0] = (random.get_uint32() & 0xFF) as u8;
                        }
                    }
                }
                levels.push(CompressedLevel {
                    width: w,
                    height: h,
                    depth: d,
                    data,
                });
            }
        }

        Self {
            format,
            num_levels,
            array_size,
            levels,
        }
    }

    fn level(&self, level: u32, layer: u32) -> &CompressedLevel {
        &self.levels[(level * self.array_size + layer) as usize]
    }

    /// The offset alignment every level starts at: 4, and the block size.
    fn offset_multiples(&self) -> [u32; 2] {
        [4, get_block_size_in_bytes(self.format)]
    }

    /// `TestTexture::getCompressedSize`
    fn compressed_size(&self) -> u32 {
        let multiples = self.offset_multiples();
        let mut size = 0u32;
        for level_ndx in 0..self.num_levels {
            for layer_ndx in 0..self.array_size {
                size = next_multiple_of_all(multiples, size);
                size += self.level(level_ndx, layer_ndx).data.len() as u32;
            }
        }
        size
    }

    /// `TestTexture::getBufferCopyRegions` and `TestTexture::write` walk the same
    /// offsets, so both are driven from this one iteration.
    fn level_offsets(&self) -> Vec<u32> {
        let multiples = self.offset_multiples();
        let mut offsets = Vec::with_capacity(self.levels.len());
        let mut offset = 0u32;
        for level_ndx in 0..self.num_levels {
            for layer_ndx in 0..self.array_size {
                offset = next_multiple_of_all(multiples, offset);
                offsets.push(offset);
                offset += self.level(level_ndx, layer_ndx).data.len() as u32;
            }
        }
        offsets
    }

    /// `TestTexture::getBufferCopyRegions`
    fn buffer_copy_regions(&self) -> Vec<vk::BufferImageCopy> {
        let (bw, bh) = (get_block_width(self.format), get_block_height(self.format));
        let offsets = self.level_offsets();
        let mut regions = Vec::with_capacity(self.levels.len());
        for level_ndx in 0..self.num_levels {
            for layer_ndx in 0..self.array_size {
                let level = self.level(level_ndx, layer_ndx);
                let offset = offsets[(level_ndx * self.array_size + layer_ndx) as usize];
                regions.push(vk::BufferImageCopy {
                    buffer_offset: u64::from(offset),
                    buffer_row_length: next_multiple(bw, level.width),
                    buffer_image_height: next_multiple(bh, level.height),
                    image_subresource: vk::ImageSubresourceLayers {
                        aspect_mask: vk::ImageAspectFlags::COLOR,
                        mip_level: level_ndx,
                        base_array_layer: layer_ndx,
                        layer_count: 1,
                    },
                    image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                    image_extent: vk::Extent3D {
                        width: level.width,
                        height: level.height,
                        depth: level.depth,
                    },
                });
            }
        }
        regions
    }

    /// `TestTexture::write`
    fn write(&self, dest: &mut [u8]) {
        for (level, offset) in self.levels.iter().zip(self.level_offsets()) {
            let at = offset as usize;
            dest[at..at + level.data.len()].copy_from_slice(&level.data);
        }
    }
}

/// `CopyCompressedImageToBufferTestCase`
pub struct CompressedImageToBufferCase {
    name: String,
    image_type: vk::ImageType,
    format: vk::Format,
    extent: [u32; 3],
    array_layers: u32,
    allocation_kind: AllocationKind,
    command_variant: CopyCommandVariant,
    queue_selection: QueueSelection,
    general_layout: bool,
    /// `INDIRECT_COPY` in `TestParams::extensionFlags`. Upstream sets it on every
    /// `1d_images` case, which is why that whole sub-group needs the extension.
    indirect_copy: bool,
}

impl TestCase for CompressedImageToBufferCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.command_variant == CopyCommandVariant::CopyCommands2 {
            context.require_device_functionality("VK_KHR_copy_commands2")?;
        }
        if self.indirect_copy {
            context.require_device_functionality("VK_KHR_copy_memory_indirect")?;
        }
        if self.allocation_kind == AllocationKind::Dedicated {
            context.require_device_functionality("VK_KHR_dedicated_allocation")?;
        }
        select_queue(context, self.queue_selection)?;

        let properties = unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                self.format,
                self.image_type,
                vk::ImageTiling::OPTIMAL,
                vk::ImageUsageFlags::TRANSFER_SRC,
                vk::ImageCreateFlags::empty(),
            )
        }
        .map_err(|_| TestError::NotSupported("Format not supported".to_string()))?;

        let [width, height, depth] = self.extent;
        let mip_levels = match self.image_type {
            vk::ImageType::_1D => compute_mip_pyramid_levels(width),
            vk::ImageType::_2D => compute_mip_pyramid_levels(width.max(height)),
            _ => compute_mip_pyramid_levels(width.max(height).max(depth)),
        };
        if properties.max_mip_levels < mip_levels {
            return Err(TestError::NotSupported("Required number of mip levels not supported".to_string()));
        }
        // `getArraySize(m_params.src.image)`, which reads extent.depth rather than
        // TestParams::arrayLayers - so this is 1 for every 2D case, layer count or not.
        let array_layers = if self.image_type != vk::ImageType::_3D { depth } else { 1 };
        if properties.max_array_layers < array_layers {
            return Err(TestError::NotSupported("Required number of layers not supported".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CompressedImageToBufferInstance { context, params: self })
    }
}

/// `CopyCompressedImageToBuffer`
struct CompressedImageToBufferInstance<'a> {
    context: &'a Context<'a>,
    params: &'a CompressedImageToBufferCase,
}

impl TestInstance for CompressedImageToBufferInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let p = self.params;
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let (queue, queue_family_index) = select_queue(self.context, p.queue_selection)?;

        let texture = CompressedTestTexture::new(p.image_type, p.format, p.extent, p.array_layers);

        // Source image, containing all the mip levels.
        let image_info = vk::ImageCreateInfo {
            s_type: vk::StructureType::IMAGE_CREATE_INFO,
            next: std::ptr::null(),
            flags: vk::ImageCreateFlags::empty(),
            image_type: p.image_type,
            format: p.format,
            extent: vk::Extent3D {
                width: p.extent[0],
                height: p.extent[1],
                depth: p.extent[2],
            },
            mip_levels: texture.num_levels,
            array_layers: p.array_layers,
            samples: vk::SampleCountFlags::_1,
            tiling: vk::ImageTiling::OPTIMAL,
            usage: vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST,
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 0,
            queue_family_indices: std::ptr::null(),
            initial_layout: vk::ImageLayout::UNDEFINED,
        };
        let source = if p.allocation_kind == AllocationKind::Dedicated {
            ImageWithMemory::new_dedicated(device, allocator, image_info, MemoryRequirement::ANY)?
        } else {
            ImageWithMemory::new(device, allocator, image_info, MemoryRequirement::ANY)?
        };

        // Upload the whole pyramid in one go.
        let texture_size = texture.compressed_size();
        let source_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(u64::from(texture_size), vk::BufferUsageFlags::TRANSFER_SRC),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            let dest = std::slice::from_raw_parts_mut(source_buffer.get_allocation().get_host_ptr(), texture_size as usize);
            dest.fill(0);
            texture.write(dest);
        }
        flush_alloc(device, source_buffer.get_allocation())?;
        let copy_regions = texture.buffer_copy_regions();

        let initial_layout = if p.general_layout {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::TRANSFER_DST_OPTIMAL
        };
        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let full_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, texture.num_levels, 0, p.array_layers);
        {
            let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            begin_command_buffer(device, *cmd_buffer)?;
            unsafe {
                let pre = make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    initial_layout,
                    source.get(),
                    full_range,
                );
                device.cmd_pipeline_barrier(
                    *cmd_buffer,
                    vk::PipelineStageFlags::HOST,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[pre],
                );
                device.cmd_copy_buffer_to_image(*cmd_buffer, source_buffer.get(), source.get(), initial_layout, &copy_regions);
                let post = make_image_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::TRANSFER_READ,
                    initial_layout,
                    initial_layout,
                    source.get(),
                    full_range,
                );
                device.cmd_pipeline_barrier(
                    *cmd_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[post],
                );
            }
            end_command_buffer(device, *cmd_buffer)?;
            submit_commands_and_wait(device, queue, *cmd_buffer)?;
        }

        // One destination buffer, sized for the largest level, reused for all of them.
        let level0_size = texture.level(0, 0).data.len();
        let destination = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(level0_size as u64, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let copy_layout = if p.general_layout {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL
        };
        for mip_level in 0..texture.num_levels {
            for array_layer in 0..texture.array_size {
                let level = texture.level(mip_level, array_layer);
                let buffer_size = level.data.len();

                // Clear the buffer before copying into it as a precaution.
                unsafe {
                    std::slice::from_raw_parts_mut(destination.get_allocation().get_host_ptr(), buffer_size).fill(0);
                }
                flush_alloc(device, destination.get_allocation())?;

                let extent = mip_level_extents(p.extent, mip_level);
                let region = vk::BufferImageCopy {
                    buffer_offset: 0,
                    buffer_row_length: 0,
                    buffer_image_height: 0,
                    image_subresource: vk::ImageSubresourceLayers {
                        aspect_mask: vk::ImageAspectFlags::COLOR,
                        mip_level,
                        base_array_layer: array_layer,
                        layer_count: 1,
                    },
                    image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                    image_extent: vk::Extent3D {
                        width: extent[0],
                        height: extent[1],
                        depth: extent[2],
                    },
                };

                let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
                begin_command_buffer(device, *cmd_buffer)?;
                unsafe {
                    // A general-layout run has no layout to change, so the ordering is
                    // carried by a plain memory barrier instead.
                    if p.general_layout {
                        let memory_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::TRANSFER_READ);
                        device.cmd_pipeline_barrier(
                            *cmd_buffer,
                            vk::PipelineStageFlags::TRANSFER,
                            vk::PipelineStageFlags::TRANSFER,
                            vk::DependencyFlags::empty(),
                            &[memory_barrier],
                            &[] as &[vk::BufferMemoryBarrier],
                            &[] as &[vk::ImageMemoryBarrier],
                        );
                    } else {
                        let image_barrier = make_image_memory_barrier(
                            vk::AccessFlags::TRANSFER_WRITE,
                            vk::AccessFlags::TRANSFER_READ,
                            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                            source.get(),
                            make_image_subresource_range(vk::ImageAspectFlags::COLOR, mip_level, 1, array_layer, 1),
                        );
                        device.cmd_pipeline_barrier(
                            *cmd_buffer,
                            vk::PipelineStageFlags::TRANSFER,
                            vk::PipelineStageFlags::TRANSFER,
                            vk::DependencyFlags::empty(),
                            &[] as &[vk::MemoryBarrier],
                            &[] as &[vk::BufferMemoryBarrier],
                            &[image_barrier],
                        );
                    }

                    if p.command_variant == CopyCommandVariant::CopyCommands2 {
                        let region2 = vk::BufferImageCopy2 {
                            s_type: vk::StructureType::BUFFER_IMAGE_COPY_2,
                            next: std::ptr::null(),
                            buffer_offset: region.buffer_offset,
                            buffer_row_length: region.buffer_row_length,
                            buffer_image_height: region.buffer_image_height,
                            image_subresource: region.image_subresource,
                            image_offset: region.image_offset,
                            image_extent: region.image_extent,
                        };
                        let info = vk::CopyImageToBufferInfo2 {
                            s_type: vk::StructureType::COPY_IMAGE_TO_BUFFER_INFO_2,
                            next: std::ptr::null(),
                            src_image: source.get(),
                            src_image_layout: copy_layout,
                            dst_buffer: destination.get(),
                            region_count: 1,
                            regions: &region2,
                        };
                        device.cmd_copy_image_to_buffer2(*cmd_buffer, &info);
                    } else {
                        device.cmd_copy_image_to_buffer(*cmd_buffer, source.get(), copy_layout, destination.get(), &[region]);
                    }

                    let buffer_barrier = vk::BufferMemoryBarrier {
                        s_type: vk::StructureType::BUFFER_MEMORY_BARRIER,
                        next: std::ptr::null(),
                        src_access_mask: vk::AccessFlags::TRANSFER_WRITE,
                        dst_access_mask: vk::AccessFlags::HOST_READ,
                        src_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
                        dst_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
                        buffer: destination.get(),
                        offset: 0,
                        size: buffer_size as u64,
                    };
                    device.cmd_pipeline_barrier(
                        *cmd_buffer,
                        vk::PipelineStageFlags::TRANSFER,
                        vk::PipelineStageFlags::HOST,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[buffer_barrier],
                        &[] as &[vk::ImageMemoryBarrier],
                    );
                }
                end_command_buffer(device, *cmd_buffer)?;
                submit_commands_and_wait(device, queue, *cmd_buffer)?;

                invalidate_alloc(device, destination.get_allocation())?;
                let result = unsafe { std::slice::from_raw_parts(destination.get_allocation().get_host_ptr().cast_const(), buffer_size) };
                if result != level.data.as_slice() {
                    return Ok(TestStatus::fail(format!(
                        "Incorrect data retrieved for mip level {mip_level}, layer {array_layer} - extents ({}, {}); check log for more info",
                        level.width, level.height
                    )));
                }
            }
        }

        Ok(TestStatus::pass("OK"))
    }
}

/// `extents[]` for the 1D and 2D groups. The first is all power-of-two edges, so most
/// mip levels are multiples of four; the second makes the two lowest levels 3 and 1
/// texels high, below every block height.
const EXTENTS_2D: [[u32; 3]; 2] = [[64, 64, 1], [64, 192, 1]];
/// `extents[]` for the 3D group - a power of two and a non-power.
const EXTENTS_3D: [[u32; 3]; 2] = [[16, 16, 16], [16, 8, 24]];
/// `arrayLayers[]`
const ARRAY_LAYERS: [u32; 3] = [1, 2, 5];

fn make_case(gp: &GroupParams, name: String, image_type: vk::ImageType, format: vk::Format, extent: [u32; 3], array_layers: u32, indirect_copy: bool) -> Box<dyn TestCase> {
    Box::new(CompressedImageToBufferCase {
        name,
        image_type,
        format,
        extent,
        array_layers,
        allocation_kind: gp.allocation_kind,
        command_variant: gp.command_variant,
        queue_selection: gp.queue_selection,
        general_layout: gp.general_layout,
        indirect_copy,
    })
}

/// The `mip_copies_*` half of `add1dImageToBufferTests`.
///
/// It builds 2D images, not 1D ones, and sets `INDIRECT_COPY` on every case - upstream
/// assigns `params.extensionFlags = INDIRECT_COPY` unconditionally here rather than
/// adding a second case as the 2D group does. Reproduced as-is: the whole sub-group
/// skips without VK_KHR_copy_memory_indirect, and that is the verdict to match.
pub fn add_1d_compressed_mip_copies(group: &mut tcu::TestCaseGroup, gp: &GroupParams) {
    for extent in EXTENTS_2D {
        for num_layers in ARRAY_LAYERS {
            for &(format, format_name) in COMPRESSED_FORMATS_FLOATS {
                let name = case_name_2d(format_name, extent, num_layers, "");
                group.add_child(make_case(gp, name, vk::ImageType::_2D, format, extent, num_layers, true));
            }
        }
    }
}

/// The `mip_copies_*` half of `add2dImageToBufferTests`.
pub fn add_2d_compressed_mip_copies(group: &mut tcu::TestCaseGroup, gp: &GroupParams) {
    for extent in EXTENTS_2D {
        for num_layers in ARRAY_LAYERS {
            for &(format, format_name) in COMPRESSED_FORMATS_FLOATS {
                group.add_child(make_case(
                    gp,
                    case_name_2d(format_name, extent, num_layers, ""),
                    vk::ImageType::_2D,
                    format,
                    extent,
                    num_layers,
                    false,
                ));
                // Upstream appends the suffix with no separator, so the name really is
                // `..._5_layersindirect`.
                group.add_child(make_case(
                    gp,
                    case_name_2d(format_name, extent, num_layers, "indirect"),
                    vk::ImageType::_2D,
                    format,
                    extent,
                    num_layers,
                    true,
                ));
            }
        }
    }
}

/// `add3dImageToBufferTests` - entirely compressed mip copies.
pub fn add_3d_compressed_mip_copies(group: &mut tcu::TestCaseGroup, gp: &GroupParams) {
    for extent in EXTENTS_3D {
        for &(format, format_name) in COMPRESSED_FORMATS_FLOATS {
            let name = format!("mip_copies_{format_name}_{}x{}x{}", extent[0], extent[1], extent[2]);
            group.add_child(make_case(gp, name, vk::ImageType::_3D, format, extent, 1, false));
        }
    }
}

fn case_name_2d(format_name: &str, extent: [u32; 3], num_layers: u32, suffix: &str) -> String {
    let mut name = format!("mip_copies_{format_name}_{}x{}", extent[0], extent[1]);
    if num_layers > 1 {
        name.push_str(&format!("_{num_layers}_layers"));
    }
    name.push_str(suffix);
    name
}
