#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sse3")]
fn test_x86_sse3_mm_lddqu_si128_impl() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([create__m128i_from_i32_array([1, 2, 3, 4]); 4]);
        let result = unpack__m128i_to_i32_array(_mm_lddqu_si128(ptr_mem_addr.0.as_ptr()));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: _mm_lddqu_si128(ptr_mem_addr.0.as_ptr())"))?;
    }
    Ok(())
}

pub(super) fn test_x86_sse3_mm_lddqu_si128() -> Result<(), String> {
    unsafe { test_x86_sse3_mm_lddqu_si128_impl() }
}
