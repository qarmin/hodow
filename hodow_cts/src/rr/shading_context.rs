// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/referencerenderer/rrShadingContext.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream passes `const FragmentShadingContext&` everywhere, even though
// `outputArray`/`outputArraySrc1`/`fragmentDepths` are non-const pointers *inside* that
// const struct - the classic C++ "mutate through a pointer held by a const reference"
// escape hatch, used because one context is shared by every fragment packet a
// `FragmentShader::shadeFragments` call processes and None of its borrow-checking
// exists in C++ to object. The direct, borrow-checker-shaped equivalent would need a
// different value threaded through every call for each output array, which is not what
// upstream's shape is; this keeps the raw pointers (`*mut`/`*const`), matching C++ bit
// for bit, and marks every function that dereferences them `unsafe fn` - the same
// caller obligation upstream places on its own callers silently.

use super::fragment_packet::FragmentPacket;
use super::generic_vector::GenericVec4;
use super::render_state::FaceType;
use crate::tcu::vector::Vector;

/// `rr::FragmentShadingContext`
///
/// Contains per-primitive information used in fragment shading.
pub struct FragmentShadingContext {
    /// Vertex shader outputs. Entry will be null if there is no such vertex (a point
    /// has only `[0]`, a line only `[0]`/`[1]`).
    pub varyings: [*const GenericVec4; 3],
    /// Fragment output array.
    pub output_array: *mut GenericVec4,
    /// Fragment output array for source 1 (dual-source blending).
    pub output_array_src1: *mut GenericVec4,
    /// Geometry shader output.
    pub primitive_id: i32,
    /// Fragment output count.
    pub num_fragment_outputs: i32,
    /// Number of samples.
    pub num_samples: i32,
    /// Fragment packet depths. Null if there is no depth buffer. Each sample has a
    /// per-sample depth value.
    pub fragment_depths: *mut f32,
    /// Which face (front or back) is visible.
    pub visible_face: FaceType,
}

impl FragmentShadingContext {
    #[allow(clippy::too_many_arguments)]
    pub fn new(
        varying0: *const GenericVec4,
        varying1: *const GenericVec4,
        varying2: *const GenericVec4,
        output_array: *mut GenericVec4,
        output_array_src1: *mut GenericVec4,
        fragment_depths: *mut f32,
        primitive_id: i32,
        num_fragment_outputs: i32,
        num_samples: i32,
        visible_face: FaceType,
    ) -> Self {
        Self {
            varyings: [varying0, varying1, varying2],
            output_array,
            output_array_src1,
            primitive_id,
            num_fragment_outputs,
            num_samples,
            fragment_depths,
            visible_face,
        }
    }
}

/// `writeFragmentOutput<T>`
///
/// # Safety
/// `context.output_array` must point to at least `num_fragment_outputs * 4 *
/// (packet_ndx + 1)` valid `GenericVec4` slots.
pub unsafe fn write_fragment_output(
    context: &FragmentShadingContext,
    packet_ndx: i32,
    frag_ndx: i32,
    output_ndx: i32,
    value: GenericVec4,
) {
    debug_assert!(packet_ndx >= 0);
    debug_assert!((0..4).contains(&frag_ndx));
    debug_assert!((0..context.num_fragment_outputs).contains(&output_ndx));

    let index = (output_ndx + context.num_fragment_outputs * (frag_ndx + packet_ndx * 4)) as isize;
    unsafe { *context.output_array.offset(index) = value };
}

/// `writeFragmentOutputDualSource<T>`
///
/// # Safety
/// Same as [`write_fragment_output`], additionally for `context.output_array_src1`.
pub unsafe fn write_fragment_output_dual_source(
    context: &FragmentShadingContext,
    packet_ndx: i32,
    frag_ndx: i32,
    output_ndx: i32,
    value: GenericVec4,
    value1: GenericVec4,
) {
    debug_assert!(packet_ndx >= 0);
    debug_assert!((0..4).contains(&frag_ndx));
    debug_assert!((0..context.num_fragment_outputs).contains(&output_ndx));

    let index = (output_ndx + context.num_fragment_outputs * (frag_ndx + packet_ndx * 4)) as isize;
    unsafe {
        *context.output_array.offset(index) = value;
        *context.output_array_src1.offset(index) = value1;
    }
}

/// `readPointVarying<T>` - returns the raw `GenericVec4` bits; the caller reinterprets
/// via `get_float`/`get_int`/`get_uint` exactly like upstream's `get<T>()`.
///
/// # Safety
/// `context.varyings[0]` must be non-null and point at least `varying_loc + 1`
/// `GenericVec4`s.
unsafe fn read_point_varying(context: &FragmentShadingContext, varying_loc: i32) -> GenericVec4 {
    unsafe { *context.varyings[0].offset(varying_loc as isize) }
}

/// `readLineVarying<T>`
///
/// # Safety
/// `context.varyings[0]`/`[1]` must be non-null and point at least `varying_loc + 1`
/// `GenericVec4`s each.
unsafe fn read_line_varying(
    packet: &FragmentPacket,
    context: &FragmentShadingContext,
    varying_loc: i32,
    frag_ndx: usize,
) -> Vector<f32, 4> {
    let v0 = unsafe { (*context.varyings[0].offset(varying_loc as isize)).get_float() };
    let v1 = unsafe { (*context.varyings[1].offset(varying_loc as isize)).get_float() };
    v0 * packet.barycentric[0][frag_ndx] + v1 * packet.barycentric[1][frag_ndx]
}

/// `readTriangleVarying<T>`
///
/// # Safety
/// `context.varyings[0]`/`[1]`/`[2]` must be non-null and point at least
/// `varying_loc + 1` `GenericVec4`s each.
unsafe fn read_triangle_varying(
    packet: &FragmentPacket,
    context: &FragmentShadingContext,
    varying_loc: i32,
    frag_ndx: usize,
) -> Vector<f32, 4> {
    let v0 = unsafe { (*context.varyings[0].offset(varying_loc as isize)).get_float() };
    let v1 = unsafe { (*context.varyings[1].offset(varying_loc as isize)).get_float() };
    let v2 = unsafe { (*context.varyings[2].offset(varying_loc as isize)).get_float() };
    v0 * packet.barycentric[0][frag_ndx] + v1 * packet.barycentric[1][frag_ndx] + v2 * packet.barycentric[2][frag_ndx]
}

/// `readVarying<T>` - dispatches on how many of `varyings[1]`/`[2]` are present,
/// exactly like upstream's null-pointer check.
///
/// # Safety
/// See the per-arity readers above.
pub unsafe fn read_varying(
    packet: &FragmentPacket,
    context: &FragmentShadingContext,
    varying_loc: i32,
    frag_ndx: usize,
) -> Vector<f32, 4> {
    if context.varyings[1].is_null() {
        unsafe { read_point_varying(context, varying_loc).get_float() }
    } else if context.varyings[2].is_null() {
        unsafe { read_line_varying(packet, context, varying_loc, frag_ndx) }
    } else {
        unsafe { read_triangle_varying(packet, context, varying_loc, frag_ndx) }
    }
}

/// `dFdxLocal<T, Size>`
fn dfdx_local(func: [Vector<f32, 4>; 4]) -> [Vector<f32, 4>; 4] {
    let dfdx = [func[1] - func[0], func[3] - func[2]];
    [dfdx[0], dfdx[0], dfdx[1], dfdx[1]]
}

/// `dFdyLocal<T, Size>`
fn dfdy_local(func: [Vector<f32, 4>; 4]) -> [Vector<f32, 4>; 4] {
    let dfdy = [func[2] - func[0], func[3] - func[1]];
    [dfdy[0], dfdy[1], dfdy[0], dfdy[1]]
}

/// `dFdxVarying<T>`
///
/// # Safety
/// See [`read_varying`].
pub unsafe fn dfdx_varying(
    packet: &FragmentPacket,
    context: &FragmentShadingContext,
    varying_loc: i32,
) -> [Vector<f32, 4>; 4] {
    let func = std::array::from_fn(|i| unsafe { read_varying(packet, context, varying_loc, i) });
    dfdx_local(func)
}

/// `dFdyVarying<T>`
///
/// # Safety
/// See [`read_varying`].
pub unsafe fn dfdy_varying(
    packet: &FragmentPacket,
    context: &FragmentShadingContext,
    varying_loc: i32,
) -> [Vector<f32, 4>; 4] {
    let func = std::array::from_fn(|i| unsafe { read_varying(packet, context, varying_loc, i) });
    dfdy_local(func)
}

/// `readFragmentDepth`
///
/// # Safety
/// `context.fragment_depths` must be non-null and point at enough `f32`s for the
/// given `packet_ndx`/`frag_ndx`/`sample_ndx`.
pub unsafe fn read_fragment_depth(
    context: &FragmentShadingContext,
    packet_ndx: i32,
    frag_ndx: i32,
    sample_ndx: i32,
) -> f32 {
    debug_assert!(!context.fragment_depths.is_null());
    let index = ((packet_ndx * 4 + frag_ndx) * context.num_samples + sample_ndx) as isize;
    unsafe { *context.fragment_depths.offset(index) }
}

/// `writeFragmentDepth`
///
/// # Safety
/// See [`read_fragment_depth`].
pub unsafe fn write_fragment_depth(
    context: &FragmentShadingContext,
    packet_ndx: i32,
    frag_ndx: i32,
    sample_ndx: i32,
    depth_value: f32,
) {
    debug_assert!(!context.fragment_depths.is_null());
    let index = ((packet_ndx * 4 + frag_ndx) * context.num_samples + sample_ndx) as isize;
    unsafe { *context.fragment_depths.offset(index) = depth_value };
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::tcu::vector::Vec4;

    #[test]
    fn write_then_read_output_round_trips() {
        let mut outputs = vec![GenericVec4::zero(); 4];
        let context = FragmentShadingContext::new(
            std::ptr::null(),
            std::ptr::null(),
            std::ptr::null(),
            outputs.as_mut_ptr(),
            std::ptr::null_mut(),
            std::ptr::null_mut(),
            0,
            1,
            1,
            FaceType::Front,
        );
        let value = GenericVec4::from_float(Vec4::new(1.0, 2.0, 3.0, 4.0));
        unsafe { write_fragment_output(&context, 0, 2, 0, value) };
        assert_eq!(outputs[2].get_float().x(), 1.0);
    }

    #[test]
    fn triangle_varying_is_barycentric_blend() {
        let varyings = [
            GenericVec4::from_float(Vec4::new(10.0, 0.0, 0.0, 0.0)),
            GenericVec4::from_float(Vec4::new(0.0, 0.0, 0.0, 0.0)),
            GenericVec4::from_float(Vec4::new(0.0, 0.0, 0.0, 0.0)),
        ];
        let mut outputs = vec![GenericVec4::zero(); 1];
        let context = FragmentShadingContext::new(
            &varyings[0],
            &varyings[1],
            &varyings[2],
            outputs.as_mut_ptr(),
            std::ptr::null_mut(),
            std::ptr::null_mut(),
            0,
            1,
            1,
            FaceType::Front,
        );
        let packet = FragmentPacket {
            position: crate::tcu::vector::IVec2::new(0, 0),
            coverage: 0,
            barycentric: [Vec4::splat(1.0), Vec4::splat(0.0), Vec4::splat(0.0)],
        };
        let v = unsafe { read_varying(&packet, &context, 0, 0) };
        assert_eq!(v.x(), 10.0);
    }

    #[test]
    fn dfdx_matches_hand_computed_difference() {
        let func = [
            Vector::<f32, 4>::splat(1.0),
            Vector::<f32, 4>::splat(3.0),
            Vector::<f32, 4>::splat(5.0),
            Vector::<f32, 4>::splat(9.0),
        ];
        let out = dfdx_local(func);
        assert_eq!(out[0].x(), 2.0); // func[1]-func[0]
        assert_eq!(out[2].x(), 4.0); // func[3]-func[2]
    }
}
