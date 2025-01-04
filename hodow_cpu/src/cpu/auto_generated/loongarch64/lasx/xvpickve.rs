use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_loongarch64_lasx_lasx_xvpickve_w() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvpickve_w::<0>(0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvpickve_w::<0>(0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvpickve_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvpickve_d::<0>(0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvpickve_d::<0>(0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvpickve_d_f() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvpickve_d_f::<0>(0 /* m256d */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvpickve_d_f::<0>(0 /* m256d */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvpickve_w_f() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvpickve_w_f::<0>(0 /* m256 */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvpickve_w_f::<0>(0 /* m256 */);
        });
        Ok(Verdict::Unverified(None))
    }
}
