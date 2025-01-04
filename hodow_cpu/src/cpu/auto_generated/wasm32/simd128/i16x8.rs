use std::arch::wasm32::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_wasm32_simd128_i16x8_load_extend_i8x8() -> Result<Verdict, String> {
    unsafe {
        let ptr_m = crate::cpu::common::Aligned64([1i8; 64]);
        let _result = core::hint::black_box(i16x8_load_extend_i8x8(ptr_m.0.as_ptr()));
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_load_extend_u8x8() -> Result<Verdict, String> {
    unsafe {
        let ptr_m = crate::cpu::common::Aligned64([1u8; 64]);
        let _result = core::hint::black_box(i16x8_load_extend_u8x8(ptr_m.0.as_ptr()));
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i16x8() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8(1i16, 2i16, 3i16, 4i16, 5i16, 6i16, 7i16, 8i16));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8(rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_shuffle() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8_shuffle::<0, 0, 0, 0, 0, 0, 0, 0>(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_shuffle::<0, 0, 0, 0, 0, 0, 0, 0>(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_extract_lane() -> Result<Verdict, String> {
    unsafe {
        let result = i16x8_extract_lane::<0>(0 /* v128 */);

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_extract_lane::<0>(0 /* v128 */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_replace_lane() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8_replace_lane::<0>(0 /* v128 */, 1i16));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_replace_lane::<0>(0 /* v128 */, rand::random::<i16>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_splat() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8_splat(1i16));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_splat(rand::random::<i16>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_eq() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8_eq(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_eq(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_ne() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8_ne(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_ne(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_lt() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8_lt(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_lt(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_gt() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8_gt(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_gt(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_le() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8_le(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_le(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_ge() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8_ge(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_ge(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_extadd_pairwise_i8x16() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8_extadd_pairwise_i8x16(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_extadd_pairwise_i8x16(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_extadd_pairwise_u8x16() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8_extadd_pairwise_u8x16(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_extadd_pairwise_u8x16(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_abs() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8_abs(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_abs(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_neg() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8_neg(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_neg(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_q15mulr_sat() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8_q15mulr_sat(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_q15mulr_sat(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_all_true() -> Result<Verdict, String> {
    unsafe {
        let result = i16x8_all_true(0 /* v128 */);

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_all_true(0 /* v128 */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_bitmask() -> Result<Verdict, String> {
    unsafe {
        let result = i16x8_bitmask(0 /* v128 */);

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_bitmask(0 /* v128 */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_narrow_i32x4() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8_narrow_i32x4(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_narrow_i32x4(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_extend_low_i8x16() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8_extend_low_i8x16(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_extend_low_i8x16(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_extend_high_i8x16() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8_extend_high_i8x16(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_extend_high_i8x16(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_extend_low_u8x16() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8_extend_low_u8x16(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_extend_low_u8x16(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_extend_high_u8x16() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8_extend_high_u8x16(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_extend_high_u8x16(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_shl() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8_shl(0 /* v128 */, 1u32));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_shl(0 /* v128 */, rand::random::<u32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_shr() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8_shr(0 /* v128 */, 1u32));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_shr(0 /* v128 */, rand::random::<u32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_add() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8_add(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_add(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_add_sat() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8_add_sat(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_add_sat(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_sub() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8_sub(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_sub(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_sub_sat() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8_sub_sat(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_sub_sat(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_mul() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8_mul(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_mul(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_min() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8_min(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_min(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_max() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8_max(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_max(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_extmul_low_i8x16() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8_extmul_low_i8x16(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_extmul_low_i8x16(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_extmul_high_i8x16() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8_extmul_high_i8x16(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_extmul_high_i8x16(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_extmul_low_u8x16() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8_extmul_low_u8x16(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_extmul_low_u8x16(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i16x8_extmul_high_u8x16() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i16x8_extmul_high_u8x16(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i16x8_extmul_high_u8x16(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}
