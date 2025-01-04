// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/ycbcr/vktYCbCrUtil.cpp (ChannelAccess, getChannelAccess, isXChromaSubsampled, isYChromaSubsampled, getYCbCrBitDepth,
//   getPrecision, getYCbCrFormatChannelCount, the colour conversion and sampling interval arithmetic, wrap, divFloor, calculateBounds)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2017 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. A `ChannelAccess` shares the host plane it views through `Rc<RefCell<..>>` instead of a raw pointer, so the four
// channel accessors of one packed plane can be written and read in turn. `tcu::Interval`'s operators round with the hardware rounding mode upstream; the ones
// here (`iadd`, `isub`, `imul`, `idiv`) get the same directed bounds from an error free transformation of the `f64` result.

use std::cell::RefCell;
use std::rc::Rc;

use vulkanalia::vk;

use super::format_channels::{CHANNELS, ChannelDesc};
use super::format_channels_core::CORE_CHANNELS;
use super::util::format_description;
use crate::tcu::float_format::{FloatFormat, YesNoMaybe};
use crate::tcu::interval::Interval;
use crate::tcu::pixel::get_texture_format_bit_depth;
use crate::tcu::texture::{TextureChannelClass, map_vk_format};

pub type SharedPlane = Rc<RefCell<Vec<u8>>>;

/// The `ChannelDesc` of the channel (0 R, 1 G, 2 B, 3 A) of a format, from the YCbCr table or the plain colour format one.
pub fn channel_desc(format: vk::Format, channel: usize) -> Option<ChannelDesc> {
    CHANNELS
        .iter()
        .chain(CORE_CHANNELS.iter())
        .find(|(f, _)| *f == format)
        .and_then(|(_, channels)| channels[channel])
}

/// `ChannelAccess::signExtend`
fn sign_extend(src: u32, bits: u32) -> i32 {
    let sign_bit = 1u32 << (bits - 1);
    (src | !((src & sign_bit).wrapping_sub(1))) as i32
}

fn div_round_up(a: u32, b: u32) -> u32 {
    if a % b == 0 { a / b } else { a / b + 1 }
}

/// `convertSatRte<uint32_t>` and `convertSatRte<int32_t>`: round to nearest even, saturate to `[min, max]`.
fn convert_sat_rte(f: f32, min: i64, max: i64) -> i64 {
    let q = f - f.floor();
    let mut int_val = (f - q) as i64;

    if q == 0.5 {
        if int_val % 2 != 0 {
            int_val += 1;
        }
    } else if q > 0.5 {
        int_val += 1;
    }

    int_val.clamp(min, max)
}

fn channel_mask(channel_size: u32) -> u32 {
    if channel_size == 32 {
        !0u32
    } else {
        (1u32 << channel_size) - 1
    }
}

/// `ycbcr::ChannelAccess`
#[derive(Clone)]
pub struct ChannelAccess {
    channel_class: TextureChannelClass,
    channel_size: u32,
    size: [i32; 3],
    bit_pitch: [i32; 3],
    data: SharedPlane,
    byte_start: usize,
    bit_offset: u32,
}

impl ChannelAccess {
    pub fn new(
        channel_class: TextureChannelClass,
        channel_size: u32,
        size: [i32; 3],
        bit_pitch: [i32; 3],
        data: SharedPlane,
        bit_offset: u32,
    ) -> Self {
        Self {
            channel_class,
            channel_size,
            size,
            bit_pitch,
            data,
            byte_start: (bit_offset / 8) as usize,
            bit_offset: bit_offset % 8,
        }
    }

    /// A one texel access over `value`, which every position of an absent channel reads (`nullAccess`, `nullAccessAlpha`).
    pub fn constant(size: [i32; 3], value: u32) -> Self {
        Self::new(
            TextureChannelClass::UnsignedFixedPoint,
            1,
            size,
            [0, 0, 0],
            Rc::new(RefCell::new(value.to_le_bytes().to_vec())),
            0,
        )
    }

    pub fn get_size(&self) -> [i32; 3] {
        self.size
    }

    fn locate(&self, pos: [i32; 3]) -> (usize, u32, u32) {
        debug_assert!(pos[0] < self.size[0] && pos[1] < self.size[1] && pos[2] < self.size[2]);

        let bit_offset = self.bit_offset as i32
            + self.bit_pitch[0] * pos[0]
            + self.bit_pitch[1] * pos[1]
            + self.bit_pitch[2] * pos[2];
        let first_byte = self.byte_start + (bit_offset / 8) as usize;
        let byte_count = div_round_up((bit_offset as u32 + self.channel_size) - 8 * (bit_offset as u32 / 8), 8);
        (first_byte, byte_count, (bit_offset % 8) as u32)
    }

    /// `ChannelAccess::getChannelUint`
    pub fn get_channel_uint(&self, pos: [i32; 3]) -> u32 {
        let (first_byte, byte_count, offset) = self.locate(pos);
        let mask = channel_mask(self.channel_size);
        let data = self.data.borrow();
        let mut bits = 0u64;
        for (ndx, byte) in data[first_byte..first_byte + byte_count as usize].iter().enumerate() {
            bits |= u64::from(*byte) << (8 * ndx);
        }
        ((bits >> offset) as u32) & mask
    }

    /// `ChannelAccess::setChannel(pos, uint32_t)`
    pub fn set_channel_uint(&self, pos: [i32; 3], x: u32) {
        let (first_byte, byte_count, offset) = self.locate(pos);
        let mask = channel_mask(self.channel_size);
        let mut data = self.data.borrow_mut();

        let bits = u64::from(x & mask) << offset;
        let mut old_bits = 0u64;
        for (ndx, byte) in data[first_byte..first_byte + byte_count as usize].iter().enumerate() {
            old_bits |= u64::from(*byte) << (8 * ndx);
        }
        let new_bits = bits | (old_bits & !(u64::from(mask) << offset));
        for (ndx, byte) in data[first_byte..first_byte + byte_count as usize]
            .iter_mut()
            .enumerate()
        {
            *byte = (new_bits >> (8 * ndx)) as u8;
        }
    }

    /// `ChannelAccess::getChannel(pos)` as a float
    pub fn get_channel(&self, pos: [i32; 3]) -> f32 {
        let bits = self.get_channel_uint(pos);

        match self.channel_class {
            TextureChannelClass::UnsignedFixedPoint => bits as f32 / channel_mask(self.channel_size) as f32,
            TextureChannelClass::UnsignedInteger => bits as f32,
            TextureChannelClass::SignedFixedPoint => f32::max(
                -1.0,
                sign_extend(bits, self.channel_size) as f32 / ((1u32 << (self.channel_size - 1)) - 1) as f32,
            ),
            TextureChannelClass::SignedInteger => sign_extend(bits, self.channel_size) as f32,
            TextureChannelClass::FloatingPoint => {
                assert!(self.channel_size == 32, "Float type not supported");
                f32::from_bits(bits)
            }
            TextureChannelClass::Last => panic!("Unknown texture channel class"),
        }
    }

    /// `ChannelAccess::getChannel(conversionFormat, pos)`: the interval the value can be converted to.
    pub fn get_channel_interval(&self, conversion_format: FloatFormat, pos: [i32; 3]) -> Interval {
        let bits = self.get_channel_uint(pos);

        match self.channel_class {
            TextureChannelClass::UnsignedFixedPoint => conversion_format.round_out_interval(
                idiv(
                    conversion_format.round_out_point(f64::from(bits), false),
                    conversion_format.round_out_point(f64::from(channel_mask(self.channel_size)), false),
                ),
                false,
            ),
            TextureChannelClass::UnsignedInteger => conversion_format.round_out_point(f64::from(bits), false),
            TextureChannelClass::SignedFixedPoint => {
                let result = conversion_format.round_out_interval(
                    idiv(
                        conversion_format.round_out_point(f64::from(sign_extend(bits, self.channel_size)), false),
                        conversion_format.round_out_point(f64::from((1u32 << (self.channel_size - 1)) - 1), false),
                    ),
                    false,
                );
                Interval::new(f64::max(-1.0, result.lo()), f64::max(-1.0, result.hi()))
            }
            TextureChannelClass::SignedInteger => {
                conversion_format.round_out_point(f64::from(sign_extend(bits, self.channel_size)), false)
            }
            TextureChannelClass::FloatingPoint => {
                assert!(self.channel_size == 32, "Float type not supported");
                conversion_format.round_out_point(f64::from(f32::from_bits(bits)), false)
            }
            TextureChannelClass::Last => panic!("Unknown texture channel class"),
        }
    }

    /// `ChannelAccess::setChannel(pos, float)`
    pub fn set_channel(&self, pos: [i32; 3], x: f32) {
        let mask = channel_mask(self.channel_size);

        match self.channel_class {
            TextureChannelClass::UnsignedFixedPoint => {
                let max_value = mask;
                let value = u32::min(
                    max_value,
                    convert_sat_rte(x * max_value as f32, 0, i64::from(u32::MAX)) as u32,
                );
                self.set_channel_uint(pos, value);
            }
            TextureChannelClass::SignedFixedPoint => {
                let range = ((1u32 << (self.channel_size - 1)) - 1) as i32;
                let value = (convert_sat_rte(x * range as f32, i64::from(i32::MIN), i64::from(i32::MAX)) as i32)
                    .clamp(-range, range) as u32;
                self.set_channel_uint(pos, value);
            }
            TextureChannelClass::UnsignedInteger => {
                self.set_channel_uint(pos, u32::min(mask, x as u32));
            }
            TextureChannelClass::SignedInteger => {
                let min_value = -((1u32 << (self.channel_size - 1)) as i32);
                let max_value = ((1u32 << (self.channel_size - 1)) - 1) as i32;
                self.set_channel_uint(pos, (x as i32).clamp(min_value, max_value) as u32);
            }
            TextureChannelClass::FloatingPoint => {
                assert!(self.channel_size == 32, "Float type not supported");
                self.set_channel_uint(pos, x.to_bits());
            }
            TextureChannelClass::Last => panic!("Unknown texture channel class"),
        }
    }
}

/// `getChannelAccess(data, formatInfo, size, channelNdx)`; `planes` are the host planes of the image.
pub fn get_channel_access(
    planes: &[SharedPlane],
    format: vk::Format,
    size: (u32, u32),
    channel_ndx: usize,
) -> ChannelAccess {
    let desc = channel_desc(format, channel_ndx).expect("the format has the channel");
    let info = format_description(format);
    let plane = &info.planes[desc.plane as usize];

    let pixel_stride_bits = desc.stride_bytes * 8;
    debug_assert!(size.0 % (info.block_width * plane.width_divisor) == 0);
    debug_assert!(size.1 % (info.block_height * plane.height_divisor) == 0);

    let mut access_width = size.0 / (info.block_width * plane.width_divisor);
    let access_height = size.1 / (info.block_height * plane.height_divisor);
    let element_size_bytes = plane.element_size;
    let row_pitch = element_size_bytes * access_width;
    let row_pitch_bits = row_pitch * 8;

    if desc.stride_bytes != element_size_bytes {
        debug_assert!(element_size_bytes % desc.stride_bytes == 0);
        access_width *= element_size_bytes / desc.stride_bytes;
    }

    ChannelAccess::new(
        TextureChannelClass::UnsignedFixedPoint,
        desc.size_bits,
        [access_width as i32, access_height as i32, 1],
        [pixel_stride_bits as i32, row_pitch_bits as i32, 0],
        planes[desc.plane as usize].clone(),
        desc.offset_bits,
    )
}

/// `isXChromaSubsampled`
pub fn is_x_chroma_subsampled(format: vk::Format) -> bool {
    matches!(
        format,
        vk::Format::G8B8G8R8_422_UNORM
            | vk::Format::B8G8R8G8_422_UNORM
            | vk::Format::G8_B8_R8_3PLANE_420_UNORM
            | vk::Format::G8_B8R8_2PLANE_420_UNORM
            | vk::Format::G8_B8_R8_3PLANE_422_UNORM
            | vk::Format::G8_B8R8_2PLANE_422_UNORM
            | vk::Format::G10X6B10X6G10X6R10X6_422_UNORM_4PACK16
            | vk::Format::B10X6G10X6R10X6G10X6_422_UNORM_4PACK16
            | vk::Format::G10X6_B10X6_R10X6_3PLANE_420_UNORM_3PACK16
            | vk::Format::G10X6_B10X6R10X6_2PLANE_420_UNORM_3PACK16
            | vk::Format::G10X6_B10X6_R10X6_3PLANE_422_UNORM_3PACK16
            | vk::Format::G10X6_B10X6R10X6_2PLANE_422_UNORM_3PACK16
            | vk::Format::G12X4B12X4G12X4R12X4_422_UNORM_4PACK16
            | vk::Format::B12X4G12X4R12X4G12X4_422_UNORM_4PACK16
            | vk::Format::G12X4_B12X4_R12X4_3PLANE_420_UNORM_3PACK16
            | vk::Format::G12X4_B12X4R12X4_2PLANE_420_UNORM_3PACK16
            | vk::Format::G12X4_B12X4_R12X4_3PLANE_422_UNORM_3PACK16
            | vk::Format::G12X4_B12X4R12X4_2PLANE_422_UNORM_3PACK16
            | vk::Format::G16B16G16R16_422_UNORM
            | vk::Format::B16G16R16G16_422_UNORM
            | vk::Format::G16_B16_R16_3PLANE_420_UNORM
            | vk::Format::G16_B16R16_2PLANE_420_UNORM
            | vk::Format::G16_B16_R16_3PLANE_422_UNORM
            | vk::Format::G16_B16R16_2PLANE_422_UNORM
    )
}

/// `isYChromaSubsampled`
pub fn is_y_chroma_subsampled(format: vk::Format) -> bool {
    matches!(
        format,
        vk::Format::G8_B8_R8_3PLANE_420_UNORM
            | vk::Format::G8_B8R8_2PLANE_420_UNORM
            | vk::Format::G10X6_B10X6_R10X6_3PLANE_420_UNORM_3PACK16
            | vk::Format::G10X6_B10X6R10X6_2PLANE_420_UNORM_3PACK16
            | vk::Format::G12X4_B12X4_R12X4_3PLANE_420_UNORM_3PACK16
            | vk::Format::G12X4_B12X4R12X4_2PLANE_420_UNORM_3PACK16
            | vk::Format::G16_B16_R16_3PLANE_420_UNORM
            | vk::Format::G16_B16R16_2PLANE_420_UNORM
    )
}

/// `getYCbCrBitDepth`, used for range expansion
pub fn get_ycbcr_bit_depth(format: vk::Format) -> [u32; 4] {
    match format {
        vk::Format::G8B8G8R8_422_UNORM
        | vk::Format::B8G8R8G8_422_UNORM
        | vk::Format::G8_B8_R8_3PLANE_420_UNORM
        | vk::Format::G8_B8R8_2PLANE_420_UNORM
        | vk::Format::G8_B8_R8_3PLANE_422_UNORM
        | vk::Format::G8_B8R8_2PLANE_422_UNORM
        | vk::Format::G8_B8_R8_3PLANE_444_UNORM
        | vk::Format::G8_B8R8_2PLANE_444_UNORM => [8, 8, 8, 0],

        vk::Format::R10X6_UNORM_PACK16 => [10, 0, 0, 0],
        vk::Format::R10X6G10X6_UNORM_2PACK16 => [10, 10, 0, 0],
        vk::Format::R10X6G10X6B10X6A10X6_UNORM_4PACK16 => [10, 10, 10, 10],

        vk::Format::G10X6B10X6G10X6R10X6_422_UNORM_4PACK16
        | vk::Format::B10X6G10X6R10X6G10X6_422_UNORM_4PACK16
        | vk::Format::G10X6_B10X6_R10X6_3PLANE_420_UNORM_3PACK16
        | vk::Format::G10X6_B10X6R10X6_2PLANE_420_UNORM_3PACK16
        | vk::Format::G10X6_B10X6_R10X6_3PLANE_422_UNORM_3PACK16
        | vk::Format::G10X6_B10X6R10X6_2PLANE_422_UNORM_3PACK16
        | vk::Format::G10X6_B10X6_R10X6_3PLANE_444_UNORM_3PACK16
        | vk::Format::G10X6_B10X6R10X6_2PLANE_444_UNORM_3PACK16 => [10, 10, 10, 0],

        vk::Format::R12X4_UNORM_PACK16 => [12, 0, 0, 0],
        vk::Format::R12X4G12X4_UNORM_2PACK16 => [12, 12, 0, 0],

        vk::Format::R12X4G12X4B12X4A12X4_UNORM_4PACK16
        | vk::Format::G12X4B12X4G12X4R12X4_422_UNORM_4PACK16
        | vk::Format::B12X4G12X4R12X4G12X4_422_UNORM_4PACK16
        | vk::Format::G12X4_B12X4_R12X4_3PLANE_420_UNORM_3PACK16
        | vk::Format::G12X4_B12X4R12X4_2PLANE_420_UNORM_3PACK16
        | vk::Format::G12X4_B12X4_R12X4_3PLANE_422_UNORM_3PACK16
        | vk::Format::G12X4_B12X4R12X4_2PLANE_422_UNORM_3PACK16
        | vk::Format::G12X4_B12X4_R12X4_3PLANE_444_UNORM_3PACK16
        | vk::Format::G12X4_B12X4R12X4_2PLANE_444_UNORM_3PACK16 => [12, 12, 12, 12],

        vk::Format::G16B16G16R16_422_UNORM
        | vk::Format::B16G16R16G16_422_UNORM
        | vk::Format::G16_B16_R16_3PLANE_420_UNORM
        | vk::Format::G16_B16R16_2PLANE_420_UNORM
        | vk::Format::G16_B16_R16_3PLANE_422_UNORM
        | vk::Format::G16_B16R16_2PLANE_422_UNORM
        | vk::Format::G16_B16_R16_3PLANE_444_UNORM
        | vk::Format::G16_B16R16_2PLANE_444_UNORM => [16, 16, 16, 0],

        other => {
            let tcu_format = map_vk_format(other).unwrap_or_else(|| panic!("no texture format for {other:?}"));
            get_texture_format_bit_depth(tcu_format).map(|bits| bits as u32)
        }
    }
}

/// `getPrecision`
pub fn get_precision(format: vk::Format) -> Vec<FloatFormat> {
    get_ycbcr_bit_depth(format)
        .iter()
        .map(|&channel_depth| {
            FloatFormat::with_support(
                0,
                0,
                channel_depth as i32,
                false,
                YesNoMaybe::Yes,
                YesNoMaybe::Maybe,
                YesNoMaybe::Maybe,
            )
        })
        .collect()
}

/// `getYCbCrFormatChannelCount`
pub fn get_ycbcr_format_channel_count(format: vk::Format) -> u32 {
    match format {
        vk::Format::A1R5G5B5_UNORM_PACK16
        | vk::Format::A1B5G5R5_UNORM_PACK16
        | vk::Format::A2B10G10R10_UNORM_PACK32
        | vk::Format::A2R10G10B10_UNORM_PACK32
        | vk::Format::A8B8G8R8_UNORM_PACK32
        | vk::Format::B4G4R4A4_UNORM_PACK16
        | vk::Format::R5G5B5A1_UNORM_PACK16
        | vk::Format::B5G5R5A1_UNORM_PACK16
        | vk::Format::B8G8R8A8_UNORM
        | vk::Format::R10X6G10X6B10X6A10X6_UNORM_4PACK16
        | vk::Format::R12X4G12X4B12X4A12X4_UNORM_4PACK16
        | vk::Format::R16G16B16A16_UNORM
        | vk::Format::R4G4B4A4_UNORM_PACK16
        | vk::Format::A4R4G4B4_UNORM_PACK16
        | vk::Format::A4B4G4R4_UNORM_PACK16
        | vk::Format::R8G8B8A8_UNORM => 4,

        vk::Format::B10X6G10X6R10X6G10X6_422_UNORM_4PACK16
        | vk::Format::B12X4G12X4R12X4G12X4_422_UNORM_4PACK16
        | vk::Format::B16G16R16G16_422_UNORM
        | vk::Format::B5G6R5_UNORM_PACK16
        | vk::Format::B8G8R8G8_422_UNORM
        | vk::Format::B8G8R8_UNORM
        | vk::Format::G10X6B10X6G10X6R10X6_422_UNORM_4PACK16
        | vk::Format::G10X6_B10X6R10X6_2PLANE_420_UNORM_3PACK16
        | vk::Format::G10X6_B10X6R10X6_2PLANE_422_UNORM_3PACK16
        | vk::Format::G10X6_B10X6R10X6_2PLANE_444_UNORM_3PACK16
        | vk::Format::G10X6_B10X6_R10X6_3PLANE_420_UNORM_3PACK16
        | vk::Format::G10X6_B10X6_R10X6_3PLANE_422_UNORM_3PACK16
        | vk::Format::G10X6_B10X6_R10X6_3PLANE_444_UNORM_3PACK16
        | vk::Format::G12X4B12X4G12X4R12X4_422_UNORM_4PACK16
        | vk::Format::G12X4_B12X4R12X4_2PLANE_420_UNORM_3PACK16
        | vk::Format::G12X4_B12X4R12X4_2PLANE_422_UNORM_3PACK16
        | vk::Format::G12X4_B12X4R12X4_2PLANE_444_UNORM_3PACK16
        | vk::Format::G12X4_B12X4_R12X4_3PLANE_420_UNORM_3PACK16
        | vk::Format::G12X4_B12X4_R12X4_3PLANE_422_UNORM_3PACK16
        | vk::Format::G12X4_B12X4_R12X4_3PLANE_444_UNORM_3PACK16
        | vk::Format::G16B16G16R16_422_UNORM
        | vk::Format::G16_B16R16_2PLANE_420_UNORM
        | vk::Format::G16_B16R16_2PLANE_422_UNORM
        | vk::Format::G16_B16R16_2PLANE_444_UNORM
        | vk::Format::G16_B16_R16_3PLANE_420_UNORM
        | vk::Format::G16_B16_R16_3PLANE_422_UNORM
        | vk::Format::G16_B16_R16_3PLANE_444_UNORM
        | vk::Format::G8B8G8R8_422_UNORM
        | vk::Format::G8_B8R8_2PLANE_420_UNORM
        | vk::Format::G8_B8R8_2PLANE_422_UNORM
        | vk::Format::G8_B8R8_2PLANE_444_UNORM
        | vk::Format::G8_B8_R8_3PLANE_420_UNORM
        | vk::Format::G8_B8_R8_3PLANE_422_UNORM
        | vk::Format::G8_B8_R8_3PLANE_444_UNORM
        | vk::Format::R16G16B16_UNORM
        | vk::Format::R5G6B5_UNORM_PACK16
        | vk::Format::R8G8B8_UNORM
        | vk::Format::B10G11R11_UFLOAT_PACK32 => 3,

        vk::Format::R10X6G10X6_UNORM_2PACK16
        | vk::Format::R12X4G12X4_UNORM_2PACK16
        | vk::Format::R16G16_UNORM
        | vk::Format::R4G4_UNORM_PACK8
        | vk::Format::R8G8_UNORM => 2,

        vk::Format::R10X6_UNORM_PACK16
        | vk::Format::R12X4_UNORM_PACK16
        | vk::Format::R16_UNORM
        | vk::Format::A8_UNORM
        | vk::Format::R8_UNORM => 1,

        other => panic!("Unknown number of channels of {other:?}"),
    }
}

// Interval arithmetic with the directed rounding of `tcu::Interval`'s operators.

fn next_up(value: f64) -> f64 {
    if value.is_nan() || value == f64::INFINITY {
        return value;
    }
    let bits = value.to_bits();
    if value == 0.0 {
        f64::from_bits(1)
    } else if value > 0.0 {
        f64::from_bits(bits + 1)
    } else {
        f64::from_bits(bits - 1)
    }
}

fn next_down(value: f64) -> f64 {
    -next_up(-value)
}

fn add_error(a: f64, b: f64, sum: f64) -> f64 {
    let virtual_b = sum - a;
    (a - (sum - virtual_b)) + (b - virtual_b)
}

fn add_down(a: f64, b: f64) -> f64 {
    let sum = a + b;
    if !sum.is_finite() {
        return sum;
    }
    if add_error(a, b, sum) < 0.0 {
        next_down(sum)
    } else {
        sum
    }
}

fn add_up(a: f64, b: f64) -> f64 {
    let sum = a + b;
    if !sum.is_finite() {
        return sum;
    }
    if add_error(a, b, sum) > 0.0 { next_up(sum) } else { sum }
}

fn mul_down(a: f64, b: f64) -> f64 {
    let product = a * b;
    if !product.is_finite() {
        return product;
    }
    if a.mul_add(b, -product) < 0.0 {
        next_down(product)
    } else {
        product
    }
}

fn mul_up(a: f64, b: f64) -> f64 {
    let product = a * b;
    if !product.is_finite() {
        return product;
    }
    if a.mul_add(b, -product) > 0.0 {
        next_up(product)
    } else {
        product
    }
}

fn div_down(a: f64, b: f64) -> f64 {
    let quotient = a / b;
    if !quotient.is_finite() {
        return quotient;
    }
    let remainder = (-quotient).mul_add(b, a);
    let true_value_below = (remainder < 0.0 && b > 0.0) || (remainder > 0.0 && b < 0.0);
    if true_value_below {
        next_down(quotient)
    } else {
        quotient
    }
}

fn div_up(a: f64, b: f64) -> f64 {
    let quotient = a / b;
    if !quotient.is_finite() {
        return quotient;
    }
    let remainder = (-quotient).mul_add(b, a);
    let true_value_above = (remainder > 0.0 && b > 0.0) || (remainder < 0.0 && b < 0.0);
    if true_value_above { next_up(quotient) } else { quotient }
}

fn exact(value: f64) -> Interval {
    Interval::exact(value)
}

fn iadd(x: Interval, y: Interval) -> Interval {
    Interval::new(add_down(x.lo(), y.lo()), add_up(x.hi(), y.hi()))
}

fn isub(x: Interval, y: Interval) -> Interval {
    Interval::new(add_down(x.lo(), -y.hi()), add_up(x.hi(), -y.lo()))
}

fn imul(x: Interval, y: Interval) -> Interval {
    let mut lo = f64::INFINITY;
    let mut hi = f64::NEG_INFINITY;
    for xp in [x.lo(), x.hi()] {
        for yp in [y.lo(), y.hi()] {
            lo = lo.min(mul_down(xp, yp));
            hi = hi.max(mul_up(xp, yp));
        }
    }
    Interval::new(lo, hi)
}

fn idiv(nom: Interval, den: Interval) -> Interval {
    if den.contains(0.0) {
        return Interval::unbounded(false);
    }
    let mut lo = f64::INFINITY;
    let mut hi = f64::NEG_INFINITY;
    for nomp in [nom.lo(), nom.hi()] {
        for denp in [den.lo(), den.hi()] {
            lo = lo.min(div_down(nomp, denp));
            hi = hi.max(div_up(nomp, denp));
        }
    }
    Interval::new(lo, hi)
}

// YCbCr color conversion utilities

fn range_expand_chroma(
    range: vk::SamplerYcbcrRange,
    conversion_format: FloatFormat,
    bits: u32,
    sample: Interval,
) -> Interval {
    let values = 1u32 << bits;

    match range {
        vk::SamplerYcbcrRange::ITU_FULL => conversion_format.round_out_interval(
            isub(
                sample,
                conversion_format.round_out_interval(
                    exact(f64::from(1u32 << (bits - 1)) / f64::from((1u32 << bits) - 1)),
                    false,
                ),
            ),
            false,
        ),
        vk::SamplerYcbcrRange::ITU_NARROW => {
            let a = conversion_format.round_out_interval(imul(sample, exact(f64::from(values - 1))), false);
            let dividend =
                conversion_format.round_out_interval(isub(a, exact(f64::from(128u32 * (1u32 << (bits - 8))))), false);
            let divisor = exact(f64::from(224u32 * (1u32 << (bits - 8))));
            conversion_format.round_out_interval(idiv(dividend, divisor), false)
        }
        other => panic!("Unknown YCbCrRange {other:?}"),
    }
}

fn range_expand_luma(
    range: vk::SamplerYcbcrRange,
    conversion_format: FloatFormat,
    bits: u32,
    sample: Interval,
) -> Interval {
    let values = 1u32 << bits;

    match range {
        vk::SamplerYcbcrRange::ITU_FULL => conversion_format.round_out_interval(sample, false),
        vk::SamplerYcbcrRange::ITU_NARROW => {
            let a = conversion_format.round_out_interval(imul(sample, exact(f64::from(values - 1))), false);
            let dividend =
                conversion_format.round_out_interval(isub(a, exact(f64::from(16u32 * (1u32 << (bits - 8))))), false);
            let divisor = exact(f64::from(219u32 * (1u32 << (bits - 8))));
            conversion_format.round_out_interval(idiv(dividend, divisor), false)
        }
        other => panic!("Unknown YCbCrRange {other:?}"),
    }
}

fn clamp_maybe(x: Interval, min: f64, max: f64) -> Interval {
    let mut result = x;

    debug_assert!(min <= max);

    if x.lo() < min {
        result = result | exact(min);
    }
    if x.hi() > max {
        result = result | exact(max);
    }
    result
}

fn convert_color(
    color_model: vk::SamplerYcbcrModelConversion,
    range: vk::SamplerYcbcrRange,
    conversion_format: &[FloatFormat],
    bit_depth: [u32; 4],
    input: [Interval; 4],
) -> [Interval; 4] {
    let mut output = [Interval::empty(); 4];
    let ro = |format: FloatFormat, x: Interval| format.round_out_interval(x, false);

    match color_model {
        vk::SamplerYcbcrModelConversion::RGB_IDENTITY => {
            output = input;
        }
        vk::SamplerYcbcrModelConversion::YCBCR_IDENTITY => {
            output[0] = clamp_maybe(
                range_expand_chroma(range, conversion_format[0], bit_depth[0], input[0]),
                -0.5,
                0.5,
            );
            output[1] = clamp_maybe(
                range_expand_luma(range, conversion_format[1], bit_depth[1], input[1]),
                0.0,
                1.0,
            );
            output[2] = clamp_maybe(
                range_expand_chroma(range, conversion_format[2], bit_depth[2], input[2]),
                -0.5,
                0.5,
            );
            output[3] = input[3];
        }
        vk::SamplerYcbcrModelConversion::YCBCR_601
        | vk::SamplerYcbcrModelConversion::YCBCR_709
        | vk::SamplerYcbcrModelConversion::YCBCR_2020 => {
            let y = range_expand_luma(range, conversion_format[1], bit_depth[1], input[1]);
            let cr = range_expand_chroma(range, conversion_format[0], bit_depth[0], input[0]);
            let cb = range_expand_chroma(range, conversion_format[2], bit_depth[2], input[2]);

            let y_clamped = clamp_maybe(y, 0.0, 1.0);
            let cr_clamped = clamp_maybe(cr, -0.5, 0.5);
            let cb_clamped = clamp_maybe(cb, -0.5, 0.5);

            let (f0, f1, f2) = (conversion_format[0], conversion_format[1], conversion_format[2]);

            if color_model == vk::SamplerYcbcrModelConversion::YCBCR_601 {
                output[0] = ro(f0, iadd(y_clamped, ro(f0, imul(exact(1.402), cr_clamped))));
                output[1] = ro(
                    f1,
                    isub(
                        ro(f1, isub(y_clamped, ro(f1, imul(exact(0.202008 / 0.587), cb_clamped)))),
                        ro(f1, imul(exact(0.419198 / 0.587), cr_clamped)),
                    ),
                );
                output[2] = ro(f2, iadd(y_clamped, ro(f2, imul(exact(1.772), cb_clamped))));
            } else if color_model == vk::SamplerYcbcrModelConversion::YCBCR_709 {
                output[0] = ro(f0, iadd(y_clamped, ro(f0, imul(exact(1.5748), cr_clamped))));
                output[1] = ro(
                    f1,
                    isub(
                        ro(
                            f1,
                            isub(y_clamped, ro(f1, imul(exact(0.13397432 / 0.7152), cb_clamped))),
                        ),
                        ro(f1, imul(exact(0.33480248 / 0.7152), cr_clamped)),
                    ),
                );
                output[2] = ro(f2, iadd(y_clamped, ro(f2, imul(exact(1.8556), cb_clamped))));
            } else {
                output[0] = ro(f0, iadd(y_clamped, ro(f0, imul(exact(1.4746), cr_clamped))));
                output[1] = ro(
                    f1,
                    isub(
                        ro(
                            f1,
                            isub(y_clamped, ro(f1, imul(ro(f1, exact(0.11156702 / 0.6780)), cb_clamped))),
                        ),
                        ro(f1, imul(ro(f1, exact(0.38737742 / 0.6780)), cr_clamped)),
                    ),
                );
                output[2] = ro(f2, iadd(y_clamped, ro(f2, imul(exact(1.8814), cb_clamped))));
            }
            output[3] = input[3];
        }
        other => panic!("Unknown YCbCrModel {other:?}"),
    }

    if color_model != vk::SamplerYcbcrModelConversion::YCBCR_IDENTITY {
        for value in output.iter_mut().take(3) {
            *value = clamp_maybe(*value, 0.0, 1.0);
        }
    }
    output
}

fn mirror(coord: i32) -> i32 {
    if coord >= 0 { coord } else { -(1 + coord) }
}

fn imod(a: i32, b: i32) -> i32 {
    let m = a % b;
    if m < 0 { m + b } else { m }
}

fn de_frac(x: f64) -> f64 {
    x - x.floor()
}

fn frac(x: Interval) -> Interval {
    if x.hi() - x.lo() >= 1.0 {
        Interval::new(0.0, 1.0)
    } else {
        Interval::new(de_frac(x.lo()), de_frac(x.hi()))
    }
}

fn calculate_uv(coord_format: FloatFormat, st: Interval, size: i32) -> Interval {
    coord_format.round_out_interval(
        imul(coord_format.round_out_interval(st, false), exact(f64::from(size))),
        false,
    )
}

fn de_round_to_int32(x: f64) -> i32 {
    (x + 0.5).floor() as i32
}

fn calculate_nearest_ij_range(coord_format: FloatFormat, uv: Interval) -> [i32; 2] {
    let ij = coord_format.round_out_interval(isub(coord_format.round_out_interval(uv, false), exact(0.5)), false);

    [
        de_round_to_int32(ij.lo() - coord_format.ulp(ij.lo(), 1.0)),
        de_round_to_int32(ij.hi() + coord_format.ulp(ij.hi(), 1.0)),
    ]
}

/// The range of pixel coordinates that can be used as the lower coordinate for linear sampling
fn calculate_linear_ij_range(coord_format: FloatFormat, uv: Interval) -> [i32; 2] {
    let ij = coord_format.round_out_interval(isub(uv, exact(0.5)), false);

    [ij.lo().floor() as i32, ij.hi().floor() as i32]
}

fn calculate_ij_range(filter: vk::Filter, coord_format: FloatFormat, uv: Interval) -> [i32; 2] {
    debug_assert!(filter == vk::Filter::NEAREST || filter == vk::Filter::LINEAR);
    if filter == vk::Filter::LINEAR {
        calculate_linear_ij_range(coord_format, uv)
    } else {
        calculate_nearest_ij_range(coord_format, uv)
    }
}

fn calculate_ab(sub_texel_precision_bits: u32, uv: Interval, ij: i32) -> Interval {
    let subdivisions = f64::from(1u32 << sub_texel_precision_bits);
    let ab = frac(isub(uv, exact(0.5)) & Interval::new(f64::from(ij), f64::from(ij + 1)));
    let grid_ab = imul(ab, exact(subdivisions));

    Interval::new(
        f64::max(grid_ab.lo().floor() / subdivisions, 0.0),
        f64::min(grid_ab.hi().ceil() / subdivisions, 1.0),
    )
}

/// The address modes every lookup of `calculate_bounds` shares.
struct Lookup {
    address_mode_u: vk::SamplerAddressMode,
    address_mode_v: vk::SamplerAddressMode,
}

impl Lookup {
    fn lookup_wrapped(&self, access: &ChannelAccess, conversion_format: FloatFormat, coord: [i32; 2]) -> Interval {
        let size = access.get_size();
        let mut interval = access.get_channel_interval(
            conversion_format,
            [
                wrap(self.address_mode_u, coord[0], size[0]),
                wrap(self.address_mode_v, coord[1], size[1]),
                0,
            ],
        );

        // Expand range for 10-bit conversions to +/-1.0 ULP
        if conversion_format.fraction_bits() == 10 {
            interval = interval | exact(interval.lo() - (interval.hi() - interval.lo()) / 2.0);
            interval = interval | exact(interval.hi() + (interval.hi() - interval.lo()) / 2.0);
        }

        interval
    }

    fn linear_sample(
        &self,
        access: &ChannelAccess,
        conversion_format: FloatFormat,
        filtering_format: FloatFormat,
        coord: [i32; 2],
        a: Interval,
        b: Interval,
    ) -> Interval {
        linear_interpolate(
            filtering_format,
            a,
            b,
            self.lookup_wrapped(access, conversion_format, [coord[0], coord[1]]),
            self.lookup_wrapped(access, conversion_format, [coord[0] + 1, coord[1]]),
            self.lookup_wrapped(access, conversion_format, [coord[0], coord[1] + 1]),
            self.lookup_wrapped(access, conversion_format, [coord[0] + 1, coord[1] + 1]),
        )
    }

    fn reconstruct_linear_x_chroma_sample(
        &self,
        filtering_format: FloatFormat,
        conversion_format: FloatFormat,
        offset: vk::ChromaLocation,
        access: &ChannelAccess,
        i: i32,
        j: i32,
    ) -> Interval {
        let sub_i = if offset == vk::ChromaLocation::COSITED_EVEN {
            div_floor(i, 2)
        } else if i % 2 == 0 {
            div_floor(i, 2) - 1
        } else {
            div_floor(i, 2)
        };
        let a = if offset == vk::ChromaLocation::COSITED_EVEN {
            if i % 2 == 0 { 0.0 } else { 0.5 }
        } else if i % 2 == 0 {
            0.25
        } else {
            0.75
        };

        let interval_a = filtering_format.round_out_interval(
            imul(exact(a), self.lookup_wrapped(access, conversion_format, [sub_i, j])),
            false,
        );
        let interval_b = filtering_format.round_out_interval(
            imul(
                exact(1.0 - a),
                self.lookup_wrapped(access, conversion_format, [sub_i + 1, j]),
            ),
            false,
        );
        filtering_format.round_out_interval(iadd(interval_a, interval_b), false)
    }

    #[allow(clippy::too_many_arguments)]
    fn reconstruct_linear_xy_chroma_sample(
        &self,
        filtering_format: FloatFormat,
        conversion_format: FloatFormat,
        x_offset: vk::ChromaLocation,
        y_offset: vk::ChromaLocation,
        access: &ChannelAccess,
        i: i32,
        j: i32,
    ) -> Interval {
        let sub_i = if x_offset == vk::ChromaLocation::COSITED_EVEN {
            div_floor(i, 2)
        } else if i % 2 == 0 {
            div_floor(i, 2) - 1
        } else {
            div_floor(i, 2)
        };
        let sub_j = if y_offset == vk::ChromaLocation::COSITED_EVEN {
            div_floor(j, 2)
        } else if j % 2 == 0 {
            div_floor(j, 2) - 1
        } else {
            div_floor(j, 2)
        };

        let a = if x_offset == vk::ChromaLocation::COSITED_EVEN {
            if i % 2 == 0 { 0.0 } else { 0.5 }
        } else if i % 2 == 0 {
            0.25
        } else {
            0.75
        };
        let b = if y_offset == vk::ChromaLocation::COSITED_EVEN {
            if j % 2 == 0 { 0.0 } else { 0.5 }
        } else if j % 2 == 0 {
            0.25
        } else {
            0.75
        };

        self.linear_sample(
            access,
            conversion_format,
            filtering_format,
            [sub_i, sub_j],
            exact(a),
            exact(b),
        )
    }
}

fn linear_interpolate(
    filtering_format: FloatFormat,
    a: Interval,
    b: Interval,
    p00: Interval,
    p10: Interval,
    p01: Interval,
    p11: Interval,
) -> Interval {
    let p = [p00, p10, p01, p11];
    let mut result = exact(0.0);

    for (ndx, point) in p.iter().enumerate() {
        let weight_a = filtering_format.round_out_interval(if ndx % 2 == 0 { isub(exact(1.0), a) } else { a }, false);
        let weight_b = filtering_format.round_out_interval(if ndx / 2 == 0 { isub(exact(1.0), b) } else { b }, false);
        let weight = filtering_format.round_out_interval(imul(weight_a, weight_b), false);

        result = filtering_format.round_out_interval(
            iadd(result, filtering_format.round_out_interval(imul(*point, weight), false)),
            false,
        );
    }

    result
}

fn calculate_implicit_chroma_uv(coord_format: FloatFormat, offset: vk::ChromaLocation, uv: Interval) -> Interval {
    if offset == vk::ChromaLocation::COSITED_EVEN {
        coord_format.round_out_interval(
            imul(exact(0.5), coord_format.round_out_interval(iadd(uv, exact(0.5)), false)),
            false,
        )
    } else {
        coord_format.round_out_interval(imul(exact(0.5), uv), false)
    }
}

fn swizzle<'a>(
    swizzle: vk::ComponentSwizzle,
    identity_plane: &'a ChannelAccess,
    r_plane: &'a ChannelAccess,
    g_plane: &'a ChannelAccess,
    b_plane: &'a ChannelAccess,
    a_plane: &'a ChannelAccess,
) -> &'a ChannelAccess {
    match swizzle {
        vk::ComponentSwizzle::IDENTITY => identity_plane,
        vk::ComponentSwizzle::R => r_plane,
        vk::ComponentSwizzle::G => g_plane,
        vk::ComponentSwizzle::B => b_plane,
        vk::ComponentSwizzle::A => a_plane,
        other => panic!("Unsupported swizzle {other:?}"),
    }
}

/// `wrap`
pub fn wrap(address_mode: vk::SamplerAddressMode, coord: i32, size: i32) -> i32 {
    match address_mode {
        vk::SamplerAddressMode::MIRRORED_REPEAT => (size - 1) - mirror(imod(coord, 2 * size) - size),
        vk::SamplerAddressMode::REPEAT => imod(coord, size),
        vk::SamplerAddressMode::CLAMP_TO_EDGE => coord.clamp(0, size - 1),
        vk::SamplerAddressMode::MIRROR_CLAMP_TO_EDGE => mirror(coord).clamp(0, size - 1),
        other => panic!("Unknown wrap mode {other:?}"),
    }
}

/// `divFloor`
pub fn div_floor(a: i32, b: i32) -> i32 {
    if a % b == 0 || a > 0 { a / b } else { a / b - 1 }
}

/// The per texel output of `calculateBounds`.
pub struct Bounds {
    pub min_bounds: Vec<[f32; 4]>,
    pub max_bounds: Vec<[f32; 4]>,
    pub uv_bounds: Vec<[f32; 4]>,
    pub ij_bounds: Vec<[i32; 4]>,
}

/// The inputs of `calculateBounds` that are not the channel planes.
pub struct BoundsParams<'a> {
    pub bit_depth: [u32; 4],
    pub sts: &'a [[f32; 2]],
    pub filtering_format: &'a [FloatFormat],
    pub conversion_format: &'a [FloatFormat],
    pub sub_texel_precision_bits: u32,
    pub filter: vk::Filter,
    pub color_model: vk::SamplerYcbcrModelConversion,
    pub range: vk::SamplerYcbcrRange,
    pub chroma_filter: vk::Filter,
    pub x_chroma_offset: vk::ChromaLocation,
    pub y_chroma_offset: vk::ChromaLocation,
    pub component_mapping: vk::ComponentMapping,
    pub explicit_reconstruction: bool,
    pub address_mode_u: vk::SamplerAddressMode,
    pub address_mode_v: vk::SamplerAddressMode,
}

/// `calculateBounds`
pub fn calculate_bounds(
    r_plane: &ChannelAccess,
    g_plane: &ChannelAccess,
    b_plane: &ChannelAccess,
    a_plane: &ChannelAccess,
    params: &BoundsParams<'_>,
) -> Bounds {
    let highp = FloatFormat::with_support(
        -126,
        127,
        23,
        true,
        YesNoMaybe::Maybe,
        YesNoMaybe::Yes,
        YesNoMaybe::Maybe,
    );
    let coord_format = FloatFormat::new(-32, 32, 16, true);
    let r_access = swizzle(params.component_mapping.r, r_plane, r_plane, g_plane, b_plane, a_plane);
    let g_access = swizzle(params.component_mapping.g, g_plane, r_plane, g_plane, b_plane, a_plane);
    let b_access = swizzle(params.component_mapping.b, b_plane, r_plane, g_plane, b_plane, a_plane);
    let a_access = swizzle(params.component_mapping.a, a_plane, r_plane, g_plane, b_plane, a_plane);

    let filter = params.filter;
    let chroma_filter = params.chroma_filter;
    let x_chroma_offset = params.x_chroma_offset;
    let y_chroma_offset = params.y_chroma_offset;
    let explicit_reconstruction = params.explicit_reconstruction;
    let conversion_format = params.conversion_format;
    let filtering_format = params.filtering_format;
    let sub_texel_precision_bits = params.sub_texel_precision_bits;
    let lookup = Lookup {
        address_mode_u: params.address_mode_u,
        address_mode_v: params.address_mode_v,
    };

    let subsampled_x = g_access.get_size()[0] > r_access.get_size()[0];
    let subsampled_y = g_access.get_size()[1] > r_access.get_size()[1];

    let mut bounds = Bounds {
        min_bounds: vec![[f32::INFINITY; 4]; params.sts.len()],
        max_bounds: vec![[f32::NEG_INFINITY; 4]; params.sts.len()],
        uv_bounds: vec![[f32::INFINITY, f32::NEG_INFINITY, f32::INFINITY, f32::NEG_INFINITY]; params.sts.len()],
        ij_bounds: vec![[0x7FFF_FFFF, -1 - 0x7FFF_FFFF, 0x7FFF_FFFF, -1 - 0x7FFF_FFFF]; params.sts.len()],
    };

    // Chroma plane sizes must match
    debug_assert!(r_access.get_size() == b_access.get_size());
    // Luma plane sizes must match
    debug_assert!(g_access.get_size() == a_access.get_size());
    // Luma plane size must match chroma plane or be twice as big
    debug_assert!(
        r_access.get_size()[0] == g_access.get_size()[0] || 2 * r_access.get_size()[0] == g_access.get_size()[0]
    );
    debug_assert!(
        r_access.get_size()[1] == g_access.get_size()[1] || 2 * r_access.get_size()[1] == g_access.get_size()[1]
    );
    debug_assert!(filter == vk::Filter::NEAREST || filter == vk::Filter::LINEAR);
    debug_assert!(chroma_filter == vk::Filter::NEAREST || chroma_filter == vk::Filter::LINEAR);
    debug_assert!(subsampled_x || !subsampled_y);

    let convert = |r_value: Interval, g_value: Interval, b_value: Interval, a_value: Interval| {
        convert_color(
            params.color_model,
            params.range,
            conversion_format,
            params.bit_depth,
            [r_value, g_value, b_value, a_value],
        )
    };
    let lookup_chroma = |access: &ChannelAccess, format_ndx: usize, i: i32, j: i32| {
        lookup.lookup_wrapped(access, conversion_format[format_ndx], [i, j])
    };

    for (ndx, st) in params.sts.iter().enumerate() {
        let mut result_bounds = [Interval::empty(); 4];

        let u = calculate_uv(coord_format, exact(f64::from(st[0])), g_access.get_size()[0]);
        let v = calculate_uv(coord_format, exact(f64::from(st[1])), g_access.get_size()[1]);

        bounds.uv_bounds[ndx][0] = u.lo() as f32;
        bounds.uv_bounds[ndx][1] = u.hi() as f32;
        bounds.uv_bounds[ndx][2] = v.lo() as f32;
        bounds.uv_bounds[ndx][3] = v.hi() as f32;

        let i_range = calculate_ij_range(filter, coord_format, u);
        let j_range = calculate_ij_range(filter, coord_format, v);

        bounds.ij_bounds[ndx][0] = i_range[0];
        bounds.ij_bounds[ndx][1] = i_range[1];
        bounds.ij_bounds[ndx][2] = j_range[0];
        bounds.ij_bounds[ndx][3] = j_range[1];

        for j in j_range[0]..=j_range[1] {
            for i in i_range[0]..=i_range[1] {
                if filter == vk::Filter::NEAREST {
                    let g_value = lookup_chroma(g_access, 1, i, j);
                    let a_value = lookup_chroma(a_access, 3, i, j);

                    if explicit_reconstruction || !(subsampled_x || subsampled_y) {
                        let (r_value, b_value);
                        if chroma_filter == vk::Filter::NEAREST || !subsampled_x {
                            // Reconstruct using nearest if needed, otherwise, just take what's already there.
                            let sub_i = if subsampled_x { i / 2 } else { i };
                            let sub_j = if subsampled_y { j / 2 } else { j };
                            r_value = lookup_chroma(r_access, 0, sub_i, sub_j);
                            b_value = lookup_chroma(b_access, 2, sub_i, sub_j);
                        } else if subsampled_y {
                            r_value = lookup.reconstruct_linear_xy_chroma_sample(
                                filtering_format[0],
                                conversion_format[0],
                                x_chroma_offset,
                                y_chroma_offset,
                                r_access,
                                i,
                                j,
                            );
                            b_value = lookup.reconstruct_linear_xy_chroma_sample(
                                filtering_format[2],
                                conversion_format[2],
                                x_chroma_offset,
                                y_chroma_offset,
                                b_access,
                                i,
                                j,
                            );
                        } else {
                            r_value = lookup.reconstruct_linear_x_chroma_sample(
                                filtering_format[0],
                                conversion_format[0],
                                x_chroma_offset,
                                r_access,
                                i,
                                j,
                            );
                            b_value = lookup.reconstruct_linear_x_chroma_sample(
                                filtering_format[2],
                                conversion_format[2],
                                x_chroma_offset,
                                b_access,
                                i,
                                j,
                            );
                        }

                        let dst_color = convert(r_value, g_value, b_value, a_value);
                        for comp_ndx in 0..4 {
                            result_bounds[comp_ndx] =
                                result_bounds[comp_ndx] | highp.round_out_interval(dst_color[comp_ndx], false);
                        }
                    } else {
                        let chroma_u = if subsampled_x {
                            calculate_implicit_chroma_uv(coord_format, x_chroma_offset, u)
                        } else {
                            u
                        };
                        let chroma_v = if subsampled_y {
                            calculate_implicit_chroma_uv(coord_format, y_chroma_offset, v)
                        } else {
                            v
                        };

                        // Reconstructed chroma samples with implicit filtering
                        let chroma_i_range = if subsampled_x {
                            calculate_ij_range(chroma_filter, coord_format, chroma_u)
                        } else {
                            [i, i]
                        };
                        let chroma_j_range = if subsampled_y {
                            calculate_ij_range(chroma_filter, coord_format, chroma_v)
                        } else {
                            [j, j]
                        };

                        for chroma_j in chroma_j_range[0]..=chroma_j_range[1] {
                            for chroma_i in chroma_i_range[0]..=chroma_i_range[1] {
                                let (r_value, b_value);

                                if chroma_filter == vk::Filter::NEAREST {
                                    r_value = lookup_chroma(r_access, 0, chroma_i, chroma_j);
                                    b_value = lookup_chroma(b_access, 2, chroma_i, chroma_j);
                                } else {
                                    let chroma_a = calculate_ab(sub_texel_precision_bits, chroma_u, chroma_i);
                                    let chroma_b = calculate_ab(sub_texel_precision_bits, chroma_v, chroma_j);

                                    r_value = lookup.linear_sample(
                                        r_access,
                                        conversion_format[0],
                                        filtering_format[0],
                                        [chroma_i, chroma_j],
                                        chroma_a,
                                        chroma_b,
                                    );
                                    b_value = lookup.linear_sample(
                                        b_access,
                                        conversion_format[2],
                                        filtering_format[2],
                                        [chroma_i, chroma_j],
                                        chroma_a,
                                        chroma_b,
                                    );
                                }

                                let dst_color = convert(r_value, g_value, b_value, a_value);
                                for comp_ndx in 0..4 {
                                    result_bounds[comp_ndx] =
                                        result_bounds[comp_ndx] | highp.round_out_interval(dst_color[comp_ndx], false);
                                }
                            }
                        }
                    }
                } else {
                    // filter == VK_FILTER_LINEAR
                    let luma_a = calculate_ab(sub_texel_precision_bits, u, i);
                    let luma_b = calculate_ab(sub_texel_precision_bits, v, j);

                    let g_value = lookup.linear_sample(
                        g_access,
                        conversion_format[1],
                        filtering_format[1],
                        [i, j],
                        luma_a,
                        luma_b,
                    );
                    let a_value = lookup.linear_sample(
                        a_access,
                        conversion_format[3],
                        filtering_format[3],
                        [i, j],
                        luma_a,
                        luma_b,
                    );

                    if explicit_reconstruction || !(subsampled_x || subsampled_y) {
                        let (r_value, b_value);
                        if chroma_filter == vk::Filter::NEAREST || !subsampled_x {
                            let div_x = if subsampled_x { 2 } else { 1 };
                            let div_y = if subsampled_y { 2 } else { 1 };
                            let corners = |access: &ChannelAccess, format_ndx: usize| {
                                linear_interpolate(
                                    filtering_format[format_ndx],
                                    luma_a,
                                    luma_b,
                                    lookup_chroma(access, format_ndx, i / div_x, j / div_y),
                                    lookup_chroma(access, format_ndx, (i + 1) / div_x, j / div_y),
                                    lookup_chroma(access, format_ndx, i / div_x, (j + 1) / div_y),
                                    lookup_chroma(access, format_ndx, (i + 1) / div_x, (j + 1) / div_y),
                                )
                            };
                            r_value = corners(r_access, 0);
                            b_value = corners(b_access, 2);
                        } else if subsampled_y {
                            // Linear, Reconstructed xx chroma samples with explicit linear filtering
                            let corners = |access: &ChannelAccess, format_ndx: usize| {
                                let reconstruct = |ii: i32, jj: i32| {
                                    lookup.reconstruct_linear_xy_chroma_sample(
                                        filtering_format[format_ndx],
                                        conversion_format[format_ndx],
                                        x_chroma_offset,
                                        y_chroma_offset,
                                        access,
                                        ii,
                                        jj,
                                    )
                                };
                                linear_interpolate(
                                    filtering_format[format_ndx],
                                    luma_a,
                                    luma_b,
                                    reconstruct(i, j),
                                    reconstruct(i + 1, j),
                                    reconstruct(i, j + 1),
                                    reconstruct(i + 1, j + 1),
                                )
                            };
                            r_value = corners(r_access, 0);
                            b_value = corners(b_access, 2);
                        } else {
                            // Linear, Reconstructed x chroma samples with explicit linear filtering
                            let corners = |access: &ChannelAccess, format_ndx: usize| {
                                let reconstruct = |ii: i32, jj: i32| {
                                    lookup.reconstruct_linear_x_chroma_sample(
                                        filtering_format[format_ndx],
                                        conversion_format[format_ndx],
                                        x_chroma_offset,
                                        access,
                                        ii,
                                        jj,
                                    )
                                };
                                linear_interpolate(
                                    filtering_format[format_ndx],
                                    luma_a,
                                    luma_b,
                                    reconstruct(i, j),
                                    reconstruct(i + 1, j),
                                    reconstruct(i, j + 1),
                                    reconstruct(i + 1, j + 1),
                                )
                            };
                            r_value = corners(r_access, 0);
                            b_value = corners(b_access, 2);
                        }

                        let dst_color = convert(r_value, g_value, b_value, a_value);
                        for comp_ndx in 0..4 {
                            result_bounds[comp_ndx] =
                                result_bounds[comp_ndx] | highp.round_out_interval(dst_color[comp_ndx], false);
                        }
                    } else {
                        let chroma_u = if subsampled_x {
                            calculate_implicit_chroma_uv(coord_format, x_chroma_offset, u)
                        } else {
                            u
                        };
                        let chroma_v = if subsampled_y {
                            calculate_implicit_chroma_uv(coord_format, y_chroma_offset, v)
                        } else {
                            v
                        };

                        // The chroma filter is ignored here upstream as well
                        let chroma_i_range = calculate_nearest_ij_range(coord_format, chroma_u);
                        let chroma_j_range = calculate_nearest_ij_range(coord_format, chroma_v);

                        for chroma_j in chroma_j_range[0]..=chroma_j_range[1] {
                            for chroma_i in chroma_i_range[0]..=chroma_i_range[1] {
                                let (r_value, b_value);

                                if chroma_filter == vk::Filter::NEAREST {
                                    r_value = lookup_chroma(r_access, 1, chroma_i, chroma_j);
                                    b_value = lookup_chroma(b_access, 3, chroma_i, chroma_j);
                                } else {
                                    let chroma_a = calculate_ab(sub_texel_precision_bits, chroma_u, chroma_i);
                                    let chroma_b = calculate_ab(sub_texel_precision_bits, chroma_v, chroma_j);

                                    r_value = lookup.linear_sample(
                                        r_access,
                                        conversion_format[0],
                                        filtering_format[0],
                                        [chroma_i, chroma_j],
                                        chroma_a,
                                        chroma_b,
                                    );
                                    b_value = lookup.linear_sample(
                                        b_access,
                                        conversion_format[2],
                                        filtering_format[2],
                                        [chroma_i, chroma_j],
                                        chroma_a,
                                        chroma_b,
                                    );
                                }

                                let dst_color = convert(r_value, g_value, b_value, a_value);
                                for comp_ndx in 0..4 {
                                    result_bounds[comp_ndx] =
                                        result_bounds[comp_ndx] | highp.round_out_interval(dst_color[comp_ndx], false);
                                }
                            }
                        }
                    }
                }
            }
        }

        bounds.min_bounds[ndx] = [
            result_bounds[0].lo() as f32,
            result_bounds[1].lo() as f32,
            result_bounds[2].lo() as f32,
            result_bounds[3].lo() as f32,
        ];
        bounds.max_bounds[ndx] = [
            result_bounds[0].hi() as f32,
            result_bounds[1].hi() as f32,
            result_bounds[2].hi() as f32,
            result_bounds[3].hi() as f32,
        ];
    }

    bounds
}
