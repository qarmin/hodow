// SPDX-License-Identifier: Apache-2.0
//
// Ported from external/vulkancts/modules/vulkan/ycbcr/vktYCbCrUtil.cpp and the plane
// geometry half of external/vulkancts/framework/vulkan/vkImageUtil.cpp.

use vulkanalia::vk;

use super::format_tables::{FormatInfo, PLANE_COMPATIBLE_FORMATS, PlaneInfo};

/// The single plane a non-planar format is described by: itself, one texel per block.
/// Upstream builds this on the fly in `getPlanarFormatDescription`; here it stands in
/// for the table entry a non-YCbCr format has none of.
fn single_plane_info(format: vk::Format) -> FormatInfo {
    FormatInfo {
        block_width: 1,
        block_height: 1,
        planes: std::slice::from_ref(Box::leak(Box::new(PlaneInfo {
            element_size: block_byte_size_uncompressed(format),
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

/// The byte size of one texel of an uncompressed format, from its name's bit layout.
/// Deliberately not a table: every format that reaches here is one of the plane
/// compatible formats, which are all plain one- and two-channel integer formats.
fn block_byte_size_uncompressed(format: vk::Format) -> u32 {
    match format {
        vk::Format::R8_UNORM | vk::Format::R8_UINT | vk::Format::R8_SNORM | vk::Format::R8_SINT | vk::Format::R8_SRGB => 1,
        vk::Format::R8G8_UNORM | vk::Format::R8G8_UINT | vk::Format::R8G8_SNORM | vk::Format::R8G8_SINT | vk::Format::R8G8_SRGB => 2,
        vk::Format::R10X6_UNORM_PACK16 | vk::Format::R12X4_UNORM_PACK16 | vk::Format::R16_UNORM | vk::Format::R16_UINT | vk::Format::R16_SFLOAT => 2,
        vk::Format::R10X6G10X6_UNORM_2PACK16 | vk::Format::R12X4G12X4_UNORM_2PACK16 | vk::Format::R16G16_UNORM | vk::Format::R16G16_UINT => 4,
        vk::Format::R8G8B8A8_UNORM | vk::Format::B8G8R8A8_UNORM | vk::Format::R32_UINT | vk::Format::R32_SFLOAT => 4,
        vk::Format::R4G4_UNORM_PACK8 | vk::Format::A8_UNORM => 1,
        vk::Format::R4G4B4A4_UNORM_PACK16
        | vk::Format::B4G4R4A4_UNORM_PACK16
        | vk::Format::R5G6B5_UNORM_PACK16
        | vk::Format::B5G6R5_UNORM_PACK16
        | vk::Format::R5G5B5A1_UNORM_PACK16
        | vk::Format::B5G5R5A1_UNORM_PACK16
        | vk::Format::A1R5G5B5_UNORM_PACK16
        | vk::Format::A1B5G5R5_UNORM_PACK16 => 2,
        vk::Format::R8G8B8_UNORM | vk::Format::B8G8R8_UNORM => 3,
        vk::Format::R16G16B16_UNORM => 6,
        vk::Format::R16G16B16A16_UNORM => 8,
        vk::Format::A2R10G10B10_UNORM_PACK32 | vk::Format::A2B10G10R10_UNORM_PACK32 | vk::Format::A8B8G8R8_UNORM_PACK32 | vk::Format::B10G11R11_UFLOAT_PACK32 => 4,
        other => panic!("no byte size known for {other:?}"),
    }
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
        let planes = (0..info.planes.len()).map(|ndx| vec![0u8; plane_size_in_bytes(&info, size, ndx)]).collect();
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

        assert_eq!(lsb_dont_care_mask(vk::Format::R10X6_UNORM_PACK16, vk::Format::R16_UNORM), Some(0xC0));
        assert_eq!(lsb_dont_care_mask(vk::Format::R16_UNORM, vk::Format::R12X4_UNORM_PACK16), Some(0xF0));
        assert_eq!(lsb_dont_care_mask(vk::Format::R8_UNORM, vk::Format::R8G8_UNORM), None);

        let mut data = MultiPlaneImageData::new(vk::Format::R10X6_UNORM_PACK16, (8, 8));
        let mut rng = crate::tcu::random::Random::new(1);
        data.fill_random(&mut rng);
        for pair in data.plane(0).chunks(2) {
            assert_eq!(pair[0] & 0x3F, 0, "the six unused low bits must be clear");
        }
    }
}
