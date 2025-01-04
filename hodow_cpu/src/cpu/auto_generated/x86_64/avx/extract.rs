use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

#[target_feature(enable = "avx")]
fn test_x86_64_avx_mm256_extract_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_extract_epi64::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result, 8589934593).map_err(|e| crate::cpu::with_call(e, "_mm256_extract_epi64::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_extract_epi64::<0>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx_mm256_extract_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx_mm256_extract_epi64_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_64_avx_mm256_extract_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_extract_epi64::<0>(create__m256i_from([0, -1, 2, -3]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_extract_epi64::<0>(create__m256i_from([0, -1, 2, -3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_extract_epi64::<0>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx_mm256_extract_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx_mm256_extract_epi64_normal2_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_64_avx_mm256_extract_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_extract_epi64::<0>(create__m256i_from([100, 200, 300, 400]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "_mm256_extract_epi64::<0>(create__m256i_from([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_extract_epi64::<0>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx_mm256_extract_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx_mm256_extract_epi64_normal3_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_64_avx_mm256_extract_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_extract_epi64::<0>(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm256_extract_epi64::<0>(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_extract_epi64::<0>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx_mm256_extract_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx_mm256_extract_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_64_avx_mm256_extract_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_extract_epi64::<0>(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]));
        check_int_equality(result, 9223372036854775807).map_err(|e| crate::cpu::with_call(e, "_mm256_extract_epi64::<0>(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_extract_epi64::<0>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx_mm256_extract_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx_mm256_extract_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_64_avx_mm256_extract_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_extract_epi64::<0>(create__m256i_from([0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_extract_epi64::<0>(create__m256i_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_extract_epi64::<0>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx_mm256_extract_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx_mm256_extract_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_64_avx_mm256_extract_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_extract_epi64::<0>(create__m256i_from([-1, -1, -1, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "_mm256_extract_epi64::<0>(create__m256i_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_extract_epi64::<0>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx_mm256_extract_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx_mm256_extract_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_64_avx_mm256_extract_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_extract_epi64::<0>(create__m256i_from([i64::MIN, i64::MAX, 0, -1]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm256_extract_epi64::<0>(create__m256i_from([i64::MIN, i64::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_extract_epi64::<0>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx_mm256_extract_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx_mm256_extract_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_64_avx_mm256_extract_epi64_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_extract_epi64::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result, 17179869187).map_err(|e| crate::cpu::with_call(e, "_mm256_extract_epi64::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_extract_epi64::<1>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx_mm256_extract_epi64_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx_mm256_extract_epi64_imm_1_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_64_avx_mm256_extract_epi64_imm_3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_extract_epi64::<3>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result, 34359738375).map_err(|e| crate::cpu::with_call(e, "_mm256_extract_epi64::<3>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_extract_epi64::<3>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_avx_mm256_extract_epi64_imm_3() -> Result<Verdict, String> {
    unsafe { test_x86_64_avx_mm256_extract_epi64_imm_3_impl() }
}
