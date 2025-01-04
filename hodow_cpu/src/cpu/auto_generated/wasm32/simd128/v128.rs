use std::arch::wasm32::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_wasm32_simd128_v128_load() -> Result<Verdict, String> {
    unsafe {
        let ptr_m = crate::cpu::common::Aligned64([0 /* v128 */; 64]);
        let _result = core::hint::black_box(v128_load(ptr_m.0.as_ptr()));
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_v128_load8_splat() -> Result<Verdict, String> {
    unsafe {
        let ptr_m = crate::cpu::common::Aligned64([1u8; 64]);
        let _result = core::hint::black_box(v128_load8_splat(ptr_m.0.as_ptr()));
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_v128_load16_splat() -> Result<Verdict, String> {
    unsafe {
        let ptr_m = crate::cpu::common::Aligned64([1u16; 32]);
        let _result = core::hint::black_box(v128_load16_splat(ptr_m.0.as_ptr()));
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_v128_load32_splat() -> Result<Verdict, String> {
    unsafe {
        let ptr_m = crate::cpu::common::Aligned64([1u32; 16]);
        let _result = core::hint::black_box(v128_load32_splat(ptr_m.0.as_ptr()));
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_v128_load64_splat() -> Result<Verdict, String> {
    unsafe {
        let ptr_m = crate::cpu::common::Aligned64([1u64; 8]);
        let _result = core::hint::black_box(v128_load64_splat(ptr_m.0.as_ptr()));
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_v128_load32_zero() -> Result<Verdict, String> {
    unsafe {
        let ptr_m = crate::cpu::common::Aligned64([1u32; 16]);
        let _result = core::hint::black_box(v128_load32_zero(ptr_m.0.as_ptr()));
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_v128_load64_zero() -> Result<Verdict, String> {
    unsafe {
        let ptr_m = crate::cpu::common::Aligned64([1u64; 8]);
        let _result = core::hint::black_box(v128_load64_zero(ptr_m.0.as_ptr()));
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_v128_store() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_m = crate::cpu::common::Aligned64([0 /* v128 */; 64]);
        let a = 0 /* v128 */;
        v128_store(ptr_m.0.as_mut_ptr(), a);
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_v128_load8_lane() -> Result<Verdict, String> {
    unsafe {
        let v = 0 /* v128 */;
        let ptr_m = crate::cpu::common::Aligned64([1u8; 64]);
        let _result = core::hint::black_box(v128_load8_lane::<0>(v, ptr_m.0.as_ptr()));
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_v128_load16_lane() -> Result<Verdict, String> {
    unsafe {
        let v = 0 /* v128 */;
        let ptr_m = crate::cpu::common::Aligned64([1u16; 32]);
        let _result = core::hint::black_box(v128_load16_lane::<0>(v, ptr_m.0.as_ptr()));
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_v128_load32_lane() -> Result<Verdict, String> {
    unsafe {
        let v = 0 /* v128 */;
        let ptr_m = crate::cpu::common::Aligned64([1u32; 16]);
        let _result = core::hint::black_box(v128_load32_lane::<0>(v, ptr_m.0.as_ptr()));
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_v128_load64_lane() -> Result<Verdict, String> {
    unsafe {
        let v = 0 /* v128 */;
        let ptr_m = crate::cpu::common::Aligned64([1u64; 8]);
        let _result = core::hint::black_box(v128_load64_lane::<0>(v, ptr_m.0.as_ptr()));
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_v128_store8_lane() -> Result<Verdict, String> {
    unsafe {
        let v = 0 /* v128 */;
        let mut ptr_m = crate::cpu::common::Aligned64([1u8; 64]);
        v128_store8_lane::<0>(v, ptr_m.0.as_mut_ptr());
        let _ = core::hint::black_box(&mut ptr_m);
        let result = core::ptr::read(ptr_m.0.as_ptr().cast::<[u8; 64]>());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_wasm32_simd128_v128_store16_lane() -> Result<Verdict, String> {
    unsafe {
        let v = 0 /* v128 */;
        let mut ptr_m = crate::cpu::common::Aligned64([1u16; 32]);
        v128_store16_lane::<0>(v, ptr_m.0.as_mut_ptr());
        let _ = core::hint::black_box(&mut ptr_m);
        let result = core::ptr::read(ptr_m.0.as_ptr().cast::<[u16; 32]>());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_wasm32_simd128_v128_store32_lane() -> Result<Verdict, String> {
    unsafe {
        let v = 0 /* v128 */;
        let mut ptr_m = crate::cpu::common::Aligned64([1u32; 16]);
        v128_store32_lane::<0>(v, ptr_m.0.as_mut_ptr());
        let _ = core::hint::black_box(&mut ptr_m);
        let result = core::ptr::read(ptr_m.0.as_ptr().cast::<[u32; 16]>());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_wasm32_simd128_v128_store64_lane() -> Result<Verdict, String> {
    unsafe {
        let v = 0 /* v128 */;
        let mut ptr_m = crate::cpu::common::Aligned64([1u64; 8]);
        v128_store64_lane::<0>(v, ptr_m.0.as_mut_ptr());
        let _ = core::hint::black_box(&mut ptr_m);
        let result = core::ptr::read(ptr_m.0.as_ptr().cast::<[u64; 8]>());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_wasm32_simd128_v128_not() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(v128_not(0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = v128_not(0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_v128_and() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(v128_and(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = v128_and(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_v128_andnot() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(v128_andnot(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = v128_andnot(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_v128_or() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(v128_or(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = v128_or(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_v128_xor() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(v128_xor(0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = v128_xor(0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_v128_bitselect() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(v128_bitselect(0 /* v128 */, 0 /* v128 */, 0 /* v128 */));

        crate::cpu::fuzz(&mut || {
            let _ = v128_bitselect(0 /* v128 */, 0 /* v128 */, 0 /* v128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_wasm32_simd128_v128_any_true() -> Result<Verdict, String> {
    unsafe {
        let result = v128_any_true(0 /* v128 */);

        crate::cpu::fuzz(&mut || {
            let _ = v128_any_true(0 /* v128 */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
