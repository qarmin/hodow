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

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_extracti_si64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_extracti_si64::<0, 0>(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result[..2], &[1, 2, 3, 4][..2]).map_err(|e| crate::cpu::with_call(e, "_mm_extracti_si64::<0, 0>(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extracti_si64::<0, 0>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse4a_mm_extracti_si64() -> Result<Verdict, String> {
    unsafe { test_x86_sse4a_mm_extracti_si64_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_extracti_si64_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_extracti_si64::<0, 0>(create__m128i_from_i32_array([0, -1, 2, -3])));
        check_array_equality(&result[..2], &[0, -1, 2, -3][..2]).map_err(|e| crate::cpu::with_call(e, "_mm_extracti_si64::<0, 0>(create__m128i_from_i32_array([0, -1, 2, -3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extracti_si64::<0, 0>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse4a_mm_extracti_si64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse4a_mm_extracti_si64_normal2_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_extracti_si64_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_extracti_si64::<0, 0>(create__m128i_from_i32_array([100, 200, 300, 400])));
        check_array_equality(&result[..2], &[100, 200, 300, 400][..2]).map_err(|e| crate::cpu::with_call(e, "_mm_extracti_si64::<0, 0>(create__m128i_from_i32_array([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extracti_si64::<0, 0>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse4a_mm_extracti_si64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse4a_mm_extracti_si64_normal3_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_extracti_si64_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_extracti_si64::<0, 0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result[..2], &[-2147483648, -2147483648, -2147483648, -2147483648][..2]).map_err(|e| crate::cpu::with_call(e, "_mm_extracti_si64::<0, 0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extracti_si64::<0, 0>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse4a_mm_extracti_si64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse4a_mm_extracti_si64_boundary_min_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_extracti_si64_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_extracti_si64::<0, 0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result[..2], &[2147483647, 2147483647, 2147483647, 2147483647][..2]).map_err(|e| crate::cpu::with_call(e, "_mm_extracti_si64::<0, 0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extracti_si64::<0, 0>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse4a_mm_extracti_si64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse4a_mm_extracti_si64_boundary_max_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_extracti_si64_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_extracti_si64::<0, 0>(create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result[..2], &[0, 0, 0, 0][..2]).map_err(|e| crate::cpu::with_call(e, "_mm_extracti_si64::<0, 0>(create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extracti_si64::<0, 0>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse4a_mm_extracti_si64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse4a_mm_extracti_si64_boundary_zero_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_extracti_si64_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_extracti_si64::<0, 0>(create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result[..2], &[-1, -1, -1, -1][..2]).map_err(|e| crate::cpu::with_call(e, "_mm_extracti_si64::<0, 0>(create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extracti_si64::<0, 0>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse4a_mm_extracti_si64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse4a_mm_extracti_si64_boundary_allones_impl() }
}

#[target_feature(enable = "sse4a")]
fn test_x86_sse4a_mm_extracti_si64_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_extracti_si64::<0, 0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result[..2], &[-2147483648, 2147483647, 0, -1][..2]).map_err(|e| crate::cpu::with_call(e, "_mm_extracti_si64::<0, 0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extracti_si64::<0, 0>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse4a_mm_extracti_si64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse4a_mm_extracti_si64_boundary_mixed_impl() }
}
