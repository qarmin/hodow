use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_s390x_vector_vec_extend_s64() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_extend_s64(0 /* VectorExtendSigned64 */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_extend_s64(0 /* VectorExtendSigned64 */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_s390x_vector_vec_extend_to_fp32_hi() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_extend_to_fp32_hi::<0>(0 /* vector_signed_short */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_extend_to_fp32_hi::<0>(0 /* vector_signed_short */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_s390x_vector_vec_extend_to_fp32_lo() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_extend_to_fp32_lo::<0>(0 /* vector_signed_short */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_extend_to_fp32_lo::<0>(0 /* vector_signed_short */);
        });
        Ok(Verdict::Unverified(None))
    }
}
