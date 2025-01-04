use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_s390x_vector_vec_xst() -> Result<Verdict, String> {
    unsafe {
        vec_xst(0 /* T */, 0 /* isize */, 0 /* ElementType */);

        crate::cpu::fuzz(&mut || {
            vec_xst(0 /* T */, 0 /* isize */, 0 /* ElementType */);
        });
        Ok(Verdict::Unverified(None))
    }
}
