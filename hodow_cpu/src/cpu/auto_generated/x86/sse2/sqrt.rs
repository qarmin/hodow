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

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_sqrt_sd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0])));
        check_float_array_equality(&result, &[1.7320508075688772, 2.0]).map_err(|e| crate::cpu::with_call(e, "_mm_sqrt_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sqrt_sd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_sqrt_sd() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_sqrt_sd_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_sqrt_sd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[3.1622776601683795, -1.0]).map_err(|e| crate::cpu::with_call(e, "_mm_sqrt_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sqrt_sd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_sqrt_sd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_sqrt_sd_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_sqrt_sd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[10.488088481701515, 200.0]).map_err(|e| crate::cpu::with_call(e, "_mm_sqrt_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sqrt_sd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_sqrt_sd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_sqrt_sd_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_sqrt_sd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::NAN, -1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_sqrt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sqrt_sd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_sqrt_sd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_sqrt_sd_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_sqrt_sd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.3407807929942596e154, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_sqrt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sqrt_sd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_sqrt_sd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_sqrt_sd_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_sqrt_sd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_sqrt_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sqrt_sd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_sqrt_sd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_sqrt_sd_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_sqrt_sd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_sqrt_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sqrt_sd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_sqrt_sd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_sqrt_sd_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_sqrt_sd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, -f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm_sqrt_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sqrt_sd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_sqrt_sd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_sqrt_sd_boundary_mixed_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_sqrt_sd_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.3407807929942596e154, -1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_sqrt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sqrt_sd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_sqrt_sd_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_sqrt_sd_asym_min_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_sqrt_sd_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::NAN, 1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "_mm_sqrt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sqrt_sd(create_random__m128d(), create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_sqrt_sd_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_sqrt_sd_asym_max_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_sqrt_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_pd(create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 1.4142135623730951]).map_err(|e| crate::cpu::with_call(e, "_mm_sqrt_pd(create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sqrt_pd(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_sqrt_pd() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_sqrt_pd_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_sqrt_pd_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_pd(create__m128d_from([0.0f64, -1.0f64])));
        check_float_array_equality(&result, &[0.0, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_sqrt_pd(create__m128d_from([0.0f64, -1.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sqrt_pd(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_sqrt_pd_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_sqrt_pd_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_sqrt_pd_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_pd(create__m128d_from([100.0f64, 200.0f64])));
        check_float_array_equality(&result, &[10.0, 14.142135623730951]).map_err(|e| crate::cpu::with_call(e, "_mm_sqrt_pd(create__m128d_from([100.0f64, 200.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sqrt_pd(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_sqrt_pd_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_sqrt_pd_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_sqrt_pd_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_pd(create__m128d_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_sqrt_pd(create__m128d_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sqrt_pd(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_sqrt_pd_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_sqrt_pd_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_sqrt_pd_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_pd(create__m128d_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.3407807929942596e154, 1.3407807929942596e154]).map_err(|e| crate::cpu::with_call(e, "_mm_sqrt_pd(create__m128d_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sqrt_pd(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_sqrt_pd_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_sqrt_pd_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_sqrt_pd_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_pd(create__m128d_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_sqrt_pd(create__m128d_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sqrt_pd(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_sqrt_pd_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_sqrt_pd_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_sqrt_pd_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_pd(create__m128d_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_sqrt_pd(create__m128d_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sqrt_pd(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_sqrt_pd_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_sqrt_pd_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_sqrt_pd_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_sqrt_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_sqrt_pd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sqrt_pd(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_sqrt_pd_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_sqrt_pd_boundary_mixed_impl() }
}
