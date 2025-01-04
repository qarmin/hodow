use std::arch::wasm32::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_wasm32_simd128_i8x16() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i8x16(1i8, 2i8, 3i8, 4i8, 5i8, 6i8, 7i8, 8i8, 9i8, 10i8, 11i8, 12i8, 13i8, 14i8, 15i8, 16i8));

        crate::cpu::fuzz(&mut || {
            let _ = i8x16(rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i8x16_shuffle() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i8x16_shuffle::<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i8x16_shuffle::<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i8x16_extract_lane() -> Result<Verdict, String> {
    unsafe {
        let result = i8x16_extract_lane::<0>(0 /* v128 */);

        crate::cpu::fuzz(&mut || {
            let _ = i8x16_extract_lane::<0>(0 /* v128 */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_wasm32_simd128_i8x16_replace_lane() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i8x16_replace_lane::<0>(0 /* v128 */, 1i8));

        crate::cpu::fuzz(&mut || {
            let _ = i8x16_replace_lane::<0>(0 /* v128 */, rand::random::<i8>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i8x16_swizzle() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i8x16_swizzle(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i8x16_swizzle(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i8x16_splat() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i8x16_splat(1i8));

        crate::cpu::fuzz(&mut || {
            let _ = i8x16_splat(rand::random::<i8>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i8x16_eq() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i8x16_eq(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i8x16_eq(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i8x16_ne() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i8x16_ne(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i8x16_ne(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i8x16_lt() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i8x16_lt(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i8x16_lt(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i8x16_gt() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i8x16_gt(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i8x16_gt(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i8x16_le() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i8x16_le(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i8x16_le(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i8x16_ge() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i8x16_ge(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i8x16_ge(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i8x16_abs() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i8x16_abs(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i8x16_abs(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i8x16_neg() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i8x16_neg(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i8x16_neg(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i8x16_popcnt() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i8x16_popcnt(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i8x16_popcnt(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i8x16_all_true() -> Result<Verdict, String> {
    unsafe {
        let result = i8x16_all_true(0 /* v128 */);

        crate::cpu::fuzz(&mut || {
            let _ = i8x16_all_true(0 /* v128 */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_wasm32_simd128_i8x16_bitmask() -> Result<Verdict, String> {
    unsafe {
        let result = i8x16_bitmask(0 /* v128 */);

        crate::cpu::fuzz(&mut || {
            let _ = i8x16_bitmask(0 /* v128 */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_wasm32_simd128_i8x16_narrow_i16x8() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i8x16_narrow_i16x8(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i8x16_narrow_i16x8(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i8x16_shl() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i8x16_shl(0 /* v128 */, 1u32));

        crate::cpu::fuzz(&mut || {
            let _ = i8x16_shl(0 /* v128 */, rand::random::<u32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i8x16_shr() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i8x16_shr(0 /* v128 */, 1u32));

        crate::cpu::fuzz(&mut || {
            let _ = i8x16_shr(0 /* v128 */, rand::random::<u32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i8x16_add() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i8x16_add(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i8x16_add(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i8x16_add_sat() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i8x16_add_sat(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i8x16_add_sat(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i8x16_sub() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i8x16_sub(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i8x16_sub(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i8x16_sub_sat() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i8x16_sub_sat(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i8x16_sub_sat(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i8x16_min() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i8x16_min(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i8x16_min(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i8x16_max() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i8x16_max(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i8x16_max(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}
