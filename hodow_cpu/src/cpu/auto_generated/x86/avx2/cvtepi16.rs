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

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cvtepi16_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cvtepi16_epi32(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 2, 0, 3, 0, 4, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtepi16_epi32(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtepi16_epi32(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cvtepi16_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cvtepi16_epi32_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cvtepi16_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cvtepi16_epi32(create__m128i_from_i32_array([0, -1, 2, -3])));
        check_array_equality(&result, &[0, 0, -1, -1, 2, 0, -3, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtepi16_epi32(create__m128i_from_i32_array([0, -1, 2, -3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtepi16_epi32(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cvtepi16_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cvtepi16_epi32_normal2_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cvtepi16_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cvtepi16_epi32(create__m128i_from_i32_array([100, 200, 300, 400])));
        check_array_equality(&result, &[100, 0, 200, 0, 300, 0, 400, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtepi16_epi32(create__m128i_from_i32_array([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtepi16_epi32(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cvtepi16_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cvtepi16_epi32_normal3_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cvtepi16_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cvtepi16_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, -32768, 0, -32768, 0, -32768, 0, -32768]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtepi16_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtepi16_epi32(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cvtepi16_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cvtepi16_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cvtepi16_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cvtepi16_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-1, 32767, -1, 32767, -1, 32767, -1, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtepi16_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtepi16_epi32(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cvtepi16_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cvtepi16_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cvtepi16_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cvtepi16_epi32(create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtepi16_epi32(create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtepi16_epi32(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cvtepi16_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cvtepi16_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cvtepi16_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cvtepi16_epi32(create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtepi16_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtepi16_epi32(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cvtepi16_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cvtepi16_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cvtepi16_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cvtepi16_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, -32768, -1, 32767, 0, 0, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtepi16_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtepi16_epi32(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cvtepi16_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cvtepi16_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cvtepi16_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_cvtepi16_epi64(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 0, 2, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtepi16_epi64(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtepi16_epi64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cvtepi16_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cvtepi16_epi64_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cvtepi16_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_cvtepi16_epi64(create__m128i_from_i64_array([0, -1])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtepi16_epi64(create__m128i_from_i64_array([0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtepi16_epi64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cvtepi16_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cvtepi16_epi64_normal2_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cvtepi16_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_cvtepi16_epi64(create__m128i_from_i64_array([100, 200])));
        check_array_equality(&result, &[100, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtepi16_epi64(create__m128i_from_i64_array([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtepi16_epi64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cvtepi16_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cvtepi16_epi64_normal3_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cvtepi16_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_cvtepi16_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0, 0, 0, -32768]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtepi16_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtepi16_epi64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cvtepi16_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cvtepi16_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cvtepi16_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_cvtepi16_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[-1, -1, -1, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtepi16_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtepi16_epi64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cvtepi16_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cvtepi16_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cvtepi16_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_cvtepi16_epi64(create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtepi16_epi64(create__m128i_from_i64_array([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtepi16_epi64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cvtepi16_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cvtepi16_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cvtepi16_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_cvtepi16_epi64(create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtepi16_epi64(create__m128i_from_i64_array([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtepi16_epi64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cvtepi16_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cvtepi16_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cvtepi16_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_cvtepi16_epi64(create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[0, 0, 0, -32768]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtepi16_epi64(create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtepi16_epi64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cvtepi16_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cvtepi16_epi64_boundary_mixed_impl() }
}
