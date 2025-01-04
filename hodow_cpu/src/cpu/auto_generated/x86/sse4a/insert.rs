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

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_insert_si64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_insert_si64(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result[..2], &[5, 2, 0, 0][..2]).map_err(|e| crate::cpu::with_call(e, "_mm_insert_si64(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_insert_si64(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse4a_mm_insert_si64() -> Result<Verdict, String> {
    unsafe { test_x86_sse4a_mm_insert_si64_impl() }
}
