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

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_testnzc_si128_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_testnzc_si128(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_testnzc_si128(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_testnzc_si128(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_testnzc_si128() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_testnzc_si128_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_testnzc_si128_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_testnzc_si128(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_testnzc_si128(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_testnzc_si128(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_testnzc_si128_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_testnzc_si128_normal2_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_testnzc_si128_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_testnzc_si128(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_testnzc_si128(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_testnzc_si128(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_testnzc_si128_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_testnzc_si128_normal3_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_testnzc_si128_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_testnzc_si128(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_testnzc_si128(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_testnzc_si128(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_testnzc_si128_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_testnzc_si128_boundary_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_testnzc_si128_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_testnzc_si128(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_testnzc_si128(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_testnzc_si128(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_testnzc_si128_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_testnzc_si128_boundary_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_testnzc_si128_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_testnzc_si128(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_testnzc_si128(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_testnzc_si128(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_testnzc_si128_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_testnzc_si128_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_testnzc_si128_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_testnzc_si128(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_testnzc_si128(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_testnzc_si128(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_testnzc_si128_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_testnzc_si128_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_testnzc_si128_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_testnzc_si128(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_testnzc_si128(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_testnzc_si128(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_testnzc_si128_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_testnzc_si128_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_testnzc_si128_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_testnzc_si128(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_testnzc_si128(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_testnzc_si128(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_testnzc_si128_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_testnzc_si128_asym_min_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_testnzc_si128_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_testnzc_si128(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_testnzc_si128(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_testnzc_si128(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_testnzc_si128_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_testnzc_si128_asym_max_min_impl() }
}
