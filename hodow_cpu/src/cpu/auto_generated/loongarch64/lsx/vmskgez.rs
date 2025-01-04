use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_loongarch64_lsx_lsx_vmskgez_b() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(lsx_vmskgez_b(0 /* m128i */));

        crate::cpu::fuzz(&mut || {
            let _ = lsx_vmskgez_b(0 /* m128i */);
        });
        Ok(Verdict::Unverified(None))
    }
}
