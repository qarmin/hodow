// SPDX-License-Identifier: Apache-2.0
//
// Ported from external/vulkancts/modules/vulkan/ycbcr/vktYCbCrUtil.cpp and the plane
// geometry half of external/vulkancts/framework/vulkan/vkImageUtil.cpp.

use vulkanalia::Device;
use vulkanalia::vk::{self, HasBuilder};

use super::format_tables::{FormatInfo, PLANE_COMPATIBLE_FORMATS, PlaneInfo};
use crate::tcu::TestError;
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::compressed_formats::{get_block_height, get_block_size_in_bytes, get_block_width, is_compressed_format};
use crate::vk::mem_util::{Allocation, MemoryRequirement, SimpleAllocator, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool};

/// The single plane a non-planar format is described by: itself, one texel per block.
/// Upstream builds this on the fly in `getPlanarFormatDescription`; here it stands in
/// for the table entry a non-YCbCr format has none of.
fn single_plane_info(format: vk::Format) -> FormatInfo {
    let compressed = is_compressed_format(format);
    FormatInfo {
        block_width: get_block_width(format),
        block_height: get_block_height(format),
        planes: std::slice::from_ref(Box::leak(Box::new(PlaneInfo {
            element_size: if compressed {
                get_block_size_in_bytes(format)
            } else {
                block_byte_size_uncompressed(format)
            },
            width_divisor: 1,
            height_divisor: 1,
            compatible_format: format,
        }))),
    }
}

/// `getPlanarFormatDescription`
pub fn format_description(format: vk::Format) -> FormatInfo {
    match PLANE_COMPATIBLE_FORMATS.iter().find(|(f, _)| *f == format) {
        Some((_, info)) => FormatInfo {
            block_width: info.block_width,
            block_height: info.block_height,
            planes: info.planes,
        },
        None => single_plane_info(format),
    }
}

/// `getPlaneExtent` - a chroma plane of a subsampled format covers fewer texels than
/// the image does.
pub fn plane_extent(info: &FormatInfo, size: (u32, u32), plane_ndx: usize) -> (u32, u32) {
    let plane = &info.planes[plane_ndx];
    (size.0 / plane.width_divisor, size.1 / plane.height_divisor)
}

/// `getPlaneSizeInBytes`
pub fn plane_size_in_bytes(info: &FormatInfo, size: (u32, u32), plane_ndx: usize) -> usize {
    let (w, h) = plane_extent(info, size, plane_ndx);
    let (w, h) = (w / info.block_width, h / info.block_height);
    (info.planes[plane_ndx].element_size * w * h) as usize
}

/// `getBlockExtent` - the texel block a format is addressed in. Only the subsampled
/// YCbCr formats have one wider than a texel here; nothing compressed reaches this.
pub fn block_extent(format: vk::Format) -> (u32, u32) {
    let info = format_description(format);
    (info.block_width, info.block_height)
}

/// `getBlockByteSize`, for the single-plane formats a copy actually moves.
pub fn block_byte_size(format: vk::Format) -> u32 {
    let info = format_description(format);
    if info.planes.len() == 1 {
        info.planes[0].element_size
    } else {
        block_byte_size_uncompressed(format)
    }
}

/// The byte size of one element of an uncompressed format, derived from its name.
///
/// Only formats absent from the plane table reach here, which are the plain colour
/// formats and the single-plane formats a copy moves; every one of them states its own
/// size. A table would be a second place for the same fact to be wrong, and upstream's
/// own answer comes from a several-hundred-case switch that is no more authoritative
/// than the name is.
fn block_byte_size_uncompressed(format: vk::Format) -> u32 {
    let name = format!("{format:?}");

    // `..._<n>PACK<bits>` is n elements of that many bits; a bare `PACK<bits>` is one.
    if let Some(pos) = name.rfind("PACK") {
        let bits: u32 = name[pos + 4..]
            .parse()
            .unwrap_or_else(|_| panic!("unparseable pack width in {name}"));
        let count: u32 = name[..pos].chars().last().and_then(|c| c.to_digit(10)).unwrap_or(1);
        return count * bits / 8;
    }

    // Otherwise the channel widths spell out the total: R16G16B16A16 is 64 bits.
    let mut bits = 0u32;
    let mut digits = String::new();
    for ch in name.split('_').next().unwrap_or(&name).chars() {
        if ch.is_ascii_digit() {
            digits.push(ch);
        } else {
            bits += digits.parse::<u32>().unwrap_or(0);
            digits.clear();
        }
    }
    bits += digits.parse::<u32>().unwrap_or(0);

    assert!(bits > 0 && bits.is_multiple_of(8), "no byte size derivable from {name}");
    bits / 8
}

/// `getPlaneAspect`
pub fn plane_aspect(plane_ndx: usize) -> vk::ImageAspectFlags {
    match plane_ndx {
        0 => vk::ImageAspectFlags::PLANE_0,
        1 => vk::ImageAspectFlags::PLANE_1,
        2 => vk::ImageAspectFlags::PLANE_2,
        _ => panic!("invalid plane index {plane_ndx}"),
    }
}

/// `getAspectPlaneNdx`
pub fn aspect_plane_ndx(aspect: vk::ImageAspectFlags) -> usize {
    match aspect {
        vk::ImageAspectFlags::PLANE_1 => 1,
        vk::ImageAspectFlags::PLANE_2 => 2,
        _ => 0,
    }
}

/// `MultiPlaneImageData` - one host-side byte buffer per plane. The copy tests only
/// ever move bytes around, so the channel decoding upstream also offers is not needed.
pub struct MultiPlaneImageData {
    format: vk::Format,
    size: (u32, u32),
    planes: Vec<Vec<u8>>,
}

impl MultiPlaneImageData {
    pub fn new(format: vk::Format, size: (u32, u32)) -> Self {
        let info = format_description(format);
        let planes = (0..info.planes.len())
            .map(|ndx| vec![0u8; plane_size_in_bytes(&info, size, ndx)])
            .collect();
        Self { format, size, planes }
    }

    pub fn format(&self) -> vk::Format {
        self.format
    }

    pub fn size(&self) -> (u32, u32) {
        self.size
    }

    pub fn description(&self) -> FormatInfo {
        format_description(self.format)
    }

    pub fn plane_count(&self) -> usize {
        self.planes.len()
    }

    pub fn plane(&self, ndx: usize) -> &[u8] {
        &self.planes[ndx]
    }

    pub fn plane_mut(&mut self, ndx: usize) -> &mut [u8] {
        &mut self.planes[ndx]
    }

    /// `fillRandom`. The copy path never interprets these bytes, so filling them at
    /// byte granularity is enough - except that upstream fills through channel
    /// accessors, which leaves the padding bits of the packed formats zero. Writing
    /// random bits there instead would be comparing against something no driver
    /// promises to preserve.
    pub fn fill_random(&mut self, rng: &mut crate::tcu::random::Random) {
        let padding = packed_padding_mask(self.format);
        for plane in &mut self.planes {
            for byte in plane.iter_mut() {
                *byte = rng.get_uint8();
            }
            if let Some(mask) = padding {
                // A PACK16 element packs its channel into the high bits, so the unused
                // low bits live in the low byte of each little-endian pair.
                for pair in plane.chunks_mut(2) {
                    pair[0] &= mask;
                }
            }
        }
    }
}

/// The low-bit mask of a packed format whose element does not fill its 16 bits:
/// `R10X6` leaves 6 unused bits, `R12X4` leaves 4.
fn packed_padding_mask(format: vk::Format) -> Option<u8> {
    let name = format!("{format:?}");
    if name.contains("10X6") {
        Some(0xC0)
    } else if name.contains("12X4") {
        Some(0xF0)
    } else {
        None
    }
}

/// `areLsb6BitsDontCare` / `areLsb4BitsDontCare` - if either side of the copy is a
/// packed format with unused low bits, those bits are undefined in the result and are
/// masked out of the comparison. Upstream lists the formats one by one; they are
/// exactly the ones whose names carry the padding width.
pub fn lsb_dont_care_mask(src_format: vk::Format, dst_format: vk::Format) -> Option<u8> {
    let names = [format!("{src_format:?}"), format!("{dst_format:?}")];
    if names.iter().any(|n| n.contains("10X6")) {
        Some(0xC0)
    } else if names.iter().any(|n| n.contains("12X4")) {
        Some(0xF0)
    } else {
        None
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    /// The plane geometry is generated from upstream, so what is worth pinning is that
    /// it is being *read* the way upstream reads it. A 420 format subsamples chroma in
    /// both directions, a 422 format only horizontally, and the packed formats address
    /// two texels per block.
    #[test]
    fn plane_geometry_matches_the_subsampling() {
        let g8_420 = format_description(vk::Format::G8_B8_R8_3PLANE_420_UNORM);
        assert_eq!(g8_420.planes.len(), 3);
        assert_eq!(plane_extent(&g8_420, (24, 16), 0), (24, 16));
        assert_eq!(plane_extent(&g8_420, (24, 16), 1), (12, 8));
        assert_eq!(plane_extent(&g8_420, (24, 16), 2), (12, 8));

        let g8_422 = format_description(vk::Format::G8_B8_R8_3PLANE_422_UNORM);
        assert_eq!(plane_extent(&g8_422, (24, 16), 1), (12, 16));

        // A single-plane 422 format is addressed two texels at a time.
        let packed = format_description(vk::Format::G8B8G8R8_422_UNORM);
        assert_eq!(packed.planes.len(), 1);
        assert_eq!((packed.block_width, packed.block_height), (2, 1));

        // Anything not in the table is one plane of itself, one texel per block.
        let plain = format_description(vk::Format::R8G8B8A8_UNORM);
        assert_eq!(plain.planes.len(), 1);
        assert_eq!((plain.block_width, plain.block_height), (1, 1));
        assert_eq!(plain.planes[0].compatible_format, vk::Format::R8G8B8A8_UNORM);
    }

    #[test]
    fn plane_sizes_account_for_subsampling_and_block_size() {
        let g8_420 = format_description(vk::Format::G8_B8_R8_3PLANE_420_UNORM);
        assert_eq!(plane_size_in_bytes(&g8_420, (24, 16), 0), 24 * 16);
        assert_eq!(plane_size_in_bytes(&g8_420, (24, 16), 1), 12 * 8);

        // 2 texels per block, 4 bytes per block: the same bytes as one 16-bit texel.
        let packed = format_description(vk::Format::G8B8G8R8_422_UNORM);
        assert_eq!(plane_size_in_bytes(&packed, (24, 16), 0), 24 / 2 * 16 * 4);
    }

    /// The padding bits of a packed format must stay clear, and are also what the
    /// comparison masks out - the two have to agree or a correct copy still fails.
    #[test]
    fn packed_padding_and_compare_mask_agree() {
        assert_eq!(packed_padding_mask(vk::Format::R10X6_UNORM_PACK16), Some(0xC0));
        assert_eq!(packed_padding_mask(vk::Format::R12X4_UNORM_PACK16), Some(0xF0));
        assert_eq!(packed_padding_mask(vk::Format::R8G8_UNORM), None);

        assert_eq!(
            lsb_dont_care_mask(vk::Format::R10X6_UNORM_PACK16, vk::Format::R16_UNORM),
            Some(0xC0)
        );
        assert_eq!(
            lsb_dont_care_mask(vk::Format::R16_UNORM, vk::Format::R12X4_UNORM_PACK16),
            Some(0xF0)
        );
        assert_eq!(lsb_dont_care_mask(vk::Format::R8_UNORM, vk::Format::R8G8_UNORM), None);

        let mut data = MultiPlaneImageData::new(vk::Format::R10X6_UNORM_PACK16, (8, 8));
        let mut rng = crate::tcu::random::Random::new(1);
        data.fill_random(&mut rng);
        for pair in data.plane(0).chunks(2) {
            assert_eq!(pair[0] & 0x3F, 0, "the six unused low bits must be clear");
        }
    }
}

/// `allocateAndBindImageMemory`. A disjoint image binds one allocation per plane; every
/// other image binds one for the whole thing.
pub fn allocate_and_bind_image_memory<'a>(
    device: &'a Device,
    allocator: &SimpleAllocator,
    image: vk::Image,
    format: vk::Format,
    disjoint: bool,
    requirement: MemoryRequirement,
) -> Result<Vec<Allocation<'a>>, TestError> {
    use vulkanalia::vk::{DeviceV1_0, DeviceV1_1};

    if !disjoint {
        let reqs = unsafe { device.get_image_memory_requirements(image) };
        let allocation = allocator.allocate(device, reqs, requirement)?;
        unsafe { device.bind_image_memory(image, allocation.get_memory(), allocation.get_offset()) }
            .vk_check("vkBindImageMemory")?;
        return Ok(vec![allocation]);
    }

    // `bindImagePlanesMemory` - the plane aspect selects which plane's requirements are
    // being asked about, and the binds go through in one call.
    let num_planes = format_description(format).planes.len();
    let mut allocations = Vec::with_capacity(num_planes);
    for plane_ndx in 0..num_planes {
        let mut plane_reqs_info = vk::ImagePlaneMemoryRequirementsInfo::builder().plane_aspect(plane_aspect(plane_ndx));
        let info = vk::ImageMemoryRequirementsInfo2::builder()
            .image(image)
            .push_next(&mut plane_reqs_info);
        let mut reqs = vk::MemoryRequirements2::default();
        unsafe { device.get_image_memory_requirements2(&info, &mut reqs) };
        allocations.push(allocator.allocate(device, reqs.memory_requirements, requirement)?);
    }

    let mut plane_infos: Vec<vk::BindImagePlaneMemoryInfo> = (0..num_planes)
        .map(|ndx| {
            vk::BindImagePlaneMemoryInfo::builder()
                .plane_aspect(plane_aspect(ndx))
                .build()
        })
        .collect();
    let bind_infos: Vec<vk::BindImageMemoryInfo> = allocations
        .iter()
        .zip(plane_infos.iter_mut())
        .map(|(alloc, plane_info)| {
            vk::BindImageMemoryInfo::builder()
                .image(image)
                .memory(alloc.get_memory())
                .memory_offset(alloc.get_offset())
                .push_next(plane_info)
                .build()
        })
        .collect();
    unsafe { device.bind_image_memory2(&bind_infos) }.vk_check("vkBindImageMemory2")?;

    Ok(allocations)
}

/// The aspect a plane is addressed by: a single-plane format has none, and uses COLOR.
fn aspect_for(info: &FormatInfo, plane_ndx: usize) -> vk::ImageAspectFlags {
    if info.planes.len() > 1 {
        plane_aspect(plane_ndx)
    } else {
        vk::ImageAspectFlags::COLOR
    }
}

/// `uploadImage` of layer 0.
#[allow(clippy::too_many_arguments)]
pub fn upload_image(
    device: &Device,
    allocator: &SimpleAllocator,
    queue: vk::Queue,
    queue_family_index: u32,
    image: vk::Image,
    data: &MultiPlaneImageData,
    next_access: vk::AccessFlags,
    final_layout: vk::ImageLayout,
) -> Result<(), TestError> {
    upload_image_layer(
        device,
        allocator,
        queue,
        queue_family_index,
        image,
        data,
        next_access,
        final_layout,
        0,
    )
}

/// `uploadImage` - one staging buffer per plane, copied in and left in `final_layout`; `array_layer` is the layer of the image written.
#[allow(clippy::too_many_arguments)]
pub fn upload_image_layer(
    device: &Device,
    allocator: &SimpleAllocator,
    queue: vk::Queue,
    queue_family_index: u32,
    image: vk::Image,
    data: &MultiPlaneImageData,
    next_access: vk::AccessFlags,
    final_layout: vk::ImageLayout,
    array_layer: u32,
) -> Result<(), TestError> {
    use vulkanalia::vk::DeviceV1_0;

    let info = data.description();
    let command_pool = make_command_pool(device, queue_family_index)?;
    let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;

    // Held until the submit below completes.
    let mut staging = Vec::new();
    for plane_ndx in 0..info.planes.len() {
        let bytes = data.plane(plane_ndx);
        let buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(bytes.len() as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_SRC),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe { std::ptr::copy_nonoverlapping(bytes.as_ptr(), buffer.get_allocation().get_host_ptr(), bytes.len()) };
        flush_alloc(device, buffer.get_allocation())?;
        staging.push(buffer);
    }

    begin_command_buffer(device, *command_buffer)?;
    // plane_ndx indexes the staging buffers and the plane metadata together, as upstream does.
    #[allow(clippy::needless_range_loop)]
    for plane_ndx in 0..info.planes.len() {
        let aspect = aspect_for(&info, plane_ndx);
        let (w, h) = plane_extent(&info, data.size(), plane_ndx);
        let subresource_range = vk::ImageSubresourceRange {
            aspect_mask: aspect,
            base_mip_level: 0,
            level_count: 1,
            base_array_layer: array_layer,
            layer_count: 1,
        };

        let pre = vk::ImageMemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::empty())
            .dst_access_mask(vk::AccessFlags::TRANSFER_WRITE)
            .old_layout(vk::ImageLayout::UNDEFINED)
            .new_layout(vk::ImageLayout::TRANSFER_DST_OPTIMAL)
            .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .image(image)
            .subresource_range(subresource_range);
        unsafe {
            device.cmd_pipeline_barrier(
                *command_buffer,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[pre],
            );
        }

        let copy = vk::BufferImageCopy::builder()
            .buffer_offset(0)
            .buffer_row_length(0)
            .buffer_image_height(0)
            .image_subresource(vk::ImageSubresourceLayers {
                aspect_mask: aspect,
                mip_level: 0,
                base_array_layer: array_layer,
                layer_count: 1,
            })
            .image_offset(vk::Offset3D { x: 0, y: 0, z: 0 })
            .image_extent(vk::Extent3D {
                width: w,
                height: h,
                depth: 1,
            });
        unsafe {
            device.cmd_copy_buffer_to_image(
                *command_buffer,
                staging[plane_ndx].get(),
                image,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &[copy],
            );
        }

        let post = vk::ImageMemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
            .dst_access_mask(next_access)
            .old_layout(vk::ImageLayout::TRANSFER_DST_OPTIMAL)
            .new_layout(final_layout)
            .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .image(image)
            .subresource_range(subresource_range);
        unsafe {
            device.cmd_pipeline_barrier(
                *command_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::ALL_COMMANDS,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[post],
            );
        }
    }
    end_command_buffer(device, *command_buffer)?;
    submit_commands_and_wait(device, queue, *command_buffer)?;
    Ok(())
}

/// `downloadImage` - the mirror of `upload_image`.
#[allow(clippy::too_many_arguments)]
pub fn download_image(
    device: &Device,
    allocator: &SimpleAllocator,
    queue: vk::Queue,
    queue_family_index: u32,
    image: vk::Image,
    data: &mut MultiPlaneImageData,
    prev_access: vk::AccessFlags,
    initial_layout: vk::ImageLayout,
) -> Result<(), TestError> {
    use vulkanalia::vk::DeviceV1_0;

    let info = data.description();
    let command_pool = make_command_pool(device, queue_family_index)?;
    let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;

    let mut staging = Vec::new();
    for plane_ndx in 0..info.planes.len() {
        let _ = plane_ndx;
        staging.push(BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                data.plane(plane_ndx).len() as vk::DeviceSize,
                vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?);
    }

    begin_command_buffer(device, *command_buffer)?;
    // plane_ndx indexes the staging buffers and the plane metadata together, as upstream does.
    #[allow(clippy::needless_range_loop)]
    for plane_ndx in 0..info.planes.len() {
        let aspect = aspect_for(&info, plane_ndx);
        let (w, h) = plane_extent(&info, data.size(), plane_ndx);
        let subresource_range = vk::ImageSubresourceRange {
            aspect_mask: aspect,
            base_mip_level: 0,
            level_count: 1,
            base_array_layer: 0,
            layer_count: 1,
        };

        let pre = vk::ImageMemoryBarrier::builder()
            .src_access_mask(prev_access)
            .dst_access_mask(vk::AccessFlags::TRANSFER_READ)
            .old_layout(initial_layout)
            .new_layout(vk::ImageLayout::TRANSFER_SRC_OPTIMAL)
            .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .image(image)
            .subresource_range(subresource_range);
        unsafe {
            device.cmd_pipeline_barrier(
                *command_buffer,
                vk::PipelineStageFlags::ALL_COMMANDS,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[pre],
            );
        }

        let copy = vk::BufferImageCopy::builder()
            .buffer_offset(0)
            .buffer_row_length(0)
            .buffer_image_height(0)
            .image_subresource(vk::ImageSubresourceLayers {
                aspect_mask: aspect,
                mip_level: 0,
                base_array_layer: 0,
                layer_count: 1,
            })
            .image_offset(vk::Offset3D { x: 0, y: 0, z: 0 })
            .image_extent(vk::Extent3D {
                width: w,
                height: h,
                depth: 1,
            });
        unsafe {
            device.cmd_copy_image_to_buffer(
                *command_buffer,
                image,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                staging[plane_ndx].get(),
                &[copy],
            );
        }
    }
    end_command_buffer(device, *command_buffer)?;
    submit_commands_and_wait(device, queue, *command_buffer)?;

    // plane_ndx indexes the staging buffers and the plane metadata together, as upstream does.
    #[allow(clippy::needless_range_loop)]
    for plane_ndx in 0..info.planes.len() {
        invalidate_alloc(device, staging[plane_ndx].get_allocation())?;
        let len = data.plane(plane_ndx).len();
        let src = staging[plane_ndx].get_allocation().get_host_ptr();
        unsafe { std::ptr::copy_nonoverlapping(src, data.plane_mut(plane_ndx).as_mut_ptr(), len) };
    }
    Ok(())
}

/// `fillImageMemory` of layer 0.
#[allow(clippy::too_many_arguments)]
pub fn fill_image_memory(
    device: &Device,
    queue: vk::Queue,
    queue_family_index: u32,
    image: vk::Image,
    allocations: &[Allocation<'_>],
    data: &MultiPlaneImageData,
    next_access: vk::AccessFlags,
    final_layout: vk::ImageLayout,
) -> Result<(), TestError> {
    fill_image_memory_layer(
        device,
        queue,
        queue_family_index,
        image,
        allocations,
        data,
        next_access,
        final_layout,
        0,
    )
}

/// `fillImageMemory` - a linear image is written through its mapped memory rather than
/// staged, so the driver's row pitch has to be respected per plane.
#[allow(clippy::too_many_arguments)]
pub fn fill_image_memory_layer(
    device: &Device,
    queue: vk::Queue,
    queue_family_index: u32,
    image: vk::Image,
    allocations: &[Allocation<'_>],
    data: &MultiPlaneImageData,
    next_access: vk::AccessFlags,
    final_layout: vk::ImageLayout,
    array_layer: u32,
) -> Result<(), TestError> {
    use vulkanalia::vk::DeviceV1_0;

    let info = data.description();
    for plane_ndx in 0..info.planes.len() {
        let aspect = aspect_for(&info, plane_ndx);
        // A non-disjoint image has one allocation covering every plane.
        let allocation = if allocations.len() > 1 {
            &allocations[plane_ndx]
        } else {
            &allocations[0]
        };
        let plane_bytes = data.plane(plane_ndx);
        let plane_h = data.size().1 / info.planes[plane_ndx].height_divisor;

        let subresource = vk::ImageSubresource {
            aspect_mask: aspect,
            mip_level: 0,
            array_layer,
        };
        let layout = unsafe { device.get_image_subresource_layout(image, &subresource) };

        let row_size = plane_bytes.len() / plane_h as usize;
        for row in 0..plane_h as usize {
            let dst = unsafe {
                allocation
                    .get_host_ptr()
                    .add(layout.offset as usize + layout.row_pitch as usize * row)
            };
            unsafe { std::ptr::copy_nonoverlapping(plane_bytes[row * row_size..].as_ptr(), dst, row_size) };
        }
        flush_alloc(device, allocation)?;
    }

    let command_pool = make_command_pool(device, queue_family_index)?;
    let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
    begin_command_buffer(device, *command_buffer)?;
    let barrier = vk::ImageMemoryBarrier::builder()
        .src_access_mask(vk::AccessFlags::empty())
        .dst_access_mask(next_access)
        .old_layout(vk::ImageLayout::PREINITIALIZED)
        .new_layout(final_layout)
        .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .image(image)
        .subresource_range(vk::ImageSubresourceRange {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            base_mip_level: 0,
            level_count: 1,
            base_array_layer: array_layer,
            layer_count: 1,
        });
    unsafe {
        device.cmd_pipeline_barrier(
            *command_buffer,
            vk::PipelineStageFlags::HOST,
            vk::PipelineStageFlags::ALL_COMMANDS,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[barrier],
        );
    }
    end_command_buffer(device, *command_buffer)?;
    submit_commands_and_wait(device, queue, *command_buffer)?;
    Ok(())
}

/// `readImageMemory` - the mirror of `fill_image_memory`.
pub fn read_image_memory(
    device: &Device,
    image: vk::Image,
    allocations: &[Allocation<'_>],
    data: &mut MultiPlaneImageData,
) -> Result<(), TestError> {
    use vulkanalia::vk::DeviceV1_0;

    let info = data.description();
    let size = data.size();
    for plane_ndx in 0..info.planes.len() {
        let aspect = aspect_for(&info, plane_ndx);
        let allocation = if allocations.len() > 1 {
            &allocations[plane_ndx]
        } else {
            &allocations[0]
        };
        invalidate_alloc(device, allocation)?;

        let subresource = vk::ImageSubresource {
            aspect_mask: aspect,
            mip_level: 0,
            array_layer: 0,
        };
        let layout = unsafe { device.get_image_subresource_layout(image, &subresource) };

        let plane_h = size.1 / info.planes[plane_ndx].height_divisor;
        let row_size = data.plane(plane_ndx).len() / plane_h as usize;
        for row in 0..plane_h as usize {
            let src = unsafe {
                allocation
                    .get_host_ptr()
                    .add(layout.offset as usize + layout.row_pitch as usize * row)
            };
            let dst = data.plane_mut(plane_ndx)[row * row_size..].as_mut_ptr();
            unsafe { std::ptr::copy_nonoverlapping(src, dst, row_size) };
        }
    }
    Ok(())
}

#[cfg(test)]
mod byte_size_tests {
    use super::*;

    /// The sizes are derived from the format name rather than tabulated, so what needs
    /// pinning is that the derivation agrees with the formats it will actually see.
    #[test]
    fn element_sizes_are_derived_correctly() {
        for (format, expected) in [
            (vk::Format::R4G4_UNORM_PACK8, 1u32),
            (vk::Format::A4R4G4B4_UNORM_PACK16, 2),
            (vk::Format::A4B4G4R4_UNORM_PACK16, 2),
            (vk::Format::R5G6B5_UNORM_PACK16, 2),
            (vk::Format::A2B10G10R10_UNORM_PACK32, 4),
            (vk::Format::R10X6_UNORM_PACK16, 2),
            (vk::Format::R10X6G10X6_UNORM_2PACK16, 4),
            (vk::Format::R10X6G10X6B10X6A10X6_UNORM_4PACK16, 8),
            (vk::Format::R12X4_UNORM_PACK16, 2),
            (vk::Format::R8_UNORM, 1),
            (vk::Format::R8G8_UNORM, 2),
            (vk::Format::R8G8B8_UNORM, 3),
            (vk::Format::R8G8B8A8_UNORM, 4),
            (vk::Format::B8G8R8A8_UNORM, 4),
            (vk::Format::R16_UNORM, 2),
            (vk::Format::R16G16_UNORM, 4),
            (vk::Format::R16G16B16_UNORM, 6),
            (vk::Format::R16G16B16A16_UNORM, 8),
        ] {
            assert_eq!(block_byte_size_uncompressed(format), expected, "{format:?}");
        }
    }

    /// Every format the copy tests can reach must have a derivable size, or the test
    /// panics mid-run instead of failing.
    #[test]
    fn every_reachable_format_has_a_size() {
        for (format, _, _) in crate::vkt::tests::api::copy_format_lists::BASIC_UNSIGNED_FLOAT_FORMATS {
            let info = format_description(*format);
            for plane in info.planes {
                let size = block_byte_size(plane.compatible_format);
                assert!(size > 0, "{:?} plane {:?}", format, plane.compatible_format);
            }
            assert!(block_byte_size(*format) > 0, "{format:?}");
        }
    }
}

/// `checkImageSupport`
pub fn check_image_support(
    context: &crate::vkt::Context<'_>,
    format: vk::Format,
    create_flags: vk::ImageCreateFlags,
    tiling: vk::ImageTiling,
) -> Result<(), TestError> {
    use vulkanalia::vk::{InstanceV1_0, InstanceV1_1};

    let disjoint = create_flags.contains(vk::ImageCreateFlags::DISJOINT);

    let mut features = vk::PhysicalDeviceSamplerYcbcrConversionFeatures::default();
    {
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
    }
    if features.sampler_ycbcr_conversion == vk::FALSE {
        return Err(TestError::NotSupported(
            "samplerYcbcrConversion is not supported".to_string(),
        ));
    }

    if disjoint {
        context.require_device_functionality("VK_KHR_bind_memory2")?;
        context.require_device_functionality("VK_KHR_get_memory_requirements2")?;
    }

    let format_properties = unsafe {
        context
            .get_instance()
            .get_physical_device_format_properties(context.get_physical_device(), format)
    };
    let feature_flags = if tiling == vk::ImageTiling::OPTIMAL {
        format_properties.optimal_tiling_features
    } else {
        format_properties.linear_tiling_features
    };

    if !feature_flags
        .intersects(vk::FormatFeatureFlags::MIDPOINT_CHROMA_SAMPLES | vk::FormatFeatureFlags::COSITED_CHROMA_SAMPLES)
    {
        return Err(TestError::NotSupported(
            "YCbCr conversion is not supported for format".to_string(),
        ));
    }

    if disjoint && !feature_flags.contains(vk::FormatFeatureFlags::DISJOINT) {
        return Err(TestError::NotSupported(
            "Disjoint planes are not supported for format".to_string(),
        ));
    }

    Ok(())
}
