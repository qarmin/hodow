use std::arch::powerpc::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_powerpc_altivec_vec_sum2s() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_sum2s(0 /* vector_signed_int */, 0 /* vector_signed_int */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_sum2s(0 /* vector_signed_int */, 0 /* vector_signed_int */);
        });
        Ok(Verdict::Unverified(None))
    }
}
