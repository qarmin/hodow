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

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvtss_si32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtss_si32(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_cvtss_si32(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtss_si32(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_cvtss_si32() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_cvtss_si32_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvtss_si32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtss_si32(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_cvtss_si32(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtss_si32(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_cvtss_si32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_cvtss_si32_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvtss_si32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtss_si32(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "_mm_cvtss_si32(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtss_si32(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_cvtss_si32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_cvtss_si32_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvtss_si32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtss_si32(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result, -2147483648).map_err(|e| crate::cpu::with_call(e, "_mm_cvtss_si32(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtss_si32(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_cvtss_si32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_cvtss_si32_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvtss_si32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtss_si32(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result, -2147483648).map_err(|e| crate::cpu::with_call(e, "_mm_cvtss_si32(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtss_si32(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_cvtss_si32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_cvtss_si32_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvtss_si32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtss_si32(create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_cvtss_si32(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtss_si32(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_cvtss_si32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_cvtss_si32_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvtss_si32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtss_si32(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result, -2147483648).map_err(|e| crate::cpu::with_call(e, "_mm_cvtss_si32(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtss_si32(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_cvtss_si32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_cvtss_si32_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvtss_si32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtss_si32(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result, -2147483648).map_err(|e| crate::cpu::with_call(e, "_mm_cvtss_si32(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtss_si32(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_cvtss_si32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_cvtss_si32_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvtss_f32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtss_f32(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_float_equality(result, 1.0).map_err(|e| crate::cpu::with_call(e, "_mm_cvtss_f32(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtss_f32(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_cvtss_f32() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_cvtss_f32_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvtss_f32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtss_f32(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "_mm_cvtss_f32(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtss_f32(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_cvtss_f32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_cvtss_f32_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvtss_f32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtss_f32(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]));
        check_float_equality(result, 100.0).map_err(|e| crate::cpu::with_call(e, "_mm_cvtss_f32(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtss_f32(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_cvtss_f32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_cvtss_f32_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvtss_f32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtss_f32(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_float_equality(result, -3.4028235e38).map_err(|e| crate::cpu::with_call(e, "_mm_cvtss_f32(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtss_f32(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_cvtss_f32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_cvtss_f32_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvtss_f32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtss_f32(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_float_equality(result, 3.4028235e38).map_err(|e| crate::cpu::with_call(e, "_mm_cvtss_f32(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtss_f32(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_cvtss_f32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_cvtss_f32_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvtss_f32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtss_f32(create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "_mm_cvtss_f32(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtss_f32(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_cvtss_f32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_cvtss_f32_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvtss_f32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtss_f32(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_float_equality(result, f32::NAN).map_err(|e| crate::cpu::with_call(e, "_mm_cvtss_f32(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtss_f32(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_cvtss_f32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_cvtss_f32_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvtss_f32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtss_f32(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_float_equality(result, f32::INFINITY).map_err(|e| crate::cpu::with_call(e, "_mm_cvtss_f32(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtss_f32(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_cvtss_f32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_cvtss_f32_boundary_mixed_impl() }
}
