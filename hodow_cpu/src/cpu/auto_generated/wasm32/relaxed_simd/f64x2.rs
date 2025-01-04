use std::arch::wasm32::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_wasm32_relaxed_simd_f64x2_relaxed_madd() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f64x2_relaxed_madd(0 /* v128 */, 0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f64x2_relaxed_madd(0 /* v128 */, 0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_relaxed_simd_f64x2_relaxed_nmadd() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f64x2_relaxed_nmadd(0 /* v128 */, 0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f64x2_relaxed_nmadd(0 /* v128 */, 0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_relaxed_simd_f64x2_relaxed_min() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f64x2_relaxed_min(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f64x2_relaxed_min(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_relaxed_simd_f64x2_relaxed_max() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f64x2_relaxed_max(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f64x2_relaxed_max(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}
