use std::arch::powerpc::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_powerpc_altivec_vec_vsel() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_vsel(0 /* vector_signed_char */, 0 /* vector_signed_char */, 0 /* vector_signed_char */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_vsel(0 /* vector_signed_char */, 0 /* vector_signed_char */, 0 /* vector_signed_char */);
        });
        Ok(Verdict::Unverified(None))
    }
}
