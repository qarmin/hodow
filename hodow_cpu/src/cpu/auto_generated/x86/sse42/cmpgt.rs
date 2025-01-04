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

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpgt_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_cmpgt_epi64(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_cmpgt_epi64(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cmpgt_epi64(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse42_mm_cmpgt_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_sse42_mm_cmpgt_epi64_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpgt_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_cmpgt_epi64(create__m128i_from_i64_array([0, -1]), create__m128i_from_i64_array([10, 9])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_cmpgt_epi64(create__m128i_from_i64_array([0, -1]), create__m128i_from_i64_array([10, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cmpgt_epi64(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse42_mm_cmpgt_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse42_mm_cmpgt_epi64_normal2_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpgt_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_cmpgt_epi64(create__m128i_from_i64_array([100, 200]), create__m128i_from_i64_array([110, 210])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_cmpgt_epi64(create__m128i_from_i64_array([100, 200]), create__m128i_from_i64_array([110, 210]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cmpgt_epi64(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse42_mm_cmpgt_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse42_mm_cmpgt_epi64_normal3_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpgt_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_cmpgt_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_cmpgt_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cmpgt_epi64(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse42_mm_cmpgt_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse42_mm_cmpgt_epi64_boundary_min_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpgt_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_cmpgt_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_cmpgt_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cmpgt_epi64(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse42_mm_cmpgt_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse42_mm_cmpgt_epi64_boundary_max_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpgt_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_cmpgt_epi64(create__m128i_from_i64_array([0, 0]), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_cmpgt_epi64(create__m128i_from_i64_array([0, 0]), create__m128i_from_i64_array([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cmpgt_epi64(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse42_mm_cmpgt_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse42_mm_cmpgt_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpgt_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_cmpgt_epi64(create__m128i_from_i64_array([-1, -1]), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_cmpgt_epi64(create__m128i_from_i64_array([-1, -1]), create__m128i_from_i64_array([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cmpgt_epi64(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse42_mm_cmpgt_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse42_mm_cmpgt_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpgt_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_cmpgt_epi64(create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_cmpgt_epi64(create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cmpgt_epi64(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse42_mm_cmpgt_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse42_mm_cmpgt_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpgt_epi64_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_cmpgt_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_cmpgt_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cmpgt_epi64(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse42_mm_cmpgt_epi64_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse42_mm_cmpgt_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpgt_epi64_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_cmpgt_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_cmpgt_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cmpgt_epi64(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse42_mm_cmpgt_epi64_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse42_mm_cmpgt_epi64_asym_max_min_impl() }
}
