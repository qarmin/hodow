use std::arch::wasm32::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_wasm32_relaxed_simd_i32x4_relaxed_trunc_f32x4() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4_relaxed_trunc_f32x4(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_relaxed_trunc_f32x4(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_relaxed_simd_i32x4_relaxed_trunc_f64x2_zero() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4_relaxed_trunc_f64x2_zero(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_relaxed_trunc_f64x2_zero(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_relaxed_simd_i32x4_relaxed_laneselect() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4_relaxed_laneselect(0 /* v128 */, 0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_relaxed_laneselect(0 /* v128 */, 0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_relaxed_simd_i32x4_relaxed_dot_i8x16_i7x16_add() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4_relaxed_dot_i8x16_i7x16_add(0 /* v128 */, 0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_relaxed_dot_i8x16_i7x16_add(0 /* v128 */, 0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}
