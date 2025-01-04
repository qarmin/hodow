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

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenclast_epi128_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenclast_epi128(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1667457909, 1667457917, 1667457904, 1667458046, 1667457894, 1667457889, 1667457994, 1667457824]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesenclast_epi128(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesenclast_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesenclast_epi128() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesenclast_epi128_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenclast_epi128_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenclast_epi128(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[375592553, 1662411551, 375592571, 1662411603, 375592700, 1662411530, 375592575, 1662411674]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesenclast_epi128(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesenclast_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesenclast_epi128_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesenclast_epi128_normal2_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenclast_epi128_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenclast_epi128(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[1667457837, 1667464250, 1667464519, 1667457786, 1667462721, 1667462408, 1667463587, 1667465117]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesenclast_epi128(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesenclast_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesenclast_epi128_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesenclast_epi128_normal3_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenclast_epi128_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenclast_epi128(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[1298359139, 1298359139, 1298359139, 1298359139, 1298359139, 1298359139, 1298359139, 1298359139]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesenclast_epi128(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesenclast_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesenclast_epi128_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesenclast_epi128_boundary_min_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenclast_epi128_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenclast_epi128(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-1377179159, -1377179159, -1377179159, -1377179159, -1377179159, -1377179159, -1377179159, -1377179159]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesenclast_epi128(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesenclast_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesenclast_epi128_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesenclast_epi128_boundary_max_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenclast_epi128_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenclast_epi128(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesenclast_epi128(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesenclast_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesenclast_epi128_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesenclast_epi128_boundary_zero_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenclast_epi128_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenclast_epi128(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesenclast_epi128(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesenclast_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesenclast_epi128_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesenclast_epi128_boundary_allones_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenclast_epi128_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenclast_epi128(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-1771891101, -1293312791, -765258141, -1662411543, -1771891101, -1293312791, -765258141, -1662411543]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesenclast_epi128(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesenclast_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesenclast_epi128_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesenclast_epi128_boundary_mixed_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenclast_epi128_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenclast_epi128(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-1298359140, -1298359140, -1298359140, -1298359140, -1298359140, -1298359140, -1298359140, -1298359140]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesenclast_epi128(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesenclast_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesenclast_epi128_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesenclast_epi128_asym_min_max_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenclast_epi128_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenclast_epi128(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[1377179158, 1377179158, 1377179158, 1377179158, 1377179158, 1377179158, 1377179158, 1377179158]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesenclast_epi128(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesenclast_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesenclast_epi128_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesenclast_epi128_asym_max_min_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenclast_epi128_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenclast_epi128(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[1667457901, 1667457893, 1667457896, 1667458022, 1667457918, 1667457913, 1667458002, 1667457832, 1667457816, 1667457917, 1667457840, 1667458018, 1667457994, 1667457973, 1667457897, 1667458026]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesenclast_epi128(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesenclast_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesenclast_epi128() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesenclast_epi128_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenclast_epi128_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenclast_epi128(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[375592553, 1662411551, 375592571, 1662411603, 375592700, 1662411530, 375592575, 1662411674, 375592553, 1662411551, 375592571, 1662411603, 375592700, 1662411530, 375592575, 1662411674]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesenclast_epi128(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesenclast_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesenclast_epi128_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesenclast_epi128_normal2_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenclast_epi128_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenclast_epi128(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[1667457837, 1667464250, 1667464519, 1667457786, 1667462721, 1667462408, 1667463587, 1667465117, 1667463377, 1667494249, 1667495551, 1667465053, 1667460836, 1667460670, 1667459680, 1667460419]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesenclast_epi128(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesenclast_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesenclast_epi128_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesenclast_epi128_normal3_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenclast_epi128_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenclast_epi128(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[1298359139, 1298359139, 1298359139, 1298359139, 1298359139, 1298359139, 1298359139, 1298359139, 1298359139, 1298359139, 1298359139, 1298359139, 1298359139, 1298359139, 1298359139, 1298359139]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesenclast_epi128(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesenclast_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesenclast_epi128_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesenclast_epi128_boundary_min_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenclast_epi128_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenclast_epi128(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-1377179159, -1377179159, -1377179159, -1377179159, -1377179159, -1377179159, -1377179159, -1377179159, -1377179159, -1377179159, -1377179159, -1377179159, -1377179159, -1377179159, -1377179159, -1377179159]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesenclast_epi128(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesenclast_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesenclast_epi128_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesenclast_epi128_boundary_max_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenclast_epi128_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenclast_epi128(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesenclast_epi128(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesenclast_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesenclast_epi128_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesenclast_epi128_boundary_zero_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenclast_epi128_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenclast_epi128(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesenclast_epi128(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesenclast_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesenclast_epi128_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesenclast_epi128_boundary_allones_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenclast_epi128_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenclast_epi128(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-1771891101, -1293312791, -765258141, -1662411543, -1771891101, -1293312791, -765258141, -1662411543, -1771891101, -1293312791, -765258141, -1662411543, -1771891101, -1293312791, -765258141, -1662411543]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesenclast_epi128(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesenclast_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesenclast_epi128_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesenclast_epi128_boundary_mixed_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenclast_epi128_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenclast_epi128(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-1298359140, -1298359140, -1298359140, -1298359140, -1298359140, -1298359140, -1298359140, -1298359140, -1298359140, -1298359140, -1298359140, -1298359140, -1298359140, -1298359140, -1298359140, -1298359140]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesenclast_epi128(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesenclast_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesenclast_epi128_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesenclast_epi128_asym_min_max_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenclast_epi128_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenclast_epi128(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[1377179158, 1377179158, 1377179158, 1377179158, 1377179158, 1377179158, 1377179158, 1377179158, 1377179158, 1377179158, 1377179158, 1377179158, 1377179158, 1377179158, 1377179158, 1377179158]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesenclast_epi128(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesenclast_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesenclast_epi128_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesenclast_epi128_asym_max_min_impl() }
}
