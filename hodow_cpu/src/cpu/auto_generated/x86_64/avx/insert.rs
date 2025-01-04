use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

#[target_feature(enable = "avx")]
fn test_x86_64_avx_mm256_insert_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_insert_epi64::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i64));
        check_array_equality(&result, &[9, 17179869187, 25769803781, 34359738375]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi64::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi64::<0>(create_random__m256i(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx_mm256_insert_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx_mm256_insert_epi64_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_64_avx_mm256_insert_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_insert_epi64::<0>(create__m256i_from([0, -1, 2, -3]), 1i64));
        check_array_equality(&result, &[1, -1, 2, -3]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi64::<0>(create__m256i_from([0, -1, 2, -3]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi64::<0>(create_random__m256i(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx_mm256_insert_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx_mm256_insert_epi64_normal2_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_64_avx_mm256_insert_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_insert_epi64::<0>(create__m256i_from([100, 200, 300, 400]), 1i64));
        check_array_equality(&result, &[1, 200, 300, 400]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi64::<0>(create__m256i_from([100, 200, 300, 400]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi64::<0>(create_random__m256i(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx_mm256_insert_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx_mm256_insert_epi64_normal3_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_64_avx_mm256_insert_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_insert_epi64::<0>(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), 1i64));
        check_array_equality(&result, &[1, -9223372036854775808, -9223372036854775808, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi64::<0>(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi64::<0>(create_random__m256i(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx_mm256_insert_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx_mm256_insert_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_64_avx_mm256_insert_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_insert_epi64::<0>(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), 1i64));
        check_array_equality(&result, &[1, 9223372036854775807, 9223372036854775807, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi64::<0>(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi64::<0>(create_random__m256i(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx_mm256_insert_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx_mm256_insert_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_64_avx_mm256_insert_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_insert_epi64::<0>(create__m256i_from([0, 0, 0, 0]), 1i64));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi64::<0>(create__m256i_from([0, 0, 0, 0]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi64::<0>(create_random__m256i(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx_mm256_insert_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx_mm256_insert_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_64_avx_mm256_insert_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_insert_epi64::<0>(create__m256i_from([-1, -1, -1, -1]), 1i64));
        check_array_equality(&result, &[1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi64::<0>(create__m256i_from([-1, -1, -1, -1]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi64::<0>(create_random__m256i(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx_mm256_insert_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx_mm256_insert_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_64_avx_mm256_insert_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_insert_epi64::<0>(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), 1i64));
        check_array_equality(&result, &[1, 9223372036854775807, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi64::<0>(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), 1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi64::<0>(create_random__m256i(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx_mm256_insert_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx_mm256_insert_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_64_avx_mm256_insert_epi64_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_insert_epi64::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i64));
        check_array_equality(&result, &[8589934593, 9, 25769803781, 34359738375]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi64::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi64::<1>(create_random__m256i(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx_mm256_insert_epi64_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx_mm256_insert_epi64_imm_1_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_64_avx_mm256_insert_epi64_imm_3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_insert_epi64::<3>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i64));
        check_array_equality(&result, &[8589934593, 17179869187, 25769803781, 9]).map_err(|e| crate::cpu::with_call(e, "_mm256_insert_epi64::<3>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 9i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_insert_epi64::<3>(create_random__m256i(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx_mm256_insert_epi64_imm_3() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx_mm256_insert_epi64_imm_3_impl() }
}
