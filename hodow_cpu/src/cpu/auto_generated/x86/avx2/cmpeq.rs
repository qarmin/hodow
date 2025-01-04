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
fn test_x86_avx2_mm256_cmpeq_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_cmpeq_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi64(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi64_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_cmpeq_epi64(create__m256i_from([0, -1, 2, -3]), create__m256i_from([10, 9, 12, 7])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi64(create__m256i_from([0, -1, 2, -3]), create__m256i_from([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi64(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi64_normal2_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_cmpeq_epi64(create__m256i_from([100, 200, 300, 400]), create__m256i_from([110, 210, 310, 410])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi64(create__m256i_from([100, 200, 300, 400]), create__m256i_from([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi64(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi64_normal3_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_cmpeq_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi64(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_cmpeq_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi64(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_cmpeq_epi64(create__m256i_from([0, 0, 0, 0]), create__m256i_from([0, 0, 0, 0])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi64(create__m256i_from([0, 0, 0, 0]), create__m256i_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi64(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_cmpeq_epi64(create__m256i_from([-1, -1, -1, -1]), create__m256i_from([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi64(create__m256i_from([-1, -1, -1, -1]), create__m256i_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi64(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_cmpeq_epi64(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__m256i_from([i64::MIN, i64::MAX, 0, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi64(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__m256i_from([i64::MIN, i64::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi64(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi64_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_cmpeq_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi64(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi64_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi64_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_cmpeq_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi64(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi64_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx2,sse4.1")]
fn test_x86_avx2_mm256_cmpeq_epi64_vs_narrow_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("sse4.1")) {
            return Ok(Verdict::Skipped("sse4.1 not present"));
        }
    unsafe {
        let a_wide = create__m256i_from([1i64, 2i64, 3i64, 4i64]);
        let a_narrow = create__m128i_from_i64_array([1i64, 2i64]);
        let b_wide = create__m256i_from([5i64, 6i64, 7i64, 8i64]);
        let b_narrow = create__m128i_from_i64_array([5i64, 6i64]);
        let wide = unpack__m256i_to_i64_array(_mm256_cmpeq_epi64(a_wide, b_wide));
        let narrow = unpack__m128i_to_i64_array(_mm_cmpeq_epi64(a_narrow, b_narrow));
        check_array_equality(&wide[..2], &narrow).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi64(a_wide, b_wide) vs _mm_cmpeq_epi64(a_narrow, b_narrow)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi64_vs_narrow() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi64_vs_narrow_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cmpeq_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi32_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cmpeq_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi32_normal2_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cmpeq_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi32_normal3_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cmpeq_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cmpeq_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cmpeq_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cmpeq_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cmpeq_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi32_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cmpeq_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi32_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi32_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cmpeq_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi32_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx2,sse2")]
fn test_x86_avx2_mm256_cmpeq_epi32_vs_narrow_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("sse2")) {
            return Ok(Verdict::Skipped("sse2 not present"));
        }
    unsafe {
        let a_wide = create__m256i_from_i32_array([1i32, 2i32, 3i32, 4i32, 5i32, 6i32, 7i32, 8i32]);
        let a_narrow = create__m128i_from_i32_array([1i32, 2i32, 3i32, 4i32]);
        let b_wide = create__m256i_from_i32_array([9i32, 10i32, 11i32, 12i32, 13i32, 14i32, 15i32, 16i32]);
        let b_narrow = create__m128i_from_i32_array([9i32, 10i32, 11i32, 12i32]);
        let wide = unpack__m256i_to_i32_array(_mm256_cmpeq_epi32(a_wide, b_wide));
        let narrow = unpack__m128i_to_i32_array(_mm_cmpeq_epi32(a_narrow, b_narrow));
        check_array_equality(&wide[..4], &narrow).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi32(a_wide, b_wide) vs _mm_cmpeq_epi32(a_narrow, b_narrow)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi32_vs_narrow() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi32_vs_narrow_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_cmpeq_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi16(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi16_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi16_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_cmpeq_epi16(create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi16(create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi16(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi16_normal2_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi16_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_cmpeq_epi16(create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m256i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi16(create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m256i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi16(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi16_normal3_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi16_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_cmpeq_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi16(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi16_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_cmpeq_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi16(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi16_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_cmpeq_epi16(create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi16(create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi16(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi16_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_cmpeq_epi16(create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi16(create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi16(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_cmpeq_epi16(create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi16(create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi16(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi16_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_cmpeq_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi16(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi16_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi16_asym_min_max_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi16_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_cmpeq_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi16(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi16_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi16_asym_max_min_impl() }
}

#[target_feature(enable = "avx2,sse2")]
fn test_x86_avx2_mm256_cmpeq_epi16_vs_narrow_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("sse2")) {
            return Ok(Verdict::Skipped("sse2 not present"));
        }
    unsafe {
        let a_wide = create__m256i_from_i16_array([1i16, 2i16, 3i16, 4i16, 5i16, 6i16, 7i16, 8i16, 9i16, 10i16, 11i16, 12i16, 13i16, 14i16, 15i16, 16i16]);
        let a_narrow = create__m128i_from_i16_array([1i16, 2i16, 3i16, 4i16, 5i16, 6i16, 7i16, 8i16]);
        let b_wide = create__m256i_from_i16_array([17i16, 18i16, 19i16, 20i16, 21i16, 22i16, 23i16, 24i16, 25i16, 26i16, 27i16, 28i16, 29i16, 30i16, 31i16, 32i16]);
        let b_narrow = create__m128i_from_i16_array([17i16, 18i16, 19i16, 20i16, 21i16, 22i16, 23i16, 24i16]);
        let wide = unpack__m256i_to_i16_array(_mm256_cmpeq_epi16(a_wide, b_wide));
        let narrow = unpack__m128i_to_i16_array(_mm_cmpeq_epi16(a_narrow, b_narrow));
        check_array_equality(&wide[..8], &narrow).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi16(a_wide, b_wide) vs _mm_cmpeq_epi16(a_narrow, b_narrow)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi16_vs_narrow() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi16_vs_narrow_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_cmpeq_epi8(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0, -1, -1, -1, 0, -1, -1, -1, 0, -1, -1, -1, 0, -1, -1, -1, 0, -1, -1, -1, 0, -1, -1, -1, 0, -1, -1, -1, 0, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi8(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi8(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi8_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi8_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_cmpeq_epi8(create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi8(create__m256i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi8(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi8_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi8_normal2_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi8_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_cmpeq_epi8(create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128]), create__m256i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74, -82, 18, 118, -38, 62, -94, 6, 106, -50, 50, -106, -6, 94, -62, 38, -118])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi8(create__m256i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84, -72, 28, -128]), create__m256i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74, -82, 18, 118, -38, 62, -94, 6, 106, -50, 50, -106, -6, 94, -62, 38, -118]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi8(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi8_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi8_normal3_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi8_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_cmpeq_epi8(create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi8(create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi8(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi8_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi8_boundary_min_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi8_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_cmpeq_epi8(create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi8(create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi8(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi8_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi8_boundary_max_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi8_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_cmpeq_epi8(create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi8(create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi8(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi8_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi8_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_cmpeq_epi8(create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi8(create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi8(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi8_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi8_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_cmpeq_epi8(create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi8(create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__m256i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi8(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi8_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi8_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_cmpeq_epi8(create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi8(create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi8(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi8_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi8_asym_min_max_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_cmpeq_epi8_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i8_array(_mm256_cmpeq_epi8(create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi8(create__m256i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m256i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cmpeq_epi8(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi8_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi8_asym_max_min_impl() }
}

#[target_feature(enable = "avx2,sse2")]
fn test_x86_avx2_mm256_cmpeq_epi8_vs_narrow_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("sse2")) {
            return Ok(Verdict::Skipped("sse2 not present"));
        }
    unsafe {
        let a_wide = create__m256i_from_i8_array([1i8, 2i8, 3i8, 4i8, 5i8, 6i8, 7i8, 8i8, 9i8, 10i8, 11i8, 12i8, 13i8, 14i8, 15i8, 16i8, 17i8, 18i8, 19i8, 20i8, 21i8, 22i8, 23i8, 24i8, 25i8, 26i8, 27i8, 28i8, 29i8, 30i8, 31i8, 32i8]);
        let a_narrow = create__m128i_from_i8_array([1i8, 2i8, 3i8, 4i8, 5i8, 6i8, 7i8, 8i8, 9i8, 10i8, 11i8, 12i8, 13i8, 14i8, 15i8, 16i8]);
        let b_wide = create__m256i_from_i8_array([33i8, 34i8, 35i8, 36i8, 37i8, 38i8, 39i8, 40i8, 41i8, 42i8, 43i8, 44i8, 45i8, 46i8, 47i8, 48i8, 49i8, 50i8, 51i8, 52i8, 53i8, 54i8, 55i8, 56i8, 57i8, 58i8, 59i8, 60i8, 61i8, 62i8, 63i8, 64i8]);
        let b_narrow = create__m128i_from_i8_array([33i8, 34i8, 35i8, 36i8, 37i8, 38i8, 39i8, 40i8, 41i8, 42i8, 43i8, 44i8, 45i8, 46i8, 47i8, 48i8]);
        let wide = unpack__m256i_to_i8_array(_mm256_cmpeq_epi8(a_wide, b_wide));
        let narrow = unpack__m128i_to_i8_array(_mm_cmpeq_epi8(a_narrow, b_narrow));
        check_array_equality(&wide[..16], &narrow).map_err(|e| crate::cpu::with_call(e, "_mm256_cmpeq_epi8(a_wide, b_wide) vs _mm_cmpeq_epi8(a_narrow, b_narrow)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_cmpeq_epi8_vs_narrow() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_cmpeq_epi8_vs_narrow_impl() }
}
