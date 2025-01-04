use std::arch::wasm32::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_wasm32_simd128_u8x16() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u8x16(1u8, 2u8, 3u8, 4u8, 5u8, 6u8, 7u8, 8u8, 9u8, 10u8, 11u8, 12u8, 13u8, 14u8, 15u8, 16u8));

        crate::cpu::fuzz(&mut || {
            let _ = u8x16(rand::random::<u8>(), rand::random::<u8>(), rand::random::<u8>(), rand::random::<u8>(), rand::random::<u8>(), rand::random::<u8>(), rand::random::<u8>(), rand::random::<u8>(), rand::random::<u8>(), rand::random::<u8>(), rand::random::<u8>(), rand::random::<u8>(), rand::random::<u8>(), rand::random::<u8>(), rand::random::<u8>(), rand::random::<u8>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u8x16_extract_lane() -> Result<Verdict, String> {
    unsafe {
        let result = u8x16_extract_lane::<0>(0 /* v128 */);

        crate::cpu::fuzz(&mut || {
            let _ = u8x16_extract_lane::<0>(0 /* v128 */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_wasm32_simd128_u8x16_replace_lane() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u8x16_replace_lane::<0>(0 /* v128 */, 1u8));

        crate::cpu::fuzz(&mut || {
            let _ = u8x16_replace_lane::<0>(0 /* v128 */, rand::random::<u8>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u8x16_splat() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u8x16_splat(1u8));

        crate::cpu::fuzz(&mut || {
            let _ = u8x16_splat(rand::random::<u8>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u8x16_lt() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u8x16_lt(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = u8x16_lt(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u8x16_gt() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u8x16_gt(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = u8x16_gt(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u8x16_le() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u8x16_le(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = u8x16_le(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u8x16_ge() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u8x16_ge(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = u8x16_ge(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u8x16_narrow_i16x8() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u8x16_narrow_i16x8(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = u8x16_narrow_i16x8(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u8x16_shr() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u8x16_shr(0 /* v128 */, 1u32));

        crate::cpu::fuzz(&mut || {
            let _ = u8x16_shr(0 /* v128 */, rand::random::<u32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u8x16_add_sat() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u8x16_add_sat(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = u8x16_add_sat(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u8x16_sub_sat() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u8x16_sub_sat(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = u8x16_sub_sat(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u8x16_min() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u8x16_min(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = u8x16_min(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u8x16_max() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u8x16_max(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = u8x16_max(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u8x16_avgr() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u8x16_avgr(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = u8x16_avgr(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}
