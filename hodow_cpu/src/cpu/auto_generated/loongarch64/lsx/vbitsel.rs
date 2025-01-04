use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_loongarch64_lsx_lsx_vbitsel_v() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vbitsel_v(0 /* m128i */, 0 /* m128i */, 0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vbitsel_v(0 /* m128i */, 0 /* m128i */, 0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}
