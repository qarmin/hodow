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
fn test_x86_avx2_mm256_permutevar8x32_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_permutevar8x32_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[2, 3, 4, 5, 6, 7, 8, 1]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutevar8x32_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutevar8x32_epi32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permutevar8x32_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permutevar8x32_epi32_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permutevar8x32_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_permutevar8x32_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[2, -1, 4, -7, 6, -5, 0, -3]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutevar8x32_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutevar8x32_epi32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permutevar8x32_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permutevar8x32_epi32_normal2_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permutevar8x32_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_permutevar8x32_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[700, 300, 700, 300, 700, 300, 700, 300]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutevar8x32_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutevar8x32_epi32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permutevar8x32_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permutevar8x32_epi32_normal3_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permutevar8x32_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_permutevar8x32_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutevar8x32_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutevar8x32_epi32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permutevar8x32_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permutevar8x32_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permutevar8x32_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_permutevar8x32_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutevar8x32_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutevar8x32_epi32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permutevar8x32_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permutevar8x32_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permutevar8x32_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_permutevar8x32_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutevar8x32_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutevar8x32_epi32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permutevar8x32_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permutevar8x32_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permutevar8x32_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_permutevar8x32_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutevar8x32_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutevar8x32_epi32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permutevar8x32_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permutevar8x32_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permutevar8x32_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_permutevar8x32_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-2147483648, -1, -2147483648, -1, -2147483648, -1, -2147483648, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutevar8x32_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutevar8x32_epi32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permutevar8x32_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permutevar8x32_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permutevar8x32_epi32_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_permutevar8x32_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutevar8x32_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutevar8x32_epi32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permutevar8x32_epi32_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permutevar8x32_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permutevar8x32_epi32_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_permutevar8x32_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutevar8x32_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutevar8x32_epi32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permutevar8x32_epi32_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permutevar8x32_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permutevar8x32_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_permutevar8x32_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_float_array_equality(&result, &[2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutevar8x32_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutevar8x32_ps(create_random__m256(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permutevar8x32_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permutevar8x32_ps_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permutevar8x32_ps_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_permutevar8x32_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[-1.0, 2.0, -3.0, 4.0, -5.0, 6.0, -7.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutevar8x32_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutevar8x32_ps(create_random__m256(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permutevar8x32_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permutevar8x32_ps_normal2_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permutevar8x32_ps_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_permutevar8x32_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0, 100.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutevar8x32_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutevar8x32_ps(create_random__m256(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permutevar8x32_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permutevar8x32_ps_normal3_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permutevar8x32_ps_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_permutevar8x32_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutevar8x32_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutevar8x32_ps(create_random__m256(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permutevar8x32_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permutevar8x32_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permutevar8x32_ps_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_permutevar8x32_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutevar8x32_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutevar8x32_ps(create_random__m256(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permutevar8x32_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permutevar8x32_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permutevar8x32_ps_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_permutevar8x32_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutevar8x32_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutevar8x32_ps(create_random__m256(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permutevar8x32_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permutevar8x32_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permutevar8x32_ps_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_permutevar8x32_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutevar8x32_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutevar8x32_ps(create_random__m256(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permutevar8x32_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permutevar8x32_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_permutevar8x32_ps_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_permutevar8x32_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_float_array_equality(&result, &[-f32::INFINITY, -0.0, 5.877472e-39, f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39, f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm256_permutevar8x32_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_permutevar8x32_ps(create_random__m256(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_permutevar8x32_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_permutevar8x32_ps_boundary_mixed_impl() }
}
