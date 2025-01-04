use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_loongarch64_lsx_lsx_vreplve_b() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vreplve_b(0 /* m128i */, 1i32));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vreplve_b(0 /* m128i */, rand::random::<i32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vreplve_h() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vreplve_h(0 /* m128i */, 1i32));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vreplve_h(0 /* m128i */, rand::random::<i32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vreplve_w() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vreplve_w(0 /* m128i */, 1i32));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vreplve_w(0 /* m128i */, rand::random::<i32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vreplve_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vreplve_d(0 /* m128i */, 1i32));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vreplve_d(0 /* m128i */, rand::random::<i32>());
        });
        Ok(Verdict::Unverified(None))
    }
}
