use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_s390x_vector_vec_store_len() -> Result<Verdict, String> {
    unsafe {
        vec_store_len(0 /* T */, 0 /* ElementType */, 1u32);

        crate::cpu::fuzz(&mut || {
            vec_store_len(0 /* T */, 0 /* ElementType */, rand::random::<u32>());
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_s390x_vector_vec_store_len_r() -> Result<Verdict, String> {
    unsafe {
        let vector = 0 /* vector_unsigned_char */;
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let byte_count = 2u32;
        vec_store_len_r(vector, ptr_ptr.0.as_mut_ptr(), byte_count);
        let _ = core::hint::black_box(&mut ptr_ptr);
        let result = core::ptr::read(ptr_ptr.0.as_ptr().cast::<[u8; 64]>());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
