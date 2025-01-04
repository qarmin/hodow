use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_loongarch64_lasx_lasx_xbz_b() -> Result<Verdict, String> {
    unsafe {
        let result = lasx_xbz_b(0 /* m256i */);

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xbz_b(0 /* m256i */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xbz_d() -> Result<Verdict, String> {
    unsafe {
        let result = lasx_xbz_d(0 /* m256i */);

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xbz_d(0 /* m256i */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xbz_h() -> Result<Verdict, String> {
    unsafe {
        let result = lasx_xbz_h(0 /* m256i */);

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xbz_h(0 /* m256i */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xbz_v() -> Result<Verdict, String> {
    unsafe {
        let result = lasx_xbz_v(0 /* m256i */);

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xbz_v(0 /* m256i */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xbz_w() -> Result<Verdict, String> {
    unsafe {
        let result = lasx_xbz_w(0 /* m256i */);

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xbz_w(0 /* m256i */);
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
