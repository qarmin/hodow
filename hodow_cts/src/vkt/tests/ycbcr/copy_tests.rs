// SPDX-License-Identifier: Apache-2.0
//
// Ported from external/vulkancts/modules/vulkan/ycbcr/vktYCbCrCopyTests.cpp

use vulkanalia::vk;

use super::format_tables::{COMPATIBLE_FORMAT_CLASSES, COMPRESSED_FORMATS_FLOATS, COMPRESSED_FORMATS_SRGB, FormatInfo, PLANE_COMPATIBLE_FORMATS, PlaneInfo};
use super::util::{
    MultiPlaneImageData, allocate_and_bind_image_memory, aspect_plane_ndx, block_byte_size, block_extent, download_image, fill_image_memory, format_description,
    lsb_dont_care_mask, plane_aspect, plane_extent, plane_size_in_bytes, read_image_memory, upload_image,
};
use crate::tcu::random::Random;
use crate::tcu::{TestCaseGroup, TestError};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::MemoryRequirement;
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool};
use crate::vk::{Unique, VkResultExt};
use crate::vkt::tests::api::copy_format_lists::BASIC_UNSIGNED_FLOAT_FORMATS;
use crate::vkt::{Context, TestCase, TestInstance};

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
    config: TestConfig,
}

/// `buildSeed` - the copies are random, but per case rather than per run, so a failure
/// is reproducible. `tcu::SeedBuilder` is a CRC32 over the fed bytes.
fn build_seed(config: &TestConfig) -> u32 {
    let mut builder = SeedBuilder::new();
    builder.feed_u32(6792903);
    for image in [&config.src, &config.dst] {
        builder.feed_u32(image.format.as_raw() as u32);
        builder.feed_u32(image.tiling.as_raw() as u32);
        builder.feed_bool(image.disjoint);
        builder.feed_u32(image.size.0);
        builder.feed_u32(image.size.1);
    }
    builder.get()
}

/// `tcu::SeedBuilder`
struct SeedBuilder {
    hash: u32,
}

impl SeedBuilder {
    fn new() -> Self {
        Self { hash: 0xccf1_39d7 }
    }

    /// `advanceCrc32`
    fn feed(&mut self, bytes: &[u8]) {
        const GENERATOR: u32 = 0x04C1_1DB7;
        for &byte in bytes {
            self.hash ^= u32::from(byte);
            for _ in 0..8 {
                self.hash = if self.hash & 1 != 0 { (self.hash >> 1) ^ GENERATOR } else { self.hash >> 1 };
            }
        }
    }

    fn feed_u32(&mut self, value: u32) {
        self.feed(&value.to_ne_bytes());
    }

    fn feed_bool(&mut self, value: bool) {
        self.feed(&[u8::from(value)]);
    }

    fn get(&self) -> u32 {
        self.hash
    }
}

/// `genCopies` - ten copies between randomly chosen compatible plane pairs, each of a
/// random size at a random offset, aligned to the texel block of both sides.
fn gen_copies(rng: &mut Random, copy_count: usize, config: &TestConfig) -> Vec<vk::ImageCopy> {
    let src_info = format_description(config.src.format);
    let dst_info = format_description(config.dst.format);

    let mut pairs = Vec::new();
    for (src_ndx, src_plane) in src_info.planes.iter().enumerate() {
        for (dst_ndx, dst_plane) in dst_info.planes.iter().enumerate() {
            if is_compatible(src_plane.compatible_format, dst_plane.compatible_format) {
                pairs.push((src_ndx, dst_ndx));
            }
        }
    }
    assert!(!pairs.is_empty(), "the case would not have been registered without a compatible plane pair");

    let random_uvec2 = |rng: &mut Random, min: (u32, u32), max: (u32, u32)| (rng.get_int(min.0 as i32, max.0 as i32) as u32, rng.get_int(min.1 as i32, max.1 as i32) as u32);

    let mut copies = Vec::with_capacity(copy_count);
    for _ in 0..copy_count {
        let (src_plane_ndx, dst_plane_ndx) = *rng.choose(&pairs);

        let src_block = block_extent(src_info.planes[src_plane_ndx].compatible_format);
        let src_plane_extent = plane_extent(&src_info, config.src.size, src_plane_ndx);
        let src_plane_blocks = (src_plane_extent.0 / src_block.0, src_plane_extent.1 / src_block.1);

        let dst_block = block_extent(dst_info.planes[dst_plane_ndx].compatible_format);
        let dst_plane_extent = plane_extent(&dst_info, config.dst.size, dst_plane_ndx);
        let dst_plane_blocks = (dst_plane_extent.0 / dst_block.0, dst_plane_extent.1 / dst_block.1);

        let copy_blocks = random_uvec2(rng, (1, 1), (src_plane_blocks.0.min(dst_plane_blocks.0), src_plane_blocks.1.min(dst_plane_blocks.1)));
        let src_off = random_uvec2(rng, (0, 0), (src_plane_blocks.0 - copy_blocks.0, src_plane_blocks.1 - copy_blocks.1));
        let dst_off = random_uvec2(rng, (0, 0), (dst_plane_blocks.0 - copy_blocks.0, dst_plane_blocks.1 - copy_blocks.1));
        let src_offset = (src_block.0 * src_off.0, src_block.1 * src_off.1);
        let dst_offset = (dst_block.0 * dst_off.0, dst_block.1 * dst_off.1);
        let copy_extent = (copy_blocks.0 * src_block.0, copy_blocks.1 * src_block.1);

        let layers = |info: &FormatInfo, ndx: usize| vk::ImageSubresourceLayers {
            aspect_mask: if info.planes.len() > 1 { plane_aspect(ndx) } else { vk::ImageAspectFlags::COLOR },
            mip_level: 0,
            base_array_layer: 0,
            layer_count: 1,
        };

        copies.push(vk::ImageCopy {
            src_subresource: layers(&src_info, src_plane_ndx),
            src_offset: vk::Offset3D {
                x: src_offset.0 as i32,
                y: src_offset.1 as i32,
                z: 0,
            },
            dst_subresource: layers(&dst_info, dst_plane_ndx),
            dst_offset: vk::Offset3D {
                x: dst_offset.0 as i32,
                y: dst_offset.1 as i32,
                z: 0,
            },
            extent: vk::Extent3D {
                width: copy_extent.0,
                height: copy_extent.1,
                depth: 1,
            },
        });
    }
    copies
}

impl TestCase for CopyTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        use vulkanalia::vk::InstanceV1_0;

        let limits = context.get_device_properties().limits;
        for image in [&self.config.src, &self.config.dst] {
            if image.size.0 > limits.max_image_dimension_2d || image.size.1 > limits.max_image_dimension_2d {
                return Err(TestError::NotSupported("Requested image dimensions not supported".into()));
            }
        }

        context.require_device_functionality("VK_KHR_sampler_ycbcr_conversion")?;

        for image in [&self.config.src, &self.config.dst] {
            // VUID-vkGetPhysicalDeviceFormatProperties-format-parameter
            if matches!(image.format, vk::Format::A1B5G5R5_UNORM_PACK16 | vk::Format::A8_UNORM) {
                context.require_device_functionality("VK_KHR_maintenance5")?;
            }

            let props = unsafe { context.get_instance().get_physical_device_format_properties(context.get_physical_device(), image.format) };
            let features = if image.tiling == vk::ImageTiling::OPTIMAL {
                props.optimal_tiling_features
            } else {
                props.linear_tiling_features
            };

            if !features.intersects(vk::FormatFeatureFlags::TRANSFER_SRC | vk::FormatFeatureFlags::TRANSFER_DST) {
                return Err(TestError::NotSupported("Format doesn't support copies".into()));
            }

            if image.disjoint && !features.contains(vk::FormatFeatureFlags::DISJOINT) {
                return Err(TestError::NotSupported("Format doesn't support disjoint planes".into()));
            }
        }

        Ok(())
    }

    fn programs(&self) -> crate::vk::programs::BinaryCollection {
        crate::vk::programs::BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CopyTestInstance { context, config: self.config })
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

/// `imageCopyTest`
struct CopyTestInstance<'a> {
    context: &'a Context<'a>,
    config: TestConfig,
}

impl TestInstance for CopyTestInstance<'_> {
    fn iterate(&mut self) -> crate::tcu::TestOutcome {
        use vulkanalia::vk::{DeviceV1_0, HasBuilder};

        let config = self.config;
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();

        let mut rng = Random::new(build_seed(&config));

        let copies = gen_copies(&mut rng, 10, &config);

        let mut src_data = MultiPlaneImageData::new(config.src.format, config.src.size);
        let mut dst_data = MultiPlaneImageData::new(config.dst.format, config.dst.size);
        src_data.fill_random(&mut rng);
        dst_data.fill_random(&mut rng);

        let make_image = |image_config: &ImageConfig| -> Result<Unique<'_, vk::Image>, TestError> {
            let info = vk::ImageCreateInfo::builder()
                .flags(if image_config.disjoint {
                    vk::ImageCreateFlags::DISJOINT
                } else {
                    vk::ImageCreateFlags::empty()
                })
                .image_type(vk::ImageType::_2D)
                .format(image_config.format)
                .extent(vk::Extent3D {
                    width: image_config.size.0,
                    height: image_config.size.1,
                    depth: 1,
                })
                .mip_levels(1)
                .array_layers(1)
                .samples(vk::SampleCountFlags::_1)
                .tiling(image_config.tiling)
                .usage(vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                // A linear image is filled by writing its memory directly, which needs
                // a layout that preserves what was written.
                .initial_layout(if image_config.tiling == vk::ImageTiling::LINEAR {
                    vk::ImageLayout::PREINITIALIZED
                } else {
                    vk::ImageLayout::UNDEFINED
                });
            let handle = unsafe { device.create_image(&info, None) }.vk_check("vkCreateImage")?;
            Ok(Unique::new(device, handle))
        };

        let src_image = make_image(&config.src)?;
        let dst_image = make_image(&config.dst)?;

        let requirement_for = |tiling: vk::ImageTiling| {
            if tiling == vk::ImageTiling::OPTIMAL {
                MemoryRequirement::ANY
            } else {
                MemoryRequirement::HOST_VISIBLE
            }
        };

        let src_memory = allocate_and_bind_image_memory(device, allocator, *src_image, config.src.format, config.src.disjoint, requirement_for(config.src.tiling))?;
        let dst_memory = allocate_and_bind_image_memory(device, allocator, *dst_image, config.dst.format, config.dst.disjoint, requirement_for(config.dst.tiling))?;

        if config.src.tiling == vk::ImageTiling::OPTIMAL {
            upload_image(
                device,
                allocator,
                queue,
                queue_family_index,
                *src_image,
                &src_data,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            )?;
        } else {
            fill_image_memory(
                device,
                queue,
                queue_family_index,
                *src_image,
                &src_memory,
                &src_data,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            )?;
        }

        if config.dst.tiling == vk::ImageTiling::OPTIMAL {
            upload_image(
                device,
                allocator,
                queue,
                queue_family_index,
                *dst_image,
                &dst_data,
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            )?;
        } else {
            fill_image_memory(
                device,
                queue,
                queue_family_index,
                *dst_image,
                &dst_memory,
                &dst_data,
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            )?;
        }

        let command_pool = make_command_pool(device, queue_family_index)?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;

        // Held until the submit below completes.
        let mut intermediate = Vec::new();

        begin_command_buffer(device, *command_buffer)?;
        for copy in &copies {
            if config.intermediate_buffer {
                // The copy goes image -> buffer -> image instead of straight across,
                // which is a different path through the driver for the same result.
                let src_plane_ndx = aspect_plane_ndx(copy.src_subresource.aspect_mask);
                let src_plane_format = format_description(config.src.format).planes[src_plane_ndx].compatible_format;
                let buffer_size = (config.src.size.0 * config.src.size.1 * block_byte_size(src_plane_format)) as vk::DeviceSize;
                let buffer = BufferWithMemory::new(
                    device,
                    allocator,
                    make_buffer_create_info(buffer_size, vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST),
                    MemoryRequirement::ANY,
                )?;

                let to_buffer = vk::BufferImageCopy::builder()
                    .buffer_offset(0)
                    .buffer_row_length(0)
                    .buffer_image_height(0)
                    .image_subresource(copy.src_subresource)
                    .image_offset(copy.src_offset)
                    .image_extent(copy.extent);
                let from_buffer = vk::BufferImageCopy::builder()
                    .buffer_offset(0)
                    .buffer_row_length(0)
                    .buffer_image_height(0)
                    .image_subresource(copy.dst_subresource)
                    .image_offset(copy.dst_offset)
                    .image_extent(copy.extent);

                let barrier = vk::BufferMemoryBarrier::builder()
                    .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
                    .dst_access_mask(vk::AccessFlags::TRANSFER_READ)
                    .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                    .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                    .buffer(buffer.get())
                    .offset(0)
                    .size(vk::WHOLE_SIZE);

                unsafe {
                    device.cmd_copy_image_to_buffer(*command_buffer, *src_image, vk::ImageLayout::TRANSFER_SRC_OPTIMAL, buffer.get(), &[to_buffer]);
                    device.cmd_pipeline_barrier(
                        *command_buffer,
                        vk::PipelineStageFlags::TRANSFER,
                        vk::PipelineStageFlags::TRANSFER,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[barrier],
                        &[] as &[vk::ImageMemoryBarrier],
                    );
                    device.cmd_copy_buffer_to_image(*command_buffer, buffer.get(), *dst_image, vk::ImageLayout::TRANSFER_DST_OPTIMAL, &[from_buffer]);
                }
                intermediate.push(buffer);
            } else {
                unsafe {
                    device.cmd_copy_image(
                        *command_buffer,
                        *src_image,
                        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                        *dst_image,
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        &[*copy],
                    );
                }
            }
        }
        end_command_buffer(device, *command_buffer)?;
        submit_commands_and_wait(device, queue, *command_buffer)?;

        let mut result = MultiPlaneImageData::new(config.dst.format, config.dst.size);
        if config.dst.tiling == vk::ImageTiling::OPTIMAL {
            download_image(
                device,
                allocator,
                queue,
                queue_family_index,
                *dst_image,
                &mut result,
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            )?;
        } else {
            read_image_memory(device, *dst_image, &dst_memory, &mut result)?;
        }

        // The reference is the destination with each copy applied by hand, row by row,
        // in the block-addressed coordinates the copy was expressed in.
        let mut reference = MultiPlaneImageData::new(config.dst.format, config.dst.size);
        for plane_ndx in 0..reference.plane_count() {
            reference.plane_mut(plane_ndx).copy_from_slice(dst_data.plane(plane_ndx));
        }

        let src_info = format_description(config.src.format);
        let dst_info = format_description(config.dst.format);
        for copy in &copies {
            let src_plane_ndx = aspect_plane_ndx(copy.src_subresource.aspect_mask);
            let dst_plane_ndx = aspect_plane_ndx(copy.dst_subresource.aspect_mask);
            let src_plane_format = src_info.planes[src_plane_ndx].compatible_format;
            let dst_plane_format = dst_info.planes[dst_plane_ndx].compatible_format;
            let block_size_bytes = block_byte_size(src_plane_format);

            let src_block = block_extent(src_plane_format);
            let src_plane_ext = plane_extent(&src_info, config.src.size, src_plane_ndx);
            let src_plane_blocks = (src_plane_ext.0 / src_block.0, src_plane_ext.1 / src_block.1);
            let src_block_offset = (copy.src_offset.x as u32 / src_block.0, copy.src_offset.y as u32 / src_block.1);
            let src_pitch = (block_size_bytes, block_size_bytes * src_plane_blocks.0);

            let dst_block = block_extent(dst_plane_format);
            let dst_plane_ext = plane_extent(&dst_info, config.dst.size, dst_plane_ndx);
            let dst_plane_blocks = (dst_plane_ext.0 / dst_block.0, dst_plane_ext.1 / dst_block.1);
            let dst_block_offset = (copy.dst_offset.x as u32 / dst_block.0, copy.dst_offset.y as u32 / dst_block.1);
            let dst_pitch = (block_size_bytes, block_size_bytes * dst_plane_blocks.0);

            let blocks = (copy.extent.width / src_block.0, copy.extent.height / src_block.1);

            for y in 0..blocks.1 {
                let size = (blocks.0 * block_size_bytes) as usize;
                let src_pos = (src_pitch.0 * src_block_offset.0 + src_pitch.1 * (src_block_offset.1 + y)) as usize;
                let dst_pos = (dst_pitch.0 * dst_block_offset.0 + dst_pitch.1 * (dst_block_offset.1 + y)) as usize;
                let bytes = src_data.plane(src_plane_ndx)[src_pos..src_pos + size].to_vec();
                reference.plane_mut(dst_plane_ndx)[dst_pos..dst_pos + size].copy_from_slice(&bytes);
            }
        }

        // The padding bits of a packed format are undefined after a copy, so they are
        // masked out of the low byte of each element rather than expected to match.
        let dont_care = lsb_dont_care_mask(config.src.format, config.dst.format);
        const MAX_ERROR_COUNT: usize = 30;
        let mut error_count = 0usize;

        for plane_ndx in 0..result.plane_count() {
            let plane_size = plane_size_in_bytes(&dst_info, config.dst.size, plane_ndx);
            for byte_ndx in 0..plane_size {
                let res = result.plane(plane_ndx)[byte_ndx];
                let reference_byte = reference.plane(plane_ndx)[byte_ndx];
                let mask = match dont_care {
                    Some(m) if byte_ndx % 2 == 0 => m,
                    _ => 0xFF,
                };

                if (res & mask) != (reference_byte & mask) {
                    error_count += 1;
                    if error_count > MAX_ERROR_COUNT {
                        break;
                    }
                }
            }
            if error_count > MAX_ERROR_COUNT {
                break;
            }
        }

        if error_count > 0 {
            let count = if error_count > MAX_ERROR_COUNT {
                format!("{MAX_ERROR_COUNT}+")
            } else {
                error_count.to_string()
            };
            return Ok(crate::tcu::TestStatus::fail(format!("Failed, found {count} incorrect bytes")));
        }

        Ok(crate::tcu::TestStatus::pass("Pass"))
    }
}
