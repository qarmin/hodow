use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsi128_si64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtsi128_si64(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result, 8589934593).map_err(|e| crate::cpu::with_call(e, "_mm_cvtsi128_si64(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi128_si64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvtsi128_si64() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvtsi128_si64_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsi128_si64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtsi128_si64(create__m128i_from_i32_array([0, -1, 2, -3]));
        check_int_equality(result, -4294967296).map_err(|e| crate::cpu::with_call(e, "_mm_cvtsi128_si64(create__m128i_from_i32_array([0, -1, 2, -3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi128_si64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvtsi128_si64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvtsi128_si64_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsi128_si64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtsi128_si64(create__m128i_from_i32_array([100, 200, 300, 400]));
        check_int_equality(result, 858993459300).map_err(|e| crate::cpu::with_call(e, "_mm_cvtsi128_si64(create__m128i_from_i32_array([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi128_si64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvtsi128_si64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvtsi128_si64_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsi128_si64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtsi128_si64(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, -9223372034707292160).map_err(|e| crate::cpu::with_call(e, "_mm_cvtsi128_si64(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi128_si64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvtsi128_si64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvtsi128_si64_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsi128_si64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtsi128_si64(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, 9223372034707292159).map_err(|e| crate::cpu::with_call(e, "_mm_cvtsi128_si64(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi128_si64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvtsi128_si64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvtsi128_si64_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsi128_si64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtsi128_si64(create__m128i_from_i32_array([0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_cvtsi128_si64(create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi128_si64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvtsi128_si64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvtsi128_si64_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsi128_si64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtsi128_si64(create__m128i_from_i32_array([-1, -1, -1, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "_mm_cvtsi128_si64(create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi128_si64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvtsi128_si64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvtsi128_si64_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsi128_si64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtsi128_si64(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result, 9223372034707292160).map_err(|e| crate::cpu::with_call(e, "_mm_cvtsi128_si64(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi128_si64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvtsi128_si64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvtsi128_si64_boundary_mixed_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsi128_si64x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtsi128_si64x(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result, 8589934593).map_err(|e| crate::cpu::with_call(e, "_mm_cvtsi128_si64x(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi128_si64x(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvtsi128_si64x() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvtsi128_si64x_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsi128_si64x_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtsi128_si64x(create__m128i_from_i32_array([0, -1, 2, -3]));
        check_int_equality(result, -4294967296).map_err(|e| crate::cpu::with_call(e, "_mm_cvtsi128_si64x(create__m128i_from_i32_array([0, -1, 2, -3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi128_si64x(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvtsi128_si64x_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvtsi128_si64x_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsi128_si64x_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtsi128_si64x(create__m128i_from_i32_array([100, 200, 300, 400]));
        check_int_equality(result, 858993459300).map_err(|e| crate::cpu::with_call(e, "_mm_cvtsi128_si64x(create__m128i_from_i32_array([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi128_si64x(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvtsi128_si64x_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvtsi128_si64x_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsi128_si64x_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtsi128_si64x(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, -9223372034707292160).map_err(|e| crate::cpu::with_call(e, "_mm_cvtsi128_si64x(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi128_si64x(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvtsi128_si64x_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvtsi128_si64x_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsi128_si64x_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtsi128_si64x(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, 9223372034707292159).map_err(|e| crate::cpu::with_call(e, "_mm_cvtsi128_si64x(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi128_si64x(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvtsi128_si64x_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvtsi128_si64x_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsi128_si64x_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtsi128_si64x(create__m128i_from_i32_array([0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_cvtsi128_si64x(create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi128_si64x(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvtsi128_si64x_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvtsi128_si64x_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsi128_si64x_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtsi128_si64x(create__m128i_from_i32_array([-1, -1, -1, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "_mm_cvtsi128_si64x(create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi128_si64x(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvtsi128_si64x_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvtsi128_si64x_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsi128_si64x_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cvtsi128_si64x(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result, 9223372034707292160).map_err(|e| crate::cpu::with_call(e, "_mm_cvtsi128_si64x(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi128_si64x(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_sse2_mm_cvtsi128_si64x_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_64_sse2_mm_cvtsi128_si64x_boundary_mixed_impl() }
}
