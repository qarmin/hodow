use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_loongarch64_lasx_lasx_xvmod_b() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvmod_b(0 /* m256i */, 0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvmod_b(0 /* m256i */, 0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvmod_h() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvmod_h(0 /* m256i */, 0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvmod_h(0 /* m256i */, 0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvmod_w() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvmod_w(0 /* m256i */, 0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvmod_w(0 /* m256i */, 0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvmod_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvmod_d(0 /* m256i */, 0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvmod_d(0 /* m256i */, 0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvmod_bu() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvmod_bu(0 /* m256i */, 0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvmod_bu(0 /* m256i */, 0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvmod_hu() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvmod_hu(0 /* m256i */, 0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvmod_hu(0 /* m256i */, 0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvmod_wu() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvmod_wu(0 /* m256i */, 0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvmod_wu(0 /* m256i */, 0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvmod_du() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvmod_du(0 /* m256i */, 0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvmod_du(0 /* m256i */, 0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}
