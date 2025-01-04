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
fn test_x86_sha_mm_sha256msg2_epu32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256msg2_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[221185, 327682, 3691028700, 536953158]).map_err(|e| crate::cpu::with_call(e, "_mm_sha256msg2_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha256msg2_epu32(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha256msg2_epu32() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha256msg2_epu32_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256msg2_epu32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256msg2_epu32(create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__m128i_from_u32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[491520, 221183, 805306853, 3288359123]).map_err(|e| crate::cpu::with_call(e, "_mm_sha256msg2_epu32(create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__m128i_from_u32_array([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha256msg2_epu32(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha256msg2_epu32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha256msg2_epu32_normal2_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256msg2_epu32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256msg2_epu32(create__m128i_from_u32_array([100, 200, 300, 400]), create__m128i_from_u32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[12435556, 16662728, 1480503397, 3900522880]).map_err(|e| crate::cpu::with_call(e, "_mm_sha256msg2_epu32(create__m128i_from_u32_array([100, 200, 300, 400]), create__m128i_from_u32_array([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha256msg2_epu32(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha256msg2_epu32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha256msg2_epu32_normal3_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256msg2_epu32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256msg2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_sha256msg2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha256msg2_epu32(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha256msg2_epu32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha256msg2_epu32_boundary_min_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256msg2_epu32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256msg2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4194302, 4194302, 53222, 53222]).map_err(|e| crate::cpu::with_call(e, "_mm_sha256msg2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha256msg2_epu32(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha256msg2_epu32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha256msg2_epu32_boundary_max_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256msg2_epu32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256msg2_epu32(create__m128i_from_u32_array([0, 0, 0, 0]), create__m128i_from_u32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_sha256msg2_epu32(create__m128i_from_u32_array([0, 0, 0, 0]), create__m128i_from_u32_array([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha256msg2_epu32(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha256msg2_epu32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha256msg2_epu32_boundary_zero_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256msg2_epu32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256msg2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4194302, 4194302, 53222, 53222]).map_err(|e| crate::cpu::with_call(e, "_mm_sha256msg2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha256msg2_epu32(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha256msg2_epu32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha256msg2_epu32_boundary_allones_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256msg2_epu32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256msg2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX])));
        check_array_equality(&result, &[0, 4194302, 0, 53222]).map_err(|e| crate::cpu::with_call(e, "_mm_sha256msg2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha256msg2_epu32(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha256msg2_epu32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha256msg2_epu32_boundary_mixed_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256msg2_epu32_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256msg2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4194303, 4194303, 28647, 28647]).map_err(|e| crate::cpu::with_call(e, "_mm_sha256msg2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha256msg2_epu32(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha256msg2_epu32_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha256msg2_epu32_asym_min_max_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256msg2_epu32_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256msg2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[4294967295, 4294967295, 4194302, 4194302]).map_err(|e| crate::cpu::with_call(e, "_mm_sha256msg2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha256msg2_epu32(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha256msg2_epu32_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha256msg2_epu32_asym_max_min_impl() }
}
