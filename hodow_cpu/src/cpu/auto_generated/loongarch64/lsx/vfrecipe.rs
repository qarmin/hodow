use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_loongarch64_lsx_lsx_vfrecipe_s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfrecipe_s(0 /* m128 */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfrecipe_s(0 /* m128 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_loongarch64_lsx_lsx_vfrecipe_d() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vfrecipe_d(0 /* m128d */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vfrecipe_d(0 /* m128d */);
        });
        Ok(Verdict::Unverified(None))
    }
}
