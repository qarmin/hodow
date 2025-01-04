use std::arch::wasm32::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_wasm32_simd128_u32x4() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u32x4(1u32, 2u32, 3u32, 4u32));

        crate::cpu::fuzz(&mut || {
            let _ = u32x4(rand::random::<u32>(), rand::random::<u32>(), rand::random::<u32>(), rand::random::<u32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u32x4_extract_lane() -> Result<Verdict, String> {
    unsafe {
        let result = u32x4_extract_lane::<0>(0 /* v128 */);

        crate::cpu::fuzz(&mut || {
            let _ = u32x4_extract_lane::<0>(0 /* v128 */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_wasm32_simd128_u32x4_replace_lane() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u32x4_replace_lane::<0>(0 /* v128 */, 1u32));

        crate::cpu::fuzz(&mut || {
            let _ = u32x4_replace_lane::<0>(0 /* v128 */, rand::random::<u32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u32x4_splat() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u32x4_splat(1u32));

        crate::cpu::fuzz(&mut || {
            let _ = u32x4_splat(rand::random::<u32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u32x4_lt() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u32x4_lt(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = u32x4_lt(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u32x4_gt() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u32x4_gt(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = u32x4_gt(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u32x4_le() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u32x4_le(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = u32x4_le(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u32x4_ge() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u32x4_ge(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = u32x4_ge(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u32x4_shr() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u32x4_shr(0 /* v128 */, 1u32));

        crate::cpu::fuzz(&mut || {
            let _ = u32x4_shr(0 /* v128 */, rand::random::<u32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u32x4_min() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u32x4_min(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = u32x4_min(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u32x4_max() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u32x4_max(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = u32x4_max(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u32x4_trunc_sat_f32x4() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u32x4_trunc_sat_f32x4(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = u32x4_trunc_sat_f32x4(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u32x4_trunc_sat_f64x2_zero() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u32x4_trunc_sat_f64x2_zero(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = u32x4_trunc_sat_f64x2_zero(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}
