use std::arch::powerpc64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_powerpc64_vsx_vec_xst_len() -> Result<Verdict, String> {
    unsafe {
        vec_xst_len(0 /* T */, 0 /* Out */, 0usize);

        crate::cpu::fuzz(&mut || {
            vec_xst_len(0 /* T */, 0 /* Out */, rand::random::<u64>() as usize);
        });
        Ok(Verdict::Unverified(None))
    }
}
