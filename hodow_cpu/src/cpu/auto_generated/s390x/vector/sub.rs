use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_s390x_vector_vec_sub() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_sub(0 /* T */, 0 /* U */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_sub(0 /* T */, 0 /* U */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_s390x_vector_vec_sub_u128() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_sub_u128(0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_sub_u128(0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */);
        });
        Ok(Verdict::Unverified(None))
    }
}
