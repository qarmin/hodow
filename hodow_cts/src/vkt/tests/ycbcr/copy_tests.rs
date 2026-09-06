// SPDX-License-Identifier: Apache-2.0
//
// Ported from external/vulkancts/modules/vulkan/ycbcr/vktYCbCrCopyTests.cpp

use vulkanalia::vk;

use super::format_tables::{COMPATIBLE_FORMAT_CLASSES, COMPRESSED_FORMATS_FLOATS, COMPRESSED_FORMATS_SRGB, PLANE_COMPATIBLE_FORMATS, PlaneInfo};
use crate::tcu::TestCaseGroup;
use crate::vkt::tests::api::copy_format_lists::BASIC_UNSIGNED_FLOAT_FORMATS;

/// `ImageConfig`
#[derive(Clone, Copy)]
pub struct ImageConfig {
    pub format: vk::Format,
    pub tiling: vk::ImageTiling,
    pub disjoint: bool,
    pub size: (u32, u32),
}

/// `TestConfig`
#[derive(Clone, Copy)]
pub struct TestConfig {
    pub src: ImageConfig,
    pub dst: ImageConfig,
    pub intermediate_buffer: bool,
    pub extent: Option<(u32, u32)>,
}

/// `vk::isYCbCrFormat`, answered from the generated plane table: a format has a planar
/// description exactly when it is one.
pub fn is_ycbcr_format(format: vk::Format) -> bool {
    PLANE_COMPATIBLE_FORMATS.iter().any(|(f, _)| *f == format)
}

/// `getPlanarFormatDescription().planes`. A format with no entry is single-plane, and
/// its one plane copies as itself.
pub fn planes_of(format: vk::Format) -> &'static [PlaneInfo] {
    PLANE_COMPATIBLE_FORMATS.iter().find(|(f, _)| *f == format).map_or(&[][..], |(_, info)| info.planes)
}

fn plane_formats(format: vk::Format) -> impl Iterator<Item = vk::Format> {
    planes_of(format).iter().map(|p| p.compatible_format)
}

fn is_compressed(format: vk::Format) -> bool {
    COMPRESSED_FORMATS_FLOATS.contains(&format) || COMPRESSED_FORMATS_SRGB.contains(&format)
}

/// `isCompatible` - two formats may be copied between when they are the same, or share
/// a bit-width class. The 128-bit class is the one exception: it holds the compressed
/// formats too, and those are not interchangeable with the uncompressed ones.
pub fn is_compatible(src: vk::Format, dst: vk::Format) -> bool {
    if src == dst {
        return true;
    }

    for (ndx, class) in COMPATIBLE_FORMAT_CLASSES.iter().enumerate() {
        // The 128-bit class is index 7 in the generated order (8, 16, 24, 32, 48, 64, 96, 128, ...).
        let exclude_compressed = ndx == 7;
        if class.contains(&src) && class.contains(&dst) && (!exclude_compressed || (!is_compressed(src) && !is_compressed(dst))) {
            return true;
        }
    }

    false
}

/// `isCopyCompatible` - a copy between two images is expressible when some plane of one
/// is compatible with some plane of the other.
pub fn is_copy_compatible(src_format: vk::Format, dst_format: vk::Format) -> bool {
    match (is_ycbcr_format(src_format), is_ycbcr_format(dst_format)) {
        (true, true) => plane_formats(src_format).any(|s| plane_formats(dst_format).any(|d| is_compatible(s, d))),
        (true, false) => plane_formats(src_format).any(|s| is_compatible(s, dst_format)),
        (false, true) => plane_formats(dst_format).any(|d| is_compatible(src_format, d)),
        (false, false) => is_compatible(src_format, dst_format),
    }
}

/// A YCbCr image is sized so its chroma planes divide evenly; everything else uses an
/// awkward size on purpose.
fn size_for(format: vk::Format) -> (u32, u32) {
    if is_ycbcr_format(format) { (24, 16) } else { (23, 17) }
}

struct CopyTestCase {
    name: String,
    #[allow(dead_code)]
    config: TestConfig,
}

impl crate::vkt::TestCase for CopyTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, _context: &crate::vkt::Context<'_>) -> Result<(), crate::vkt::TestError> {
        Err(crate::vkt::TestError::NotSupported("ycbcr copy: instance not implemented yet".into()))
    }

    fn programs(&self) -> crate::vk::programs::BinaryCollection {
        crate::vk::programs::BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, _context: &'a crate::vkt::Context<'a>) -> Box<dyn crate::vkt::TestInstance + 'a> {
        unreachable!("check_support rejects every case until the instance lands")
    }
}

/// `initYcbcrDefaultCopyTests`
pub fn create_copy_tests() -> TestCaseGroup {
    const TILINGS: [(&str, vk::ImageTiling); 2] = [("linear", vk::ImageTiling::LINEAR), ("optimal", vk::ImageTiling::OPTIMAL)];

    let mut group = TestCaseGroup::new("copy");

    for (src_format, src_format_name, _) in BASIC_UNSIGNED_FLOAT_FORMATS {
        let src_size = size_for(*src_format);
        let mut src_group = TestCaseGroup::new(*src_format_name);

        for (dst_format, dst_format_name, _) in BASIC_UNSIGNED_FLOAT_FORMATS {
            let dst_size = size_for(*dst_format);

            // At least one side has to be a YCbCr format - a plain-to-plain copy is
            // covered by the api group - and the two have to be copy compatible.
            if (!is_ycbcr_format(*src_format) && !is_ycbcr_format(*dst_format)) || !is_copy_compatible(*src_format, *dst_format) {
                continue;
            }

            let mut dst_group = TestCaseGroup::new(*dst_format_name);

            for (src_tiling_name, src_tiling) in TILINGS {
                for (dst_tiling_name, dst_tiling) in TILINGS {
                    for src_disjoint in [false, true] {
                        for dst_disjoint in [false, true] {
                            for use_buffer in [false, true] {
                                let config = TestConfig {
                                    src: ImageConfig {
                                        format: *src_format,
                                        tiling: src_tiling,
                                        disjoint: src_disjoint,
                                        size: src_size,
                                    },
                                    dst: ImageConfig {
                                        format: *dst_format,
                                        tiling: dst_tiling,
                                        disjoint: dst_disjoint,
                                        size: dst_size,
                                    },
                                    intermediate_buffer: use_buffer,
                                    extent: None,
                                };
                                let name = format!(
                                    "{src_tiling_name}{}{}{dst_tiling_name}{}",
                                    if src_disjoint { "_disjoint_" } else { "_" },
                                    if use_buffer { "buffer_" } else { "" },
                                    if dst_disjoint { "_disjoint" } else { "" },
                                );
                                dst_group.add_child(Box::new(CopyTestCase { name, config }) as Box<dyn crate::vkt::TestCase>);
                            }
                        }
                    }
                }
            }

            src_group.add_child(dst_group);
        }

        group.add_child(src_group);
    }

    group
}
