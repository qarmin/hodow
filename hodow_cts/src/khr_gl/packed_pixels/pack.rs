// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcPackedPixelsTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 Google Inc.
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `RectangleTest::unpack_*` and `pack_*` families: upstream writes one function per type and, for the packed types, three (float, uint and int output) that differ only in the final conversion. Here a packed type is a table of (component, shift, width) fields (`PackedLayout`) and one function extracts all three flavours; the `_INT` variants shift a sign-extended value and mask, which gives the same field as shifting the unsigned one. The gradient is a byte buffer, and `Element` is what upstream's `reinterpret_cast<Type *>` does.

use super::{FloatPixel, PixelFormat, PixelType};
use crate::glw;
use crate::khr_gl::misc::{
    float_to_half_float, float_to_unsigned_f10, float_to_unsigned_f11, half_float_to_float, unsigned_f10_to_float,
    unsigned_f11_to_float,
};
use crate::tcu::TestError;

/// `F_32_UINT_24_8_REV` - the companion type for GL_FLOAT_32_UNSIGNED_INT_24_8_REV.
#[derive(Clone, Copy)]
pub struct F32Uint248Rev {
    pub d: f32,
    pub s: u32,
}

/// A value of one of the gradient's element types, read from and written to a byte buffer in native byte order.
pub trait Element: Copy {
    const SIZE: usize;
    fn put(self, dst: &mut [u8]);
    fn get(src: &[u8]) -> Self;
    /// `(int)static_cast<Type>(value)`
    fn to_i32(self) -> i32;
    /// `(unsigned int)static_cast<Type>(value)`
    fn to_u32(self) -> u32;
    /// The value itself for a float element; only `pack_FLOAT` asks for it.
    fn to_f32(self) -> f32;
}

macro_rules! integer_element {
    ($ty:ty) => {
        impl Element for $ty {
            const SIZE: usize = std::mem::size_of::<$ty>();
            fn put(self, dst: &mut [u8]) {
                dst[..Self::SIZE].copy_from_slice(&self.to_ne_bytes());
            }
            fn get(src: &[u8]) -> Self {
                Self::from_ne_bytes(src[..Self::SIZE].try_into().expect("a slice of the element size"))
            }
            fn to_i32(self) -> i32 {
                self as i32
            }
            fn to_u32(self) -> u32 {
                self as u32
            }
            fn to_f32(self) -> f32 {
                self as f32
            }
        }
    };
}

integer_element!(u8);
integer_element!(i8);
integer_element!(u16);
integer_element!(i16);
integer_element!(u32);
integer_element!(i32);

impl Element for f32 {
    const SIZE: usize = 4;
    fn put(self, dst: &mut [u8]) {
        dst[..4].copy_from_slice(&self.to_ne_bytes());
    }
    fn get(src: &[u8]) -> Self {
        f32::from_ne_bytes(src[..4].try_into().expect("a slice of four bytes"))
    }
    fn to_i32(self) -> i32 {
        self as i32
    }
    fn to_u32(self) -> u32 {
        self as u32
    }
    fn to_f32(self) -> f32 {
        self
    }
}

impl Element for F32Uint248Rev {
    const SIZE: usize = 8;
    fn put(self, dst: &mut [u8]) {
        dst[..4].copy_from_slice(&self.d.to_ne_bytes());
        dst[4..8].copy_from_slice(&self.s.to_ne_bytes());
    }
    fn get(src: &[u8]) -> Self {
        Self {
            d: f32::get(src),
            s: u32::get(&src[4..]),
        }
    }
    fn to_i32(self) -> i32 {
        0
    }
    fn to_u32(self) -> u32 {
        0
    }
    fn to_f32(self) -> f32 {
        self.d
    }
}

/// `unpackSizedComponents<Type>` - `type_bits` is `sizeof(Type) * 8`; the caller truncates to `Type`.
fn unpack_sized_components(value: f32, type_bits: i32, s: [i32; 4]) -> u64 {
    let v = f64::from(value);
    let comp = |factor: f64, size: i32| -> u64 { (v * factor * f64::from((1 << size) - 1)) as u64 };
    let c1 = comp(1.00, s[0]);
    let c2 = comp(0.75, s[1]);
    let c3 = comp(0.50, s[2]);
    let c4 = comp(0.25, s[3]);
    (c1 << (type_bits - s[0]))
        | (c2 << (type_bits - s[0] - s[1]))
        | (c3 << (type_bits - s[0] - s[1] - s[2]))
        | (c4 << (type_bits - s[0] - s[1] - s[2] - s[3]))
}

/// `unpackSizedComponentsRev<Type>`
fn unpack_sized_components_rev(value: f32, type_bits: i32, s: [i32; 4]) -> u64 {
    let v = f64::from(value);
    let comp = |factor: f64, size: i32| -> u64 { (v * factor * f64::from((1 << size) - 1)) as u64 };
    let c1 = comp(1.00, s[3]);
    let c2 = comp(0.75, s[2]);
    let c3 = comp(0.50, s[1]);
    let c4 = comp(0.25, s[0]);
    (c4 << (type_bits - s[0]))
        | (c3 << (type_bits - s[0] - s[1]))
        | (c2 << (type_bits - s[0] - s[1] - s[2]))
        | (c1 << (type_bits - s[0] - s[1] - s[2] - s[3]))
}

/// `unpack_UNSIGNED_INT_5_9_9_9_REV`
fn unpack_unsigned_int_5_9_9_9_rev(value: f32) -> u32 {
    const N: i32 = 9;
    const B: i32 = 15;
    const E_MAX: i32 = 31;

    let red = value * 1.00;
    let green = value * 0.75;
    let blue = value * 0.50;

    let shared_exp_max = (2.0f32.powf(N as f32) - 1.0) / 2.0f32.powf(N as f32) * 2.0f32.powf((E_MAX - B) as f32);

    let red_c = 0.0f32.max(shared_exp_max.min(red));
    let green_c = 0.0f32.max(shared_exp_max.min(green));
    let blue_c = 0.0f32.max(shared_exp_max.min(blue));

    let max_c = red_c.max(green_c).max(blue_c);

    let exp_p = ((-B - 1) as f32).max(max_c.log2().floor()) + 1.0 + B as f32;
    let max_s = (max_c / 2.0f32.powf(exp_p - B as f32 - N as f32) + 0.5).floor();

    let exp_s = if 0.0 <= max_s && max_s < 2.0f32.powf(N as f32) {
        exp_p
    } else {
        exp_p + 1.0
    };

    let red_s = (red_c / 2.0f32.powf(exp_s - B as f32 - N as f32) + 0.5).floor();
    let green_s = (green_c / 2.0f32.powf(exp_s - B as f32 - N as f32) + 0.5).floor();
    let blue_s = (blue_c / 2.0f32.powf(exp_s - B as f32 - N as f32) + 0.5).floor();

    let c1 = (red_s as u32) & 511;
    let c2 = (green_s as u32) & 511;
    let c3 = (blue_s as u32) & 511;
    let c4 = (exp_s as u32) & 31;

    c1 | (c2 << 9) | (c3 << 18) | (c4 << 27)
}

/// `unpack_UNSIGNED_INT_10F_11F_11F_REV`
fn unpack_unsigned_int_10f_11f_11f_rev(value: f32) -> u32 {
    let c1 = float_to_unsigned_f11(value * 1.00);
    let c2 = float_to_unsigned_f11(value * 0.75);
    let c3 = float_to_unsigned_f10(value * 0.50);
    (c3 << 22) | (c2 << 11) | c1
}

/// `unpack_FLOAT_32_UNSIGNED_INT_24_8_REV`
fn unpack_float_32_unsigned_int_24_8_rev(value: f32) -> F32Uint248Rev {
    F32Uint248Rev {
        d: value,
        s: ((f64::from(value) * 255.0 * 0.75) as u32) & 0xff,
    }
}

/// The `unpack_*` function for a type, as a boxed closure: `value` in, the element out.
pub enum Unpack {
    U8(fn(f32) -> u8),
    I8(fn(f32) -> i8),
    U16(fn(f32) -> u16),
    I16(fn(f32) -> i16),
    U32(fn(f32) -> u32),
    I32(fn(f32) -> i32),
    F32(fn(f32) -> f32),
    Pair(fn(f32) -> F32Uint248Rev),
}

/// `createGradient`'s switch: which unpack function builds the gradient for a type.
pub fn unpack_for_type(type_: glw::GLenum) -> Result<Unpack, TestError> {
    Ok(match type_ {
        glw::GL_UNSIGNED_BYTE => Unpack::U8(|v| (v * f32::from(u8::MAX)) as u8),
        glw::GL_BYTE => Unpack::I8(|v| (v * f32::from(i8::MAX)) as i8),
        glw::GL_UNSIGNED_SHORT => Unpack::U16(|v| (v * f32::from(u16::MAX)) as u16),
        glw::GL_SHORT => Unpack::I16(|v| (v * f32::from(i16::MAX)) as i16),
        glw::GL_UNSIGNED_INT => Unpack::U32(|v| (v * u32::MAX as f32) as u32),
        glw::GL_INT => Unpack::I32(|v| (v * i32::MAX as f32) as i32),
        glw::GL_HALF_FLOAT => Unpack::U16(float_to_half_float),
        glw::GL_FLOAT => Unpack::F32(|v| v),
        glw::GL_UNSIGNED_SHORT_5_6_5 => Unpack::U16(|v| unpack_sized_components(v, 16, [5, 6, 5, 0]) as u16),
        glw::GL_UNSIGNED_SHORT_4_4_4_4 => Unpack::U16(|v| unpack_sized_components(v, 16, [4, 4, 4, 4]) as u16),
        glw::GL_UNSIGNED_SHORT_5_5_5_1 => Unpack::U16(|v| unpack_sized_components(v, 16, [5, 5, 5, 1]) as u16),
        glw::GL_UNSIGNED_INT_2_10_10_10_REV => {
            Unpack::U32(|v| unpack_sized_components_rev(v, 32, [2, 10, 10, 10]) as u32)
        }
        glw::GL_UNSIGNED_INT_24_8 => Unpack::U32(|v| unpack_sized_components(v, 32, [24, 8, 0, 0]) as u32),
        glw::GL_UNSIGNED_INT_10F_11F_11F_REV => Unpack::U32(unpack_unsigned_int_10f_11f_11f_rev),
        glw::GL_UNSIGNED_INT_5_9_9_9_REV => Unpack::U32(unpack_unsigned_int_5_9_9_9_rev),
        glw::GL_FLOAT_32_UNSIGNED_INT_24_8_REV => Unpack::Pair(unpack_float_32_unsigned_int_24_8_rev),
        glw::GL_UNSIGNED_BYTE_3_3_2 => Unpack::U8(|v| unpack_sized_components(v, 8, [3, 3, 2, 0]) as u8),
        glw::GL_UNSIGNED_BYTE_2_3_3_REV => Unpack::U8(|v| unpack_sized_components_rev(v, 8, [2, 3, 3, 0]) as u8),
        glw::GL_UNSIGNED_SHORT_5_6_5_REV => Unpack::U16(|v| unpack_sized_components_rev(v, 16, [5, 6, 5, 0]) as u16),
        glw::GL_UNSIGNED_SHORT_4_4_4_4_REV => Unpack::U16(|v| unpack_sized_components_rev(v, 16, [4, 4, 4, 4]) as u16),
        glw::GL_UNSIGNED_SHORT_1_5_5_5_REV => Unpack::U16(|v| unpack_sized_components_rev(v, 16, [1, 5, 5, 5]) as u16),
        glw::GL_UNSIGNED_INT_8_8_8_8 => Unpack::U32(|v| unpack_sized_components(v, 32, [8, 8, 8, 8]) as u32),
        glw::GL_UNSIGNED_INT_8_8_8_8_REV => Unpack::U32(|v| unpack_sized_components_rev(v, 32, [8, 8, 8, 8]) as u32),
        glw::GL_UNSIGNED_INT_10_10_10_2 => Unpack::U32(|v| unpack_sized_components(v, 32, [10, 10, 10, 2]) as u32),
        _ => return Err(TestError::Fail("Unsupported type".to_string())),
    })
}

/// One field of a packed word: the component it feeds, the bit it starts at and its width.
pub type PackedField = (usize, u32, u32);

/// The fields of the packed types that come in float, uint and int flavours.
pub fn packed_layout(type_: glw::GLenum) -> Option<&'static [PackedField]> {
    Some(match type_ {
        glw::GL_UNSIGNED_BYTE_3_3_2 => &[(0, 5, 3), (1, 2, 3), (2, 0, 2)],
        glw::GL_UNSIGNED_BYTE_2_3_3_REV => &[(2, 6, 2), (1, 3, 3), (0, 0, 3)],
        glw::GL_UNSIGNED_SHORT_5_6_5 => &[(0, 11, 5), (1, 5, 6), (2, 0, 5)],
        glw::GL_UNSIGNED_SHORT_5_6_5_REV => &[(2, 11, 5), (1, 5, 6), (0, 0, 5)],
        glw::GL_UNSIGNED_SHORT_4_4_4_4 => &[(0, 12, 4), (1, 8, 4), (2, 4, 4), (3, 0, 4)],
        glw::GL_UNSIGNED_SHORT_4_4_4_4_REV => &[(3, 12, 4), (2, 8, 4), (1, 4, 4), (0, 0, 4)],
        glw::GL_UNSIGNED_SHORT_5_5_5_1 => &[(0, 11, 5), (1, 6, 5), (2, 1, 5), (3, 0, 1)],
        glw::GL_UNSIGNED_SHORT_1_5_5_5_REV => &[(3, 15, 1), (2, 10, 5), (1, 5, 5), (0, 0, 5)],
        glw::GL_UNSIGNED_INT_8_8_8_8 => &[(0, 24, 8), (1, 16, 8), (2, 8, 8), (3, 0, 8)],
        glw::GL_UNSIGNED_INT_8_8_8_8_REV => &[(3, 24, 8), (2, 16, 8), (1, 8, 8), (0, 0, 8)],
        glw::GL_UNSIGNED_INT_10_10_10_2 => &[(0, 22, 10), (1, 12, 10), (2, 2, 10), (3, 0, 2)],
        glw::GL_UNSIGNED_INT_2_10_10_10_REV => &[(3, 30, 2), (2, 20, 10), (1, 10, 10), (0, 0, 10)],
        _ => return None,
    })
}

/// `pack_<TYPE>` / `pack_<TYPE>_UINT` / `pack_<TYPE>_INT` for the types in `packed_layout`: the float, uint and int components of one packed word. Components the type has no field for stay 0.
pub fn pack_packed(layout: &[PackedField], value: u32) -> ([f32; 4], [u32; 4], [i32; 4]) {
    let mut floats = [0.0f32; 4];
    let mut uints = [0u32; 4];
    let mut ints = [0i32; 4];
    for &(component, shift, width) in layout {
        let max = (1u32 << width) - 1;
        let field = (value >> shift) & max;
        floats[component] = field as f32 / max as f32;
        uints[component] = field;
        ints[component] = field as i32;
    }
    (floats, uints, ints)
}

/// `pack_UNSIGNED_INT_24_8`
pub fn pack_unsigned_int_24_8(value: u32) -> [f32; 4] {
    [
        ((value >> 8) & 16_777_215) as f32 / 16_777_215.0,
        (value & 255) as f32 / 255.0,
        0.0,
        0.0,
    ]
}

/// `pack_UNSIGNED_INT_10F_11F_11F_REV`
pub fn pack_unsigned_int_10f_11f_11f_rev(value: u32) -> [f32; 4] {
    [
        unsigned_f11_to_float(value & 2047),
        unsigned_f11_to_float((value >> 11) & 2047),
        unsigned_f10_to_float((value >> 22) & 1023),
        0.0,
    ]
}

/// `pack_UNSIGNED_INT_5_9_9_9_REV`
pub fn pack_unsigned_int_5_9_9_9_rev(value: u32) -> [f32; 4] {
    const B: i32 = 15;
    const N: i32 = 9;

    let p_exp = ((value >> 27) & 31) as i32;
    let p_blue = (value >> 18) & 511;
    let p_green = (value >> 9) & 511;
    let p_red = value & 511;

    let scale = 2.0f64.powi(p_exp - B - N);
    [
        (f64::from(p_red) * scale) as f32,
        (f64::from(p_green) * scale) as f32,
        (f64::from(p_blue) * scale) as f32,
        1.0,
    ]
}

/// `pack_FLOAT_32_UNSIGNED_INT_24_8_REV`
pub fn pack_float_32_unsigned_int_24_8_rev(value: F32Uint248Rev) -> [f32; 4] {
    [value.d, (value.s & 255) as f32 / 255.0, 0.0, 0.0]
}

/// `pack_UNSIGNED_BYTE` ... `pack_FLOAT`: the normalised float of an unpacked component.
pub fn pack_normalized<T: Element>(type_: glw::GLenum, value: T) -> f32 {
    match type_ {
        glw::GL_UNSIGNED_BYTE => value.to_u32() as f32 / f32::from(u8::MAX),
        glw::GL_BYTE => (value.to_i32() as f32 / f32::from(i8::MAX)).max(-1.0),
        glw::GL_UNSIGNED_SHORT => value.to_u32() as f32 / f32::from(u16::MAX),
        glw::GL_SHORT => (value.to_i32() as f32 / f32::from(i16::MAX)).max(-1.0),
        glw::GL_UNSIGNED_INT => value.to_u32() as f32 / u32::MAX as f32,
        glw::GL_INT => (value.to_i32() as f32 / i32::MAX as f32).max(-1.0),
        glw::GL_HALF_FLOAT => half_float_to_float(value.to_u32() as u16),
        _ => value.to_f32(),
    }
}

fn default_float_pixel() -> FloatPixel {
    FloatPixel {
        i: [0; 6],
        ui: [0; 6],
        f: [-2.0; 6],
    }
}

/// The index of each of the six slots of a `FloatPixel` (r, g, b, a, d, s) in a format's `componentOrder`, which is laid out as red, green, blue, alpha, intensity, luminance, depth, stencil.
fn order_slots(format: &PixelFormat) -> [(usize, i32); 6] {
    let order = format.component_order;
    [
        (0, order[0]),
        (1, order[1]),
        (2, order[2]),
        (3, order[3]),
        (4, order[6]),
        (5, order[7]),
    ]
}

/// `orderComponentsInt`
pub fn order_components_int(values: [i32; 4], format: &PixelFormat) -> FloatPixel {
    let mut fp = default_float_pixel();
    for (slot, index) in order_slots(format) {
        if index >= 0 {
            fp.i[slot] = values[index as usize];
        }
    }
    fp
}

/// `orderComponentsUint`
pub fn order_components_uint(values: [u32; 4], format: &PixelFormat) -> FloatPixel {
    let mut fp = default_float_pixel();
    for (slot, index) in order_slots(format) {
        if index >= 0 {
            fp.ui[slot] = values[index as usize];
        }
    }
    fp
}

/// `orderComponentsFloat`
pub fn order_components_float(values: [f32; 4], format: &PixelFormat) -> FloatPixel {
    let mut fp = default_float_pixel();
    for (slot, index) in order_slots(format) {
        if index >= 0 {
            fp.f[slot] = values[index as usize];
        }
    }
    fp
}

/// `getRealBitPrecision`
pub fn get_real_bit_precision(bits: i32, is_float: bool) -> i32 {
    if !is_float {
        return bits;
    }
    match bits {
        32 => 23,
        16 => 10,
        11 => 6,
        10 => 5,
        _ => bits,
    }
}

/// `clampSignedValue`
pub fn clamp_signed_value(bits: i32, value: i32) -> i32 {
    let mut max = 2_147_483_647;
    let mut min = i32::MIN;
    if bits < 32 {
        max = ((1i64 << (bits - 1)) - 1) as i32;
        min = ((1i64 << (bits - 1)) - (1i64 << bits)) as i32;
    }

    if value >= max {
        max
    } else if value <= min {
        min
    } else {
        value
    }
}

/// `clampUnsignedValue`
pub fn clamp_unsigned_value(bits: i32, value: u32) -> u32 {
    let mut max = 4_294_967_295u32;
    let min = 0u32;
    if bits < 32 {
        max = ((1u64 << bits) - 1) as u32;
    }

    if value >= max {
        max
    } else if value <= min {
        min
    } else {
        value
    }
}

/// `getBits` - the bit depth table for a type and format pair, always `NUM_FLOAT_PIXEL_COUNT` (18) long.
pub fn get_bits(type_: &PixelType, format: &PixelFormat) -> [i32; 18] {
    let mut result_table = [0i32; 18];

    if type_.special {
        result_table[..9].copy_from_slice(&type_.bits);
        if type_.type_ == glw::GL_UNSIGNED_INT_5_9_9_9_REV {
            // this type is another special case: it is always converted to 3-channel color (no A). As results of this function are used for comparison of converted values we set A bits to 0.
            result_table[3] = 0;
        }
    } else {
        let bits = if type_.type_ == glw::GL_FLOAT {
            32
        } else if type_.type_ == glw::GL_HALF_FLOAT {
            16
        } else {
            type_.size << 3
        };

        let f = format.format;
        if f == glw::GL_DEPTH_STENCIL || f == glw::GL_DEPTH_COMPONENT {
            result_table[4] = bits;
        }
        if f == glw::GL_DEPTH_STENCIL || f == glw::GL_STENCIL_INDEX || f == glw::GL_STENCIL_INDEX8 {
            result_table[5] = bits;
        }
        if matches!(
            f,
            glw::GL_RED
                | glw::GL_RG
                | glw::GL_RGB
                | glw::GL_RGBA
                | glw::GL_BGR
                | glw::GL_BGRA
                | glw::GL_RED_INTEGER
                | glw::GL_RG_INTEGER
                | glw::GL_RGB_INTEGER
                | glw::GL_RGBA_INTEGER
                | glw::GL_BGR_INTEGER
                | glw::GL_BGRA_INTEGER
        ) {
            result_table[0] = bits;
        }
        if matches!(
            f,
            glw::GL_RG
                | glw::GL_RGB
                | glw::GL_RGBA
                | glw::GL_BGR
                | glw::GL_BGRA
                | glw::GL_RG_INTEGER
                | glw::GL_RGB_INTEGER
                | glw::GL_RGBA_INTEGER
                | glw::GL_BGR_INTEGER
                | glw::GL_BGRA_INTEGER
        ) {
            result_table[1] = bits;
        }
        if matches!(
            f,
            glw::GL_RGB
                | glw::GL_RGBA
                | glw::GL_BGR
                | glw::GL_BGRA
                | glw::GL_RGB_INTEGER
                | glw::GL_RGBA_INTEGER
                | glw::GL_BGR_INTEGER
                | glw::GL_BGRA_INTEGER
        ) {
            result_table[2] = bits;
        }
        if matches!(
            f,
            glw::GL_RGBA | glw::GL_BGRA | glw::GL_RGBA_INTEGER | glw::GL_BGRA_INTEGER
        ) {
            result_table[3] = bits;
        }
    }

    result_table
}
