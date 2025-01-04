use std::arch::powerpc::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_powerpc_altivec_vec_neg() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_neg(0 /* T */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_neg(0 /* T */);
        });
        Ok(Verdict::Unverified(None))
    }
}
