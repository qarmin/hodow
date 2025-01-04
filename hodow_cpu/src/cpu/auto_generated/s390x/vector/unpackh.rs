use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_s390x_vector_vec_unpackh() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_unpackh(0 /* T */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_unpackh(0 /* T */);
        });
        Ok(Verdict::Unverified(None))
    }
}
