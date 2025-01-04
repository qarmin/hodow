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

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_broadcastq_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_broadcastq_epi64(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[8589934593, 8589934593, 8589934593, 8589934593, 8589934593, 8589934593, 8589934593, 8589934593]).map_err(|e| crate::cpu::with_call(e, "_mm512_broadcastq_epi64(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_broadcastq_epi64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_broadcastq_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_broadcastq_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_broadcastq_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_broadcastq_epi64(create__m128i_from_i64_array([0, -1])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_broadcastq_epi64(create__m128i_from_i64_array([0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_broadcastq_epi64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_broadcastq_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_broadcastq_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_broadcastq_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_broadcastq_epi64(create__m128i_from_i64_array([100, 200])));
        check_array_equality(&result, &[100, 100, 100, 100, 100, 100, 100, 100]).map_err(|e| crate::cpu::with_call(e, "_mm512_broadcastq_epi64(create__m128i_from_i64_array([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_broadcastq_epi64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_broadcastq_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_broadcastq_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_broadcastq_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_broadcastq_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm512_broadcastq_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_broadcastq_epi64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_broadcastq_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_broadcastq_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_broadcastq_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_broadcastq_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm512_broadcastq_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_broadcastq_epi64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_broadcastq_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_broadcastq_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_broadcastq_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_broadcastq_epi64(create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_broadcastq_epi64(create__m128i_from_i64_array([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_broadcastq_epi64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_broadcastq_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_broadcastq_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_broadcastq_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_broadcastq_epi64(create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_broadcastq_epi64(create__m128i_from_i64_array([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_broadcastq_epi64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_broadcastq_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_broadcastq_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_broadcastq_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_broadcastq_epi64(create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[-9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm512_broadcastq_epi64(create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_broadcastq_epi64(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_broadcastq_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_broadcastq_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_broadcastq_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_broadcastq_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([17, 18, 19, 20])));
        check_array_equality(&result, &[77309411345, 17179869187, 77309411345, 34359738375, 77309411345, 51539607563, 77309411345, 68719476751]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_broadcastq_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_broadcastq_epi64(create_random__m512i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_broadcastq_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_broadcastq_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_broadcastq_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_broadcastq_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([10, 9])));
        check_array_equality(&result, &[10, -1, 10, -3, 10, -5, 10, -7]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_broadcastq_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([10, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_broadcastq_epi64(create_random__m512i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_broadcastq_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_broadcastq_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_broadcastq_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_broadcastq_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([110, 210])));
        check_array_equality(&result, &[110, 200, 110, 400, 110, 600, 110, 800]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_broadcastq_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([110, 210]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_broadcastq_epi64(create_random__m512i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_broadcastq_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_broadcastq_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_broadcastq_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_broadcastq_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_broadcastq_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_broadcastq_epi64(create_random__m512i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_broadcastq_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_broadcastq_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_broadcastq_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_broadcastq_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_broadcastq_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_broadcastq_epi64(create_random__m512i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_broadcastq_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_broadcastq_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_broadcastq_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_broadcastq_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_broadcastq_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_broadcastq_epi64(create_random__m512i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_broadcastq_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_broadcastq_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_broadcastq_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_broadcastq_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_broadcastq_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_broadcastq_epi64(create_random__m512i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_broadcastq_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_broadcastq_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_broadcastq_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_broadcastq_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[-9223372036854775808, 9223372036854775807, -9223372036854775808, -1, -9223372036854775808, 9223372036854775807, -9223372036854775808, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_broadcastq_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_broadcastq_epi64(create_random__m512i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_broadcastq_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_broadcastq_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_broadcastq_epi64_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_broadcastq_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[9223372036854775807, -9223372036854775808, 9223372036854775807, -9223372036854775808, 9223372036854775807, -9223372036854775808, 9223372036854775807, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_broadcastq_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_broadcastq_epi64(create_random__m512i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_broadcastq_epi64_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_broadcastq_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_broadcastq_epi64_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_broadcastq_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-9223372036854775808, 9223372036854775807, -9223372036854775808, 9223372036854775807, -9223372036854775808, 9223372036854775807, -9223372036854775808, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_broadcastq_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_broadcastq_epi64(create_random__m512i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_broadcastq_epi64_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_broadcastq_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_broadcastq_epi64_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        let src = create__m512i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m512i_to_i64_array(_mm512_mask_broadcastq_epi64(src, k, a));
        let plain = unpack__m512i_to_i64_array(_mm512_broadcastq_epi64(a));
        let src_lanes = unpack__m512i_to_i64_array(src);
        let expected: [i64; 8] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { src_lanes[i] });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_broadcastq_epi64(src, k, a) vs _mm512_broadcastq_epi64(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_broadcastq_epi64_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_broadcastq_epi64_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_broadcastq_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[8589934593, 0, 8589934593, 0, 8589934593, 0, 8589934593, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_broadcastq_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_broadcastq_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_broadcastq_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_broadcastq_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, -1])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_broadcastq_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_broadcastq_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_broadcastq_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_broadcastq_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([100, 200])));
        check_array_equality(&result, &[100, 0, 100, 0, 100, 0, 100, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_broadcastq_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_broadcastq_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_broadcastq_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_broadcastq_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-9223372036854775808, 0, -9223372036854775808, 0, -9223372036854775808, 0, -9223372036854775808, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_broadcastq_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_broadcastq_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_broadcastq_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_broadcastq_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[9223372036854775807, 0, 9223372036854775807, 0, 9223372036854775807, 0, 9223372036854775807, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_broadcastq_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_broadcastq_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_broadcastq_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_broadcastq_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_broadcastq_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_broadcastq_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_broadcastq_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_broadcastq_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_broadcastq_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_broadcastq_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_broadcastq_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_broadcastq_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[-9223372036854775808, 0, -9223372036854775808, 0, -9223372036854775808, 0, -9223372036854775808, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_broadcastq_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_broadcastq_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_broadcastq_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_broadcastq_epi64_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m512i_to_i64_array(_mm512_maskz_broadcastq_epi64(k, a));
        let plain = unpack__m512i_to_i64_array(_mm512_broadcastq_epi64(a));
        let expected: [i64; 8] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0 });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_broadcastq_epi64(k, a) vs _mm512_broadcastq_epi64(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_broadcastq_epi64_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_broadcastq_epi64_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_broadcastq_epi64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_broadcastq_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[42949672969, 17179869187, 42949672969, 34359738375]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_broadcastq_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_broadcastq_epi64(create_random__m256i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_broadcastq_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_broadcastq_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_broadcastq_epi64_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_broadcastq_epi64(create__m256i_from([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([10, 9])));
        check_array_equality(&result, &[10, -1, 10, -3]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_broadcastq_epi64(create__m256i_from([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([10, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_broadcastq_epi64(create_random__m256i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_broadcastq_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_broadcastq_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_broadcastq_epi64_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_broadcastq_epi64(create__m256i_from([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([110, 210])));
        check_array_equality(&result, &[110, 200, 110, 400]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_broadcastq_epi64(create__m256i_from([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([110, 210]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_broadcastq_epi64(create_random__m256i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_broadcastq_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_broadcastq_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_broadcastq_epi64_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_broadcastq_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_broadcastq_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_broadcastq_epi64(create_random__m256i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_broadcastq_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_broadcastq_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_broadcastq_epi64_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_broadcastq_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_broadcastq_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_broadcastq_epi64(create_random__m256i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_broadcastq_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_broadcastq_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_broadcastq_epi64_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_broadcastq_epi64(create__m256i_from([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_broadcastq_epi64(create__m256i_from([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_broadcastq_epi64(create_random__m256i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_broadcastq_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_broadcastq_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_broadcastq_epi64_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_broadcastq_epi64(create__m256i_from([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_broadcastq_epi64(create__m256i_from([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_broadcastq_epi64(create_random__m256i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_broadcastq_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_broadcastq_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_broadcastq_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_broadcastq_epi64(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[-9223372036854775808, 9223372036854775807, -9223372036854775808, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_broadcastq_epi64(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_broadcastq_epi64(create_random__m256i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_broadcastq_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_broadcastq_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_broadcastq_epi64_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_broadcastq_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[9223372036854775807, -9223372036854775808, 9223372036854775807, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_broadcastq_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_broadcastq_epi64(create_random__m256i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_broadcastq_epi64_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_broadcastq_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_broadcastq_epi64_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_broadcastq_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-9223372036854775808, 9223372036854775807, -9223372036854775808, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_broadcastq_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_broadcastq_epi64(create_random__m256i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_broadcastq_epi64_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_broadcastq_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f,avx2")]
fn test_x86_avx512f_mm256_mask_broadcastq_epi64_vs_unmasked_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx2")) {
            return Ok(Verdict::Skipped("avx2 not present"));
        }
    unsafe {
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        let src = create__m256i_from_i32_array([5, 6, 7, 8, 9, 10, 11, 12]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m256i_to_i64_array(_mm256_mask_broadcastq_epi64(src, k, a));
        let plain = unpack__m256i_to_i64_array(_mm256_broadcastq_epi64(a));
        let src_lanes = unpack__m256i_to_i64_array(src);
        let expected: [i64; 4] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { src_lanes[i] });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_broadcastq_epi64(src, k, a) vs _mm256_broadcastq_epi64(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_broadcastq_epi64_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_broadcastq_epi64_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_broadcastq_epi64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[8589934593, 0, 8589934593, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_broadcastq_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_broadcastq_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_broadcastq_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_broadcastq_epi64_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, -1])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_broadcastq_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_broadcastq_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_broadcastq_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_broadcastq_epi64_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([100, 200])));
        check_array_equality(&result, &[100, 0, 100, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_broadcastq_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_broadcastq_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_broadcastq_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_broadcastq_epi64_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-9223372036854775808, 0, -9223372036854775808, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_broadcastq_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_broadcastq_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_broadcastq_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_broadcastq_epi64_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[9223372036854775807, 0, 9223372036854775807, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_broadcastq_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_broadcastq_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_broadcastq_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_broadcastq_epi64_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_broadcastq_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_broadcastq_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_broadcastq_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_broadcastq_epi64_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_broadcastq_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_broadcastq_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_broadcastq_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_broadcastq_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[-9223372036854775808, 0, -9223372036854775808, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_broadcastq_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_broadcastq_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_broadcastq_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f,avx2")]
fn test_x86_avx512f_mm256_maskz_broadcastq_epi64_vs_unmasked_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx2")) {
            return Ok(Verdict::Skipped("avx2 not present"));
        }
    unsafe {
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m256i_to_i64_array(_mm256_maskz_broadcastq_epi64(k, a));
        let plain = unpack__m256i_to_i64_array(_mm256_broadcastq_epi64(a));
        let expected: [i64; 4] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0 });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_broadcastq_epi64(k, a) vs _mm256_broadcastq_epi64(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_broadcastq_epi64_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_broadcastq_epi64_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_broadcastq_epi64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_broadcastq_epi64(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[25769803781, 17179869187]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_broadcastq_epi64(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_broadcastq_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_broadcastq_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_broadcastq_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_broadcastq_epi64_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_broadcastq_epi64(create__m128i_from_i64_array([0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([10, 9])));
        check_array_equality(&result, &[10, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_broadcastq_epi64(create__m128i_from_i64_array([0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([10, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_broadcastq_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_broadcastq_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_broadcastq_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_broadcastq_epi64_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_broadcastq_epi64(create__m128i_from_i64_array([100, 200]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([110, 210])));
        check_array_equality(&result, &[110, 200]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_broadcastq_epi64(create__m128i_from_i64_array([100, 200]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([110, 210]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_broadcastq_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_broadcastq_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_broadcastq_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_broadcastq_epi64_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_broadcastq_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-9223372036854775808, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_broadcastq_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_broadcastq_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_broadcastq_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_broadcastq_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_broadcastq_epi64_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_broadcastq_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[9223372036854775807, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_broadcastq_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_broadcastq_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_broadcastq_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_broadcastq_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_broadcastq_epi64_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_broadcastq_epi64(create__m128i_from_i64_array([0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_broadcastq_epi64(create__m128i_from_i64_array([0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_broadcastq_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_broadcastq_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_broadcastq_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_broadcastq_epi64_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_broadcastq_epi64(create__m128i_from_i64_array([-1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[-1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_broadcastq_epi64(create__m128i_from_i64_array([-1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_broadcastq_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_broadcastq_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_broadcastq_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_broadcastq_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_broadcastq_epi64(create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[-9223372036854775808, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_broadcastq_epi64(create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_broadcastq_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_broadcastq_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_broadcastq_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_broadcastq_epi64_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_broadcastq_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[9223372036854775807, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_broadcastq_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_broadcastq_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_broadcastq_epi64_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_broadcastq_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_broadcastq_epi64_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_broadcastq_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-9223372036854775808, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_broadcastq_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_broadcastq_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_broadcastq_epi64_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_broadcastq_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f,avx2")]
fn test_x86_avx512f_mm_mask_broadcastq_epi64_vs_unmasked_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx2")) {
            return Ok(Verdict::Skipped("avx2 not present"));
        }
    unsafe {
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        let src = create__m128i_from_i32_array([5, 6, 7, 8]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m128i_to_i64_array(_mm_mask_broadcastq_epi64(src, k, a));
        let plain = unpack__m128i_to_i64_array(_mm_broadcastq_epi64(a));
        let src_lanes = unpack__m128i_to_i64_array(src);
        let expected: [i64; 2] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { src_lanes[i] });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm_mask_broadcastq_epi64(src, k, a) vs _mm_broadcastq_epi64(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_broadcastq_epi64_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_broadcastq_epi64_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_broadcastq_epi64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[8589934593, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_broadcastq_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_broadcastq_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_broadcastq_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_broadcastq_epi64_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, -1])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_broadcastq_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_broadcastq_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_broadcastq_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_broadcastq_epi64_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([100, 200])));
        check_array_equality(&result, &[100, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_broadcastq_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_broadcastq_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_broadcastq_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_broadcastq_epi64_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-9223372036854775808, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_broadcastq_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_broadcastq_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_broadcastq_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_broadcastq_epi64_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[9223372036854775807, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_broadcastq_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_broadcastq_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_broadcastq_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_broadcastq_epi64_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_broadcastq_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_broadcastq_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_broadcastq_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_broadcastq_epi64_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[-1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_broadcastq_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_broadcastq_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_broadcastq_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_broadcastq_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[-9223372036854775808, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_broadcastq_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_broadcastq_epi64(create_random__mmask8(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_broadcastq_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_broadcastq_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f,avx2")]
fn test_x86_avx512f_mm_maskz_broadcastq_epi64_vs_unmasked_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx2")) {
            return Ok(Verdict::Skipped("avx2 not present"));
        }
    unsafe {
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m128i_to_i64_array(_mm_maskz_broadcastq_epi64(k, a));
        let plain = unpack__m128i_to_i64_array(_mm_broadcastq_epi64(a));
        let expected: [i64; 2] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0 });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_broadcastq_epi64(k, a) vs _mm_broadcastq_epi64(a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_broadcastq_epi64_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_broadcastq_epi64_vs_unmasked_impl() }
}
