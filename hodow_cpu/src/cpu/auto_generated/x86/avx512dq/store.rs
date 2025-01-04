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

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_store_mask8_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([create__mmask8_from(0b01010101); 64]);
        let a = create__mmask8_from(0b01010101);
        _store_mask8(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[u8; 64]>());
        check_array_equality(&result, &[85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85, 85]).map_err(|e| crate::cpu::with_call(e, "_store_mask8(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_store_mask8() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_store_mask8_impl() }
}
