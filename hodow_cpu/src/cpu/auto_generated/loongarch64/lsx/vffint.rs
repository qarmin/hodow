use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_loongarch64_lsx_lsx_vffint_s_w() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vffint_s_w(0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vffint_s_w(0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vffint_d_l() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vffint_d_l(0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vffint_d_l(0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vffint_s_wu() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vffint_s_wu(0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vffint_s_wu(0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vffint_d_lu() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vffint_d_lu(0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vffint_d_lu(0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vffint_s_l() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vffint_s_l(0 /* m128i */, 0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vffint_s_l(0 /* m128i */, 0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}
