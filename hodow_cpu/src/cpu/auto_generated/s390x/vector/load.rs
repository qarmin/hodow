use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_s390x_vector_vec_load_pair() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_load_pair(0 /* ElementType */, 0 /* ElementType */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_load_pair(0 /* ElementType */, 0 /* ElementType */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_s390x_vector_vec_load_bndry() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_load_bndry::<0>(0 /* ElementType */));

        crate::cpu::fuzz(&mut || {
            let _ = vec_load_bndry::<0>(0 /* ElementType */);
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_s390x_vector_vec_load_len() -> Result<Verdict, String> {
    unsafe {
        let _result = core::hint::black_box(vec_load_len(0 /* ElementType */, 1u32));

        crate::cpu::fuzz(&mut || {
            let _ = vec_load_len(0 /* ElementType */, rand::random::<u32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_s390x_vector_vec_load_len_r() -> Result<Verdict, String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let byte_count = 2u32;
        let _result = core::hint::black_box(vec_load_len_r(ptr_ptr.0.as_ptr(), byte_count));
        Ok(Verdict::Unverified(None))
    }
}
