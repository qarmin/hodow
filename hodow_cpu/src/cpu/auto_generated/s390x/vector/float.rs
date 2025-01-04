use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_s390x_vector_vec_float() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_float(0 /* VectorFloat */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_float(0 /* VectorFloat */);
        });
        Ok(Verdict::Unverified(None))
    }
}
