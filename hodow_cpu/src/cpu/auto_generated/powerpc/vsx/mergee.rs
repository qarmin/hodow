use std::arch::powerpc::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_powerpc_vsx_vec_mergee() -> Result<Verdict, String> {
    unsafe {
        vec_mergee(0 /* T */, 0 /* T */);

        crate::cpu::fuzz(&mut || {
            vec_mergee(0 /* T */, 0 /* T */);
        });
        Ok(Verdict::Unverified(None))
    }
}
