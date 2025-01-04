use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_s390x_vector_vec_search_string_cc() -> Result<Verdict, String> {
    unsafe {
        vec_search_string_cc(0 /* T */, 0 /* T */, 0 /* vector_unsigned_char */);

        crate::cpu::fuzz(&mut || {
            vec_search_string_cc(0 /* T */, 0 /* T */, 0 /* vector_unsigned_char */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_s390x_vector_vec_search_string_until_zero_cc() -> Result<Verdict, String> {
    unsafe {
        vec_search_string_until_zero_cc(0 /* T */, 0 /* T */, 0 /* vector_unsigned_char */);

        crate::cpu::fuzz(&mut || {
            vec_search_string_until_zero_cc(0 /* T */, 0 /* T */, 0 /* vector_unsigned_char */);
        });
        Ok(Verdict::Unverified(None))
    }
}
