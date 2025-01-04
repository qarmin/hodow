use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_s390x_vector_vcelfb() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vcelfb(0 /* vector_unsigned_int */));

        crate::cpu::fuzz(&mut || {
            let _ = vcelfb(0 /* vector_unsigned_int */);
        });
        Ok(Verdict::Unverified(None))
    }
}
