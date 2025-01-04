#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_x86_bt_bittestandset() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_p = crate::cpu::common::Aligned64([1i32; 16]);
        let b = 2i32;
        let ret_value = _bittestandset(ptr_p.0.as_mut_ptr(), b);
        let _ = core::hint::black_box(&mut ptr_p);
        let out_p = core::ptr::read(ptr_p.0.as_ptr().cast::<[i32; 16]>());
        let result = (ret_value, out_p);
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
