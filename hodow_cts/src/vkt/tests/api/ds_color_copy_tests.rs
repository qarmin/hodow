// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiDSColorBitCopyTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Copying between a depth/stencil aspect and a same-width colour format. The check is a
// raw bit comparison rather than a decoded one: the point is that the bits survive the
// round trip, not that they mean the same thing in both formats.

use vulkanalia::prelude::v1_0::*;

use crate::tcu::{self, Random, TestError, TestOutcome, TestStatus};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_memory_barrier, make_image_subresource_range};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestInstance};

/// `kMinDepthFloatVal` / `kMaxDepthFloatVal`
const MIN_DEPTH_FLOAT: f32 = 0.125;
const MAX_DEPTH_FLOAT: f32 = 1.0;
/// `kMaxDepthFloatValUnrestricted` - beyond 1.0, which a D32 image only accepts with
/// VK_EXT_depth_range_unrestricted.
const MAX_DEPTH_FLOAT_UNRESTRICTED: f32 = 10.0;
/// `kDepth24Mask`
const DEPTH24_MASK: u32 = 0x00FF_FFFF;

/// `QueueType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum QueueType {
    Universal,
    ComputeOnly,
    TransferOnly,
}

/// `getFormatGroups` - the spec's list of same-width depth/stencil and colour formats.
struct FormatGroup {
    ds_formats: &'static [(vk::Format, &'static str)],
    color_formats: &'static [(vk::Format, &'static str)],
    aspect: vk::ImageAspectFlags,
}

fn format_groups() -> Vec<FormatGroup> {
    vec![
        // 32-bit depth.
        FormatGroup {
            aspect: vk::ImageAspectFlags::DEPTH,
            ds_formats: &[(vk::Format::D32_SFLOAT, "d32_sfloat"), (vk::Format::D32_SFLOAT_S8_UINT, "d32_sfloat_s8_uint")],
            color_formats: &[
                (vk::Format::R32_SFLOAT, "r32_sfloat"),
                (vk::Format::R32_SINT, "r32_sint"),
                (vk::Format::R32_UINT, "r32_uint"),
            ],
        },
        // 24-bit depth.
        FormatGroup {
            aspect: vk::ImageAspectFlags::DEPTH,
            ds_formats: &[
                (vk::Format::X8_D24_UNORM_PACK32, "x8_d24_unorm_pack32"),
                (vk::Format::D24_UNORM_S8_UINT, "d24_unorm_s8_uint"),
            ],
            color_formats: &[
                (vk::Format::R32_SFLOAT, "r32_sfloat"),
                (vk::Format::R32_SINT, "r32_sint"),
                (vk::Format::R32_UINT, "r32_uint"),
            ],
        },
        // 16-bit depth.
        FormatGroup {
            aspect: vk::ImageAspectFlags::DEPTH,
            ds_formats: &[(vk::Format::D16_UNORM, "d16_unorm"), (vk::Format::D16_UNORM_S8_UINT, "d16_unorm_s8_uint")],
            color_formats: &[
                (vk::Format::R16_SFLOAT, "r16_sfloat"),
                (vk::Format::R16_UNORM, "r16_unorm"),
                (vk::Format::R16_SNORM, "r16_snorm"),
                (vk::Format::R16_UINT, "r16_uint"),
                (vk::Format::R16_SINT, "r16_sint"),
            ],
        },
        // 8-bit stencil.
        FormatGroup {
            aspect: vk::ImageAspectFlags::STENCIL,
            ds_formats: &[
                (vk::Format::S8_UINT, "s8_uint"),
                (vk::Format::D32_SFLOAT_S8_UINT, "d32_sfloat_s8_uint"),
                (vk::Format::D24_UNORM_S8_UINT, "d24_unorm_s8_uint"),
                (vk::Format::D16_UNORM_S8_UINT, "d16_unorm_s8_uint"),
            ],
            color_formats: &[
                (vk::Format::R8_UINT, "r8_uint"),
                (vk::Format::R8_SINT, "r8_sint"),
                (vk::Format::R8_UNORM, "r8_unorm"),
                (vk::Format::R8_SNORM, "r8_snorm"),
            ],
        },
    ]
}

fn is_d32(f: vk::Format) -> bool {
    matches!(f, vk::Format::D32_SFLOAT | vk::Format::D32_SFLOAT_S8_UINT)
}
fn is_d24(f: vk::Format) -> bool {
    matches!(f, vk::Format::X8_D24_UNORM_PACK32 | vk::Format::D24_UNORM_S8_UINT)
}
fn is_d16(f: vk::Format) -> bool {
    matches!(f, vk::Format::D16_UNORM | vk::Format::D16_UNORM_S8_UINT)
}
fn is_depth_stencil(f: vk::Format) -> bool {
    is_d32(f) || is_d24(f) || is_d16(f) || f == vk::Format::S8_UINT
}

/// `getBitCount` - how wide the values being moved are, which the whole test keys off.
fn bit_count(src: vk::Format, dst: vk::Format, aspect: vk::ImageAspectFlags) -> u32 {
    if aspect == vk::ImageAspectFlags::STENCIL {
        return 8;
    }
    if is_d32(src) || is_d32(dst) {
        32
    } else if is_d24(src) || is_d24(dst) {
        24
    } else {
        16
    }
}

/// `getImageUsage`
fn image_usage(format: vk::Format, attachment_usage: bool) -> vk::ImageUsageFlags {
    let mut usage = vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
    if attachment_usage {
        usage |= if is_depth_stencil(format) {
            vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
        } else {
            vk::ImageUsageFlags::COLOR_ATTACHMENT
        };
    }
    usage
}

/// `getRandomDepth32` - one value in sixteen is forced to zero, so the comparison also
/// covers the all-bits-clear case.
fn random_depth32(rnd: &mut Random, unrestricted: bool) -> f32 {
    if rnd.get_int(0, 15) == 0 {
        return 0.0;
    }
    let max = if unrestricted { MAX_DEPTH_FLOAT_UNRESTRICTED } else { MAX_DEPTH_FLOAT };
    rnd.get_float_range(MIN_DEPTH_FLOAT, max)
}

/// `getRandomSrcValues` - the raw bytes that go into the source image.
fn random_src_values(rnd: &mut Random, src: vk::Format, dst: vk::Format, aspect: vk::ImageAspectFlags, count: usize, unrestricted: bool) -> Vec<u8> {
    let mut bytes = Vec::new();
    match bit_count(src, dst, aspect) {
        8 => {
            for _ in 0..count {
                // A signed-norm destination must not see 0x80, which is the one value
                // that does not round-trip through the -127..127 range.
                let v = if src == vk::Format::R8_SNORM || dst == vk::Format::R8_SNORM {
                    rnd.get_int(-127, 127) as i8 as u8
                } else {
                    rnd.get_uint8()
                };
                bytes.push(v);
            }
        }
        16 => {
            for _ in 0..count {
                let v: u16 = if src == vk::Format::R16_SFLOAT || dst == vk::Format::R16_SFLOAT {
                    // Unrestricted because the value is not going through a depth image.
                    crate::tcu::pixel::f32_to_f16_bits(random_depth32(rnd, true))
                } else if src == vk::Format::R16_SNORM || dst == vk::Format::R16_SNORM {
                    rnd.get_int(-32767, 32767) as i16 as u16
                } else {
                    rnd.get_uint16()
                };
                bytes.extend_from_slice(&v.to_le_bytes());
            }
        }
        24 => {
            for _ in 0..count {
                bytes.extend_from_slice(&(rnd.get_uint32() & DEPTH24_MASK).to_le_bytes());
            }
        }
        _ => {
            for _ in 0..count {
                bytes.extend_from_slice(&random_depth32(rnd, unrestricted).to_le_bytes());
            }
        }
    }
    bytes
}

/// `DSColorCopyCase`
pub struct DsColorCopyCase {
    name: String,
    src_format: vk::Format,
    dst_format: vk::Format,
    aspect: vk::ImageAspectFlags,
    src_mip_level: u32,
    dst_mip_level: u32,
    seed: u32,
    queue_type: QueueType,
    unrestricted: bool,
    attachment_usage: bool,
}

impl DsColorCopyCase {
    fn format_supported(&self, context: &Context<'_>, format: vk::Format, mip_level: u32) -> bool {
        let usage = image_usage(format, self.attachment_usage);
        let props = unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                format,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                usage,
                vk::ImageCreateFlags::empty(),
            )
        };
        match props {
            Ok(p) => p.max_mip_levels > mip_level,
            Err(_) => false,
        }
    }
}

impl TestCase for DsColorCopyCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        // Copying between a depth/stencil aspect and a colour format is what
        // maintenance8 added; without it none of this group is legal.
        context.require_device_functionality("VK_KHR_maintenance8")?;

        for (format, mip) in [(self.src_format, self.src_mip_level), (self.dst_format, self.dst_mip_level)] {
            if !self.format_supported(context, format, mip) {
                return Err(TestError::NotSupported(format!("Format {format:?} does not support required features")));
            }
        }

        // A copy on a compute or transfer queue is only legal with maintenance10, and
        // then only for formats that advertise the matching feature bit. The bits live
        // in VkFormatProperties3, so the extension gate is checked first and the whole
        // group falls away on an implementation without it.
        if self.queue_type != QueueType::Universal {
            context.require_device_functionality("VK_KHR_maintenance10")?;
            context.require_device_functionality("VK_KHR_format_feature_flags2")?;
            let available = match self.queue_type {
                QueueType::ComputeOnly => context.get_compute_queue().is_some(),
                QueueType::TransferOnly => context.get_transfer_queue().is_some(),
                QueueType::Universal => true,
            };
            if !available {
                return Err(TestError::NotSupported("no queue of the requested kind".to_string()));
            }
        }

        if self.unrestricted {
            context.require_device_functionality("VK_EXT_depth_range_unrestricted")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DsColorCopyInstance { context, params: self })
    }
}

struct DsColorCopyInstance<'a> {
    context: &'a Context<'a>,
    params: &'a DsColorCopyCase,
}

/// `PixelValue::operator!=` - compares only the bits the format actually carries, which
/// is why a 24-bit depth ignores the high byte of its 32-bit container.
fn pixels_differ(a: &[u8], b: &[u8], bits: u32) -> bool {
    match bits {
        8 => a[0] != b[0],
        16 => a[..2] != b[..2],
        24 => {
            let (x, y) = (u32::from_le_bytes(a[..4].try_into().unwrap()), u32::from_le_bytes(b[..4].try_into().unwrap()));
            (x & DEPTH24_MASK) != (y & DEPTH24_MASK)
        }
        _ => a[..4] != b[..4],
    }
}

impl TestInstance for DsColorCopyInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let p = self.params;
        let vk_device = self.context.get_device();
        let allocator = self.context.get_default_allocator();

        let base_extent = [16u32, 16, 1];
        let pixel_count = (base_extent[0] * base_extent[1] * base_extent[2]) as usize;
        let src_mip_levels = p.src_mip_level + 1;
        let dst_mip_levels = p.dst_mip_level + 1;

        let is_src_ds = is_depth_stencil(p.src_format);
        let is_dst_ds = is_depth_stencil(p.dst_format);
        let src_aspect = if is_src_ds { p.aspect } else { vk::ImageAspectFlags::COLOR };
        let dst_aspect = if is_dst_ds { p.aspect } else { vk::ImageAspectFlags::COLOR };

        let bits = bit_count(p.src_format, p.dst_format, p.aspect);
        // The staging buffers hold whatever the aspect's transfer layout is, so the
        // stride is the bit count rounded up to whole bytes - except a 24-bit depth,
        // which travels in a 32-bit container.
        let texel_bytes = if bits == 24 { 4 } else { (bits / 8) as usize };

        let (queue, queue_family_index) = match p.queue_type {
            QueueType::Universal => (self.context.get_universal_queue(), self.context.get_universal_queue_family_index()),
            QueueType::ComputeOnly => self
                .context
                .get_compute_queue()
                .ok_or_else(|| TestError::NotSupported("no compute-only queue".to_string()))?,
            QueueType::TransferOnly => self
                .context
                .get_transfer_queue()
                .ok_or_else(|| TestError::NotSupported("no transfer-only queue".to_string()))?,
        };

        let mut rnd = Random::new(p.seed);
        let src_values = random_src_values(&mut rnd, p.src_format, p.dst_format, p.aspect, pixel_count, p.unrestricted);

        let src_buffer = BufferWithMemory::new(
            vk_device,
            allocator,
            make_buffer_create_info(src_values.len() as u64, vk::BufferUsageFlags::TRANSFER_SRC),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe { std::ptr::copy_nonoverlapping(src_values.as_ptr(), src_buffer.get_allocation().get_host_ptr(), src_values.len()) };
        flush_alloc(vk_device, src_buffer.get_allocation())?;

        let dst_bytes = pixel_count * texel_bytes;
        let dst_buffer = BufferWithMemory::new(
            vk_device,
            allocator,
            make_buffer_create_info(dst_bytes as u64, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let make_image = |format: vk::Format, mip_levels: u32, mip: u32| -> Result<ImageWithMemory<'_>, TestError> {
            let info = vk::ImageCreateInfo {
                s_type: vk::StructureType::IMAGE_CREATE_INFO,
                next: std::ptr::null(),
                flags: vk::ImageCreateFlags::empty(),
                image_type: vk::ImageType::_2D,
                format,
                extent: vk::Extent3D {
                    width: base_extent[0] << mip,
                    height: base_extent[1] << mip,
                    depth: base_extent[2],
                },
                mip_levels,
                array_layers: 1,
                samples: vk::SampleCountFlags::_1,
                tiling: vk::ImageTiling::OPTIMAL,
                usage: image_usage(format, p.attachment_usage),
                sharing_mode: vk::SharingMode::EXCLUSIVE,
                queue_family_index_count: 0,
                queue_family_indices: std::ptr::null(),
                initial_layout: vk::ImageLayout::UNDEFINED,
            };
            ImageWithMemory::new(vk_device, allocator, info, MemoryRequirement::ANY)
        };

        let src_image = make_image(p.src_format, src_mip_levels, p.src_mip_level)?;
        let dst_image = make_image(p.dst_format, dst_mip_levels, p.dst_mip_level)?;

        let src_range = make_image_subresource_range(src_aspect, 0, src_mip_levels, 0, 1);
        let dst_range = make_image_subresource_range(dst_aspect, 0, dst_mip_levels, 0, 1);
        let src_layers = vk::ImageSubresourceLayers {
            aspect_mask: src_aspect,
            mip_level: p.src_mip_level,
            base_array_layer: 0,
            layer_count: 1,
        };
        let dst_layers = vk::ImageSubresourceLayers {
            aspect_mask: dst_aspect,
            mip_level: p.dst_mip_level,
            base_array_layer: 0,
            layer_count: 1,
        };
        let base_vk_extent = vk::Extent3D {
            width: base_extent[0],
            height: base_extent[1],
            depth: base_extent[2],
        };

        let cmd_pool = make_command_pool(vk_device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        begin_command_buffer(vk_device, *cmd_buffer)?;
        unsafe {
            let to_dst = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                src_image.get(),
                src_range,
            );
            vk_device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_dst],
            );

            let region = vk::BufferImageCopy {
                buffer_offset: 0,
                buffer_row_length: 0,
                buffer_image_height: 0,
                image_subresource: src_layers,
                image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                image_extent: base_vk_extent,
            };
            vk_device.cmd_copy_buffer_to_image(*cmd_buffer, src_buffer.get(), src_image.get(), vk::ImageLayout::TRANSFER_DST_OPTIMAL, &[region]);

            let to_src = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                src_image.get(),
                src_range,
            );
            let dst_to_dst = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                dst_image.get(),
                dst_range,
            );
            vk_device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_src, dst_to_dst],
            );

            let copy = vk::ImageCopy {
                src_subresource: src_layers,
                src_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                dst_subresource: dst_layers,
                dst_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                extent: base_vk_extent,
            };
            vk_device.cmd_copy_image(
                *cmd_buffer,
                src_image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                dst_image.get(),
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &[copy],
            );

            let post = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                dst_image.get(),
                dst_range,
            );
            vk_device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[post],
            );

            let readback = vk::BufferImageCopy {
                buffer_offset: 0,
                buffer_row_length: 0,
                buffer_image_height: 0,
                image_subresource: dst_layers,
                image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                image_extent: base_vk_extent,
            };
            vk_device.cmd_copy_image_to_buffer(*cmd_buffer, dst_image.get(), vk::ImageLayout::TRANSFER_SRC_OPTIMAL, dst_buffer.get(), &[readback]);
        }
        end_command_buffer(vk_device, *cmd_buffer)?;
        submit_commands_and_wait(vk_device, queue, *cmd_buffer)?;

        invalidate_alloc(vk_device, dst_buffer.get_allocation())?;
        let result = unsafe { std::slice::from_raw_parts(dst_buffer.get_allocation().get_host_ptr().cast_const(), dst_bytes) }.to_vec();

        for i in 0..pixel_count {
            let a = &src_values[i * texel_bytes..];
            let b = &result[i * texel_bytes..];
            if pixels_differ(a, b, bits) {
                let (x, y) = (i as u32 % base_extent[0], i as u32 / base_extent[0]);
                return Ok(TestStatus::fail(format!("Unexpected value at ({x}, {y})")));
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createDSColorBitCopyTests`
pub fn create_ds_color_copy_tests() -> tcu::TestCaseGroup {
    let mut group = tcu::TestCaseGroup::new("ds_color_copy");

    for fg in format_groups() {
        for &(ds_format, ds_name) in fg.ds_formats {
            for &(color_format, color_name) in fg.color_formats {
                for ds_to_color in [true, false] {
                    for src_mip_level in [0u32, 3] {
                        for dst_mip_level in [0u32, 3] {
                            for attachment_usage in [false, true] {
                                // Attachment usage is only exercised at the base level.
                                if attachment_usage && (src_mip_level != 0 || dst_mip_level != 0) {
                                    continue;
                                }

                                let (src_format, src_name, dst_format, dst_name) = if ds_to_color {
                                    (ds_format, ds_name, color_format, color_name)
                                } else {
                                    (color_format, color_name, ds_format, ds_name)
                                };

                                // The seed is a function of the case, so the same case
                                // always gets the same data - which is what makes a
                                // failure reproducible without recording the values.
                                let seed =
                                    ((src_format.as_raw() as u32) << 24) | ((dst_format.as_raw() as u32) << 16) | ((fg.aspect.bits()) << 8) | (src_mip_level << 2) | dst_mip_level;

                                for queue_type in [QueueType::Universal, QueueType::ComputeOnly, QueueType::TransferOnly] {
                                    // Only a 32-bit value can exceed the usual depth
                                    // range, so only it gets the unrestricted variant.
                                    let unrestricted_values: &[bool] = if bit_count(src_format, dst_format, fg.aspect) == 32 { &[false, true] } else { &[false] };

                                    for &unrestricted in unrestricted_values {
                                        let queue_suffix = match queue_type {
                                            QueueType::Universal => "",
                                            QueueType::ComputeOnly => "_cq",
                                            QueueType::TransferOnly => "_tq",
                                        };
                                        let aspect_name = if fg.aspect == vk::ImageAspectFlags::DEPTH { "depth" } else { "stencil" };
                                        let name = format!(
                                            "{src_name}_{dst_name}_{aspect_name}_level{src_mip_level}_to_level{dst_mip_level}{}{}{queue_suffix}",
                                            if unrestricted { "_unrestricted" } else { "" },
                                            if attachment_usage { "_att_usage" } else { "" }
                                        );

                                        group.add_child(Box::new(DsColorCopyCase {
                                            name,
                                            src_format,
                                            dst_format,
                                            aspect: fg.aspect,
                                            src_mip_level,
                                            dst_mip_level,
                                            seed,
                                            queue_type,
                                            unrestricted,
                                            attachment_usage,
                                        }) as Box<dyn TestCase>);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    group
}
