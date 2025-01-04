use std::arch::wasm32::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_wasm32_simd128_i64x2_load_extend_i32x2() -> Result<Verdict, String> {
    unsafe {
        let ptr_m = crate::cpu::common::Aligned64([1i32; 16]);
        let _result = core::hint::black_box(i64x2_load_extend_i32x2(ptr_m.0.as_ptr()));
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i64x2_load_extend_u32x2() -> Result<Verdict, String> {
    unsafe {
        let ptr_m = crate::cpu::common::Aligned64([1u32; 16]);
        let _result = core::hint::black_box(i64x2_load_extend_u32x2(ptr_m.0.as_ptr()));
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i64x2() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i64x2(1i64, 2i64));

        crate::cpu::fuzz(&mut || {
            let _ = i64x2(rand::random::<i64>(), rand::random::<i64>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i64x2_shuffle() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i64x2_shuffle::<0, 0>(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i64x2_shuffle::<0, 0>(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i64x2_extract_lane() -> Result<Verdict, String> {
    unsafe {
        let result = i64x2_extract_lane::<0>(0 /* v128 */);

        crate::cpu::fuzz(&mut || {
            let _ = i64x2_extract_lane::<0>(0 /* v128 */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_wasm32_simd128_i64x2_replace_lane() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i64x2_replace_lane::<0>(0 /* v128 */, 1i64));

        crate::cpu::fuzz(&mut || {
            let _ = i64x2_replace_lane::<0>(0 /* v128 */, rand::random::<i64>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i64x2_splat() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i64x2_splat(1i64));

        crate::cpu::fuzz(&mut || {
            let _ = i64x2_splat(rand::random::<i64>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i64x2_eq() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i64x2_eq(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i64x2_eq(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i64x2_ne() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i64x2_ne(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i64x2_ne(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i64x2_lt() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i64x2_lt(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i64x2_lt(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i64x2_gt() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i64x2_gt(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i64x2_gt(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i64x2_le() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i64x2_le(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i64x2_le(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i64x2_ge() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i64x2_ge(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i64x2_ge(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i64x2_abs() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i64x2_abs(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i64x2_abs(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i64x2_neg() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i64x2_neg(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i64x2_neg(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i64x2_all_true() -> Result<Verdict, String> {
    unsafe {
        let result = i64x2_all_true(0 /* v128 */);

        crate::cpu::fuzz(&mut || {
            let _ = i64x2_all_true(0 /* v128 */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_wasm32_simd128_i64x2_bitmask() -> Result<Verdict, String> {
    unsafe {
        let result = i64x2_bitmask(0 /* v128 */);

        crate::cpu::fuzz(&mut || {
            let _ = i64x2_bitmask(0 /* v128 */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_wasm32_simd128_i64x2_extend_low_i32x4() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i64x2_extend_low_i32x4(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i64x2_extend_low_i32x4(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i64x2_extend_high_i32x4() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i64x2_extend_high_i32x4(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i64x2_extend_high_i32x4(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i64x2_extend_low_u32x4() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i64x2_extend_low_u32x4(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i64x2_extend_low_u32x4(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i64x2_extend_high_u32x4() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i64x2_extend_high_u32x4(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i64x2_extend_high_u32x4(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i64x2_shl() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i64x2_shl(0 /* v128 */, 1u32));

        crate::cpu::fuzz(&mut || {
            let _ = i64x2_shl(0 /* v128 */, rand::random::<u32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i64x2_shr() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i64x2_shr(0 /* v128 */, 1u32));

        crate::cpu::fuzz(&mut || {
            let _ = i64x2_shr(0 /* v128 */, rand::random::<u32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i64x2_add() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i64x2_add(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i64x2_add(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i64x2_sub() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i64x2_sub(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i64x2_sub(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i64x2_mul() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i64x2_mul(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i64x2_mul(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i64x2_extmul_low_i32x4() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i64x2_extmul_low_i32x4(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i64x2_extmul_low_i32x4(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i64x2_extmul_high_i32x4() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i64x2_extmul_high_i32x4(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i64x2_extmul_high_i32x4(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i64x2_extmul_low_u32x4() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i64x2_extmul_low_u32x4(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i64x2_extmul_low_u32x4(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_i64x2_extmul_high_u32x4() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(i64x2_extmul_high_u32x4(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = i64x2_extmul_high_u32x4(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}
