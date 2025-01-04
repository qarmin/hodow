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
fn test_x86_vaes_mm256_aesdeclast_epi128_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdeclast_epi128(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1381126656, 1381126752, 1381126878, 1381126716, 1381126715, 1381126827, 1381126711, 1381126831]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesdeclast_epi128(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesdeclast_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesdeclast_epi128() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesdeclast_epi128_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdeclast_epi128_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdeclast_epi128(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[2102558040, 1383944820, 2102558054, 1383944742, 2102558014, 1383944806, 2102558133, 1383944810]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesdeclast_epi128(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesdeclast_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesdeclast_epi128_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesdeclast_epi128_normal2_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdeclast_epi128_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdeclast_epi128(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[1381108194, 1381126755, 1381127028, 1381107724, 1381160004, 1381108540, 1381132478, 1381132670]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesdeclast_epi128(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesdeclast_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesdeclast_epi128_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesdeclast_epi128_normal3_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdeclast_epi128_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdeclast_epi128(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-1169010094, -1169010094, -1169010094, -1169010094, -1169010094, -1169010094, -1169010094, -1169010094]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesdeclast_epi128(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesdeclast_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesdeclast_epi128_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesdeclast_epi128_boundary_min_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdeclast_epi128_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdeclast_epi128(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[344097410, 344097410, 344097410, 344097410, 344097410, 344097410, 344097410, 344097410]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesdeclast_epi128(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesdeclast_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesdeclast_epi128_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesdeclast_epi128_boundary_max_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdeclast_epi128_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdeclast_epi128(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesdeclast_epi128(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesdeclast_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesdeclast_epi128_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesdeclast_epi128_boundary_zero_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdeclast_epi128_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdeclast_epi128(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesdeclast_epi128(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesdeclast_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesdeclast_epi128_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesdeclast_epi128_boundary_allones_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdeclast_epi128_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdeclast_epi128(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-346915502, 763538818, 2102558034, -981291646, -346915502, 763538818, 2102558034, -981291646]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesdeclast_epi128(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesdeclast_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesdeclast_epi128_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesdeclast_epi128_boundary_mixed_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdeclast_epi128_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdeclast_epi128(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[1169010093, 1169010093, 1169010093, 1169010093, 1169010093, 1169010093, 1169010093, 1169010093]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesdeclast_epi128(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesdeclast_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesdeclast_epi128_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesdeclast_epi128_asym_min_max_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdeclast_epi128_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdeclast_epi128(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-344097411, -344097411, -344097411, -344097411, -344097411, -344097411, -344097411, -344097411]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesdeclast_epi128(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesdeclast_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesdeclast_epi128_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesdeclast_epi128_asym_max_min_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdeclast_epi128_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdeclast_epi128(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[1381126680, 1381126776, 1381126854, 1381126692, 1381126691, 1381126835, 1381126703, 1381126823, 1381126745, 1381126841, 1381126789, 1381126813, 1381126894, 1381126857, 1381126884, 1381126748]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesdeclast_epi128(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesdeclast_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesdeclast_epi128() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesdeclast_epi128_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdeclast_epi128_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdeclast_epi128(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[2102558040, 1383944820, 2102558054, 1383944742, 2102558014, 1383944806, 2102558133, 1383944810, 2102558040, 1383944820, 2102558054, 1383944742, 2102558014, 1383944806, 2102558133, 1383944810]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesdeclast_epi128(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesdeclast_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesdeclast_epi128_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesdeclast_epi128_normal2_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdeclast_epi128_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdeclast_epi128(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[1381108194, 1381126755, 1381127028, 1381107724, 1381160004, 1381108540, 1381132478, 1381132670, 1381118913, 1381160506, 1381159179, 1381119046, 1381146757, 1381118787, 1381118837, 1381118008]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesdeclast_epi128(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesdeclast_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesdeclast_epi128_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesdeclast_epi128_normal3_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdeclast_epi128_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdeclast_epi128(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-1169010094, -1169010094, -1169010094, -1169010094, -1169010094, -1169010094, -1169010094, -1169010094, -1169010094, -1169010094, -1169010094, -1169010094, -1169010094, -1169010094, -1169010094, -1169010094]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesdeclast_epi128(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesdeclast_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesdeclast_epi128_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesdeclast_epi128_boundary_min_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdeclast_epi128_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdeclast_epi128(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[344097410, 344097410, 344097410, 344097410, 344097410, 344097410, 344097410, 344097410, 344097410, 344097410, 344097410, 344097410, 344097410, 344097410, 344097410, 344097410]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesdeclast_epi128(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesdeclast_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesdeclast_epi128_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesdeclast_epi128_boundary_max_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdeclast_epi128_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdeclast_epi128(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesdeclast_epi128(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesdeclast_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesdeclast_epi128_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesdeclast_epi128_boundary_zero_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdeclast_epi128_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdeclast_epi128(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesdeclast_epi128(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesdeclast_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesdeclast_epi128_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesdeclast_epi128_boundary_allones_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdeclast_epi128_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdeclast_epi128(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-346915502, 763538818, 2102558034, -981291646, -346915502, 763538818, 2102558034, -981291646, -346915502, 763538818, 2102558034, -981291646, -346915502, 763538818, 2102558034, -981291646]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesdeclast_epi128(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesdeclast_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesdeclast_epi128_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesdeclast_epi128_boundary_mixed_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdeclast_epi128_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdeclast_epi128(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[1169010093, 1169010093, 1169010093, 1169010093, 1169010093, 1169010093, 1169010093, 1169010093, 1169010093, 1169010093, 1169010093, 1169010093, 1169010093, 1169010093, 1169010093, 1169010093]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesdeclast_epi128(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesdeclast_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesdeclast_epi128_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesdeclast_epi128_asym_min_max_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdeclast_epi128_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdeclast_epi128(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-344097411, -344097411, -344097411, -344097411, -344097411, -344097411, -344097411, -344097411, -344097411, -344097411, -344097411, -344097411, -344097411, -344097411, -344097411, -344097411]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesdeclast_epi128(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesdeclast_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesdeclast_epi128_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesdeclast_epi128_asym_max_min_impl() }
}
