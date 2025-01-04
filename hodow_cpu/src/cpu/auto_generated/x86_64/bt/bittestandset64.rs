use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_x86_64_bt_bittestandset64() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1i64; 8]);
        let b = 2i64;
        let ret_value = _bittestandset64(ptr_p.0.as_mut_ptr(), b);
        let _ = core::hint::black_box(&mut ptr_p);
        let out_p = core::ptr::read(ptr_p.0.as_ptr().cast::<[i64; 8]>());
        let result = (ret_value, out_p);
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
