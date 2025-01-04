use std::arch::powerpc::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_powerpc_altivec_vec_cmpge() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_cmpge(0 /* vector_float */, 0 /* vector_float */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_cmpge(0 /* vector_float */, 0 /* vector_float */);
        });
        Ok(Verdict::Unverified(None))
    }
}
