use std::arch::powerpc::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_powerpc_vsx_vec_xxpermdi() -> Result<Verdict, String> {
    unsafe {
        vec_xxpermdi::<0>(0 /* T */, 0 /* T */);

        crate::cpu::fuzz(&mut || {
            vec_xxpermdi::<0>(0 /* T */, 0 /* T */);
        });
        Ok(Verdict::Unverified(None))
    }
}
