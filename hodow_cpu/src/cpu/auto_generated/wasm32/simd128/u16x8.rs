use std::arch::wasm32::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_wasm32_simd128_u16x8() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u16x8(1u16, 2u16, 3u16, 4u16, 5u16, 6u16, 7u16, 8u16));

        crate::cpu::fuzz(&mut || {
            let _ = u16x8(rand::random::<u16>(), rand::random::<u16>(), rand::random::<u16>(), rand::random::<u16>(), rand::random::<u16>(), rand::random::<u16>(), rand::random::<u16>(), rand::random::<u16>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u16x8_extract_lane() -> Result<Verdict, String> {
    unsafe {
        let result = u16x8_extract_lane::<0>(0 /* v128 */);

        crate::cpu::fuzz(&mut || {
            let _ = u16x8_extract_lane::<0>(0 /* v128 */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_wasm32_simd128_u16x8_replace_lane() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u16x8_replace_lane::<0>(0 /* v128 */, 1u16));

        crate::cpu::fuzz(&mut || {
            let _ = u16x8_replace_lane::<0>(0 /* v128 */, rand::random::<u16>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u16x8_splat() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u16x8_splat(1u16));

        crate::cpu::fuzz(&mut || {
            let _ = u16x8_splat(rand::random::<u16>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u16x8_lt() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u16x8_lt(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = u16x8_lt(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u16x8_gt() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u16x8_gt(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = u16x8_gt(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u16x8_le() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u16x8_le(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = u16x8_le(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u16x8_ge() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u16x8_ge(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = u16x8_ge(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u16x8_narrow_i32x4() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u16x8_narrow_i32x4(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = u16x8_narrow_i32x4(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u16x8_shr() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u16x8_shr(0 /* v128 */, 1u32));

        crate::cpu::fuzz(&mut || {
            let _ = u16x8_shr(0 /* v128 */, rand::random::<u32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u16x8_add_sat() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u16x8_add_sat(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = u16x8_add_sat(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u16x8_sub_sat() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u16x8_sub_sat(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = u16x8_sub_sat(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u16x8_min() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u16x8_min(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = u16x8_min(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u16x8_max() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u16x8_max(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = u16x8_max(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u16x8_avgr() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u16x8_avgr(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = u16x8_avgr(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}
