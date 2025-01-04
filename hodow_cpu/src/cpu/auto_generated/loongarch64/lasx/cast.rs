use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_loongarch64_lasx_lasx_cast_128_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_cast_128_s(0 /* m128 */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_cast_128_s(0 /* m128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_cast_128_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_cast_128_d(0 /* m128d */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_cast_128_d(0 /* m128d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_cast_128() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_cast_128(0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_cast_128(0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}
