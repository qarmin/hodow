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
fn test_x86_avx_mm256_testz_si256_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_testz_si256(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_testz_si256(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_testz_si256(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_testz_si256() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_testz_si256_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_testz_si256_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_testz_si256(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_testz_si256(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_testz_si256(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_testz_si256_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_testz_si256_normal2_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_testz_si256_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_testz_si256(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_testz_si256(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_testz_si256(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_testz_si256_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_testz_si256_normal3_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_testz_si256_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_testz_si256(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_testz_si256(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_testz_si256(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_testz_si256_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_testz_si256_boundary_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_testz_si256_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_testz_si256(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_testz_si256(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_testz_si256(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_testz_si256_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_testz_si256_boundary_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_testz_si256_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_testz_si256(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm256_testz_si256(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_testz_si256(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_testz_si256_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_testz_si256_boundary_zero_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_testz_si256_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_testz_si256(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_testz_si256(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_testz_si256(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_testz_si256_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_testz_si256_boundary_allones_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_testz_si256_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_testz_si256(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_testz_si256(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_testz_si256(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_testz_si256_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_testz_si256_boundary_mixed_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_testz_si256_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_testz_si256(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm256_testz_si256(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_testz_si256(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_testz_si256_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_testz_si256_asym_min_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_testz_si256_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_testz_si256(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm256_testz_si256(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_testz_si256(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_testz_si256_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_testz_si256_asym_max_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_testz_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_testz_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm256_testz_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_testz_pd(create_random__m256d(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_testz_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_testz_pd_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_testz_pd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_testz_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm256_testz_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_testz_pd(create_random__m256d(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_testz_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_testz_pd_normal2_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_testz_pd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_testz_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm256_testz_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_testz_pd(create_random__m256d(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_testz_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_testz_pd_normal3_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_testz_pd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_testz_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_testz_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_testz_pd(create_random__m256d(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_testz_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_testz_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_testz_pd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_testz_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm256_testz_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_testz_pd(create_random__m256d(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_testz_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_testz_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_testz_pd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_testz_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm256_testz_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_testz_pd(create_random__m256d(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_testz_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_testz_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_testz_pd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_testz_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm256_testz_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_testz_pd(create_random__m256d(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_testz_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_testz_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_testz_pd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_testz_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_testz_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_testz_pd(create_random__m256d(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_testz_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_testz_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_testz_pd_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_testz_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm256_testz_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_testz_pd(create_random__m256d(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_testz_pd_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_testz_pd_asym_min_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_testz_pd_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_testz_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm256_testz_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_testz_pd(create_random__m256d(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_testz_pd_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_testz_pd_asym_max_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_testz_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_testz_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_testz_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_testz_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_testz_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_testz_pd_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_testz_pd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_testz_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_testz_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_testz_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_testz_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_testz_pd_normal2_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_testz_pd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_testz_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_testz_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_testz_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_testz_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_testz_pd_normal3_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_testz_pd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_testz_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_testz_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_testz_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_testz_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_testz_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_testz_pd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_testz_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_testz_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_testz_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_testz_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_testz_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_testz_pd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_testz_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_testz_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_testz_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_testz_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_testz_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_testz_pd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_testz_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_testz_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_testz_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_testz_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_testz_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_testz_pd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_testz_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_testz_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_testz_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_testz_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_testz_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_testz_pd_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_testz_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_testz_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_testz_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_testz_pd_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_testz_pd_asym_min_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_testz_pd_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_testz_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_testz_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_testz_pd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_testz_pd_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_testz_pd_asym_max_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_testz_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_testz_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm256_testz_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_testz_ps(create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_testz_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_testz_ps_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_testz_ps_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_testz_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm256_testz_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_testz_ps(create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_testz_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_testz_ps_normal2_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_testz_ps_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_testz_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm256_testz_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_testz_ps(create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_testz_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_testz_ps_normal3_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_testz_ps_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_testz_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_testz_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_testz_ps(create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_testz_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_testz_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_testz_ps_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_testz_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm256_testz_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_testz_ps(create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_testz_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_testz_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_testz_ps_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_testz_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm256_testz_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_testz_ps(create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_testz_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_testz_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_testz_ps_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_testz_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm256_testz_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_testz_ps(create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_testz_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_testz_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_testz_ps_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_testz_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_testz_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_testz_ps(create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_testz_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_testz_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_testz_ps_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_testz_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm256_testz_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_testz_ps(create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_testz_ps_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_testz_ps_asym_min_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_testz_ps_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_testz_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm256_testz_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_testz_ps(create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_testz_ps_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_testz_ps_asym_max_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_testz_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_testz_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_testz_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_testz_ps(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_testz_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_testz_ps_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_testz_ps_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_testz_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_testz_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_testz_ps(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_testz_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_testz_ps_normal2_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_testz_ps_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_testz_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_testz_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_testz_ps(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_testz_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_testz_ps_normal3_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_testz_ps_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_testz_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_testz_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_testz_ps(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_testz_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_testz_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_testz_ps_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_testz_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_testz_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_testz_ps(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_testz_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_testz_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_testz_ps_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_testz_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_testz_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_testz_ps(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_testz_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_testz_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_testz_ps_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_testz_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_testz_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_testz_ps(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_testz_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_testz_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_testz_ps_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_testz_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_testz_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_testz_ps(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_testz_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_testz_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_testz_ps_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_testz_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_testz_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_testz_ps(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_testz_ps_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_testz_ps_asym_min_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm_testz_ps_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_testz_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_testz_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_testz_ps(create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm_testz_ps_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm_testz_ps_asym_max_min_impl() }
}
