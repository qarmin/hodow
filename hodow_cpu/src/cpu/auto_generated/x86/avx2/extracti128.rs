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

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_extracti128_si256_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_extracti128_si256::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| crate::cpu::with_call(e, "_mm256_extracti128_si256::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_extracti128_si256::<0>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_extracti128_si256() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_extracti128_si256_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_extracti128_si256_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_extracti128_si256::<0>(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, -1, 2, -3]).map_err(|e| crate::cpu::with_call(e, "_mm256_extracti128_si256::<0>(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_extracti128_si256::<0>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_extracti128_si256_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_extracti128_si256_normal2_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_extracti128_si256_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_extracti128_si256::<0>(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800])));
        check_array_equality(&result, &[100, 200, 300, 400]).map_err(|e| crate::cpu::with_call(e, "_mm256_extracti128_si256::<0>(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_extracti128_si256::<0>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_extracti128_si256_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_extracti128_si256_normal3_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_extracti128_si256_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_extracti128_si256::<0>(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm256_extracti128_si256::<0>(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_extracti128_si256::<0>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_extracti128_si256_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_extracti128_si256_boundary_min_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_extracti128_si256_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_extracti128_si256::<0>(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm256_extracti128_si256::<0>(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_extracti128_si256::<0>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_extracti128_si256_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_extracti128_si256_boundary_max_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_extracti128_si256_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_extracti128_si256::<0>(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_extracti128_si256::<0>(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_extracti128_si256::<0>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_extracti128_si256_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_extracti128_si256_boundary_zero_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_extracti128_si256_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_extracti128_si256::<0>(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_extracti128_si256::<0>(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_extracti128_si256::<0>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_extracti128_si256_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_extracti128_si256_boundary_allones_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_extracti128_si256_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_extracti128_si256::<0>(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-2147483648, 2147483647, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_extracti128_si256::<0>(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_extracti128_si256::<0>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_extracti128_si256_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_extracti128_si256_boundary_mixed_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_extracti128_si256_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_extracti128_si256::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[5, 6, 7, 8]).map_err(|e| crate::cpu::with_call(e, "_mm256_extracti128_si256::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_extracti128_si256::<1>(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_extracti128_si256_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_extracti128_si256_imm_1_impl() }
}
