use std::arch::powerpc::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_powerpc_altivec_vec_perm() -> Result<Verdict, String> {
    unsafe {
        vec_perm(0 /* T */, 0 /* T */, 0 /* vector_unsigned_char */);

        crate::cpu::fuzz(&mut || {
            vec_perm(0 /* T */, 0 /* T */, 0 /* vector_unsigned_char */);
        });
        Ok(Verdict::Unverified(None))
    }
}
