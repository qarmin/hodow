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
fn test_x86_sse_mm_rsqrt_ss_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rsqrt_ss(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[0.9998779, 2.0, 3.0, 4.0]).map_err(|e| crate::cpu::with_call(e, "_mm_rsqrt_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_rsqrt_ss(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_rsqrt_ss() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_rsqrt_ss_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rsqrt_ss_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rsqrt_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32])));
        check_float_array_equality(&result, &[f32::INFINITY, -1.0, 2.0, -3.0]).map_err(|e| crate::cpu::with_call(e, "_mm_rsqrt_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_rsqrt_ss(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_rsqrt_ss_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_rsqrt_ss_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rsqrt_ss_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rsqrt_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32])));
        check_float_array_equality(&result, &[0.099990845, 200.0, 300.0, 400.0]).map_err(|e| crate::cpu::with_call(e, "_mm_rsqrt_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_rsqrt_ss(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_rsqrt_ss_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_rsqrt_ss_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rsqrt_ss_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rsqrt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm_rsqrt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_rsqrt_ss(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_rsqrt_ss_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_rsqrt_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rsqrt_ss_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rsqrt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[5.421011e-20, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "_mm_rsqrt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_rsqrt_ss(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_rsqrt_ss_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_rsqrt_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rsqrt_ss_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rsqrt_ss(create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[f32::INFINITY, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_rsqrt_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_rsqrt_ss(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_rsqrt_ss_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_rsqrt_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rsqrt_ss_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rsqrt_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_rsqrt_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_rsqrt_ss(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_rsqrt_ss_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_rsqrt_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rsqrt_ss_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rsqrt_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[0.0, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| crate::cpu::with_call(e, "_mm_rsqrt_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_rsqrt_ss(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_rsqrt_ss_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_rsqrt_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rsqrt_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rsqrt_ps(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[0.9998779, 0.70703125, 0.5772705, 0.49993896]).map_err(|e| crate::cpu::with_call(e, "_mm_rsqrt_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_rsqrt_ps(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_rsqrt_ps() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_rsqrt_ps_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rsqrt_ps_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rsqrt_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::NAN, 0.70703125, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_rsqrt_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_rsqrt_ps(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_rsqrt_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_rsqrt_ps_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rsqrt_ps_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rsqrt_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32])));
        check_float_array_equality(&result, &[0.099990845, 0.07070923, 0.05773163, 0.049995422]).map_err(|e| crate::cpu::with_call(e, "_mm_rsqrt_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_rsqrt_ps(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_rsqrt_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_rsqrt_ps_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rsqrt_ps_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rsqrt_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_rsqrt_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_rsqrt_ps(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_rsqrt_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_rsqrt_ps_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rsqrt_ps_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rsqrt_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[5.421011e-20, 5.421011e-20, 5.421011e-20, 5.421011e-20]).map_err(|e| crate::cpu::with_call(e, "_mm_rsqrt_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_rsqrt_ps(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_rsqrt_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_rsqrt_ps_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rsqrt_ps_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rsqrt_ps(create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm_rsqrt_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_rsqrt_ps(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_rsqrt_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_rsqrt_ps_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rsqrt_ps_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rsqrt_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "_mm_rsqrt_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_rsqrt_ps(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_rsqrt_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_rsqrt_ps_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rsqrt_ps_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rsqrt_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[0.0, f32::NAN, -f32::INFINITY, f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "_mm_rsqrt_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_rsqrt_ps(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse_mm_rsqrt_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse_mm_rsqrt_ps_boundary_mixed_impl() }
}
