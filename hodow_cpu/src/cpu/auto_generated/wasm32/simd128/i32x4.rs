use std::arch::wasm32::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_wasm32_simd128_i32x4_load_extend_i16x4() -> Result<Verdict, String> {
    unsafe {
        let ptr_m = crate::cpu::common::Aligned64([1i16; 32]);
        let _result = core::hint::black_box(i32x4_load_extend_i16x4(ptr_m.0.as_ptr()));
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i32x4_load_extend_u16x4() -> Result<Verdict, String> {
    unsafe {
        let ptr_m = crate::cpu::common::Aligned64([1u16; 32]);
        let _result = core::hint::black_box(i32x4_load_extend_u16x4(ptr_m.0.as_ptr()));
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i32x4() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4(1i32, 2i32, 3i32, 4i32));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4(rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i32x4_shuffle() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4_shuffle::<0, 0, 0, 0>(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_shuffle::<0, 0, 0, 0>(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i32x4_extract_lane() -> Result<Verdict, String> {
    unsafe {
        let result = i32x4_extract_lane::<0>(0 /* v128 */);

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_extract_lane::<0>(0 /* v128 */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_wasm32_simd128_i32x4_replace_lane() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4_replace_lane::<0>(0 /* v128 */, 1i32));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_replace_lane::<0>(0 /* v128 */, rand::random::<i32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i32x4_splat() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4_splat(1i32));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_splat(rand::random::<i32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i32x4_eq() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4_eq(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_eq(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i32x4_ne() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4_ne(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_ne(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i32x4_lt() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4_lt(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_lt(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i32x4_gt() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4_gt(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_gt(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i32x4_le() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4_le(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_le(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i32x4_ge() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4_ge(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_ge(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i32x4_extadd_pairwise_i16x8() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4_extadd_pairwise_i16x8(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_extadd_pairwise_i16x8(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i32x4_extadd_pairwise_u16x8() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4_extadd_pairwise_u16x8(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_extadd_pairwise_u16x8(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i32x4_abs() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4_abs(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_abs(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i32x4_neg() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4_neg(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_neg(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i32x4_all_true() -> Result<Verdict, String> {
    unsafe {
        let result = i32x4_all_true(0 /* v128 */);

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_all_true(0 /* v128 */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_wasm32_simd128_i32x4_bitmask() -> Result<Verdict, String> {
    unsafe {
        let result = i32x4_bitmask(0 /* v128 */);

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_bitmask(0 /* v128 */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_wasm32_simd128_i32x4_extend_low_i16x8() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4_extend_low_i16x8(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_extend_low_i16x8(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i32x4_extend_high_i16x8() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4_extend_high_i16x8(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_extend_high_i16x8(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i32x4_extend_low_u16x8() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4_extend_low_u16x8(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_extend_low_u16x8(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i32x4_extend_high_u16x8() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4_extend_high_u16x8(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_extend_high_u16x8(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i32x4_shl() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4_shl(0 /* v128 */, 1u32));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_shl(0 /* v128 */, rand::random::<u32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i32x4_shr() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4_shr(0 /* v128 */, 1u32));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_shr(0 /* v128 */, rand::random::<u32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i32x4_add() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4_add(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_add(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i32x4_sub() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4_sub(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_sub(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i32x4_mul() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4_mul(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_mul(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i32x4_min() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4_min(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_min(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i32x4_max() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4_max(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_max(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i32x4_dot_i16x8() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4_dot_i16x8(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_dot_i16x8(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i32x4_extmul_low_i16x8() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4_extmul_low_i16x8(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_extmul_low_i16x8(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i32x4_extmul_high_i16x8() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4_extmul_high_i16x8(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_extmul_high_i16x8(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i32x4_extmul_low_u16x8() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4_extmul_low_u16x8(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_extmul_low_u16x8(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i32x4_extmul_high_u16x8() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4_extmul_high_u16x8(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_extmul_high_u16x8(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i32x4_trunc_sat_f32x4() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4_trunc_sat_f32x4(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_trunc_sat_f32x4(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i32x4_trunc_sat_f64x2_zero() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i32x4_trunc_sat_f64x2_zero(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i32x4_trunc_sat_f64x2_zero(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}
