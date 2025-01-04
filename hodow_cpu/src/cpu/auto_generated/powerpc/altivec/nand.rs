use std::arch::powerpc::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_powerpc_altivec_vec_nand() -> Result<Verdict, String> {
    unsafe {
        vec_nand(0 /* T */, 0 /* U */);

        crate::cpu::fuzz(&mut || {
            vec_nand(0 /* T */, 0 /* U */);
        });
        Ok(Verdict::Unverified(None))
    }
}
