use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_s390x_vector_vec_rli() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_rli(0 /* T */, 0 /* c_ulong */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_rli(0 /* T */, 0 /* c_ulong */);
        });
        Ok(Verdict::Unverified(None))
    }
}
