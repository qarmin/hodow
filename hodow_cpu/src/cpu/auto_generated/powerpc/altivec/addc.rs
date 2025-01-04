use std::arch::powerpc::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_powerpc_altivec_vec_addc() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_addc(0 /* vector_unsigned_int */, 0 /* vector_unsigned_int */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_addc(0 /* vector_unsigned_int */, 0 /* vector_unsigned_int */);
        });
        Ok(Verdict::Unverified(None))
    }
}
