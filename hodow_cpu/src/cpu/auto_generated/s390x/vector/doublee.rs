use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_s390x_vector_vec_doublee() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_doublee(0 /* vector_float */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_doublee(0 /* vector_float */);
        });
        Ok(Verdict::Unverified(None))
    }
}
