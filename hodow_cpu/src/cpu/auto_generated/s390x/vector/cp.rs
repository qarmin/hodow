use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_s390x_vector_vec_cp_until_zero() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_cp_until_zero(0 /* T */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_cp_until_zero(0 /* T */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_s390x_vector_vec_cp_until_zero_cc() -> Result<Verdict, String> {
    unsafe {
        vec_cp_until_zero_cc(0 /* T */);

        crate::cpu::fuzz(&mut || {
            vec_cp_until_zero_cc(0 /* T */);
        });
        Ok(Verdict::Unverified(None))
    }
}
