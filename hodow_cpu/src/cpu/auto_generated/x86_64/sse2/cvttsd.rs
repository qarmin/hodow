use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvttsd_si64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvttsd_si64(create__m128d_from([1.0, 2.0]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_cvttsd_si64(create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvttsd_si64(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvttsd_si64_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvttsd_si64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvttsd_si64(create__m128d_from([0.0f64, -1.0f64]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_cvttsd_si64(create__m128d_from([0.0f64, -1.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvttsd_si64(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvttsd_si64_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvttsd_si64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvttsd_si64(create__m128d_from([100.0f64, 200.0f64]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "_mm_cvttsd_si64(create__m128d_from([100.0f64, 200.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvttsd_si64(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvttsd_si64_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvttsd_si64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvttsd_si64(create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm_cvttsd_si64(create__m128d_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvttsd_si64(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvttsd_si64_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvttsd_si64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvttsd_si64(create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm_cvttsd_si64(create__m128d_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvttsd_si64(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvttsd_si64_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvttsd_si64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvttsd_si64(create__m128d_from([0.0, 0.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_cvttsd_si64(create__m128d_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvttsd_si64(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvttsd_si64_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvttsd_si64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvttsd_si64(create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm_cvttsd_si64(create__m128d_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvttsd_si64(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvttsd_si64_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvttsd_si64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvttsd_si64(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm_cvttsd_si64(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvttsd_si64(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvttsd_si64_boundary_mixed_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvttsd_si64x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvttsd_si64x(create__m128d_from([1.0, 2.0]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_cvttsd_si64x(create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvttsd_si64x(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64x() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvttsd_si64x_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvttsd_si64x_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvttsd_si64x(create__m128d_from([0.0f64, -1.0f64]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_cvttsd_si64x(create__m128d_from([0.0f64, -1.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvttsd_si64x(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64x_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvttsd_si64x_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvttsd_si64x_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvttsd_si64x(create__m128d_from([100.0f64, 200.0f64]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "_mm_cvttsd_si64x(create__m128d_from([100.0f64, 200.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvttsd_si64x(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64x_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvttsd_si64x_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvttsd_si64x_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvttsd_si64x(create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm_cvttsd_si64x(create__m128d_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvttsd_si64x(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64x_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvttsd_si64x_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvttsd_si64x_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvttsd_si64x(create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm_cvttsd_si64x(create__m128d_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvttsd_si64x(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64x_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvttsd_si64x_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvttsd_si64x_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvttsd_si64x(create__m128d_from([0.0, 0.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_cvttsd_si64x(create__m128d_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvttsd_si64x(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64x_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvttsd_si64x_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvttsd_si64x_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvttsd_si64x(create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm_cvttsd_si64x(create__m128d_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvttsd_si64x(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64x_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvttsd_si64x_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvttsd_si64x_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvttsd_si64x(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "_mm_cvttsd_si64x(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvttsd_si64x(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64x_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvttsd_si64x_boundary_mixed_impl() }
}
