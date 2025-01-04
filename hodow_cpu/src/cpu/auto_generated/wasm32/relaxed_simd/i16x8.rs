use std::arch::wasm32::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_wasm32_relaxed_simd_i16x8_relaxed_laneselect() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8_relaxed_laneselect(0 /* v128 */, 0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_relaxed_laneselect(0 /* v128 */, 0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_relaxed_simd_i16x8_relaxed_q15mulr() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8_relaxed_q15mulr(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_relaxed_q15mulr(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_relaxed_simd_i16x8_relaxed_dot_i8x16_i7x16() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8_relaxed_dot_i8x16_i7x16(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_relaxed_dot_i8x16_i7x16(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}
