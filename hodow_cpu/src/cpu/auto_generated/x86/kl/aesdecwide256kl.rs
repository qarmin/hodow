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

#[target_feature(enable = "kl")]
fn test_x86_kl_mm_aesdecwide256kl_u8_impl() -> Result<Verdict, String> {
        if !(crate::cpu::common::x86::keylocker_usable()) {
            return Ok(Verdict::Skipped("widekl not present"));
        }
    unsafe {
        let mut ptr_output = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let ptr_input = crate::cpu::common::Aligned64([create__m128i_from_i32_array([5, 6, 7, 8]); 4]);
        let ptr_handle = crate::cpu::common::Aligned64([9u8; 64]);
        let result = _mm_aesdecwide256kl_u8(ptr_output.0.as_mut_ptr(), ptr_input.0.as_ptr(), ptr_handle.0.as_ptr());
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_kl_mm_aesdecwide256kl_u8() -> Result<Verdict, String> {
    unsafe { test_x86_kl_mm_aesdecwide256kl_u8_impl() }
}
