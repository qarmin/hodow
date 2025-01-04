use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_loongarch64_lasx_lasx_insert_128_lo_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_insert_128_lo_s(0 /* m256 */, 0 /* m128 */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_insert_128_lo_s(0 /* m256 */, 0 /* m128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_insert_128_hi_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_insert_128_hi_s(0 /* m256 */, 0 /* m128 */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_insert_128_hi_s(0 /* m256 */, 0 /* m128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_insert_128_lo_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_insert_128_lo_d(0 /* m256d */, 0 /* m128d */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_insert_128_lo_d(0 /* m256d */, 0 /* m128d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_insert_128_hi_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_insert_128_hi_d(0 /* m256d */, 0 /* m128d */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_insert_128_hi_d(0 /* m256d */, 0 /* m128d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_insert_128_lo() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_insert_128_lo(0 /* m256i */, 0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_insert_128_lo(0 /* m256i */, 0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_insert_128_hi() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_insert_128_hi(0 /* m256i */, 0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_insert_128_hi(0 /* m256i */, 0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}
