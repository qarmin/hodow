use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_loongarch64_lsx_lsx_vmskltz_b() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vmskltz_b(0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vmskltz_b(0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vmskltz_h() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vmskltz_h(0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vmskltz_h(0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vmskltz_w() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vmskltz_w(0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vmskltz_w(0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vmskltz_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vmskltz_d(0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vmskltz_d(0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}
