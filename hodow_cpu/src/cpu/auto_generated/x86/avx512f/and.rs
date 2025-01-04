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
fn test_x86_avx512f_mm512_and_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_and_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_and_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_and_epi32(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_and_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_and_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 9, 0, 5, 4, 1, 0, 1, 0, 9, 0, 5, 4, 1, 0, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_and_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_and_epi32(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_and_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_and_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[100, 192, 292, 400, 500, 576, 644, 800, 900, 992, 1092, 1200, 1300, 1280, 1476, 1600]).map_err(|e| crate::cpu::with_call(e, "_mm512_and_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_and_epi32(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_and_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_and_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm512_and_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_and_epi32(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_and_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_and_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm512_and_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_and_epi32(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_and_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_and_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_and_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_and_epi32(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_and_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_and_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_and_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_and_epi32(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_and_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_and_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-2147483648, 2147483647, 0, -1, -2147483648, 2147483647, 0, -1, -2147483648, 2147483647, 0, -1, -2147483648, 2147483647, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_and_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_and_epi32(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_and_epi32_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_and_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_and_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_and_epi32(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_epi32_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_and_epi32_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_and_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_and_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_and_epi32(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_epi32_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_and_epi32_prop_commutative_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m512i_from_i32_array([1i32, 2i32, 3i32, 4i32, 5i32, 6i32, 7i32, 8i32, 9i32, 10i32, 11i32, 12i32, 13i32, 14i32, 15i32, 16i32]);
        let b = create__m512i_from_i32_array([17i32, 18i32, 19i32, 20i32, 21i32, 22i32, 23i32, 24i32, 25i32, 26i32, 27i32, 28i32, 29i32, 30i32, 31i32, 32i32]);
        let lhs = unpack__m512i_to_i32_array(_mm512_and_epi32(a, b));
        let rhs = unpack__m512i_to_i32_array(_mm512_and_epi32(b, a));
        check_array_equality(&lhs, &rhs).map_err(|e| crate::cpu::with_call(e, "_mm512_and_epi32(a, b) vs _mm512_and_epi32(b, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_epi32_prop_commutative() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_epi32_prop_commutative_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_and_epi32_prop_idempotent_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m512i_from_i32_array([1i32, 2i32, 3i32, 4i32, 5i32, 6i32, 7i32, 8i32, 9i32, 10i32, 11i32, 12i32, 13i32, 14i32, 15i32, 16i32]);
        let lhs = unpack__m512i_to_i32_array(_mm512_and_epi32(a, a));
        let rhs = unpack__m512i_to_i32_array(a);
        check_array_equality(&lhs, &rhs).map_err(|e| crate::cpu::with_call(e, "_mm512_and_epi32(a, a) vs a"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_epi32_prop_idempotent() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_epi32_prop_idempotent_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_and_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_and_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_and_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_and_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_and_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_and_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_and_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_and_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m512i_from_i32_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[0, -1, 4, -3, 8, -5, 16, -7, 0, -1, 4, -3, 8, -5, 16, -7]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_and_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m512i_from_i32_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_and_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_and_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_and_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_and_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_and_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]), create__m512i_from_i32_array([120, 220, 320, 420, 520, 620, 720, 820, 920, 1020, 1120, 1220, 1320, 1420, 1520, 1620])));
        check_array_equality(&result, &[104, 200, 256, 400, 8, 600, 704, 800, 904, 1000, 1088, 1200, 1288, 1400, 1504, 1600]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_and_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]), create__m512i_from_i32_array([120, 220, 320, 420, 520, 620, 720, 820, 920, 1020, 1120, 1220, 1320, 1420, 1520, 1620]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_and_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_and_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_and_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_and_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_and_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_and_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_and_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_and_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_and_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_and_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_and_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_and_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_and_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_and_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_and_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_and_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_and_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_and_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_and_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_and_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_and_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_and_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_and_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_and_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_and_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_and_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_and_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_and_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_and_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-2147483648, 2147483647, 0, -1, -2147483648, 2147483647, 0, -1, -2147483648, 2147483647, 0, -1, -2147483648, 2147483647, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_and_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_and_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_and_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_and_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_and_epi32_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_and_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, -2147483648, 3, -2147483648, 5, -2147483648, 7, -2147483648, 9, -2147483648, 11, -2147483648, 13, -2147483648, 15, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_and_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_and_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_and_epi32_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_and_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_and_epi32_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_and_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_and_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_and_epi32(create_random__m512i(), create_random__mmask16(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_and_epi32_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_and_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_and_epi32_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let b = create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]);
        let src = create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]);
        let k = create__mmask16_from(0b0101010101010101);
        let masked = unpack__m512i_to_i32_array(_mm512_mask_and_epi32(src, k, a, b));
        let plain = unpack__m512i_to_i32_array(_mm512_and_epi32(a, b));
        let src_lanes = unpack__m512i_to_i32_array(src);
        let expected: [i32; 16] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { src_lanes[i] });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_and_epi32(src, k, a, b) vs _mm512_and_epi32(a, b)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_and_epi32_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_and_epi32_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_and_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0, 9, 0, 11, 0, 13, 0, 15, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_and_epi32(create_random__mmask16(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_and_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_and_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_and_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_and_epi32(create_random__mmask16(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_and_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_and_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_and_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[100, 0, 292, 0, 500, 0, 644, 0, 900, 0, 1092, 0, 1300, 0, 1476, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_and_epi32(create_random__mmask16(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_and_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_and_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_and_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_and_epi32(create_random__mmask16(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_and_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_and_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_and_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_and_epi32(create_random__mmask16(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_and_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_and_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_and_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_and_epi32(create_random__mmask16(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_and_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_and_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_and_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_and_epi32(create_random__mmask16(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_and_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_and_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_and_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-2147483648, 0, 0, 0, -2147483648, 0, 0, 0, -2147483648, 0, 0, 0, -2147483648, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_and_epi32(create_random__mmask16(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_and_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_and_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_and_epi32_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_and_epi32(create_random__mmask16(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_and_epi32_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_and_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_and_epi32_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_and_epi32(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_and_epi32(create_random__mmask16(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_and_epi32_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_and_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_and_epi32_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let b = create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]);
        let k = create__mmask16_from(0b0101010101010101);
        let masked = unpack__m512i_to_i32_array(_mm512_maskz_and_epi32(k, a, b));
        let plain = unpack__m512i_to_i32_array(_mm512_and_epi32(a, b));
        let expected: [i32; 16] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0 });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_and_epi32(k, a, b) vs _mm512_and_epi32(a, b)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_and_epi32_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_and_epi32_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_and_epi32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_and_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_and_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_and_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_and_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_and_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_and_epi32_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_and_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]), create__m256i_from_i32_array([20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[0, -1, 4, -3, 8, -5, 16, -7]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_and_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]), create__m256i_from_i32_array([20, 19, 22, 17, 24, 15, 26, 13]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_and_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_and_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_and_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_and_epi32_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_and_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]), create__m256i_from_i32_array([120, 220, 320, 420, 520, 620, 720, 820])));
        check_array_equality(&result, &[104, 200, 256, 400, 8, 600, 704, 800]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_and_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]), create__m256i_from_i32_array([120, 220, 320, 420, 520, 620, 720, 820]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_and_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_and_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_and_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_and_epi32_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_and_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_and_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_and_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_and_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_and_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_and_epi32_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_and_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_and_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_and_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_and_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_and_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_and_epi32_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_and_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_and_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_and_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_and_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_and_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_and_epi32_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_and_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_and_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_and_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_and_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_and_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_and_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_and_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-2147483648, 2147483647, 0, -1, -2147483648, 2147483647, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_and_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_and_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_and_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_and_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_and_epi32_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_and_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, -2147483648, 3, -2147483648, 5, -2147483648, 7, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_and_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_and_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_and_epi32_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_and_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_and_epi32_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_and_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0, 2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_and_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_and_epi32(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_and_epi32_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_and_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_and_epi32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_and_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 0, 3, 0, 5, 0, 7, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_and_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_and_epi32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_and_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_and_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_and_epi32_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_and_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 0, 0, 0, 4, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_and_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_and_epi32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_and_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_and_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_and_epi32_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_and_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[100, 0, 292, 0, 500, 0, 644, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_and_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_and_epi32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_and_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_and_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_and_epi32_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_and_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, 0, -2147483648, 0, -2147483648, 0, -2147483648, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_and_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_and_epi32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_and_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_and_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_and_epi32_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_and_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 0, 2147483647, 0, 2147483647, 0, 2147483647, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_and_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_and_epi32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_and_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_and_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_and_epi32_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_and_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_and_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_and_epi32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_and_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_and_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_and_epi32_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_and_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_and_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_and_epi32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_and_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_and_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_and_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_and_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-2147483648, 0, 0, 0, -2147483648, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_and_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_and_epi32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_and_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_and_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_and_epi32_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_and_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_and_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_and_epi32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_and_epi32_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_and_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_and_epi32_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_and_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_and_epi32(create__mmask8_from(0b01010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_and_epi32(create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_and_epi32_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_and_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_and_epi32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_and_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_and_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_and_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_and_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_and_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_and_epi32_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_and_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([10, 9, 12, 7]), create__m128i_from_i32_array([20, 19, 22, 17])));
        check_array_equality(&result, &[0, -1, 4, -3]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_and_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([10, 9, 12, 7]), create__m128i_from_i32_array([20, 19, 22, 17]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_and_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_and_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_and_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_and_epi32_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_and_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([110, 210, 310, 410]), create__m128i_from_i32_array([120, 220, 320, 420])));
        check_array_equality(&result, &[104, 200, 256, 400]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_and_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([110, 210, 310, 410]), create__m128i_from_i32_array([120, 220, 320, 420]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_and_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_and_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_and_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_and_epi32_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_and_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_and_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_and_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_and_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_and_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_and_epi32_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_and_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_and_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_and_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_and_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_and_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_and_epi32_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_and_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_and_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_and_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_and_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_and_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_and_epi32_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_and_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_and_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_and_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_and_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_and_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_and_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_and_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-2147483648, 2147483647, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_and_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_and_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_and_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_and_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_and_epi32_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_and_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, -2147483648, 3, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_and_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_and_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_and_epi32_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_and_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_and_epi32_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_and_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 2147483647, 0, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_and_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_and_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_and_epi32_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_and_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_and_epi32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_and_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 0, 3, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_and_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_and_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_and_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_and_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_and_epi32_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_and_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_and_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_and_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_and_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_and_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_and_epi32_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_and_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[100, 0, 292, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_and_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_and_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_and_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_and_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_and_epi32_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_and_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, 0, -2147483648, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_and_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_and_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_and_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_and_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_and_epi32_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_and_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 0, 2147483647, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_and_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_and_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_and_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_and_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_and_epi32_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_and_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_and_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_and_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_and_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_and_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_and_epi32_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_and_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_and_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_and_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_and_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_and_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_and_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_and_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-2147483648, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_and_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_and_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_and_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_and_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_and_epi32_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_and_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_and_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_and_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_and_epi32_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_and_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_and_epi32_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_and_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_and_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_and_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_and_epi32_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_and_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_and_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_and_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[8589934593, 17179869187, 25769803781, 34359738375, 42949672969, 51539607563, 60129542157, 15]).map_err(|e| crate::cpu::with_call(e, "_mm512_and_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_and_epi64(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_and_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_and_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 9, 0, 5, 4, 1, 0, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_and_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_and_epi64(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_and_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_and_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__m512i_from([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[100, 192, 292, 400, 500, 576, 644, 800]).map_err(|e| crate::cpu::with_call(e, "_mm512_and_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__m512i_from([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_and_epi64(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_and_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_and_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm512_and_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_and_epi64(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_and_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_and_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm512_and_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_and_epi64(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_and_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_and_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_and_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_and_epi64(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_and_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_and_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_and_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_and_epi64(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_and_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_and_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1])));
        check_array_equality(&result, &[-9223372036854775808, 9223372036854775807, 0, -1, -9223372036854775808, 9223372036854775807, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_and_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_and_epi64(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_and_epi64_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_and_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_and_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_and_epi64(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_epi64_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_and_epi64_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_and_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_and_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_and_epi64(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_epi64_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_and_epi64_prop_commutative_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m512i_from([1i64, 2i64, 3i64, 4i64, 5i64, 6i64, 7i64, 8i64]);
        let b = create__m512i_from([9i64, 10i64, 11i64, 12i64, 13i64, 14i64, 15i64, 16i64]);
        let lhs = unpack__m512i_to_i64_array(_mm512_and_epi64(a, b));
        let rhs = unpack__m512i_to_i64_array(_mm512_and_epi64(b, a));
        check_array_equality(&lhs, &rhs).map_err(|e| crate::cpu::with_call(e, "_mm512_and_epi64(a, b) vs _mm512_and_epi64(b, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_epi64_prop_commutative() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_epi64_prop_commutative_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_and_epi64_prop_idempotent_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m512i_from([1i64, 2i64, 3i64, 4i64, 5i64, 6i64, 7i64, 8i64]);
        let lhs = unpack__m512i_to_i64_array(_mm512_and_epi64(a, a));
        let rhs = unpack__m512i_to_i64_array(a);
        check_array_equality(&lhs, &rhs).map_err(|e| crate::cpu::with_call(e, "_mm512_and_epi64(a, a) vs a"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_epi64_prop_idempotent() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_epi64_prop_idempotent_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_and_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_and_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[8589934593, 17179869187, 25769803781, 34359738375, 42949672969, 51539607563, 60129542157, 68719476751]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_and_epi64(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask8_from(0b01010101), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_and_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_and_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_and_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_and_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_and_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m512i_from([10, 9, 12, 7, 14, 5, 16, 3]), create__m512i_from([20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[0, -1, 4, -3, 8, -5, 16, -7]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_and_epi64(create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask8_from(0b01010101), create__m512i_from([10, 9, 12, 7, 14, 5, 16, 3]), create__m512i_from([20, 19, 22, 17, 24, 15, 26, 13]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_and_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_and_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_and_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_and_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_and_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m512i_from([110, 210, 310, 410, 510, 610, 710, 810]), create__m512i_from([120, 220, 320, 420, 520, 620, 720, 820])));
        check_array_equality(&result, &[104, 200, 256, 400, 8, 600, 704, 800]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_and_epi64(create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask8_from(0b01010101), create__m512i_from([110, 210, 310, 410, 510, 610, 710, 810]), create__m512i_from([120, 220, 320, 420, 520, 620, 720, 820]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_and_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_and_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_and_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_and_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_and_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_and_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_and_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_and_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_and_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_and_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_and_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_and_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_and_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_and_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_and_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_and_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_and_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_and_epi64(create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_and_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_and_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_and_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_and_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_and_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_and_epi64(create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_and_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_and_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_and_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_and_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_and_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1])));
        check_array_equality(&result, &[-9223372036854775808, 9223372036854775807, 0, -1, -9223372036854775808, 9223372036854775807, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_and_epi64(create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_and_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_and_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_and_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_and_epi64_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_and_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[8589934593, -9223372036854775808, 25769803781, -9223372036854775808, 42949672969, -9223372036854775808, 60129542157, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_and_epi64(create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_and_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_and_epi64_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_and_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_and_epi64_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_mask_and_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0, 9223372036854775807, 0, 9223372036854775807, 0, 9223372036854775807, 0, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_and_epi64(create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_and_epi64(create_random__m512i(), create_random__mmask8(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_and_epi64_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_and_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_mask_and_epi64_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let b = create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]);
        let src = create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m512i_to_i64_array(_mm512_mask_and_epi64(src, k, a, b));
        let plain = unpack__m512i_to_i64_array(_mm512_and_epi64(a, b));
        let src_lanes = unpack__m512i_to_i64_array(src);
        let expected: [i64; 8] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { src_lanes[i] });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_and_epi64(src, k, a, b) vs _mm512_and_epi64(a, b)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_mask_and_epi64_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_mask_and_epi64_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_and_epi64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_and_epi64(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[8589934593, 0, 25769803781, 0, 42949672969, 0, 60129542157, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_and_epi64(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_and_epi64(create_random__mmask8(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_and_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_and_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_and_epi64_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_and_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 0, 0, 0, 4, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_and_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_and_epi64(create_random__mmask8(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_and_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_and_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_and_epi64_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_and_epi64(create__mmask8_from(0b01010101), create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__m512i_from([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[100, 0, 292, 0, 500, 0, 644, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_and_epi64(create__mmask8_from(0b01010101), create__m512i_from([100, 200, 300, 400, 500, 600, 700, 800]), create__m512i_from([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_and_epi64(create_random__mmask8(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_and_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_and_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_and_epi64_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_and_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-9223372036854775808, 0, -9223372036854775808, 0, -9223372036854775808, 0, -9223372036854775808, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_and_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_and_epi64(create_random__mmask8(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_and_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_and_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_and_epi64_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_and_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[9223372036854775807, 0, 9223372036854775807, 0, 9223372036854775807, 0, 9223372036854775807, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_and_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_and_epi64(create_random__mmask8(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_and_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_and_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_and_epi64_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_and_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_and_epi64(create__mmask8_from(0b01010101), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_and_epi64(create_random__mmask8(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_and_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_and_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_and_epi64_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_and_epi64(create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0, -1, 0, -1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_and_epi64(create__mmask8_from(0b01010101), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_and_epi64(create_random__mmask8(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_and_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_and_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_and_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_and_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1])));
        check_array_equality(&result, &[-9223372036854775808, 0, 0, 0, -9223372036854775808, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_and_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]), create__m512i_from([i64::MIN, i64::MAX, 0, -1, i64::MIN, i64::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_and_epi64(create_random__mmask8(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_and_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_and_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_and_epi64_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_and_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_and_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_and_epi64(create_random__mmask8(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_and_epi64_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_and_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_and_epi64_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i64_array(_mm512_maskz_and_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_and_epi64(create__mmask8_from(0b01010101), create__m512i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m512i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_and_epi64(create_random__mmask8(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_and_epi64_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_and_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_maskz_and_epi64_vs_unmasked_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let b = create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]);
        let k = create__mmask8_from(0b01010101);
        let masked = unpack__m512i_to_i64_array(_mm512_maskz_and_epi64(k, a, b));
        let plain = unpack__m512i_to_i64_array(_mm512_and_epi64(a, b));
        let expected: [i64; 8] = core::array::from_fn(|i| if (k >> i) & 1 == 1 { plain[i] } else { 0 });
        check_array_equality(&masked, &expected).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_and_epi64(k, a, b) vs _mm512_and_epi64(a, b)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_maskz_and_epi64_vs_unmasked() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_maskz_and_epi64_vs_unmasked_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_and_epi64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_and_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[8589934593, 17179869187, 25769803781, 34359738375]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_and_epi64(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_and_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_and_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_and_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_and_epi64_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_and_epi64(create__m256i_from([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m256i_from([10, 9, 12, 7]), create__m256i_from([20, 19, 22, 17])));
        check_array_equality(&result, &[0, -1, 4, -3]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_and_epi64(create__m256i_from([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m256i_from([10, 9, 12, 7]), create__m256i_from([20, 19, 22, 17]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_and_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_and_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_and_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_and_epi64_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_and_epi64(create__m256i_from([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m256i_from([110, 210, 310, 410]), create__m256i_from([120, 220, 320, 420])));
        check_array_equality(&result, &[104, 200, 256, 400]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_and_epi64(create__m256i_from([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m256i_from([110, 210, 310, 410]), create__m256i_from([120, 220, 320, 420]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_and_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_and_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_and_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_and_epi64_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_and_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_and_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_and_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_and_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_and_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_and_epi64_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_and_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[9223372036854775807, 9223372036854775807, 9223372036854775807, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_and_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_and_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_and_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_and_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_and_epi64_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_and_epi64(create__m256i_from([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from([0, 0, 0, 0]), create__m256i_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_and_epi64(create__m256i_from([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m256i_from([0, 0, 0, 0]), create__m256i_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_and_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_and_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_and_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_and_epi64_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_and_epi64(create__m256i_from([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from([-1, -1, -1, -1]), create__m256i_from([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_and_epi64(create__m256i_from([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m256i_from([-1, -1, -1, -1]), create__m256i_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_and_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_and_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_and_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_and_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_and_epi64(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__m256i_from([i64::MIN, i64::MAX, 0, -1])));
        check_array_equality(&result, &[-9223372036854775808, 9223372036854775807, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_and_epi64(create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__m256i_from([i64::MIN, i64::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_and_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_and_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_and_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_and_epi64_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_and_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[8589934593, -9223372036854775808, 25769803781, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_and_epi64(create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_and_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_and_epi64_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_and_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_mask_and_epi64_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_mask_and_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0, 9223372036854775807, 0, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_and_epi64(create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_and_epi64(create_random__m256i(), create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_mask_and_epi64_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_mask_and_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_and_epi64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_and_epi64(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[8589934593, 0, 25769803781, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_and_epi64(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_and_epi64(create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_and_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_and_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_and_epi64_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_and_epi64(create__mmask8_from(0b01010101), create__m256i_from([0, -1, 2, -3]), create__m256i_from([10, 9, 12, 7])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_and_epi64(create__mmask8_from(0b01010101), create__m256i_from([0, -1, 2, -3]), create__m256i_from([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_and_epi64(create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_and_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_and_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_and_epi64_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_and_epi64(create__mmask8_from(0b01010101), create__m256i_from([100, 200, 300, 400]), create__m256i_from([110, 210, 310, 410])));
        check_array_equality(&result, &[100, 0, 292, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_and_epi64(create__mmask8_from(0b01010101), create__m256i_from([100, 200, 300, 400]), create__m256i_from([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_and_epi64(create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_and_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_and_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_and_epi64_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_and_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-9223372036854775808, 0, -9223372036854775808, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_and_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_and_epi64(create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_and_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_and_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_and_epi64_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_and_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[9223372036854775807, 0, 9223372036854775807, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_and_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_and_epi64(create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_and_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_and_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_and_epi64_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_and_epi64(create__mmask8_from(0b01010101), create__m256i_from([0, 0, 0, 0]), create__m256i_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_and_epi64(create__mmask8_from(0b01010101), create__m256i_from([0, 0, 0, 0]), create__m256i_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_and_epi64(create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_and_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_and_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_and_epi64_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_and_epi64(create__mmask8_from(0b01010101), create__m256i_from([-1, -1, -1, -1]), create__m256i_from([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, 0, -1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_and_epi64(create__mmask8_from(0b01010101), create__m256i_from([-1, -1, -1, -1]), create__m256i_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_and_epi64(create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_and_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_and_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_and_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_and_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__m256i_from([i64::MIN, i64::MAX, 0, -1])));
        check_array_equality(&result, &[-9223372036854775808, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_and_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MAX, 0, -1]), create__m256i_from([i64::MIN, i64::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_and_epi64(create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_and_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_and_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_and_epi64_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_and_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_and_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_and_epi64(create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_and_epi64_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_and_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm256_maskz_and_epi64_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i64_array(_mm256_maskz_and_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_and_epi64(create__mmask8_from(0b01010101), create__m256i_from([i64::MAX, i64::MAX, i64::MAX, i64::MAX]), create__m256i_from([i64::MIN, i64::MIN, i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_and_epi64(create_random__mmask8(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm256_maskz_and_epi64_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm256_maskz_and_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_and_epi64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_and_epi64(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[8589934593, 17179869187]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_and_epi64(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_and_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_and_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_and_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_and_epi64_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_and_epi64(create__m128i_from_i64_array([0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([10, 9]), create__m128i_from_i64_array([20, 19])));
        check_array_equality(&result, &[0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_and_epi64(create__m128i_from_i64_array([0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([10, 9]), create__m128i_from_i64_array([20, 19]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_and_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_and_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_and_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_and_epi64_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_and_epi64(create__m128i_from_i64_array([100, 200]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([110, 210]), create__m128i_from_i64_array([120, 220])));
        check_array_equality(&result, &[104, 200]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_and_epi64(create__m128i_from_i64_array([100, 200]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([110, 210]), create__m128i_from_i64_array([120, 220]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_and_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_and_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_and_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_and_epi64_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_and_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-9223372036854775808, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_and_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_and_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_and_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_and_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_and_epi64_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_and_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[9223372036854775807, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_and_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_and_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_and_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_and_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_and_epi64_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_and_epi64(create__m128i_from_i64_array([0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0]), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_and_epi64(create__m128i_from_i64_array([0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0]), create__m128i_from_i64_array([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_and_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_and_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_and_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_and_epi64_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_and_epi64(create__m128i_from_i64_array([-1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1]), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[-1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_and_epi64(create__m128i_from_i64_array([-1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1]), create__m128i_from_i64_array([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_and_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_and_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_and_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_and_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_and_epi64(create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[-9223372036854775808, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_and_epi64(create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_and_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_and_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_and_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_and_epi64_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_and_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[8589934593, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_and_epi64(create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_and_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_and_epi64_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_and_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_mask_and_epi64_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_mask_and_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_and_epi64(create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_and_epi64(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_mask_and_epi64_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_mask_and_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_and_epi64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_and_epi64(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[8589934593, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_and_epi64(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_and_epi64(create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_and_epi64() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_and_epi64_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_and_epi64_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_and_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, -1]), create__m128i_from_i64_array([10, 9])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_and_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, -1]), create__m128i_from_i64_array([10, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_and_epi64(create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_and_epi64_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_and_epi64_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_and_epi64_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_and_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([100, 200]), create__m128i_from_i64_array([110, 210])));
        check_array_equality(&result, &[100, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_and_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([100, 200]), create__m128i_from_i64_array([110, 210]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_and_epi64(create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_and_epi64_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_and_epi64_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_and_epi64_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_and_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-9223372036854775808, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_and_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_and_epi64(create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_and_epi64_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_and_epi64_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_and_epi64_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_and_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[9223372036854775807, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_and_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_and_epi64(create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_and_epi64_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_and_epi64_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_and_epi64_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_and_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0]), create__m128i_from_i64_array([0, 0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_and_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([0, 0]), create__m128i_from_i64_array([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_and_epi64(create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_and_epi64_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_and_epi64_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_and_epi64_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_and_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1]), create__m128i_from_i64_array([-1, -1])));
        check_array_equality(&result, &[-1, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_and_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([-1, -1]), create__m128i_from_i64_array([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_and_epi64(create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_and_epi64_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_and_epi64_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_and_epi64_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_and_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[-9223372036854775808, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_and_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_and_epi64(create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_and_epi64_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_and_epi64_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_and_epi64_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_and_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_and_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MIN, i64::MIN]), create__m128i_from_i64_array([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_and_epi64(create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_and_epi64_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_and_epi64_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm_maskz_and_epi64_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i64_array(_mm_maskz_and_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_and_epi64(create__mmask8_from(0b01010101), create__m128i_from_i64_array([i64::MAX, i64::MAX]), create__m128i_from_i64_array([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_and_epi64(create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm_maskz_and_epi64_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm_maskz_and_epi64_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_and_si512_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_and_si512(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_and_si512(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_and_si512(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_si512() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_si512_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_and_si512_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_and_si512(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 9, 0, 5, 4, 1, 0, 1, 0, 9, 0, 5, 4, 1, 0, 1]).map_err(|e| crate::cpu::with_call(e, "_mm512_and_si512(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_and_si512(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_si512_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_si512_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_and_si512_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_and_si512(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[100, 192, 292, 400, 500, 576, 644, 800, 900, 992, 1092, 1200, 1300, 1280, 1476, 1600]).map_err(|e| crate::cpu::with_call(e, "_mm512_and_si512(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_and_si512(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_si512_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_si512_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_and_si512_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_and_si512(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm512_and_si512(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_and_si512(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_si512_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_si512_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_and_si512_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_and_si512(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm512_and_si512(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_and_si512(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_si512_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_si512_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_and_si512_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_and_si512(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_and_si512(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_and_si512(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_si512_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_si512_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_and_si512_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_and_si512(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_and_si512(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_and_si512(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_si512_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_si512_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_and_si512_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_and_si512(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-2147483648, 2147483647, 0, -1, -2147483648, 2147483647, 0, -1, -2147483648, 2147483647, 0, -1, -2147483648, 2147483647, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_and_si512(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_and_si512(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_si512_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_si512_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_and_si512_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_and_si512(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_and_si512(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_and_si512(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_si512_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_si512_asym_min_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_and_si512_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_and_si512(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_and_si512(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_and_si512(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_si512_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_si512_asym_max_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_and_si512_prop_commutative_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m512i_from_i32_array([1i32, 2i32, 3i32, 4i32, 5i32, 6i32, 7i32, 8i32, 9i32, 10i32, 11i32, 12i32, 13i32, 14i32, 15i32, 16i32]);
        let b = create__m512i_from_i32_array([17i32, 18i32, 19i32, 20i32, 21i32, 22i32, 23i32, 24i32, 25i32, 26i32, 27i32, 28i32, 29i32, 30i32, 31i32, 32i32]);
        let lhs = unpack__m512i_to_i32_array(_mm512_and_si512(a, b));
        let rhs = unpack__m512i_to_i32_array(_mm512_and_si512(b, a));
        check_array_equality(&lhs, &rhs).map_err(|e| crate::cpu::with_call(e, "_mm512_and_si512(a, b) vs _mm512_and_si512(b, a)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_si512_prop_commutative() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_si512_prop_commutative_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_and_si512_prop_idempotent_impl() -> Result<Verdict, String> {
    unsafe {
        let a = create__m512i_from_i32_array([1i32, 2i32, 3i32, 4i32, 5i32, 6i32, 7i32, 8i32, 9i32, 10i32, 11i32, 12i32, 13i32, 14i32, 15i32, 16i32]);
        let lhs = unpack__m512i_to_i32_array(_mm512_and_si512(a, a));
        let rhs = unpack__m512i_to_i32_array(a);
        check_array_equality(&lhs, &rhs).map_err(|e| crate::cpu::with_call(e, "_mm512_and_si512(a, a) vs a"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_and_si512_prop_idempotent() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_and_si512_prop_idempotent_impl() }
}
