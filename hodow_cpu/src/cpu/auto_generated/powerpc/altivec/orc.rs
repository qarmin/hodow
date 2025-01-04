use std::arch::powerpc::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_powerpc_altivec_vec_orc() -> Result<Verdict, String> {
    unsafe {
        vec_orc(0 /* T */, 0 /* U */);

        crate::cpu::fuzz(&mut || {
            vec_orc(0 /* T */, 0 /* U */);
        });
        Ok(Verdict::Unverified(None))
    }
}
