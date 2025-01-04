use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_s390x_vector_vec_promote() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_promote(0 /* ElementType */, 1i32));

        crate::cpu::fuzz(&mut || {
            let _ = vec_promote(0 /* ElementType */, rand::random::<i32>());
        });
        Ok(Verdict::Unverified(None))
    }
}
