use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_s390x_vector_vec_round() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_round(0 /* T */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_round(0 /* T */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_s390x_vector_vec_round_from_fp32() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_round_from_fp32::<0>(0 /* vector_float */, 0 /* vector_float */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_round_from_fp32::<0>(0 /* vector_float */, 0 /* vector_float */);
        });
        Ok(Verdict::Unverified(None))
    }
}
