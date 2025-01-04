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
fn test_x86_avx2_mm256_mul_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mul_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 0, 33, 0, 65, 0, 105, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mul_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mul_epi32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_mul_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_mul_epi32_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_mul_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mul_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 0, 24, 0, 56, 0, 96, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mul_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mul_epi32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_mul_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_mul_epi32_normal2_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_mul_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mul_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[11000, 0, 93000, 0, 255000, 0, 497000, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mul_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mul_epi32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_mul_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_mul_epi32_normal3_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_mul_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mul_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, 1073741824, 0, 1073741824, 0, 1073741824, 0, 1073741824]).map_err(|e| crate::cpu::with_call(e, "_mm256_mul_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mul_epi32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_mul_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_mul_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_mul_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mul_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[1, 1073741823, 1, 1073741823, 1, 1073741823, 1, 1073741823]).map_err(|e| crate::cpu::with_call(e, "_mm256_mul_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mul_epi32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_mul_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_mul_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_mul_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mul_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mul_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mul_epi32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_mul_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_mul_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_mul_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mul_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[1, 0, 1, 0, 1, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mul_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mul_epi32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_mul_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_mul_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_mul_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mul_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 1073741824, 0, 0, 0, 1073741824, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mul_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mul_epi32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_mul_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_mul_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_mul_epi32_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mul_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-2147483648, -1073741824, -2147483648, -1073741824, -2147483648, -1073741824, -2147483648, -1073741824]).map_err(|e| crate::cpu::with_call(e, "_mm256_mul_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mul_epi32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_mul_epi32_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_mul_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_mul_epi32_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mul_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -1073741824, -2147483648, -1073741824, -2147483648, -1073741824, -2147483648, -1073741824]).map_err(|e| crate::cpu::with_call(e, "_mm256_mul_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mul_epi32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_mul_epi32_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_mul_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx2,sse4.1")]
fn test_x86_avx2_mm256_mul_epi32_vs_narrow_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("sse4.1")) {
            return Ok(Verdict::Skipped("sse4.1 not present"));
        }
    unsafe {
        let a_wide = create__m256i_from_i32_array([1i32, 2i32, 3i32, 4i32, 5i32, 6i32, 7i32, 8i32]);
        let a_narrow = create__m128i_from_i32_array([1i32, 2i32, 3i32, 4i32]);
        let b_wide = create__m256i_from_i32_array([9i32, 10i32, 11i32, 12i32, 13i32, 14i32, 15i32, 16i32]);
        let b_narrow = create__m128i_from_i32_array([9i32, 10i32, 11i32, 12i32]);
        let wide = unpack__m256i_to_i32_array(_mm256_mul_epi32(a_wide, b_wide));
        let narrow = unpack__m128i_to_i32_array(_mm_mul_epi32(a_narrow, b_narrow));
        check_array_equality(&wide[..4], &narrow).map_err(|e| crate::cpu::with_call(e, "_mm256_mul_epi32(a_wide, b_wide) vs _mm_mul_epi32(a_narrow, b_narrow)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_mul_epi32_vs_narrow() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_mul_epi32_vs_narrow_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_mul_epu32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_mul_epu32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 0, 33, 0, 65, 0, 105, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mul_epu32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mul_epu32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_mul_epu32() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_mul_epu32_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_mul_epu32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_mul_epu32(create__m256i_from_u32_array([0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289]), create__m256i_from_u32_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 0, 24, 0, 56, 0, 96, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mul_epu32(create__m256i_from_u32_array([0, 4294967295, 2, 4294967293, 4, 4294967291, 6, 4294967289]), create__m256i_from_u32_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mul_epu32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_mul_epu32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_mul_epu32_normal2_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_mul_epu32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_mul_epu32(create__m256i_from_u32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_u32_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[11000, 0, 93000, 0, 255000, 0, 497000, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mul_epu32(create__m256i_from_u32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_u32_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mul_epu32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_mul_epu32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_mul_epu32_normal3_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_mul_epu32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_mul_epu32(create__m256i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m256i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mul_epu32(create__m256i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m256i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mul_epu32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_mul_epu32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_mul_epu32_boundary_min_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_mul_epu32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_mul_epu32(create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[1, 4294967294, 1, 4294967294, 1, 4294967294, 1, 4294967294]).map_err(|e| crate::cpu::with_call(e, "_mm256_mul_epu32(create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mul_epu32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_mul_epu32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_mul_epu32_boundary_max_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_mul_epu32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_mul_epu32(create__m256i_from_u32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_u32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mul_epu32(create__m256i_from_u32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_u32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mul_epu32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_mul_epu32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_mul_epu32_boundary_zero_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_mul_epu32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_mul_epu32(create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[1, 4294967294, 1, 4294967294, 1, 4294967294, 1, 4294967294]).map_err(|e| crate::cpu::with_call(e, "_mm256_mul_epu32(create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mul_epu32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_mul_epu32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_mul_epu32_boundary_allones_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_mul_epu32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_mul_epu32(create__m256i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX]), create__m256i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mul_epu32(create__m256i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX]), create__m256i_from_u32_array([u32::MIN, u32::MAX, 0, u32::MAX, u32::MIN, u32::MAX, 0, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mul_epu32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_mul_epu32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_mul_epu32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_mul_epu32_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_mul_epu32(create__m256i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mul_epu32(create__m256i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mul_epu32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_mul_epu32_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_mul_epu32_asym_min_max_impl() }
}

#[target_feature(enable = "avx2")]
fn test_x86_avx2_mm256_mul_epu32_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_u32_array(_mm256_mul_epu32(create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m256i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mul_epu32(create__m256i_from_u32_array([u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create__m256i_from_u32_array([u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mul_epu32(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_mul_epu32_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_mul_epu32_asym_max_min_impl() }
}

#[target_feature(enable = "avx2,sse2")]
fn test_x86_avx2_mm256_mul_epu32_vs_narrow_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("sse2")) {
            return Ok(Verdict::Skipped("sse2 not present"));
        }
    unsafe {
        let a_wide = create__m256i_from_u32_array([1u32, 2u32, 3u32, 4u32, 5u32, 6u32, 7u32, 8u32]);
        let a_narrow = create__m128i_from_u32_array([1u32, 2u32, 3u32, 4u32]);
        let b_wide = create__m256i_from_u32_array([9u32, 10u32, 11u32, 12u32, 13u32, 14u32, 15u32, 16u32]);
        let b_narrow = create__m128i_from_u32_array([9u32, 10u32, 11u32, 12u32]);
        let wide = unpack__m256i_to_u32_array(_mm256_mul_epu32(a_wide, b_wide));
        let narrow = unpack__m128i_to_u32_array(_mm_mul_epu32(a_narrow, b_narrow));
        check_array_equality(&wide[..4], &narrow).map_err(|e| crate::cpu::with_call(e, "_mm256_mul_epu32(a_wide, b_wide) vs _mm_mul_epu32(a_narrow, b_narrow)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx2_mm256_mul_epu32_vs_narrow() -> Result<Verdict, String> {
    unsafe { test_x86_avx2_mm256_mul_epu32_vs_narrow_impl() }
}
