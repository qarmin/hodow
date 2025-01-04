use std::arch::wasm32::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_wasm32_simd128_f64x2() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f64x2(1.0f64, 2.0f64));

        crate::cpu::fuzz(&mut || {
            let _ = f64x2(rand::random::<f64>(), rand::random::<f64>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f64x2_extract_lane() -> Result<Verdict, String> {
    unsafe {
        let result = f64x2_extract_lane::<0>(0 /* v128 */);

        crate::cpu::fuzz(&mut || {
            let _ = f64x2_extract_lane::<0>(0 /* v128 */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_wasm32_simd128_f64x2_replace_lane() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f64x2_replace_lane::<0>(0 /* v128 */, 1.0f64));

        crate::cpu::fuzz(&mut || {
            let _ = f64x2_replace_lane::<0>(0 /* v128 */, rand::random::<f64>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f64x2_splat() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f64x2_splat(1.0f64));

        crate::cpu::fuzz(&mut || {
            let _ = f64x2_splat(rand::random::<f64>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f64x2_eq() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f64x2_eq(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f64x2_eq(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f64x2_ne() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f64x2_ne(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f64x2_ne(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f64x2_lt() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f64x2_lt(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f64x2_lt(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f64x2_gt() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f64x2_gt(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f64x2_gt(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f64x2_le() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f64x2_le(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f64x2_le(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f64x2_ge() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f64x2_ge(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f64x2_ge(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f64x2_ceil() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f64x2_ceil(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f64x2_ceil(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f64x2_floor() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f64x2_floor(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f64x2_floor(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f64x2_trunc() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f64x2_trunc(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f64x2_trunc(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f64x2_nearest() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f64x2_nearest(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f64x2_nearest(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f64x2_abs() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f64x2_abs(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f64x2_abs(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f64x2_neg() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f64x2_neg(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f64x2_neg(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f64x2_sqrt() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f64x2_sqrt(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f64x2_sqrt(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f64x2_add() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f64x2_add(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f64x2_add(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f64x2_sub() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f64x2_sub(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f64x2_sub(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f64x2_mul() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f64x2_mul(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f64x2_mul(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f64x2_div() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f64x2_div(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f64x2_div(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f64x2_min() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f64x2_min(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f64x2_min(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f64x2_max() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f64x2_max(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f64x2_max(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f64x2_pmin() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f64x2_pmin(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f64x2_pmin(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f64x2_pmax() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f64x2_pmax(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f64x2_pmax(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f64x2_convert_low_i32x4() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f64x2_convert_low_i32x4(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f64x2_convert_low_i32x4(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f64x2_convert_low_u32x4() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f64x2_convert_low_u32x4(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f64x2_convert_low_u32x4(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f64x2_promote_low_f32x4() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f64x2_promote_low_f32x4(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f64x2_promote_low_f32x4(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}
