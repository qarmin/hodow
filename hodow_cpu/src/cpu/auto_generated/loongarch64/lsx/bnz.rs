use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_loongarch64_lsx_lsx_bnz_b() -> Result<Verdict, String> {
    unsafe {
        let result = lsx_bnz_b(0 /* m128i */);

        crate::cpu::fuzz(&mut || {
            let _ = lsx_bnz_b(0 /* m128i */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_bnz_d() -> Result<Verdict, String> {
    unsafe {
        let result = lsx_bnz_d(0 /* m128i */);

        crate::cpu::fuzz(&mut || {
            let _ = lsx_bnz_d(0 /* m128i */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_bnz_h() -> Result<Verdict, String> {
    unsafe {
        let result = lsx_bnz_h(0 /* m128i */);

        crate::cpu::fuzz(&mut || {
            let _ = lsx_bnz_h(0 /* m128i */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_bnz_v() -> Result<Verdict, String> {
    unsafe {
        let result = lsx_bnz_v(0 /* m128i */);

        crate::cpu::fuzz(&mut || {
            let _ = lsx_bnz_v(0 /* m128i */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_bnz_w() -> Result<Verdict, String> {
    unsafe {
        let result = lsx_bnz_w(0 /* m128i */);

        crate::cpu::fuzz(&mut || {
            let _ = lsx_bnz_w(0 /* m128i */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
