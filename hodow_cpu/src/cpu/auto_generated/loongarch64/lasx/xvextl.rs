use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_loongarch64_lasx_lasx_xvextl_qu_du() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvextl_qu_du(0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvextl_qu_du(0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvextl_q_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvextl_q_d(0 /* m256i */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvextl_q_d(0 /* m256i */);
        });
        Ok(Verdict::Unverified(None))
    }
}
