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

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_packus_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_packus_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[131073, 262147, 1179665, 1310739, 393221, 524295, 1441813, 1572887, 655369, 786443, 1703961, 1835035, 917517, 1048591, 1966109, 2097183]).map_err(|e| crate::cpu::with_call(e, "_mm512_packus_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_packus_epi32(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_packus_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_packus_epi32_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_packus_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_packus_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 2, 589834, 458764, 4, 6, 327694, 196624, 0, 2, 589834, 458764, 4, 6, 327694, 196624]).map_err(|e| crate::cpu::with_call(e, "_mm512_packus_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_packus_epi32(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_packus_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_packus_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_packus_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_packus_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[13107300, 26214700, 13762670, 26870070, 39322100, 52429500, 39977470, 53084870, 65536900, 78644300, 66192270, 79299670, 91751700, 104859100, 92407070, 105514470]).map_err(|e| crate::cpu::with_call(e, "_mm512_packus_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_packus_epi32(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_packus_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_packus_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_packus_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_packus_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_packus_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_packus_epi32(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_packus_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_packus_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_packus_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_packus_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_packus_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_packus_epi32(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_packus_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_packus_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_packus_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_packus_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_packus_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_packus_epi32(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_packus_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_packus_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_packus_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_packus_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_packus_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_packus_epi32(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_packus_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_packus_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_packus_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_packus_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-65536, 0, -65536, 0, -65536, 0, -65536, 0, -65536, 0, -65536, 0, -65536, 0, -65536, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_packus_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_packus_epi32(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_packus_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_packus_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_packus_epi32_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_packus_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0, 0, -1, -1, 0, 0, -1, -1, 0, 0, -1, -1, 0, 0, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_packus_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_packus_epi32(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_packus_epi32_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_packus_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_packus_epi32_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_packus_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-1, -1, 0, 0, -1, -1, 0, 0, -1, -1, 0, 0, -1, -1, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_packus_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_packus_epi32(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_packus_epi32_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_packus_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bw,avx2")]
fn test_x86_avx512bw_mm512_packus_epi32_vs_narrow_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx2")) {
            return Ok(Verdict::Skipped("avx2 not present"));
        }
    unsafe {
        let a_wide = create__m512i_from_i32_array([1i32, 2i32, 3i32, 4i32, 5i32, 6i32, 7i32, 8i32, 9i32, 10i32, 11i32, 12i32, 13i32, 14i32, 15i32, 16i32]);
        let a_narrow = create__m256i_from_i32_array([1i32, 2i32, 3i32, 4i32, 5i32, 6i32, 7i32, 8i32]);
        let b_wide = create__m512i_from_i32_array([17i32, 18i32, 19i32, 20i32, 21i32, 22i32, 23i32, 24i32, 25i32, 26i32, 27i32, 28i32, 29i32, 30i32, 31i32, 32i32]);
        let b_narrow = create__m256i_from_i32_array([17i32, 18i32, 19i32, 20i32, 21i32, 22i32, 23i32, 24i32]);
        let wide = unpack__m512i_to_i32_array(_mm512_packus_epi32(a_wide, b_wide));
        let narrow = unpack__m256i_to_i32_array(_mm256_packus_epi32(a_narrow, b_narrow));
        check_array_equality(&wide[..8], &narrow).map_err(|e| crate::cpu::with_call(e, "_mm512_packus_epi32(a_wide, b_wide) vs _mm256_packus_epi32(a_narrow, b_narrow)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_packus_epi32_vs_narrow() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_packus_epi32_vs_narrow_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_packus_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_packus_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[17, 19, 33, 35, 21, 23, 37, 39, 25, 27, 41, 43, 29, 31, 45, 47]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_packus_epi32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_packus_epi32(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_packus_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_packus_epi32_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_packus_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_packus_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m512i_from_i32_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[10, -65524, 20, -65514, 14, -65520, 24, -65510, 10, -65524, 20, -65514, 14, -65520, 24, -65510]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_packus_epi32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m512i_from_i32_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_packus_epi32(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_packus_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_packus_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_packus_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_packus_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]), create__m512i_from_i32_array([120, 220, 320, 420, 520, 620, 720, 820, 920, 1020, 1120, 1220, 1320, 1420, 1520, 1620])));
        check_array_equality(&result, &[110, 310, 120, 320, 510, 710, 520, 720, 910, 1110, 920, 1120, 1310, 1510, 1320, 1520]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_packus_epi32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]), create__m512i_from_i32_array([120, 220, 320, 420, 520, 620, 720, 820, 920, 1020, 1120, 1220, 1320, 1420, 1520, 1620]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_packus_epi32(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_packus_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_packus_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_packus_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_packus_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_packus_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_packus_epi32(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_packus_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_packus_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_packus_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_packus_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_packus_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_packus_epi32(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_packus_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_packus_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_packus_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_packus_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_packus_epi32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_packus_epi32(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_packus_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_packus_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_packus_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_packus_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-65536, -65536, -65536, -65536, -65536, -65536, -65536, -65536, -65536, -65536, -65536, -65536, -65536, -65536, -65536, -65536]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_packus_epi32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_packus_epi32(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_packus_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_packus_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_packus_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_packus_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-2147483648, 2147418112, 0, -65536, -2147483648, 2147418112, 0, -65536, -2147483648, 2147418112, 0, -65536, -2147483648, 2147418112, 0, -65536]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_packus_epi32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_packus_epi32(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_packus_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_packus_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_packus_epi32_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_packus_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-2147418113, -2147418113, -2147483647, -2147483645, -2147418113, -2147418113, -2147483643, -2147483641, -2147418113, -2147418113, -2147483639, -2147483637, -2147418113, -2147418113, -2147483635, -2147483633]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_packus_epi32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_packus_epi32(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_packus_epi32_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_packus_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_packus_epi32_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_packus_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[2147418112, 2147418112, 2147418113, 2147418115, 2147418112, 2147418112, 2147418117, 2147418119, 2147418112, 2147418112, 2147418121, 2147418123, 2147418112, 2147418112, 2147418125, 2147418127]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_packus_epi32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_packus_epi32(create_random__m512i(), create_random__mmask32(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_packus_epi32_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_packus_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_packus_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_packus_epi32(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[1, 3, 17, 19, 5, 7, 21, 23, 9, 11, 25, 27, 13, 15, 29, 31]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_packus_epi32(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_packus_epi32(create_random__mmask32(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_packus_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_packus_epi32_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_packus_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_packus_epi32(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 2, 10, 12, 4, 6, 14, 16, 0, 2, 10, 12, 4, 6, 14, 16]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_packus_epi32(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_packus_epi32(create_random__mmask32(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_packus_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_packus_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_packus_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_packus_epi32(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[100, 300, 110, 310, 500, 700, 510, 710, 900, 1100, 910, 1110, 1300, 1500, 1310, 1510]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_packus_epi32(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_packus_epi32(create_random__mmask32(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_packus_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_packus_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_packus_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_packus_epi32(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_packus_epi32(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_packus_epi32(create_random__mmask32(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_packus_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_packus_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_packus_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_packus_epi32(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_packus_epi32(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_packus_epi32(create_random__mmask32(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_packus_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_packus_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_packus_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_packus_epi32(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_packus_epi32(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_packus_epi32(create_random__mmask32(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_packus_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_packus_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_packus_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_packus_epi32(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_packus_epi32(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_packus_epi32(create_random__mmask32(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_packus_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_packus_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_packus_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_packus_epi32(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_packus_epi32(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_packus_epi32(create_random__mmask32(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_packus_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_packus_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_packus_epi32_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_packus_epi32(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0, 0, 65535, 65535, 0, 0, 65535, 65535, 0, 0, 65535, 65535, 0, 0, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_packus_epi32(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_packus_epi32(create_random__mmask32(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_packus_epi32_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_packus_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_packus_epi32_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_packus_epi32(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[65535, 65535, 0, 0, 65535, 65535, 0, 0, 65535, 65535, 0, 0, 65535, 65535, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_packus_epi32(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_packus_epi32(create_random__mmask32(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_packus_epi32_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_packus_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_packus_epi32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_packus_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[9, 11, 17, 19, 13, 15, 21, 23]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_packus_epi32(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_packus_epi32(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_packus_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_packus_epi32_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_packus_epi32_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_packus_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]), create__m256i_from_i32_array([20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[10, -65524, 20, -65514, 14, -65520, 24, -65510]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_packus_epi32(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]), create__m256i_from_i32_array([20, 19, 22, 17, 24, 15, 26, 13]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_packus_epi32(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_packus_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_packus_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_packus_epi32_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_packus_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]), create__m256i_from_i32_array([120, 220, 320, 420, 520, 620, 720, 820])));
        check_array_equality(&result, &[110, 310, 120, 320, 510, 710, 520, 720]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_packus_epi32(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]), create__m256i_from_i32_array([120, 220, 320, 420, 520, 620, 720, 820]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_packus_epi32(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_packus_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_packus_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_packus_epi32_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_packus_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_packus_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_packus_epi32(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_packus_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_packus_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_packus_epi32_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_packus_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_packus_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_packus_epi32(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_packus_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_packus_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_packus_epi32_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_packus_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_packus_epi32(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_packus_epi32(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_packus_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_packus_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_packus_epi32_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_packus_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-65536, -65536, -65536, -65536, -65536, -65536, -65536, -65536]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_packus_epi32(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_packus_epi32(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_packus_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_packus_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_packus_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_packus_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-2147483648, 2147418112, 0, -65536, -2147483648, 2147418112, 0, -65536]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_packus_epi32(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_packus_epi32(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_packus_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_packus_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_packus_epi32_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_packus_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[-2147418113, -2147418113, -2147483647, -2147483645, -2147418113, -2147418113, -2147483643, -2147483641]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_packus_epi32(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_packus_epi32(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_packus_epi32_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_packus_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_packus_epi32_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_packus_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[2147418112, 2147418112, 2147418113, 2147418115, 2147418112, 2147418112, 2147418117, 2147418119]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_packus_epi32(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_packus_epi32(create_random__m256i(), create_random__mmask16(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_packus_epi32_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_packus_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_packus_epi32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_packus_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 3, 9, 11, 5, 7, 13, 15]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_packus_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_packus_epi32(create_random__mmask16(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_packus_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_packus_epi32_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_packus_epi32_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_packus_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 2, 10, 12, 4, 6, 14, 16]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_packus_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_packus_epi32(create_random__mmask16(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_packus_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_packus_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_packus_epi32_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_packus_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[100, 300, 110, 310, 500, 700, 510, 710]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_packus_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_packus_epi32(create_random__mmask16(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_packus_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_packus_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_packus_epi32_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_packus_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_packus_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_packus_epi32(create_random__mmask16(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_packus_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_packus_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_packus_epi32_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_packus_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_packus_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_packus_epi32(create_random__mmask16(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_packus_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_packus_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_packus_epi32_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_packus_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_packus_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_packus_epi32(create_random__mmask16(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_packus_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_packus_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_packus_epi32_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_packus_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_packus_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_packus_epi32(create_random__mmask16(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_packus_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_packus_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_packus_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_packus_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_packus_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_packus_epi32(create_random__mmask16(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_packus_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_packus_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_packus_epi32_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_packus_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0, 0, 65535, 65535, 0, 0, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_packus_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_packus_epi32(create_random__mmask16(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_packus_epi32_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_packus_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_packus_epi32_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_packus_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[65535, 65535, 0, 0, 65535, 65535, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_packus_epi32(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_packus_epi32(create_random__mmask16(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_packus_epi32_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_packus_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_packus_epi32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_packus_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[5, 7, 9, 11]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_packus_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_packus_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_packus_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_packus_epi32_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_packus_epi32_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_packus_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([10, 9, 12, 7]), create__m128i_from_i32_array([20, 19, 22, 17])));
        check_array_equality(&result, &[10, -65524, 20, -65514]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_packus_epi32(create__m128i_from_i32_array([0, -1, 2, -3]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([10, 9, 12, 7]), create__m128i_from_i32_array([20, 19, 22, 17]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_packus_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_packus_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_packus_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_packus_epi32_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_packus_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([110, 210, 310, 410]), create__m128i_from_i32_array([120, 220, 320, 420])));
        check_array_equality(&result, &[110, 310, 120, 320]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_packus_epi32(create__m128i_from_i32_array([100, 200, 300, 400]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([110, 210, 310, 410]), create__m128i_from_i32_array([120, 220, 320, 420]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_packus_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_packus_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_packus_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_packus_epi32_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_packus_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_packus_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_packus_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_packus_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_packus_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_packus_epi32_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_packus_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_packus_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_packus_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_packus_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_packus_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_packus_epi32_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_packus_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_packus_epi32(create__m128i_from_i32_array([0, 0, 0, 0]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_packus_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_packus_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_packus_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_packus_epi32_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_packus_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[-65536, -65536, -65536, -65536]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_packus_epi32(create__m128i_from_i32_array([-1, -1, -1, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_packus_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_packus_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_packus_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_packus_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_packus_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-2147483648, 2147418112, 0, -65536]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_packus_epi32(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_packus_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_packus_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_packus_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_packus_epi32_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_packus_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[-2147418113, -2147418113, -2147483647, -2147483645]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_packus_epi32(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_packus_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_packus_epi32_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_packus_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_packus_epi32_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_packus_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[2147418112, 2147418112, 2147418113, 2147418115]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_packus_epi32(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_packus_epi32(create_random__m128i(), create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_packus_epi32_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_packus_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_packus_epi32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_packus_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 3, 5, 7]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_packus_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_packus_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_packus_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_packus_epi32_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_packus_epi32_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_packus_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[0, 2, 10, 12]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_packus_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_packus_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_packus_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_packus_epi32_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_packus_epi32_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_packus_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[100, 300, 110, 310]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_packus_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_packus_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_packus_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_packus_epi32_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_packus_epi32_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_packus_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_packus_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_packus_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_packus_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_packus_epi32_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_packus_epi32_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_packus_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_packus_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_packus_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_packus_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_packus_epi32_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_packus_epi32_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_packus_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_packus_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_packus_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_packus_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_packus_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_packus_epi32_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_packus_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_packus_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_packus_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_packus_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_packus_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_packus_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_packus_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_packus_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_packus_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_packus_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_packus_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_packus_epi32_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_packus_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[0, 0, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_packus_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_packus_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_packus_epi32_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_packus_epi32_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_packus_epi32_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_packus_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[65535, 65535, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_packus_epi32(create__mmask8_from(0b01010101), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_packus_epi32(create_random__mmask8(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_packus_epi32_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_packus_epi32_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_packus_epi16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_packus_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[1, 2, 3, 4, 17, 18, 19, 20, 5, 6, 7, 8, 21, 22, 23, 24, 9, 10, 11, 12, 25, 26, 27, 28, 13, 14, 15, 16, 29, 30, 31, 32]).map_err(|e| crate::cpu::with_call(e, "_mm512_packus_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_packus_epi16(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_packus_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_packus_epi16_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_packus_epi16_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_packus_epi16(create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 2, 4, 6, 2314, 1804, 1294, 784, 0, 2, 4, 6, 2314, 1804, 1294, 784, 0, 2, 4, 6, 2314, 1804, 1294, 784, 0, 2, 4, 6, 2314, 1804, 1294, 784]).map_err(|e| crate::cpu::with_call(e, "_mm512_packus_epi16(create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_packus_epi16(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_packus_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_packus_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_packus_epi16_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_packus_epi16(create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]), create__m512i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610, 1710, 1810, 1910, 2010, 2110, 2210, 2310, 2410, 2510, 2610, 2710, 2810, 2910, 3010, 3110, 3210])));
        check_array_equality(&result, &[-14236, -1, -1, -1, -11666, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_packus_epi16(create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]), create__m512i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610, 1710, 1810, 1910, 2010, 2110, 2210, 2310, 2410, 2510, 2610, 2710, 2810, 2910, 3010, 3110, 3210]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_packus_epi16(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_packus_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_packus_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_packus_epi16_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_packus_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_packus_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_packus_epi16(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_packus_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_packus_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_packus_epi16_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_packus_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_packus_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_packus_epi16(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_packus_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_packus_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_packus_epi16_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_packus_epi16(create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_packus_epi16(create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_packus_epi16(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_packus_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_packus_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_packus_epi16_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_packus_epi16(create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_packus_epi16(create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_packus_epi16(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_packus_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_packus_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_packus_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_packus_epi16(create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-256, 0, -256, 0, -256, 0, -256, 0, -256, 0, -256, 0, -256, 0, -256, 0, -256, 0, -256, 0, -256, 0, -256, 0, -256, 0, -256, 0, -256, 0, -256, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_packus_epi16(create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_packus_epi16(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_packus_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_packus_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_packus_epi16_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_packus_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0, -1, -1, -1, -1, 0, 0, 0, 0, -1, -1, -1, -1, 0, 0, 0, 0, -1, -1, -1, -1, 0, 0, 0, 0, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm512_packus_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_packus_epi16(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_packus_epi16_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_packus_epi16_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_packus_epi16_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_packus_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -1, 0, 0, 0, 0, -1, -1, -1, -1, 0, 0, 0, 0, -1, -1, -1, -1, 0, 0, 0, 0, -1, -1, -1, -1, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_packus_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_packus_epi16(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_packus_epi16_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_packus_epi16_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bw,avx2")]
fn test_x86_avx512bw_mm512_packus_epi16_vs_narrow_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx2")) {
            return Ok(Verdict::Skipped("avx2 not present"));
        }
    unsafe {
        let a_wide = create__m512i_from_i16_array([1i16, 2i16, 3i16, 4i16, 5i16, 6i16, 7i16, 8i16, 9i16, 10i16, 11i16, 12i16, 13i16, 14i16, 15i16, 16i16, 17i16, 18i16, 19i16, 20i16, 21i16, 22i16, 23i16, 24i16, 25i16, 26i16, 27i16, 28i16, 29i16, 30i16, 31i16, 32i16]);
        let a_narrow = create__m256i_from_i16_array([1i16, 2i16, 3i16, 4i16, 5i16, 6i16, 7i16, 8i16, 9i16, 10i16, 11i16, 12i16, 13i16, 14i16, 15i16, 16i16]);
        let b_wide = create__m512i_from_i16_array([33i16, 34i16, 35i16, 36i16, 37i16, 38i16, 39i16, 40i16, 41i16, 42i16, 43i16, 44i16, 45i16, 46i16, 47i16, 48i16, 49i16, 50i16, 51i16, 52i16, 53i16, 54i16, 55i16, 56i16, 57i16, 58i16, 59i16, 60i16, 61i16, 62i16, 63i16, 64i16]);
        let b_narrow = create__m256i_from_i16_array([33i16, 34i16, 35i16, 36i16, 37i16, 38i16, 39i16, 40i16, 41i16, 42i16, 43i16, 44i16, 45i16, 46i16, 47i16, 48i16]);
        let wide = unpack__m512i_to_i16_array(_mm512_packus_epi16(a_wide, b_wide));
        let narrow = unpack__m256i_to_i16_array(_mm256_packus_epi16(a_narrow, b_narrow));
        check_array_equality(&wide[..16], &narrow).map_err(|e| crate::cpu::with_call(e, "_mm512_packus_epi16(a_wide, b_wide) vs _mm256_packus_epi16(a_narrow, b_narrow)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_packus_epi16_vs_narrow() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_packus_epi16_vs_narrow_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_packus_epi16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_packus_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[17, 18, 19, 20, 33, 34, 35, 36, 21, 22, 23, 24, 37, 38, 39, 40, 25, 26, 27, 28, 41, 42, 43, 44, 29, 30, 31, 32, 45, 46, 47, 48]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_packus_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create__m512i_from_i32_array([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_packus_epi16(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_packus_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_packus_epi16_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_packus_epi16_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_packus_epi16(create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m512i_from_i16_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[10, -244, 14, -240, 20, -234, 24, -230, 10, -244, 14, -240, 20, -234, 24, -230, 10, -244, 14, -240, 20, -234, 24, -230, 10, -244, 14, -240, 20, -234, 24, -230]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_packus_epi16(create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m512i_from_i16_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_packus_epi16(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_packus_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_packus_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_packus_epi16_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_packus_epi16(create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610, 1710, 1810, 1910, 2010, 2110, 2210, 2310, 2410, 2510, 2610, 2710, 2810, 2910, 3010, 3110, 3210]), create__m512i_from_i16_array([120, 220, 320, 420, 520, 620, 720, 820, 920, 1020, 1120, 1220, 1320, 1420, 1520, 1620, 1720, 1820, 1920, 2020, 2120, 2220, 2320, 2420, 2520, 2620, 2720, 2820, 2920, 3020, 3120, 3220])));
        check_array_equality(&result, &[110, 255, 511, 511, 376, 767, 767, 1023, 1023, 1023, 1279, 1279, 1535, 1535, 1535, 1791, 1791, 2047, 2047, 2047, 2303, 2303, 2303, 2559, 2559, 2815, 2815, 2815, 3071, 3071, 3327, 3327]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_packus_epi16(create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610, 1710, 1810, 1910, 2010, 2110, 2210, 2310, 2410, 2510, 2610, 2710, 2810, 2910, 3010, 3110, 3210]), create__m512i_from_i16_array([120, 220, 320, 420, 520, 620, 720, 820, 920, 1020, 1120, 1220, 1320, 1420, 1520, 1620, 1720, 1820, 1920, 2020, 2120, 2220, 2320, 2420, 2520, 2620, 2720, 2820, 2920, 3020, 3120, 3220]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_packus_epi16(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_packus_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_packus_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_packus_epi16_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_packus_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_packus_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_packus_epi16(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_packus_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_packus_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_packus_epi16_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_packus_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_packus_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_packus_epi16(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_packus_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_packus_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_packus_epi16_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_packus_epi16(create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_packus_epi16(create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_packus_epi16(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_packus_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_packus_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_packus_epi16_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_packus_epi16(create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-256, -256, -256, -256, -256, -256, -256, -256, -256, -256, -256, -256, -256, -256, -256, -256, -256, -256, -256, -256, -256, -256, -256, -256, -256, -256, -256, -256, -256, -256, -256, -256]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_packus_epi16(create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_packus_epi16(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_packus_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_packus_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_packus_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_packus_epi16(create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, 32512, 0, -256, -32768, 32512, 0, -256, -32768, 32512, 0, -256, -32768, 32512, 0, -256, -32768, 32512, 0, -256, -32768, 32512, 0, -256, -32768, 32512, 0, -256, -32768, 32512, 0, -256]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_packus_epi16(create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_packus_epi16(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_packus_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_packus_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_packus_epi16_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_packus_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-32513, -32513, -32513, -32513, -32767, -32766, -32765, -32764, -32513, -32513, -32513, -32513, -32763, -32762, -32761, -32760, -32513, -32513, -32513, -32513, -32759, -32758, -32757, -32756, -32513, -32513, -32513, -32513, -32755, -32754, -32753, -32752]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_packus_epi16(create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_packus_epi16(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_packus_epi16_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_packus_epi16_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_mask_packus_epi16_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_mask_packus_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[32512, 32512, 32512, 32512, 32513, 32514, 32515, 32516, 32512, 32512, 32512, 32512, 32517, 32518, 32519, 32520, 32512, 32512, 32512, 32512, 32521, 32522, 32523, 32524, 32512, 32512, 32512, 32512, 32525, 32526, 32527, 32528]).map_err(|e| crate::cpu::with_call(e, "_mm512_mask_packus_epi16(create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_mask_packus_epi16(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_mask_packus_epi16_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_mask_packus_epi16_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_packus_epi16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_packus_epi16(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[1, 2, 3, 4, 17, 18, 19, 20, 5, 6, 7, 8, 21, 22, 23, 24, 9, 10, 11, 12, 25, 26, 27, 28, 13, 14, 15, 16, 29, 30, 31, 32]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_packus_epi16(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_packus_epi16(create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_packus_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_packus_epi16_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_packus_epi16_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_packus_epi16(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 2, 4, 6, 10, 12, 14, 16, 0, 2, 4, 6, 10, 12, 14, 16, 0, 2, 4, 6, 10, 12, 14, 16, 0, 2, 4, 6, 10, 12, 14, 16]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_packus_epi16(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_packus_epi16(create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_packus_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_packus_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_packus_epi16_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_packus_epi16(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]), create__m512i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610, 1710, 1810, 1910, 2010, 2110, 2210, 2310, 2410, 2510, 2610, 2710, 2810, 2910, 3010, 3110, 3210])));
        check_array_equality(&result, &[100, 255, 255, 255, 110, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_packus_epi16(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200]), create__m512i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610, 1710, 1810, 1910, 2010, 2110, 2210, 2310, 2410, 2510, 2610, 2710, 2810, 2910, 3010, 3110, 3210]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_packus_epi16(create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_packus_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_packus_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_packus_epi16_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_packus_epi16(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_packus_epi16(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_packus_epi16(create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_packus_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_packus_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_packus_epi16_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_packus_epi16(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_packus_epi16(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_packus_epi16(create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_packus_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_packus_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_packus_epi16_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_packus_epi16(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_packus_epi16(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_packus_epi16(create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_packus_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_packus_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_packus_epi16_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_packus_epi16(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_packus_epi16(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_packus_epi16(create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_packus_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_packus_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_packus_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_packus_epi16(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_packus_epi16(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m512i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_packus_epi16(create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_packus_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_packus_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_packus_epi16_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_packus_epi16(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0, 255, 255, 255, 255, 0, 0, 0, 0, 255, 255, 255, 255, 0, 0, 0, 0, 255, 255, 255, 255, 0, 0, 0, 0, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_packus_epi16(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_packus_epi16(create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_packus_epi16_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_packus_epi16_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_maskz_packus_epi16_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i16_array(_mm512_maskz_packus_epi16(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[255, 255, 255, 255, 0, 0, 0, 0, 255, 255, 255, 255, 0, 0, 0, 0, 255, 255, 255, 255, 0, 0, 0, 0, 255, 255, 255, 255, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_maskz_packus_epi16(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m512i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_maskz_packus_epi16(create_random__mmask64(), create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_maskz_packus_epi16_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_maskz_packus_epi16_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_packus_epi16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_packus_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[9, 10, 11, 12, 17, 18, 19, 20, 13, 14, 15, 16, 21, 22, 23, 24]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_packus_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]), create__m256i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_packus_epi16(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_packus_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_packus_epi16_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_packus_epi16_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_packus_epi16(create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m256i_from_i16_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[10, -244, 14, -240, 20, -234, 24, -230, 10, -244, 14, -240, 20, -234, 24, -230]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_packus_epi16(create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create__m256i_from_i16_array([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_packus_epi16(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_packus_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_packus_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_packus_epi16_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_packus_epi16(create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]), create__m256i_from_i16_array([120, 220, 320, 420, 520, 620, 720, 820, 920, 1020, 1120, 1220, 1320, 1420, 1520, 1620])));
        check_array_equality(&result, &[110, 255, 511, 511, 376, 767, 767, 1023, 1023, 1023, 1279, 1279, 1535, 1535, 1535, 1791]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_packus_epi16(create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]), create__m256i_from_i16_array([120, 220, 320, 420, 520, 620, 720, 820, 920, 1020, 1120, 1220, 1320, 1420, 1520, 1620]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_packus_epi16(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_packus_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_packus_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_packus_epi16_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_packus_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_packus_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_packus_epi16(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_packus_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_packus_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_packus_epi16_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_packus_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_packus_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_packus_epi16(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_packus_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_packus_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_packus_epi16_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_packus_epi16(create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_packus_epi16(create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_packus_epi16(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_packus_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_packus_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_packus_epi16_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_packus_epi16(create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-256, -256, -256, -256, -256, -256, -256, -256, -256, -256, -256, -256, -256, -256, -256, -256]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_packus_epi16(create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_packus_epi16(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_packus_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_packus_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_packus_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_packus_epi16(create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, 32512, 0, -256, -32768, 32512, 0, -256, -32768, 32512, 0, -256, -32768, 32512, 0, -256]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_packus_epi16(create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_packus_epi16(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_packus_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_packus_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_packus_epi16_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_packus_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[-32513, -32513, -32513, -32513, -32767, -32766, -32765, -32764, -32513, -32513, -32513, -32513, -32763, -32762, -32761, -32760]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_packus_epi16(create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_packus_epi16(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_packus_epi16_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_packus_epi16_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_mask_packus_epi16_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_mask_packus_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[32512, 32512, 32512, 32512, 32513, 32514, 32515, 32516, 32512, 32512, 32512, 32512, 32517, 32518, 32519, 32520]).map_err(|e| crate::cpu::with_call(e, "_mm256_mask_packus_epi16(create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_mask_packus_epi16(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_mask_packus_epi16_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_mask_packus_epi16_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_packus_epi16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_packus_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 2, 3, 4, 9, 10, 11, 12, 5, 6, 7, 8, 13, 14, 15, 16]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_packus_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_packus_epi16(create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_packus_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_packus_epi16_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_packus_epi16_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_packus_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 2, 4, 6, 10, 12, 14, 16, 0, 2, 4, 6, 10, 12, 14, 16]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_packus_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_packus_epi16(create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_packus_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_packus_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_packus_epi16_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_packus_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m256i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[100, 255, 255, 255, 110, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_packus_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m256i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_packus_epi16(create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_packus_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_packus_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_packus_epi16_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_packus_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_packus_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_packus_epi16(create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_packus_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_packus_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_packus_epi16_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_packus_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_packus_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_packus_epi16(create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_packus_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_packus_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_packus_epi16_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_packus_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_packus_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_packus_epi16(create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_packus_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_packus_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_packus_epi16_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_packus_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_packus_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_packus_epi16(create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_packus_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_packus_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_packus_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_packus_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_packus_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m256i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_packus_epi16(create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_packus_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_packus_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_packus_epi16_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_packus_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0, 255, 255, 255, 255, 0, 0, 0, 0, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_packus_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_packus_epi16(create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_packus_epi16_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_packus_epi16_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm256_maskz_packus_epi16_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m256i_to_i16_array(_mm256_maskz_packus_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[255, 255, 255, 255, 0, 0, 0, 0, 255, 255, 255, 255, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_maskz_packus_epi16(create__mmask32_from(0x55555555u32), create__m256i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m256i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_maskz_packus_epi16(create_random__mmask32(), create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm256_maskz_packus_epi16_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm256_maskz_packus_epi16_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_packus_epi16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_packus_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12])));
        check_array_equality(&result, &[5, 6, 7, 8, 9, 10, 11, 12]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_packus_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([5, 6, 7, 8]), create__m128i_from_i32_array([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_packus_epi16(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_packus_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_packus_epi16_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_packus_epi16_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_packus_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3]), create__m128i_from_i16_array([20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[10, -244, 14, -240, 20, -234, 24, -230]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_packus_epi16(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3]), create__m128i_from_i16_array([20, 19, 22, 17, 24, 15, 26, 13]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_packus_epi16(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_packus_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_packus_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_packus_epi16_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_packus_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810]), create__m128i_from_i16_array([120, 220, 320, 420, 520, 620, 720, 820])));
        check_array_equality(&result, &[110, 255, 511, 511, 376, 767, 767, 1023]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_packus_epi16(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810]), create__m128i_from_i16_array([120, 220, 320, 420, 520, 620, 720, 820]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_packus_epi16(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_packus_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_packus_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_packus_epi16_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_packus_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_packus_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_packus_epi16(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_packus_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_packus_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_packus_epi16_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_packus_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_packus_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_packus_epi16(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_packus_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_packus_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_packus_epi16_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_packus_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_packus_epi16(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_packus_epi16(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_packus_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_packus_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_packus_epi16_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_packus_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-256, -256, -256, -256, -256, -256, -256, -256]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_packus_epi16(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_packus_epi16(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_packus_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_packus_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_packus_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_packus_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, 32512, 0, -256, -32768, 32512, 0, -256]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_packus_epi16(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_packus_epi16(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_packus_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_packus_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_packus_epi16_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_packus_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[-32513, -32513, -32513, -32513, -32767, -32766, -32765, -32764]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_packus_epi16(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_packus_epi16(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_packus_epi16_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_packus_epi16_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_mask_packus_epi16_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_mask_packus_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[32512, 32512, 32512, 32512, 32513, 32514, 32515, 32516]).map_err(|e| crate::cpu::with_call(e, "_mm_mask_packus_epi16(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_mask_packus_epi16(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_mask_packus_epi16_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_mask_packus_epi16_asym_max_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_packus_epi16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_packus_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_packus_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_packus_epi16(create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_packus_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_packus_epi16_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_packus_epi16_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_packus_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 2, 4, 6, 10, 12, 14, 16]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_packus_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i16_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_packus_epi16(create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_packus_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_packus_epi16_normal2_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_packus_epi16_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_packus_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[100, 255, 255, 255, 110, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_packus_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m128i_from_i16_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_packus_epi16(create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_packus_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_packus_epi16_normal3_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_packus_epi16_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_packus_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_packus_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_packus_epi16(create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_packus_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_packus_epi16_boundary_min_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_packus_epi16_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_packus_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_packus_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_packus_epi16(create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_packus_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_packus_epi16_boundary_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_packus_epi16_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_packus_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_packus_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_packus_epi16(create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_packus_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_packus_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_packus_epi16_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_packus_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_packus_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_packus_epi16(create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_packus_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_packus_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_packus_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_packus_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_packus_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_packus_epi16(create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_packus_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_packus_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_packus_epi16_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_packus_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_packus_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_packus_epi16(create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_packus_epi16_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_packus_epi16_asym_min_max_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm_maskz_packus_epi16_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512vl")) {
            return Ok(Verdict::Skipped("avx512vl not present"));
        }
    unsafe {
        let result = unpack__m128i_to_i16_array(_mm_maskz_packus_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[255, 255, 255, 255, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_maskz_packus_epi16(create__mmask16_from(0b0101010101010101), create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_maskz_packus_epi16(create_random__mmask16(), create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm_maskz_packus_epi16_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm_maskz_packus_epi16_asym_max_min_impl() }
}
