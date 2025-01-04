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

#[target_feature(enable = "fma")]
fn test_x86_fma_mm_fmsubadd_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsubadd_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]), create__m128d_from([5.0, 6.0])));
        check_float_array_equality(&result, &[8.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "_mm_fmsubadd_pd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]), create__m128d_from([5.0, 6.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fmsubadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm_fmsubadd_pd() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm_fmsubadd_pd_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm_fmsubadd_pd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsubadd_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]), create__m128d_from([20.0f64, 19.0f64])));
        check_float_array_equality(&result, &[20.0, -28.0]).map_err(|e| crate::cpu::with_call(e, "_mm_fmsubadd_pd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]), create__m128d_from([20.0f64, 19.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fmsubadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm_fmsubadd_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm_fmsubadd_pd_normal2_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm_fmsubadd_pd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsubadd_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]), create__m128d_from([120.0f64, 220.0f64])));
        check_float_array_equality(&result, &[11120.0, 41780.0]).map_err(|e| crate::cpu::with_call(e, "_mm_fmsubadd_pd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]), create__m128d_from([120.0f64, 220.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fmsubadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm_fmsubadd_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm_fmsubadd_pd_normal3_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm_fmsubadd_pd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsubadd_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm_fmsubadd_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fmsubadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm_fmsubadd_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm_fmsubadd_pd_boundary_min_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm_fmsubadd_pd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsubadd_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm_fmsubadd_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fmsubadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm_fmsubadd_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm_fmsubadd_pd_boundary_max_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm_fmsubadd_pd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsubadd_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_fmsubadd_pd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fmsubadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm_fmsubadd_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm_fmsubadd_pd_boundary_zero_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm_fmsubadd_pd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsubadd_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_fmsubadd_pd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fmsubadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm_fmsubadd_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm_fmsubadd_pd_boundary_allones_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm_fmsubadd_pd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsubadd_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm_fmsubadd_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fmsubadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm_fmsubadd_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm_fmsubadd_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm_fmsubadd_pd_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsubadd_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm_fmsubadd_pd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fmsubadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm_fmsubadd_pd_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm_fmsubadd_pd_asym_min_max_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm_fmsubadd_pd_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsubadd_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm_fmsubadd_pd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fmsubadd_pd(create_random__m128d(), create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm_fmsubadd_pd_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm_fmsubadd_pd_asym_max_min_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm256_fmsubadd_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmsubadd_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256d_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[14.0, 2.0, 32.0, 20.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_fmsubadd_pd(create__m256d_from([1.0, 2.0, 3.0, 4.0]), create__m256d_from([5.0, 6.0, 7.0, 8.0]), create__m256d_from([9.0, 10.0, 11.0, 12.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fmsubadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm256_fmsubadd_pd() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm256_fmsubadd_pd_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm256_fmsubadd_pd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmsubadd_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]), create__m256d_from([20.0f64, 19.0f64, 22.0f64, 17.0f64])));
        check_float_array_equality(&result, &[20.0, -28.0, 46.0, -38.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_fmsubadd_pd(create__m256d_from([0.0f64, -1.0f64, 2.0f64, -3.0f64]), create__m256d_from([10.0f64, 9.0f64, 12.0f64, 7.0f64]), create__m256d_from([20.0f64, 19.0f64, 22.0f64, 17.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fmsubadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm256_fmsubadd_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm256_fmsubadd_pd_normal2_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm256_fmsubadd_pd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmsubadd_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]), create__m256d_from([120.0f64, 220.0f64, 320.0f64, 420.0f64])));
        check_float_array_equality(&result, &[11120.0, 41780.0, 93320.0, 163580.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_fmsubadd_pd(create__m256d_from([100.0f64, 200.0f64, 300.0f64, 400.0f64]), create__m256d_from([110.0f64, 210.0f64, 310.0f64, 410.0f64]), create__m256d_from([120.0f64, 220.0f64, 320.0f64, 420.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fmsubadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm256_fmsubadd_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm256_fmsubadd_pd_normal3_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm256_fmsubadd_pd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmsubadd_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm256_fmsubadd_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fmsubadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm256_fmsubadd_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm256_fmsubadd_pd_boundary_min_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm256_fmsubadd_pd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmsubadd_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY, f64::INFINITY, f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm256_fmsubadd_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fmsubadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm256_fmsubadd_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm256_fmsubadd_pd_boundary_max_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm256_fmsubadd_pd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmsubadd_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_fmsubadd_pd(create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]), create__m256d_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fmsubadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm256_fmsubadd_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm256_fmsubadd_pd_boundary_zero_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm256_fmsubadd_pd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmsubadd_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN, f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm256_fmsubadd_pd(create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]), create__m256d_from([f64::NAN, f64::NAN, f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fmsubadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm256_fmsubadd_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm256_fmsubadd_pd_boundary_allones_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm256_fmsubadd_pd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmsubadd_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY, 0.0, -1.1125369292536007e-308]).map_err(|e| crate::cpu::with_call(e, "_mm256_fmsubadd_pd(create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]), create__m256d_from([f64::INFINITY, f64::NEG_INFINITY, -0.0, f64::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fmsubadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm256_fmsubadd_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm256_fmsubadd_pd_boundary_mixed_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm256_fmsubadd_pd_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmsubadd_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm256_fmsubadd_pd(create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fmsubadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm256_fmsubadd_pd_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm256_fmsubadd_pd_asym_min_max_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm256_fmsubadd_pd_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256d_to_f64_array(_mm256_fmsubadd_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY, -f64::INFINITY, -f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm256_fmsubadd_pd(create__m256d_from([f64::MAX, f64::MAX, f64::MAX, f64::MAX]), create__m256d_from([f64::MIN, f64::MIN, f64::MIN, f64::MIN]), create__m256d_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fmsubadd_pd(create_random__m256d(), create_random__m256d(), create_random__m256d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm256_fmsubadd_pd_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm256_fmsubadd_pd_asym_max_min_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm256_fmsubadd_pd_vs_narrow_impl() -> Result<Verdict, String> {
    unsafe {
        let a_wide = create__m256d_from([1.0f64, 2.0f64, 3.0f64, 4.0f64]);
        let a_narrow = create__m128d_from([1.0f64, 2.0f64]);
        let b_wide = create__m256d_from([5.0f64, 6.0f64, 7.0f64, 8.0f64]);
        let b_narrow = create__m128d_from([5.0f64, 6.0f64]);
        let c_wide = create__m256d_from([9.0f64, 10.0f64, 11.0f64, 12.0f64]);
        let c_narrow = create__m128d_from([9.0f64, 10.0f64]);
        let wide = unpack__m256d_to_f64_array(_mm256_fmsubadd_pd(a_wide, b_wide, c_wide));
        let narrow = unpack__m128d_to_f64_array(_mm_fmsubadd_pd(a_narrow, b_narrow, c_narrow));
        check_float_array_equality(&wide[..2], &narrow).map_err(|e| crate::cpu::with_call(e, "_mm256_fmsubadd_pd(a_wide, b_wide, c_wide) vs _mm_fmsubadd_pd(a_narrow, b_narrow, c_narrow)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm256_fmsubadd_pd_vs_narrow() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm256_fmsubadd_pd_vs_narrow_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm_fmsubadd_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsubadd_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[14.0, 2.0, 32.0, 20.0]).map_err(|e| crate::cpu::with_call(e, "_mm_fmsubadd_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]), create__m128_from([9.0, 10.0, 11.0, 12.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fmsubadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm_fmsubadd_ps() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm_fmsubadd_ps_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm_fmsubadd_ps_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsubadd_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create__m128_from([20.0f32, 19.0f32, 22.0f32, 17.0f32])));
        check_float_array_equality(&result, &[20.0, -28.0, 46.0, -38.0]).map_err(|e| crate::cpu::with_call(e, "_mm_fmsubadd_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create__m128_from([20.0f32, 19.0f32, 22.0f32, 17.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fmsubadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm_fmsubadd_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm_fmsubadd_ps_normal2_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm_fmsubadd_ps_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsubadd_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create__m128_from([120.0f32, 220.0f32, 320.0f32, 420.0f32])));
        check_float_array_equality(&result, &[11120.0, 41780.0, 93320.0, 163580.0]).map_err(|e| crate::cpu::with_call(e, "_mm_fmsubadd_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create__m128_from([120.0f32, 220.0f32, 320.0f32, 420.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fmsubadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm_fmsubadd_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm_fmsubadd_ps_normal3_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm_fmsubadd_ps_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsubadd_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm_fmsubadd_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fmsubadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm_fmsubadd_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm_fmsubadd_ps_boundary_min_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm_fmsubadd_ps_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsubadd_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm_fmsubadd_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fmsubadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm_fmsubadd_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm_fmsubadd_ps_boundary_max_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm_fmsubadd_ps_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsubadd_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_fmsubadd_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fmsubadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm_fmsubadd_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm_fmsubadd_ps_boundary_zero_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm_fmsubadd_ps_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsubadd_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_fmsubadd_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fmsubadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm_fmsubadd_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm_fmsubadd_ps_boundary_allones_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm_fmsubadd_ps_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsubadd_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, 0.0, -5.877472e-39]).map_err(|e| crate::cpu::with_call(e, "_mm_fmsubadd_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fmsubadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm_fmsubadd_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm_fmsubadd_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm_fmsubadd_ps_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsubadd_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm_fmsubadd_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fmsubadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm_fmsubadd_ps_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm_fmsubadd_ps_asym_min_max_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm_fmsubadd_ps_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsubadd_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm_fmsubadd_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_fmsubadd_ps(create_random__m128(), create_random__m128(), create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm_fmsubadd_ps_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm_fmsubadd_ps_asym_max_min_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm256_fmsubadd_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmsubadd_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0])));
        check_float_array_equality(&result, &[26.0, 2.0, 52.0, 28.0, 86.0, 62.0, 128.0, 104.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_fmsubadd_ps(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]), create__m256_from([9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]), create__m256_from([17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fmsubadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm256_fmsubadd_ps() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm256_fmsubadd_ps_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm256_fmsubadd_ps_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmsubadd_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m256_from([20.0f32, 19.0f32, 22.0f32, 17.0f32, 24.0f32, 15.0f32, 26.0f32, 13.0f32])));
        check_float_array_equality(&result, &[20.0, -28.0, 46.0, -38.0, 80.0, -40.0, 122.0, -34.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_fmsubadd_ps(create__m256_from([0.0f32, -1.0f32, 2.0f32, -3.0f32, 4.0f32, -5.0f32, 6.0f32, -7.0f32]), create__m256_from([10.0f32, 9.0f32, 12.0f32, 7.0f32, 14.0f32, 5.0f32, 16.0f32, 3.0f32]), create__m256_from([20.0f32, 19.0f32, 22.0f32, 17.0f32, 24.0f32, 15.0f32, 26.0f32, 13.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fmsubadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm256_fmsubadd_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm256_fmsubadd_ps_normal2_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm256_fmsubadd_ps_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmsubadd_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]), create__m256_from([120.0f32, 220.0f32, 320.0f32, 420.0f32, 520.0f32, 620.0f32, 720.0f32, 820.0f32])));
        check_float_array_equality(&result, &[11120.0, 41780.0, 93320.0, 163580.0, 255520.0, 365380.0, 497720.0, 647180.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_fmsubadd_ps(create__m256_from([100.0f32, 200.0f32, 300.0f32, 400.0f32, 500.0f32, 600.0f32, 700.0f32, 800.0f32]), create__m256_from([110.0f32, 210.0f32, 310.0f32, 410.0f32, 510.0f32, 610.0f32, 710.0f32, 810.0f32]), create__m256_from([120.0f32, 220.0f32, 320.0f32, 420.0f32, 520.0f32, 620.0f32, 720.0f32, 820.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fmsubadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm256_fmsubadd_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm256_fmsubadd_ps_normal3_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm256_fmsubadd_ps_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmsubadd_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm256_fmsubadd_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fmsubadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm256_fmsubadd_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm256_fmsubadd_ps_boundary_min_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm256_fmsubadd_ps_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmsubadd_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm256_fmsubadd_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fmsubadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm256_fmsubadd_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm256_fmsubadd_ps_boundary_max_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm256_fmsubadd_ps_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmsubadd_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_fmsubadd_ps(create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]), create__m256_from([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fmsubadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm256_fmsubadd_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm256_fmsubadd_ps_boundary_zero_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm256_fmsubadd_ps_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmsubadd_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm256_fmsubadd_ps(create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m256_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fmsubadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm256_fmsubadd_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm256_fmsubadd_ps_boundary_allones_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm256_fmsubadd_ps_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmsubadd_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, 0.0, -5.877472e-39, f32::INFINITY, f32::INFINITY, 0.0, -5.877472e-39]).map_err(|e| crate::cpu::with_call(e, "_mm256_fmsubadd_ps(create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m256_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0, f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fmsubadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm256_fmsubadd_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm256_fmsubadd_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm256_fmsubadd_ps_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmsubadd_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm256_fmsubadd_ps(create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fmsubadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm256_fmsubadd_ps_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm256_fmsubadd_ps_asym_min_max_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm256_fmsubadd_ps_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_fmsubadd_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm256_fmsubadd_ps(create__m256_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m256_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_fmsubadd_ps(create_random__m256(), create_random__m256(), create_random__m256());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm256_fmsubadd_ps_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm256_fmsubadd_ps_asym_max_min_impl() }
}

#[target_feature(enable = "fma")]
fn test_x86_fma_mm256_fmsubadd_ps_vs_narrow_impl() -> Result<Verdict, String> {
    unsafe {
        let a_wide = create__m256_from([1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32]);
        let a_narrow = create__m128_from([1.0f32, 2.0f32, 3.0f32, 4.0f32]);
        let b_wide = create__m256_from([9.0f32, 10.0f32, 11.0f32, 12.0f32, 13.0f32, 14.0f32, 15.0f32, 16.0f32]);
        let b_narrow = create__m128_from([9.0f32, 10.0f32, 11.0f32, 12.0f32]);
        let c_wide = create__m256_from([17.0f32, 18.0f32, 19.0f32, 20.0f32, 21.0f32, 22.0f32, 23.0f32, 24.0f32]);
        let c_narrow = create__m128_from([17.0f32, 18.0f32, 19.0f32, 20.0f32]);
        let wide = unpack__m256_to_f32_array(_mm256_fmsubadd_ps(a_wide, b_wide, c_wide));
        let narrow = unpack__m128_to_f32_array(_mm_fmsubadd_ps(a_narrow, b_narrow, c_narrow));
        check_float_array_equality(&wide[..4], &narrow).map_err(|e| crate::cpu::with_call(e, "_mm256_fmsubadd_ps(a_wide, b_wide, c_wide) vs _mm_fmsubadd_ps(a_narrow, b_narrow, c_narrow)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_fma_mm256_fmsubadd_ps_vs_narrow() -> Result<Verdict, String> {
    unsafe { test_x86_fma_mm256_fmsubadd_ps_vs_narrow_impl() }
}
