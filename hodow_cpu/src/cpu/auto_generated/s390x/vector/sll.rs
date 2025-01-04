use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_s390x_vector_vec_sll() -> Result<Verdict, String> {
    unsafe {
        vec_sll(0 /* T */, 0 /* vector_unsigned_char */);

        crate::cpu::fuzz(&mut || {
            vec_sll(0 /* T */, 0 /* vector_unsigned_char */);
        });
        Ok(Verdict::Unverified(None))
    }
}
