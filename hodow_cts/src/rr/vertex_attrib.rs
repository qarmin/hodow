// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/referencerenderer/rrVertexAttrib.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `VertexAttrib::pointer` stays a raw `*const u8` exactly like upstream's `const void*`
// - a vertex buffer's backing storage is arbitrary caller-owned memory read at an
// arbitrary byte offset/stride, which is precisely what a raw pointer means and what a
// borrowed slice cannot express once `stride` lets one attribute's reads overlap
// another's. `read_vertex_attrib_*` are `unsafe fn` for exactly this reason: the
// caller must guarantee `pointer` addresses at least
// `byte_offset + size * component_size` readable bytes for every vertex/instance index
// that will be read, the same obligation upstream's C++ places on its own caller
// silently.
//
// Upstream's templated `read<Src, Dst>` is only ever instantiated with `Dst = float`
// (from `readFloat`), `Dst = int32_t` (from `readInt`, always with a signed `Src`) or
// `Dst = uint32_t` (from `readUint`, always with an unsigned `Src`) - never with a
// `Src`/`Dst` pair that also needs `Order` to be `BGRAOrder` (that combination is only
// ever used by the four `*_BGRA` unorm/snorm variants, each of which already has its
// own named upstream function). So the plain integer-widening reader here takes no
// `Order` parameter, unlike the four `*_order` families that do.
//
// `needless_range_loop` is silenced module-wide: every reader here walks `0..size`
// across several parallel fixed-size arrays (`aligned`/`dst.m_data`/`order`) at once,
// the same shape `tcu::compressed_texture`/`tcu::astc` already carry this same
// allow for, and a `size` capped at 4 makes the lint's usual "use an iterator instead"
// fix read worse, not better, here.
#![allow(clippy::needless_range_loop)]

use super::generic_vector::GenericVec4;
use crate::tcu::pixel::f16_bits_to_f32;
use crate::tcu::vector::{IVec4, UVec4, Vec4};

/// `rr::VertexAttribType`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum VertexAttribType {
    // Can only be read as floats.
    Float,
    Half,
    Fixed,
    Double,

    // Can only be read as floats, will be normalized.
    NonpureUnorm8,
    NonpureUnorm16,
    NonpureUnorm32,
    /// Packed format, only `size == 4` is allowed.
    NonpureUnorm2101010Rev,

    // Clamped formats, GLES3-style conversion: max{c / (2^(b-1) - 1), -1}.
    NonpureSnorm8Clamp,
    NonpureSnorm16Clamp,
    NonpureSnorm32Clamp,
    /// Packed format, only `size == 4` is allowed.
    NonpureSnorm2101010RevClamp,

    // Scaled formats, GLES2-style conversion: (2c + 1) / (2^b - 1).
    NonpureSnorm8Scale,
    NonpureSnorm16Scale,
    NonpureSnorm32Scale,
    /// Packed format, only `size == 4` is allowed.
    NonpureSnorm2101010RevScale,

    // Can only be read as float, will not be normalized.
    NonpureUint8,
    NonpureUint16,
    NonpureUint32,

    NonpureInt8,
    NonpureInt16,
    NonpureInt32,

    /// Packed format, only `size == 4` is allowed.
    NonpureUint2101010Rev,
    /// Packed format, only `size == 4` is allowed.
    NonpureInt2101010Rev,

    // Can only be read as integers.
    PureUint8,
    PureUint16,
    PureUint32,

    PureInt8,
    PureInt16,
    PureInt32,

    // Reordered formats of GL_ARB_vertex_array_bgra.
    NonpureUnorm8Bgra,
    NonpureUnorm2101010RevBgra,
    NonpureSnorm2101010RevClampBgra,
    NonpureSnorm2101010RevScaleBgra,

    /// Do not enforce type checking when reading a GENERIC attribute. Used for
    /// current client-side attributes.
    DontCare,
}

/// `rr::VertexAttrib`
///
/// Attribute size specifies how many components there are per vertex. If size is 0,
/// no components are fetched, i.e. the vertex attribute slot is disabled.
///
/// Divisor specifies the rate at which vertex attribute advances. If it is zero,
/// attribute is advanced per vertex. If divisor is non-zero, attribute advances once
/// per `instance_divisor` instances.
///
/// `pointer` is used if `Some`, otherwise the `generic` attribute is used instead, and
/// in that case only `DontCare` is a valid attribute type.
#[derive(Clone, Copy)]
pub struct VertexAttrib {
    pub type_: VertexAttribType,
    /// Number of components, valid range is `[0,4]`.
    pub size: i32,
    /// Number of bytes two consecutive elements differ by. Zero works as in GL. Valid
    /// range is `[0, inf)`.
    pub stride: i32,
    pub instance_divisor: i32,
    pub pointer: Option<*const u8>,
    pub generic: GenericVec4,
}

impl Default for VertexAttrib {
    fn default() -> Self {
        Self {
            type_: VertexAttribType::Float,
            size: 0,
            stride: 0,
            instance_divisor: 0,
            pointer: None,
            generic: GenericVec4::zero(),
        }
    }
}

impl VertexAttrib {
    /// `VertexAttrib::VertexAttrib(type, size, stride, instanceDivisor, pointer)`
    pub fn from_pointer(
        type_: VertexAttribType,
        size: i32,
        stride: i32,
        instance_divisor: i32,
        pointer: *const u8,
    ) -> Self {
        Self {
            type_,
            size,
            stride,
            instance_divisor,
            pointer: Some(pointer),
            generic: GenericVec4::zero(),
        }
    }

    /// `VertexAttrib::VertexAttrib(const tcu::Vector<ScalarType,4>&)` (float overload)
    pub fn from_generic_float(v: Vec4) -> Self {
        Self {
            type_: VertexAttribType::DontCare,
            generic: GenericVec4::from_float(v),
            ..Default::default()
        }
    }

    pub fn from_generic_int(v: IVec4) -> Self {
        Self {
            type_: VertexAttribType::DontCare,
            generic: GenericVec4::from_int(v),
            ..Default::default()
        }
    }

    pub fn from_generic_uint(v: UVec4) -> Self {
        Self {
            type_: VertexAttribType::DontCare,
            generic: GenericVec4::from_uint(v),
            ..Default::default()
        }
    }
}

/// `isValidVertexAttrib`
#[allow(clippy::needless_bool)]
pub fn is_valid_vertex_attrib(attrib: &VertexAttrib) -> bool {
    if !(0..=4).contains(&attrib.size) || attrib.instance_divisor < 0 {
        return false;
    }

    // Generic attributes.
    if attrib.pointer.is_none() && attrib.type_ != VertexAttribType::DontCare {
        return false;
    }

    // Packed formats.
    let is_packed = matches!(
        attrib.type_,
        VertexAttribType::NonpureInt2101010Rev
            | VertexAttribType::NonpureUint2101010Rev
            | VertexAttribType::NonpureUnorm2101010Rev
            | VertexAttribType::NonpureSnorm2101010RevClamp
            | VertexAttribType::NonpureSnorm2101010RevScale
            | VertexAttribType::NonpureUnorm2101010RevBgra
            | VertexAttribType::NonpureSnorm2101010RevClampBgra
            | VertexAttribType::NonpureSnorm2101010RevScaleBgra
    );
    if is_packed && attrib.size != 4 {
        return false;
    }

    true
}

/// `getComponentSize`
fn get_component_size(type_: VertexAttribType) -> i32 {
    use VertexAttribType::*;
    match type_ {
        Float => 4,
        Half => 2,
        Fixed => 4,
        Double => 8,
        NonpureUnorm8 => 1,
        NonpureUnorm16 => 2,
        NonpureUnorm32 => 4,
        NonpureUnorm2101010Rev => 1, // sizeof(uint32_t) / 4, matching upstream's own (surprising) arithmetic
        NonpureSnorm8Clamp => 1,
        NonpureSnorm16Clamp => 2,
        NonpureSnorm32Clamp => 4,
        NonpureSnorm2101010RevClamp => 1,
        NonpureSnorm8Scale => 1,
        NonpureSnorm16Scale => 2,
        NonpureSnorm32Scale => 4,
        NonpureSnorm2101010RevScale => 1,
        NonpureUint8 => 1,
        NonpureUint16 => 2,
        NonpureUint32 => 4,
        NonpureInt8 => 1,
        NonpureInt16 => 2,
        NonpureInt32 => 4,
        NonpureUint2101010Rev => 1,
        NonpureInt2101010Rev => 1,
        PureUint8 => 1,
        PureUint16 => 2,
        PureUint32 => 4,
        PureInt8 => 1,
        PureInt16 => 2,
        PureInt32 => 4,
        NonpureUnorm8Bgra => 1,
        NonpureUnorm2101010RevBgra => 1,
        NonpureSnorm2101010RevClampBgra => 1,
        NonpureSnorm2101010RevScaleBgra => 1,
        DontCare => 0,
    }
}

// --- raw scalar reads ---

/// Reads `size` (<= 4) little-endian-native scalars of `T` starting at `ptr`,
/// unaligned, zero-filling any lanes beyond `size`.
unsafe fn read_raw_u8(ptr: *const u8, size: usize) -> [u8; 4] {
    let mut out = [0u8; 4];
    for (i, dst) in out.iter_mut().enumerate().take(size) {
        *dst = unsafe { ptr.add(i).read() };
    }
    out
}

unsafe fn read_raw_u16(ptr: *const u8, size: usize) -> [u16; 4] {
    let mut out = [0u16; 4];
    for (i, dst) in out.iter_mut().enumerate().take(size) {
        *dst = unsafe { ptr.add(i * 2).cast::<u16>().read_unaligned() };
    }
    out
}

unsafe fn read_raw_u32(ptr: *const u8, size: usize) -> [u32; 4] {
    let mut out = [0u32; 4];
    for (i, dst) in out.iter_mut().enumerate().take(size) {
        *dst = unsafe { ptr.add(i * 4).cast::<u32>().read_unaligned() };
    }
    out
}

unsafe fn read_raw_i8(ptr: *const u8, size: usize) -> [i8; 4] {
    let u = unsafe { read_raw_u8(ptr, size) };
    u.map(|v| v as i8)
}

unsafe fn read_raw_i16(ptr: *const u8, size: usize) -> [i16; 4] {
    let u = unsafe { read_raw_u16(ptr, size) };
    u.map(|v| v as i16)
}

unsafe fn read_raw_i32(ptr: *const u8, size: usize) -> [i32; 4] {
    let u = unsafe { read_raw_u32(ptr, size) };
    u.map(|v| v as i32)
}

unsafe fn read_raw_f64(ptr: *const u8, size: usize) -> [f64; 4] {
    let mut out = [0f64; 4];
    for (i, dst) in out.iter_mut().enumerate().take(size) {
        *dst = unsafe { ptr.add(i * 8).cast::<f64>().read_unaligned() };
    }
    out
}

unsafe fn read_raw_f32(ptr: *const u8, size: usize) -> [f32; 4] {
    let u = unsafe { read_raw_u32(ptr, size) };
    u.map(f32::from_bits)
}

fn extend_sign(integer: u32, integer_len: u32) -> i32 {
    (0u32.wrapping_sub((integer & (1 << (integer_len - 1))) << 1)) as i32 | integer as i32
}

/// `readUint2101010Rev<DstScalarType>` / `readInt2101010Rev<DstScalarType>` share this
/// bit layout; `signed_` selects which of the two.
fn unpack_2101010_rev(aligned: u32, size: usize, signed: bool) -> [i32; 4] {
    let lanes = [
        (aligned) & ((1 << 10) - 1),
        (aligned >> 10) & ((1 << 10) - 1),
        (aligned >> 20) & ((1 << 10) - 1),
        (aligned >> 30) & ((1 << 2) - 1),
    ];
    let bits = [10u32, 10, 10, 2];
    let mut out = [0i32; 4];
    for i in 0..size {
        out[i] = if signed {
            extend_sign(lanes[i], bits[i])
        } else {
            lanes[i] as i32
        };
    }
    out
}

const NORMAL_ORDER: [usize; 4] = [0, 1, 2, 3];
const BGRA_ORDER: [usize; 4] = [2, 1, 0, 3];

fn read_unorm_order(dst: &mut Vec4, aligned_u32: &[u32; 4], size: usize, bits: u32, order: [usize; 4]) {
    let range = ((1u64 << bits) - 1) as f32;
    for i in 0..size {
        dst.m_data[order[i]] = aligned_u32[i] as f32 / range;
    }
}

fn read_snorm_clamp(dst: &mut Vec4, aligned: &[i32; 4], size: usize, bits: u32) {
    // Clamped formats, GLES3-style conversion: max{c / (2^(b-1) - 1), -1}.
    let range = ((1u64 << (bits - 1)) - 1) as f32;
    for i in 0..size {
        dst.m_data[i] = (aligned[i] as f32 / range).max(-1.0);
    }
}

fn read_snorm_scale(dst: &mut Vec4, aligned: &[i32; 4], size: usize, bits: u32) {
    // Scaled formats, GLES2-style conversion: (2c + 1) / (2^b - 1).
    let range = ((1u64 << bits) - 1) as f32;
    for i in 0..size {
        dst.m_data[i] = (aligned[i] as f32 * 2.0 + 1.0) / range;
    }
}

fn read_snorm_2101010_rev_order(dst: &mut Vec4, aligned: u32, size: usize, order: [usize; 4], clamp: bool) {
    let lanes = unpack_2101010_rev(aligned, size, true);
    let bits = [10u32, 10, 10, 2];
    for i in 0..size {
        let range_bits = if clamp { bits[i] - 1 } else { bits[i] };
        let range = ((1u64 << range_bits) - 1) as f32;
        dst.m_data[order[i]] = if clamp {
            (lanes[i] as f32 / range).max(-1.0)
        } else {
            (lanes[i] as f32 * 2.0 + 1.0) / range
        };
    }
}

/// `readFloat`
fn read_float(dst: &mut Vec4, type_: VertexAttribType, size: i32, ptr: *const u8) {
    use VertexAttribType::*;
    let size = size as usize;
    unsafe {
        match type_ {
            Float => {
                let raw = read_raw_f32(ptr, size);
                dst.m_data[..size].copy_from_slice(&raw[..size]);
            }
            Half => {
                let raw = read_raw_u16(ptr, size);
                for i in 0..size {
                    dst.m_data[i] = f16_bits_to_f32(raw[i]);
                }
            }
            Fixed => {
                let raw = read_raw_i32(ptr, size);
                for i in 0..size {
                    dst.m_data[i] = raw[i] as f32 / (1i32 << 16) as f32;
                }
            }
            Double => {
                let raw = read_raw_f64(ptr, size);
                for i in 0..size {
                    dst.m_data[i] = raw[i] as f32;
                }
            }
            NonpureUnorm8 => read_unorm_order(dst, &read_raw_u8(ptr, size).map(u32::from), size, 8, NORMAL_ORDER),
            NonpureUnorm16 => read_unorm_order(dst, &read_raw_u16(ptr, size).map(u32::from), size, 16, NORMAL_ORDER),
            NonpureUnorm32 => read_unorm_order(dst, &read_raw_u32(ptr, size), size, 32, NORMAL_ORDER),
            NonpureUnorm2101010Rev => {
                let aligned = read_raw_u32(ptr, 1)[0];
                read_unorm_2101010_rev_order(dst, aligned, size, NORMAL_ORDER);
            }
            NonpureSnorm8Clamp => read_snorm_clamp(dst, &read_raw_i8(ptr, size).map(i32::from), size, 8),
            NonpureSnorm16Clamp => read_snorm_clamp(dst, &read_raw_i16(ptr, size).map(i32::from), size, 16),
            NonpureSnorm32Clamp => read_snorm_clamp(dst, &read_raw_i32(ptr, size), size, 32),
            NonpureSnorm2101010RevClamp => {
                let aligned = read_raw_u32(ptr, 1)[0];
                read_snorm_2101010_rev_order(dst, aligned, size, NORMAL_ORDER, true);
            }
            NonpureSnorm8Scale => read_snorm_scale(dst, &read_raw_i8(ptr, size).map(i32::from), size, 8),
            NonpureSnorm16Scale => read_snorm_scale(dst, &read_raw_i16(ptr, size).map(i32::from), size, 16),
            NonpureSnorm32Scale => read_snorm_scale(dst, &read_raw_i32(ptr, size), size, 32),
            NonpureSnorm2101010RevScale => {
                let aligned = read_raw_u32(ptr, 1)[0];
                read_snorm_2101010_rev_order(dst, aligned, size, NORMAL_ORDER, false);
            }
            NonpureUint8 => {
                let raw = read_raw_u8(ptr, size);
                for i in 0..size {
                    dst.m_data[i] = raw[i] as f32;
                }
            }
            NonpureUint16 => {
                let raw = read_raw_u16(ptr, size);
                for i in 0..size {
                    dst.m_data[i] = raw[i] as f32;
                }
            }
            NonpureUint32 => {
                let raw = read_raw_u32(ptr, size);
                for i in 0..size {
                    dst.m_data[i] = raw[i] as f32;
                }
            }
            NonpureInt8 => {
                let raw = read_raw_i8(ptr, size);
                for i in 0..size {
                    dst.m_data[i] = raw[i] as f32;
                }
            }
            NonpureInt16 => {
                let raw = read_raw_i16(ptr, size);
                for i in 0..size {
                    dst.m_data[i] = raw[i] as f32;
                }
            }
            NonpureInt32 => {
                let raw = read_raw_i32(ptr, size);
                for i in 0..size {
                    dst.m_data[i] = raw[i] as f32;
                }
            }
            NonpureUint2101010Rev => {
                let aligned = read_raw_u32(ptr, 1)[0];
                let lanes = unpack_2101010_rev(aligned, size, false);
                for i in 0..size {
                    dst.m_data[i] = lanes[i] as f32;
                }
            }
            NonpureInt2101010Rev => {
                let aligned = read_raw_u32(ptr, 1)[0];
                let lanes = unpack_2101010_rev(aligned, size, true);
                for i in 0..size {
                    dst.m_data[i] = lanes[i] as f32;
                }
            }
            NonpureUnorm8Bgra => read_unorm_order(dst, &read_raw_u8(ptr, size).map(u32::from), size, 8, BGRA_ORDER),
            NonpureUnorm2101010RevBgra => {
                let aligned = read_raw_u32(ptr, 1)[0];
                read_unorm_2101010_rev_order(dst, aligned, size, BGRA_ORDER);
            }
            NonpureSnorm2101010RevClampBgra => {
                let aligned = read_raw_u32(ptr, 1)[0];
                read_snorm_2101010_rev_order(dst, aligned, size, BGRA_ORDER, true);
            }
            NonpureSnorm2101010RevScaleBgra => {
                let aligned = read_raw_u32(ptr, 1)[0];
                read_snorm_2101010_rev_order(dst, aligned, size, BGRA_ORDER, false);
            }
            PureUint8 | PureUint16 | PureUint32 | PureInt8 | PureInt16 | PureInt32 => {
                unreachable!("Invalid read: {type_:?} must go through read_uint/read_int")
            }
            DontCare => unreachable!("Invalid read: DontCare has no pointer-backed representation"),
        }
    }
}

/// `readUnorm2101010Rev`/`readUnorm2101010RevBGRA` - shares `unpack_2101010_rev`'s
/// unsigned decode with `read_snorm_2101010_rev_order`'s per-field range, but with no
/// sign extension and no clamp.
fn read_unorm_2101010_rev_order(dst: &mut Vec4, aligned: u32, size: usize, order: [usize; 4]) {
    let lanes = unpack_2101010_rev(aligned, size, false);
    let bits = [10u32, 10, 10, 2];
    for i in 0..size {
        let range = ((1u64 << bits[i]) - 1) as f32;
        dst.m_data[order[i]] = lanes[i] as f32 / range;
    }
}

/// `readInt`
fn read_int(dst: &mut IVec4, type_: VertexAttribType, size: i32, ptr: *const u8) {
    use VertexAttribType::*;
    let size = size as usize;
    unsafe {
        match type_ {
            PureInt8 => {
                let raw = read_raw_i8(ptr, size);
                for i in 0..size {
                    dst.m_data[i] = raw[i] as i32;
                }
            }
            PureInt16 => {
                let raw = read_raw_i16(ptr, size);
                for i in 0..size {
                    dst.m_data[i] = raw[i] as i32;
                }
            }
            PureInt32 => {
                let raw = read_raw_i32(ptr, size);
                dst.m_data[..size].copy_from_slice(&raw[..size]);
            }
            _ => unreachable!("Invalid read: {type_:?} must go through read_float/read_uint"),
        }
    }
}

/// `readUint`
fn read_uint(dst: &mut UVec4, type_: VertexAttribType, size: i32, ptr: *const u8) {
    use VertexAttribType::*;
    let size = size as usize;
    unsafe {
        match type_ {
            PureUint8 => {
                let raw = read_raw_u8(ptr, size);
                for i in 0..size {
                    dst.m_data[i] = raw[i] as u32;
                }
            }
            PureUint16 => {
                let raw = read_raw_u16(ptr, size);
                for i in 0..size {
                    dst.m_data[i] = raw[i] as u32;
                }
            }
            PureUint32 => {
                let raw = read_raw_u32(ptr, size);
                dst.m_data[..size].copy_from_slice(&raw[..size]);
            }
            _ => unreachable!("Invalid read: {type_:?} must go through read_float/read_int"),
        }
    }
}

fn element_ndx(attrib: &VertexAttrib, instance_ndx: i32, vertex_ndx: i32, base_instance_ndx: i32) -> i32 {
    if attrib.instance_divisor != 0 {
        base_instance_ndx + instance_ndx / attrib.instance_divisor
    } else {
        vertex_ndx
    }
}

fn byte_offset(attrib: &VertexAttrib, element_ndx: i32) -> isize {
    let comp_size = get_component_size(attrib.type_);
    let stride = if attrib.stride != 0 {
        attrib.stride
    } else {
        attrib.size * comp_size
    };
    (element_ndx as isize) * (stride as isize)
}

/// `readVertexAttrib(tcu::Vec4&, ...)`
///
/// # Safety
/// If `attrib.pointer` is `Some`, it must address at least
/// `byte_offset + attrib.size * component_size(attrib.type_)` readable bytes for the
/// given `instance_ndx`/`vertex_ndx`/`base_instance_ndx`.
pub unsafe fn read_vertex_attrib_float(
    dst: &mut Vec4,
    attrib: &VertexAttrib,
    instance_ndx: i32,
    vertex_ndx: i32,
    base_instance_ndx: i32,
) {
    debug_assert!(is_valid_vertex_attrib(attrib));

    if let Some(pointer) = attrib.pointer {
        let ndx = element_ndx(attrib, instance_ndx, vertex_ndx, base_instance_ndx);
        let offset = byte_offset(attrib, ndx);

        *dst = Vec4::new(0.0, 0.0, 0.0, 1.0);
        read_float(dst, attrib.type_, attrib.size, unsafe { pointer.offset(offset) });
    } else {
        *dst = attrib.generic.get_float();
    }
}

/// # Safety
/// See [`read_vertex_attrib_float`].
pub unsafe fn read_vertex_attrib_int(
    dst: &mut IVec4,
    attrib: &VertexAttrib,
    instance_ndx: i32,
    vertex_ndx: i32,
    base_instance_ndx: i32,
) {
    debug_assert!(is_valid_vertex_attrib(attrib));

    if let Some(pointer) = attrib.pointer {
        let ndx = element_ndx(attrib, instance_ndx, vertex_ndx, base_instance_ndx);
        let offset = byte_offset(attrib, ndx);

        *dst = IVec4::new(0, 0, 0, 1);
        read_int(dst, attrib.type_, attrib.size, unsafe { pointer.offset(offset) });
    } else {
        *dst = attrib.generic.get_int();
    }
}

/// # Safety
/// See [`read_vertex_attrib_float`].
pub unsafe fn read_vertex_attrib_uint(
    dst: &mut UVec4,
    attrib: &VertexAttrib,
    instance_ndx: i32,
    vertex_ndx: i32,
    base_instance_ndx: i32,
) {
    debug_assert!(is_valid_vertex_attrib(attrib));

    if let Some(pointer) = attrib.pointer {
        let ndx = element_ndx(attrib, instance_ndx, vertex_ndx, base_instance_ndx);
        let offset = byte_offset(attrib, ndx);

        *dst = UVec4::new(0, 0, 0, 1);
        read_uint(dst, attrib.type_, attrib.size, unsafe { pointer.offset(offset) });
    } else {
        *dst = attrib.generic.get_uint();
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn generic_attrib_reads_back_the_stored_value() {
        let attrib = VertexAttrib::from_generic_float(Vec4::new(1.0, 2.0, 3.0, 4.0));
        let mut dst = Vec4::splat(0.0);
        unsafe { read_vertex_attrib_float(&mut dst, &attrib, 0, 0, 0) };
        assert_eq!(dst.m_data, [1.0, 2.0, 3.0, 4.0]);
    }

    #[test]
    fn float_pointer_reads_two_components_default_fills_rest() {
        let data: [f32; 2] = [10.0, -5.0];
        let attrib = VertexAttrib::from_pointer(VertexAttribType::Float, 2, 0, 0, data.as_ptr().cast());
        let mut dst = Vec4::splat(0.0);
        unsafe { read_vertex_attrib_float(&mut dst, &attrib, 0, 0, 0) };
        assert_eq!(dst.m_data, [10.0, -5.0, 0.0, 1.0]);
    }

    #[test]
    fn unorm8_normalizes_to_unit_range() {
        let data: [u8; 4] = [0, 255, 128, 64];
        let attrib = VertexAttrib::from_pointer(VertexAttribType::NonpureUnorm8, 4, 0, 0, data.as_ptr());
        let mut dst = Vec4::splat(0.0);
        unsafe { read_vertex_attrib_float(&mut dst, &attrib, 0, 0, 0) };
        assert_eq!(dst.m_data[0], 0.0);
        assert_eq!(dst.m_data[1], 1.0);
        assert!((dst.m_data[2] - 128.0 / 255.0).abs() < 1e-6);
    }

    #[test]
    fn unorm8_bgra_swaps_red_and_blue() {
        let data: [u8; 4] = [10, 20, 30, 40]; // stored as B,G,R,A per GL_BGRA convention
        let attrib = VertexAttrib::from_pointer(VertexAttribType::NonpureUnorm8Bgra, 4, 0, 0, data.as_ptr());
        let mut dst = Vec4::splat(0.0);
        unsafe { read_vertex_attrib_float(&mut dst, &attrib, 0, 0, 0) };
        // dst.x (R) should come from data[2], dst.z (B) from data[0].
        assert!((dst.m_data[0] - 30.0 / 255.0).abs() < 1e-6);
        assert!((dst.m_data[2] - 10.0 / 255.0).abs() < 1e-6);
        assert!((dst.m_data[1] - 20.0 / 255.0).abs() < 1e-6);
        assert!((dst.m_data[3] - 40.0 / 255.0).abs() < 1e-6);
    }

    #[test]
    fn snorm8_clamp_clamps_most_negative_to_minus_one() {
        let data: [i8; 1] = [-128];
        let attrib = VertexAttrib::from_pointer(VertexAttribType::NonpureSnorm8Clamp, 1, 0, 0, data.as_ptr().cast());
        let mut dst = Vec4::splat(0.0);
        unsafe { read_vertex_attrib_float(&mut dst, &attrib, 0, 0, 0) };
        assert_eq!(dst.m_data[0], -1.0);
    }

    #[test]
    fn pure_int8_reads_exact_signed_value() {
        let data: [i8; 2] = [-5, 100];
        let attrib = VertexAttrib::from_pointer(VertexAttribType::PureInt8, 2, 0, 0, data.as_ptr().cast());
        let mut dst = IVec4::new(0, 0, 0, 0);
        unsafe { read_vertex_attrib_int(&mut dst, &attrib, 0, 0, 0) };
        assert_eq!(dst.m_data, [-5, 100, 0, 1]);
    }

    #[test]
    fn pure_uint32_reads_exact_value() {
        let data: [u32; 1] = [0xDEAD_BEEF];
        let attrib = VertexAttrib::from_pointer(VertexAttribType::PureUint32, 1, 0, 0, data.as_ptr().cast());
        let mut dst = UVec4::new(0, 0, 0, 0);
        unsafe { read_vertex_attrib_uint(&mut dst, &attrib, 0, 0, 0) };
        assert_eq!(dst.m_data[0], 0xDEAD_BEEF);
    }

    #[test]
    fn instance_divisor_advances_once_per_n_instances() {
        let data: [f32; 3] = [100.0, 200.0, 300.0];
        let attrib = VertexAttrib::from_pointer(VertexAttribType::Float, 1, 4, 2, data.as_ptr().cast());
        let mut dst = Vec4::splat(0.0);

        unsafe { read_vertex_attrib_float(&mut dst, &attrib, 0, 0, 0) };
        assert_eq!(dst.m_data[0], 100.0);
        unsafe { read_vertex_attrib_float(&mut dst, &attrib, 1, 0, 0) };
        assert_eq!(dst.m_data[0], 100.0); // divisor 2: instances 0,1 share element 0
        unsafe { read_vertex_attrib_float(&mut dst, &attrib, 2, 0, 0) };
        assert_eq!(dst.m_data[0], 200.0);
    }

    #[test]
    fn invalid_size_is_rejected() {
        let mut attrib = VertexAttrib::from_generic_float(Vec4::splat(0.0));
        attrib.size = 5;
        assert!(!is_valid_vertex_attrib(&attrib));
    }

    #[test]
    fn packed_format_requires_size_four() {
        let data: [u32; 1] = [0];
        let mut attrib =
            VertexAttrib::from_pointer(VertexAttribType::NonpureUnorm2101010Rev, 4, 0, 0, data.as_ptr().cast());
        assert!(is_valid_vertex_attrib(&attrib));
        attrib.size = 3;
        assert!(!is_valid_vertex_attrib(&attrib));
    }

    #[test]
    fn unorm_2101010_rev_unpacks_all_four_fields() {
        // field0 (bits 0-9) = 1023 -> 1.0, field1/field2 = 0, field3 (bits 30-31) = 3 -> 1.0
        let packed: u32 = 1023 | (3 << 30);
        let data = [packed];
        let attrib =
            VertexAttrib::from_pointer(VertexAttribType::NonpureUnorm2101010Rev, 4, 0, 0, data.as_ptr().cast());
        let mut dst = Vec4::splat(0.0);
        unsafe { read_vertex_attrib_float(&mut dst, &attrib, 0, 0, 0) };
        assert!((dst.m_data[0] - 1.0).abs() < 1e-6);
        assert_eq!(dst.m_data[1], 0.0);
        assert!((dst.m_data[3] - 1.0).abs() < 1e-6);
    }

    #[test]
    fn int_2101010_rev_sign_extends() {
        // field0 = all ones (10 bits) == -1 signed
        let packed: u32 = 0x3FF;
        let data = [packed];
        let attrib = VertexAttrib::from_pointer(VertexAttribType::NonpureInt2101010Rev, 4, 0, 0, data.as_ptr().cast());
        let mut dst = Vec4::splat(99.0);
        unsafe { read_vertex_attrib_float(&mut dst, &attrib, 0, 0, 0) };
        assert_eq!(dst.m_data[0], -1.0);
    }
}
