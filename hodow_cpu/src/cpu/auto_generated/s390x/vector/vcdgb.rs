use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_s390x_vector_vcdgb() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vcdgb(0 /* vector_signed_long_long */));

        crate::cpu::fuzz(&mut || {
            let _ = vcdgb(0 /* vector_signed_long_long */);
        });
        Ok(Verdict::Unverified(None))
    }
}
