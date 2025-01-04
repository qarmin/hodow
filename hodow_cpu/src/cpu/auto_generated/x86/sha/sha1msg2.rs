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

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1msg2_epu32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1msg2_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[14, 14, 10, 6]).map_err(|e| crate::cpu::with_call(e, "_mm_sha1msg2_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha1msg2_epu32(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha1msg2_epu32() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha1msg2_epu32_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1msg2_epu32_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1msg2_epu32(create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__m128i_from_u32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[4294967239, 4294967275, 22, 4294967267]).map_err(|e| crate::cpu::with_call(e, "_mm_sha1msg2_epu32(create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__m128i_from_u32_array([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha1msg2_epu32(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha1msg2_epu32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha1msg2_epu32_normal2_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1msg2_epu32_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1msg2_epu32(create__m128i_from_u32_array([100, 200, 300, 400]), create__m128i_from_u32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[592, 332, 1020, 332]).map_err(|e| crate::cpu::with_call(e, "_mm_sha1msg2_epu32(create__m128i_from_u32_array([100, 200, 300, 400]), create__m128i_from_u32_array([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha1msg2_epu32(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha1msg2_epu32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha1msg2_epu32_normal3_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1msg2_epu32_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1msg2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_sha1msg2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha1msg2_epu32(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha1msg2_epu32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha1msg2_epu32_boundary_min_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1msg2_epu32_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1msg2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967295, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_sha1msg2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha1msg2_epu32(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha1msg2_epu32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha1msg2_epu32_boundary_max_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1msg2_epu32_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1msg2_epu32(create__m128i_from_u32_array([0, 0, 0, 0]), create__m128i_from_u32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_sha1msg2_epu32(create__m128i_from_u32_array([0, 0, 0, 0]), create__m128i_from_u32_array([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha1msg2_epu32(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha1msg2_epu32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha1msg2_epu32_boundary_zero_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1msg2_epu32_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1msg2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967295, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_sha1msg2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha1msg2_epu32(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha1msg2_epu32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha1msg2_epu32_boundary_allones_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1msg2_epu32_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1msg2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295]).map_err(|e| crate::cpu::with_call(e, "_mm_sha1msg2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha1msg2_epu32(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha1msg2_epu32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha1msg2_epu32_boundary_mixed_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1msg2_epu32_asym_min_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1msg2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295]).map_err(|e| crate::cpu::with_call(e, "_mm_sha1msg2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha1msg2_epu32(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha1msg2_epu32_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha1msg2_epu32_asym_min_max_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1msg2_epu32_asym_max_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1msg2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0, 4294967295, 4294967295, 4294967295]).map_err(|e| crate::cpu::with_call(e, "_mm_sha1msg2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha1msg2_epu32(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha1msg2_epu32_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha1msg2_epu32_asym_max_min_impl() }
}
