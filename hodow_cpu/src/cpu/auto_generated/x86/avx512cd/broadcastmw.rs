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

#[target_feature(enable = "avx512cd")]
fn test_x86_avx512cd_mm512_broadcastmw_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_broadcastmw_epi32(create__mmask16_from(0b0101010101010101)));
        check_array_equality(&result, &[21845, 21845, 21845, 21845, 21845, 21845, 21845, 21845, 21845, 21845, 21845, 21845, 21845, 21845, 21845, 21845]).map_err(|e| crate::cpu::with_call(e, "_mm512_broadcastmw_epi32(create__mmask16_from(0b0101010101010101))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_broadcastmw_epi32(create_random__mmask16());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512cd_mm512_broadcastmw_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512cd_mm512_broadcastmw_epi32_impl() }
}

#[target_feature(enable = "avx512cd")]
fn test_x86_avx512cd_mm256_broadcastmw_epi32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_broadcastmw_epi32(create__mmask16_from(0b0101010101010101)));
        check_array_equality(&result, &[21845, 21845, 21845, 21845, 21845, 21845, 21845, 21845]).map_err(|e| crate::cpu::with_call(e, "_mm256_broadcastmw_epi32(create__mmask16_from(0b0101010101010101))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_broadcastmw_epi32(create_random__mmask16());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512cd_mm256_broadcastmw_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512cd_mm256_broadcastmw_epi32_impl() }
}

#[target_feature(enable = "avx512cd")]
fn test_x86_avx512cd_mm_broadcastmw_epi32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_broadcastmw_epi32(create__mmask16_from(0b0101010101010101)));
        check_array_equality(&result, &[21845, 21845, 21845, 21845]).map_err(|e| crate::cpu::with_call(e, "_mm_broadcastmw_epi32(create__mmask16_from(0b0101010101010101))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_broadcastmw_epi32(create_random__mmask16());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512cd_mm_broadcastmw_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512cd_mm_broadcastmw_epi32_impl() }
}
