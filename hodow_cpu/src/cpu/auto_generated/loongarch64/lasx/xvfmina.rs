use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_loongarch64_lasx_lasx_xvfmina_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfmina_s(0 /* m256 */, 0 /* m256 */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfmina_s(0 /* m256 */, 0 /* m256 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lasx_lasx_xvfmina_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lasx_xvfmina_d(0 /* m256d */, 0 /* m256d */));

        crate::cpu::fuzz(&mut || {
            let _ = lasx_xvfmina_d(0 /* m256d */, 0 /* m256d */);
        });
        Ok(Verdict::Unverified(None))
    }
}
