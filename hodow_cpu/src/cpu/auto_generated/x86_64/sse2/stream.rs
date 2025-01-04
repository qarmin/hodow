use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_stream_si64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = 2i64;
        _mm_stream_si64(ptr_mem_addr.0.as_mut_ptr(), a);
        let _ = core::hint::black_box(&mut ptr_mem_addr);
        let result = core::ptr::read(ptr_mem_addr.0.as_ptr().cast::<[i64; 8]>());
        check_array_equality(&result, &[2, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_stream_si64(ptr_mem_addr.0.as_mut_ptr(), a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_stream_si64() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_stream_si64_impl() }
}
