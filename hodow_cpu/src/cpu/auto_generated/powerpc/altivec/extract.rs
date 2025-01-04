use std::arch::powerpc::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_powerpc_altivec_vec_extract() -> Result<Verdict, String> {
    unsafe {
        vec_extract::<0>(0 /* T */);

        crate::cpu::fuzz(&mut || {
            vec_extract::<0>(0 /* T */);
        });
        Ok(Verdict::Unverified(None))
    }
}
