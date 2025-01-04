use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_s390x_vector_vec_fp_test_data_class() -> Result<Verdict, String> {
    unsafe {
        let a = 0 /* T */;
        let mut ptr_c = crate::cpu::common::Aligned64([1i32; 16]);
        let _result = core::hint::black_box(vec_fp_test_data_class::<0>(a, ptr_c.0.as_mut_ptr()));
        let _ = core::hint::black_box(&mut ptr_c);
        let result = core::ptr::read(ptr_c.0.as_ptr().cast::<[i32; 16]>());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
