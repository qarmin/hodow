use std::arch::powerpc64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_powerpc64_vsx_vec_xl_len() -> Result<Verdict, String> {
    unsafe {
        vec_xl_len(0 /* T */, 0usize);

        crate::cpu::fuzz(&mut || {
            vec_xl_len(0 /* T */, rand::random::<u64>() as usize);
        });
        Ok(Verdict::Unverified(None))
    }
}
