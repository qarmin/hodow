use std::arch::powerpc::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_powerpc_altivec_vec_mradds() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_mradds(0 /* vector_signed_short */, 0 /* vector_signed_short */, 0 /* vector_signed_short */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_mradds(0 /* vector_signed_short */, 0 /* vector_signed_short */, 0 /* vector_signed_short */);
        });
        Ok(Verdict::Unverified(None))
    }
}
