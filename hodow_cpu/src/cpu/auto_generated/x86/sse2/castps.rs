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
fn test_x86_sse2_mm_castps_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_castps_pd(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[2.000000473111868, 512.0001225471497]).map_err(|e| crate::cpu::with_call(e, "_mm_castps_pd(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_castps_pd(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_castps_pd() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_castps_pd_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_castps_si128_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_castps_si128(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1065353216, 1073741824, 1077936128, 1082130432]).map_err(|e| crate::cpu::with_call(e, "_mm_castps_si128(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_castps_si128(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_castps_si128() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_castps_si128_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_castps_si128_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_castps_si128(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32])));
        check_array_equality(&result, &[0, -1082130432, 1073741824, -1069547520]).map_err(|e| crate::cpu::with_call(e, "_mm_castps_si128(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_castps_si128(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_castps_si128_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_castps_si128_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_castps_si128_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_castps_si128(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32])));
        check_array_equality(&result, &[1120403456, 1128792064, 1133903872, 1137180672]).map_err(|e| crate::cpu::with_call(e, "_mm_castps_si128(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_castps_si128(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_castps_si128_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_castps_si128_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_castps_si128_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_castps_si128(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_array_equality(&result, &[-8388609, -8388609, -8388609, -8388609]).map_err(|e| crate::cpu::with_call(e, "_mm_castps_si128(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_castps_si128(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_castps_si128_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_castps_si128_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_castps_si128_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_castps_si128(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_array_equality(&result, &[2139095039, 2139095039, 2139095039, 2139095039]).map_err(|e| crate::cpu::with_call(e, "_mm_castps_si128(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_castps_si128(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_castps_si128_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_castps_si128_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_castps_si128_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_castps_si128(create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_castps_si128(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_castps_si128(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_castps_si128_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_castps_si128_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_castps_si128_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_castps_si128(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_array_equality(&result, &[2143289344, 2143289344, 2143289344, 2143289344]).map_err(|e| crate::cpu::with_call(e, "_mm_castps_si128(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_castps_si128(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_castps_si128_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_castps_si128_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_castps_si128_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_castps_si128(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_array_equality(&result, &[2139095040, -8388608, -2147483648, 4194304]).map_err(|e| crate::cpu::with_call(e, "_mm_castps_si128(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_castps_si128(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_castps_si128_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_castps_si128_boundary_mixed_impl() }
}
