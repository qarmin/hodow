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
fn test_x86_avx_mm256_movemask_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_movemask_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_movemask_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_movemask_pd(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_movemask_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_movemask_pd_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_movemask_pd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_movemask_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]));
        check_int_equality(result, 10).map_err(|e| crate::cpu::with_call(e, "_mm256_movemask_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_movemask_pd(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_movemask_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_movemask_pd_normal2_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_movemask_pd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_movemask_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_movemask_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_movemask_pd(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_movemask_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_movemask_pd_normal3_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_movemask_pd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_movemask_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]));
        check_int_equality(result, 15).map_err(|e| crate::cpu::with_call(e, "_mm256_movemask_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_movemask_pd(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_movemask_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_movemask_pd_boundary_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_movemask_pd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_movemask_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_movemask_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_movemask_pd(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_movemask_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_movemask_pd_boundary_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_movemask_pd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_movemask_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_movemask_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_movemask_pd(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_movemask_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_movemask_pd_boundary_zero_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_movemask_pd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_movemask_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_movemask_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_movemask_pd(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_movemask_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_movemask_pd_boundary_allones_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_movemask_pd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_movemask_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]));
        check_int_equality(result, 6).map_err(|e| crate::cpu::with_call(e, "_mm256_movemask_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_movemask_pd(create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_movemask_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_movemask_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_movemask_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_movemask_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_movemask_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_movemask_ps(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_movemask_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_movemask_ps_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_movemask_ps_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_movemask_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]));
        check_int_equality(result, 170).map_err(|e| crate::cpu::with_call(e, "_mm256_movemask_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_movemask_ps(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_movemask_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_movemask_ps_normal2_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_movemask_ps_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_movemask_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_movemask_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_movemask_ps(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_movemask_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_movemask_ps_normal3_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_movemask_ps_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_movemask_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result, 255).map_err(|e| crate::cpu::with_call(e, "_mm256_movemask_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_movemask_ps(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_movemask_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_movemask_ps_boundary_min_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_movemask_ps_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_movemask_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_movemask_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_movemask_ps(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_movemask_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_movemask_ps_boundary_max_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_movemask_ps_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_movemask_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_movemask_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_movemask_ps(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_movemask_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_movemask_ps_boundary_zero_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_movemask_ps_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_movemask_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm256_movemask_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_movemask_ps(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_movemask_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_movemask_ps_boundary_allones_impl() }
}

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_movemask_ps_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm256_movemask_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result, 102).map_err(|e| crate::cpu::with_call(e, "_mm256_movemask_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_movemask_ps(create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx_mm256_movemask_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_movemask_ps_boundary_mixed_impl() }
}
