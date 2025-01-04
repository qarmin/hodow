use std::arch::wasm32::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_wasm32_simd128_f32x4() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f32x4(1.0f32, 2.0f32, 3.0f32, 4.0f32));

        crate::cpu::fuzz(&mut || {
            let _ = f32x4(rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f32x4_extract_lane() -> Result<Verdict, String> {
    unsafe {
        let result = f32x4_extract_lane::<0>(0 /* v128 */);

        crate::cpu::fuzz(&mut || {
            let _ = f32x4_extract_lane::<0>(0 /* v128 */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_wasm32_simd128_f32x4_replace_lane() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f32x4_replace_lane::<0>(0 /* v128 */, 1.0f32));

        crate::cpu::fuzz(&mut || {
            let _ = f32x4_replace_lane::<0>(0 /* v128 */, rand::random::<f32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f32x4_splat() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f32x4_splat(1.0f32));

        crate::cpu::fuzz(&mut || {
            let _ = f32x4_splat(rand::random::<f32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f32x4_eq() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f32x4_eq(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f32x4_eq(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f32x4_ne() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f32x4_ne(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f32x4_ne(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f32x4_lt() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f32x4_lt(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f32x4_lt(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f32x4_gt() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f32x4_gt(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f32x4_gt(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f32x4_le() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f32x4_le(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f32x4_le(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f32x4_ge() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f32x4_ge(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f32x4_ge(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f32x4_ceil() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f32x4_ceil(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f32x4_ceil(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f32x4_floor() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f32x4_floor(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f32x4_floor(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f32x4_trunc() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f32x4_trunc(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f32x4_trunc(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f32x4_nearest() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f32x4_nearest(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f32x4_nearest(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f32x4_abs() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f32x4_abs(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f32x4_abs(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f32x4_neg() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f32x4_neg(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f32x4_neg(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f32x4_sqrt() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f32x4_sqrt(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f32x4_sqrt(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f32x4_add() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f32x4_add(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f32x4_add(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f32x4_sub() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f32x4_sub(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f32x4_sub(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f32x4_mul() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f32x4_mul(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f32x4_mul(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f32x4_div() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f32x4_div(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f32x4_div(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f32x4_min() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f32x4_min(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f32x4_min(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f32x4_max() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f32x4_max(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f32x4_max(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f32x4_pmin() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f32x4_pmin(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f32x4_pmin(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f32x4_pmax() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f32x4_pmax(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f32x4_pmax(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f32x4_convert_i32x4() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f32x4_convert_i32x4(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f32x4_convert_i32x4(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f32x4_convert_u32x4() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f32x4_convert_u32x4(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f32x4_convert_u32x4(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_f32x4_demote_f64x2_zero() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(f32x4_demote_f64x2_zero(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = f32x4_demote_f64x2_zero(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}
