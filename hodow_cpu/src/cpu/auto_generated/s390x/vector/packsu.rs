use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_s390x_vector_vec_packsu() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_packsu(0 /* T */, 0 /* U */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_packsu(0 /* T */, 0 /* U */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_s390x_vector_vec_packsu_cc() -> Result<Verdict, String> {
    unsafe {
        vec_packsu_cc(0 /* T */, 0 /* T */);

        crate::cpu::fuzz(&mut || {
            vec_packsu_cc(0 /* T */, 0 /* T */);
        });
        Ok(Verdict::Unverified(None))
    }
}
