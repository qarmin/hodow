use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_s390x_vector_vec_insert() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_insert(0 /* ElementType */, 0 /* T */, 1i32));

        crate::cpu::fuzz(&mut || {
            let _ = vec_insert(0 /* ElementType */, 0 /* T */, rand::random::<i32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_s390x_vector_vec_insert_and_zero() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_insert_and_zero(0 /* ElementType */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_insert_and_zero(0 /* ElementType */);
        });
        Ok(Verdict::Unverified(None))
    }
}
