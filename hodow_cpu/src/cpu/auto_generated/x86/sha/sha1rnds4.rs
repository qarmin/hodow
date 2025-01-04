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
fn test_x86_sha_mm_sha1rnds4_epu32_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1rnds4_epu32::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[3600850568, 2863951747, 884620151, 877299341]).map_err(|e| crate::cpu::with_call(e, "_mm_sha1rnds4_epu32::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha1rnds4_epu32::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha1rnds4_epu32() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha1rnds4_epu32_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1rnds4_epu32_normal2_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__m128i_from_u32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[1453366872, 2327079284, 2402921799, 426180881]).map_err(|e| crate::cpu::with_call(e, "_mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([0, 4294967295, 2, 4294967293]), create__m128i_from_u32_array([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha1rnds4_epu32::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha1rnds4_epu32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha1rnds4_epu32_normal2_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1rnds4_epu32_normal3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([100, 200, 300, 400]), create__m128i_from_u32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[3600853854, 2864057017, 3045578856, 2382213550]).map_err(|e| crate::cpu::with_call(e, "_mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([100, 200, 300, 400]), create__m128i_from_u32_array([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha1rnds4_epu32::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha1rnds4_epu32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha1rnds4_epu32_normal3_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1rnds4_epu32_boundary_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[1453366886, 716466993, 3031962158, 4093987763]).map_err(|e| crate::cpu::with_call(e, "_mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha1rnds4_epu32::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha1rnds4_epu32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha1rnds4_epu32_boundary_min_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1rnds4_epu32_boundary_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[2527108709, 1790208792, 3031958987, 3375502092]).map_err(|e| crate::cpu::with_call(e, "_mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha1rnds4_epu32::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha1rnds4_epu32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha1rnds4_epu32_boundary_max_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1rnds4_epu32_boundary_zero_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([0, 0, 0, 0]), create__m128i_from_u32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[1453366886, 716466993, 3031962158, 4093987763]).map_err(|e| crate::cpu::with_call(e, "_mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([0, 0, 0, 0]), create__m128i_from_u32_array([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha1rnds4_epu32::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha1rnds4_epu32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha1rnds4_epu32_boundary_zero_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1rnds4_epu32_boundary_allones_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[2527108709, 1790208792, 3031958987, 3375502092]).map_err(|e| crate::cpu::with_call(e, "_mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha1rnds4_epu32::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha1rnds4_epu32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha1rnds4_epu32_boundary_allones_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1rnds4_epu32_boundary_mixed_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX])));
        check_array_equality(&result, &[3600850533, 716466977, 255493059, 427938169]).map_err(|e| crate::cpu::with_call(e, "_mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha1rnds4_epu32::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha1rnds4_epu32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha1rnds4_epu32_boundary_mixed_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1rnds4_epu32_asym_min_max_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[379625062, 3937692456, 3031961101, 4093953904]).map_err(|e| crate::cpu::with_call(e, "_mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha1rnds4_epu32::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha1rnds4_epu32_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha1rnds4_epu32_asym_min_max_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1rnds4_epu32_asym_max_min_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[3600850533, 2863950624, 3031960044, 3375535787]).map_err(|e| crate::cpu::with_call(e, "_mm_sha1rnds4_epu32::<0>(create__m128i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m128i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha1rnds4_epu32::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha1rnds4_epu32_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha1rnds4_epu32_asym_max_min_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1rnds4_epu32_imm_1_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1rnds4_epu32::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[1538685706, 42327095, 1621226322, 2495177161]).map_err(|e| crate::cpu::with_call(e, "_mm_sha1rnds4_epu32::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha1rnds4_epu32::<1>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha1rnds4_epu32_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha1rnds4_epu32_imm_1_impl() }
}

#[target_feature(enable = "sha")]
fn test_x86_sha_mm_sha1rnds4_epu32_imm_3_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let result = unpack__m128i_to_u32_array(_mm_sha1rnds4_epu32::<3>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[2996351127, 1974387567, 2888252407, 1936588283]).map_err(|e| crate::cpu::with_call(e, "_mm_sha1rnds4_epu32::<3>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_sha1rnds4_epu32::<3>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sha_mm_sha1rnds4_epu32_imm_3() -> Result<Verdict, String> {
    unsafe { test_x86_sha_mm_sha1rnds4_epu32_imm_3_impl() }
}
