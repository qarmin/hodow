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

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_cvtps_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtps_epi32(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtps_epi32(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtps_epi32(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_cvtps_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_cvtps_epi32_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_cvtps_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtps_pd(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtps_pd(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtps_pd(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_cvtps_pd() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_cvtps_pd_impl() }
}
