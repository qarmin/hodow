use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_s390x_vector_vec_perm() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_perm(0 /* T */, 0 /* T */, 0 /* vector_unsigned_char */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_perm(0 /* T */, 0 /* T */, 0 /* vector_unsigned_char */);
        });
        Ok(Verdict::Unverified(None))
    }
}
