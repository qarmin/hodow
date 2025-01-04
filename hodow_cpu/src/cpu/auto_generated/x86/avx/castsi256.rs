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

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_castsi256_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_castsi256_ps(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[1e-45, 3e-45, 4e-45, 6e-45, 7e-45, 8e-45, 1e-44, 1.1e-44]).map_err(|e| crate::cpu::with_call(e, "_mm256_castsi256_ps(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_castsi256_ps(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_castsi256_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_castsi256_ps_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_castsi256_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_castsi256_pd(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[4.2439915824e-314, 8.4879831653e-314, 1.27319747483e-313, 1.6975966331e-313]).map_err(|e| crate::cpu::with_call(e, "_mm256_castsi256_pd(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_castsi256_pd(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_castsi256_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_castsi256_pd_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_castsi256_si128_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_castsi256_si128(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| crate::cpu::with_call(e, "_mm256_castsi256_si128(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_castsi256_si128(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_castsi256_si128() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_castsi256_si128_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_castsi256_si128_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_castsi256_si128(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, -1, 2, -3]).map_err(|e| crate::cpu::with_call(e, "_mm256_castsi256_si128(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_castsi256_si128(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_castsi256_si128_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_castsi256_si128_normal2_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_castsi256_si128_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_castsi256_si128(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800])));
        check_array_equality(&result, &[100, 200, 300, 400]).map_err(|e| crate::cpu::with_call(e, "_mm256_castsi256_si128(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_castsi256_si128(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_castsi256_si128_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_castsi256_si128_normal3_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_castsi256_si128_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_castsi256_si128(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm256_castsi256_si128(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_castsi256_si128(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_castsi256_si128_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_castsi256_si128_boundary_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_castsi256_si128_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_castsi256_si128(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm256_castsi256_si128(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_castsi256_si128(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_castsi256_si128_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_castsi256_si128_boundary_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_castsi256_si128_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_castsi256_si128(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_castsi256_si128(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_castsi256_si128(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_castsi256_si128_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_castsi256_si128_boundary_zero_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_castsi256_si128_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_castsi256_si128(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_castsi256_si128(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_castsi256_si128(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_castsi256_si128_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_castsi256_si128_boundary_allones_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_castsi256_si128_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm256_castsi256_si128(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-2147483648, 2147483647, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_castsi256_si128(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_castsi256_si128(create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_castsi256_si128_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_castsi256_si128_boundary_mixed_impl() }
}
