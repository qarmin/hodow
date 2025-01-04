use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_s390x_vector_vec_cmpne() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_cmpne(0 /* T */, 0 /* T */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_cmpne(0 /* T */, 0 /* T */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_s390x_vector_vec_cmpne_idx() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_cmpne_idx(0 /* T */, 0 /* T */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_cmpne_idx(0 /* T */, 0 /* T */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_s390x_vector_vec_cmpne_idx_cc() -> Result<Verdict, String> {
    unsafe {
        vec_cmpne_idx_cc(0 /* T */, 0 /* T */);

        crate::cpu::fuzz(&mut || {
            vec_cmpne_idx_cc(0 /* T */, 0 /* T */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_s390x_vector_vec_cmpne_or_0_idx() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_cmpne_or_0_idx(0 /* T */, 0 /* T */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_cmpne_or_0_idx(0 /* T */, 0 /* T */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_s390x_vector_vec_cmpne_or_0_idx_cc() -> Result<Verdict, String> {
    unsafe {
        vec_cmpne_or_0_idx_cc(0 /* T */, 0 /* T */);

        crate::cpu::fuzz(&mut || {
            vec_cmpne_or_0_idx_cc(0 /* T */, 0 /* T */);
        });
        Ok(Verdict::Unverified(None))
    }
}
