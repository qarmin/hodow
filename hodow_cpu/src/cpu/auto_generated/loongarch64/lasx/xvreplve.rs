use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_loongarch64_lasx_lasx_xvreplve_b() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvreplve_b(0 /* m256i */, 1i32));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvreplve_b(0 /* m256i */, rand::random::<i32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvreplve_h() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvreplve_h(0 /* m256i */, 1i32));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvreplve_h(0 /* m256i */, rand::random::<i32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvreplve_w() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvreplve_w(0 /* m256i */, 1i32));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvreplve_w(0 /* m256i */, rand::random::<i32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvreplve_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvreplve_d(0 /* m256i */, 1i32));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvreplve_d(0 /* m256i */, rand::random::<i32>());
        });
        Ok(Verdict::Unverified(None))
    }
}
