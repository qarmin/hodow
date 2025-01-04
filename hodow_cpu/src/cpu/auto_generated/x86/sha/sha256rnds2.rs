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
fn test_x86_sha_mm_sha256rnds2_epu32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256rnds2_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[415236881, 1178701972, 419439380, 1689133364]).map_err(|e| crate::cpu::with_call(e, "_mm_sha256rnds2_epu32(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha256rnds2_epu32(create_random__m128i(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha256rnds2_epu32() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha256rnds2_epu32_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256rnds2_epu32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256rnds2_epu32(create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__m128i_from_u32_array([10, 9, 12, 7]), create__m128i_from_u32_array([20, 19, 22, 17])));
        check_array_equality(&result, &[622855316, 1376939545, 3847757984, 2934312860]).map_err(|e| crate::cpu::with_call(e, "_mm_sha256rnds2_epu32(create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__m128i_from_u32_array([10, 9, 12, 7]), create__m128i_from_u32_array([20, 19, 22, 17]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha256rnds2_epu32(create_random__m128i(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha256rnds2_epu32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha256rnds2_epu32_normal2_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256rnds2_epu32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256rnds2_epu32(create__m128i_from_u32_array([100, 200, 300, 400]), create__m128i_from_u32_array([110, 210, 310, 410]), create__m128i_from_u32_array([120, 220, 320, 420])));
        check_array_equality(&result, &[1379953493, 534177463, 3742815265, 2909974811]).map_err(|e| crate::cpu::with_call(e, "_mm_sha256rnds2_epu32(create__m128i_from_u32_array([100, 200, 300, 400]), create__m128i_from_u32_array([110, 210, 310, 410]), create__m128i_from_u32_array([120, 220, 320, 420]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha256rnds2_epu32(create_random__m128i(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha256rnds2_epu32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha256rnds2_epu32_normal3_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256rnds2_epu32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256rnds2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_sha256rnds2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha256rnds2_epu32(create_random__m128i(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha256rnds2_epu32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha256rnds2_epu32_boundary_min_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256rnds2_epu32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256rnds2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967291, 4018142715, 4294967290, 2941774329]).map_err(|e| crate::cpu::with_call(e, "_mm_sha256rnds2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha256rnds2_epu32(create_random__m128i(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha256rnds2_epu32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha256rnds2_epu32_boundary_max_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256rnds2_epu32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256rnds2_epu32(create__m128i_from_u32_array([0, 0, 0, 0]), create__m128i_from_u32_array([0, 0, 0, 0]), create__m128i_from_u32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_sha256rnds2_epu32(create__m128i_from_u32_array([0, 0, 0, 0]), create__m128i_from_u32_array([0, 0, 0, 0]), create__m128i_from_u32_array([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha256rnds2_epu32(create_random__m128i(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha256rnds2_epu32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha256rnds2_epu32_boundary_zero_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256rnds2_epu32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256rnds2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967291, 4018142715, 4294967290, 2941774329]).map_err(|e| crate::cpu::with_call(e, "_mm_sha256rnds2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha256rnds2_epu32(create_random__m128i(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha256rnds2_epu32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha256rnds2_epu32_boundary_allones_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256rnds2_epu32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256rnds2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX])));
        check_array_equality(&result, &[4294967295, 4294967291, 4294967293, 2146433016]).map_err(|e| crate::cpu::with_call(e, "_mm_sha256rnds2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha256rnds2_epu32(create_random__m128i(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha256rnds2_epu32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha256rnds2_epu32_boundary_mixed_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256rnds2_epu32_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256rnds2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[4294967295, 0, 4294967293, 2146433022]).map_err(|e| crate::cpu::with_call(e, "_mm_sha256rnds2_epu32(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha256rnds2_epu32(create_random__m128i(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha256rnds2_epu32_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha256rnds2_epu32_asym_min_max_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha256rnds2_epu32_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha256rnds2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[4294967294, 4225761151, 4294967295, 4225761151]).map_err(|e| crate::cpu::with_call(e, "_mm_sha256rnds2_epu32(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha256rnds2_epu32(create_random__m128i(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha256rnds2_epu32_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha256rnds2_epu32_asym_max_min_impl() }
}
