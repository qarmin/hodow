use std::arch::powerpc::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_powerpc_altivec_vec_xst() -> Result<Verdict, String> {
    unsafe {
        vec_xst(0 /* T */, 0 /* isize */, 0 /* Out */);

        crate::cpu::fuzz(&mut || {
            vec_xst(0 /* T */, 0 /* isize */, 0 /* Out */);
        });
        Ok(Verdict::Unverified(None))
    }
}
