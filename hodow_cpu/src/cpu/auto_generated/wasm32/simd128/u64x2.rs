use std::arch::wasm32::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_wasm32_simd128_u64x2() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u64x2(1u64, 2u64));

        crate::cpu::fuzz(&mut || {
            let _ = u64x2(rand::random::<u64>(), rand::random::<u64>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u64x2_extract_lane() -> Result<Verdict, String> {
    unsafe {
        let result = u64x2_extract_lane::<0>(0 /* v128 */);

        crate::cpu::fuzz(&mut || {
            let _ = u64x2_extract_lane::<0>(0 /* v128 */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_wasm32_simd128_u64x2_replace_lane() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u64x2_replace_lane::<0>(0 /* v128 */, 1u64));

        crate::cpu::fuzz(&mut || {
            let _ = u64x2_replace_lane::<0>(0 /* v128 */, rand::random::<u64>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u64x2_splat() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u64x2_splat(1u64));

        crate::cpu::fuzz(&mut || {
            let _ = u64x2_splat(rand::random::<u64>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_u64x2_shr() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(u64x2_shr(0 /* v128 */, 1u32));

        crate::cpu::fuzz(&mut || {
            let _ = u64x2_shr(0 /* v128 */, rand::random::<u32>());
        });
        Ok(Verdict::Unverified(None))
    }
}
