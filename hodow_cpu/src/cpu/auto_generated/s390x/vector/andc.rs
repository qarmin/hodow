use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_s390x_vector_vec_andc() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_andc(0 /* T */, 0 /* U */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_andc(0 /* T */, 0 /* U */);
        });
        Ok(Verdict::Unverified(None))
    }
}
