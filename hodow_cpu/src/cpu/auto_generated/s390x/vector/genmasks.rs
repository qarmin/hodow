use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_s390x_vector_vec_genmasks_8() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_genmasks_8::<3, 5>());

        crate::cpu::fuzz(&mut || {
            let _ = vec_genmasks_8::<3, 5>();
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_s390x_vector_vec_genmasks_16() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_genmasks_16::<3, 5>());

        crate::cpu::fuzz(&mut || {
            let _ = vec_genmasks_16::<3, 5>();
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_s390x_vector_vec_genmasks_32() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_genmasks_32::<3, 5>());

        crate::cpu::fuzz(&mut || {
            let _ = vec_genmasks_32::<3, 5>();
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_s390x_vector_vec_genmasks_64() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_genmasks_64::<3, 5>());

        crate::cpu::fuzz(&mut || {
            let _ = vec_genmasks_64::<3, 5>();
        });
        Ok(Verdict::Unverified(None))
    }
}
