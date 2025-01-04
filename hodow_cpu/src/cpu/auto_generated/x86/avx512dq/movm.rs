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
fn test_x86_avx512dq_mm_movm_epi32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_movm_epi32(create__mmask8_from(0b01010101)));
        check_array_equality(&result, &[-1, 0, -1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_movm_epi32(create__mmask8_from(0b01010101))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_movm_epi32(create_random__mmask8());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_movm_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_movm_epi32_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_movm_epi32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_movm_epi32(create__mmask8_from(0b01010101)));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_movm_epi32(create__mmask8_from(0b01010101))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_movm_epi32(create_random__mmask8());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_movm_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_movm_epi32_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_movm_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_movm_epi32(create__mmask16_from(0b0101010101010101)));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_movm_epi32(create__mmask16_from(0b0101010101010101))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_movm_epi32(create_random__mmask16());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_movm_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_movm_epi32_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm_movm_epi64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_movm_epi64(create__mmask8_from(0b01010101)));
        check_array_equality(&result, &[-1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_movm_epi64(create__mmask8_from(0b01010101))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_movm_epi64(create_random__mmask8());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm_movm_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm_movm_epi64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm256_movm_epi64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_movm_epi64(create__mmask8_from(0b01010101)));
        check_array_equality(&result, &[-1, 0, -1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_movm_epi64(create__mmask8_from(0b01010101))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_movm_epi64(create_random__mmask8());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm256_movm_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm256_movm_epi64_impl() }
}

#[target_feature(enable = "avx512dq")]
fn test_x86_avx512dq_mm512_movm_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_movm_epi64(create__mmask8_from(0b01010101)));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_movm_epi64(create__mmask8_from(0b01010101))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_movm_epi64(create_random__mmask8());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512dq_mm512_movm_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512dq_mm512_movm_epi64_impl() }
}
