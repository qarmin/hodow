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
fn test_x86_vaes_mm256_aesdec_epi128_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdec_epi128(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1368450932, -1051610861, -1800699598, -912388812, -206554351, -1448256351, -1846131385, 1460639283]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesdec_epi128(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesdec_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesdec_epi128() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesdec_epi128_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdec_epi128_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdec_epi128(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[587997958, 203623466, -1341145013, 1052935713, -1195344792, -558505326, -655151647, -1865959176]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesdec_epi128(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesdec_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesdec_epi128_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesdec_epi128_normal2_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdec_epi128_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdec_epi128(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[1137052007, 894036133, -494746748, -1117470177, -1981427411, -457501829, 1685617328, 1805593807]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesdec_epi128(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesdec_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesdec_epi128_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesdec_epi128_normal3_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdec_epi128_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdec_epi128(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-729289641, -729289641, -729289641, -729289641, -729289641, -729289641, -729289641, -729289641]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesdec_epi128(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesdec_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesdec_epi128_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesdec_epi128_boundary_min_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdec_epi128_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdec_epi128(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-972522460, -972522460, -972522460, -972522460, -972522460, -972522460, -972522460, -972522460]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesdec_epi128(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesdec_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesdec_epi128_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesdec_epi128_boundary_max_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdec_epi128_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdec_epi128(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesdec_epi128(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesdec_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesdec_epi128_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesdec_epi128_boundary_zero_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdec_epi128_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdec_epi128(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesdec_epi128(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesdec_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesdec_epi128_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesdec_epi128_boundary_allones_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdec_epi128_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdec_epi128(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[1736891818, 1943860188, 587997964, -183939623, 1736891818, 1943860188, 587997964, -183939623]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesdec_epi128(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesdec_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesdec_epi128_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesdec_epi128_boundary_mixed_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdec_epi128_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdec_epi128(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[729289640, 729289640, 729289640, 729289640, 729289640, 729289640, 729289640, 729289640]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesdec_epi128(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesdec_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesdec_epi128_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesdec_epi128_asym_min_max_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesdec_epi128_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesdec_epi128(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[972522459, 972522459, 972522459, 972522459, 972522459, 972522459, 972522459, 972522459]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesdec_epi128(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesdec_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesdec_epi128_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesdec_epi128_asym_max_min_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdec_epi128_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdec_epi128(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[1368450924, -1051610869, -1800699606, -912388820, -206554359, -1448256327, -1846131361, 1460639291, -191311689, -1820104047, 666477805, -31308976, -717320997, -2102291653, -1923693399, 1269766141]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesdec_epi128(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesdec_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesdec_epi128() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesdec_epi128_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdec_epi128_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdec_epi128(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[587997958, 203623466, -1341145013, 1052935713, -1195344792, -558505326, -655151647, -1865959176, 587997958, 203623466, -1341145013, 1052935713, -1195344792, -558505326, -655151647, -1865959176]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesdec_epi128(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesdec_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesdec_epi128_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesdec_epi128_normal2_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdec_epi128_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdec_epi128(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[1137052007, 894036133, -494746748, -1117470177, -1981427411, -457501829, 1685617328, 1805593807, 1368182497, -1560732501, -1026930024, 1881839037, -7442139, -366575934, -1165915401, -880795294]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesdec_epi128(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesdec_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesdec_epi128_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesdec_epi128_normal3_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdec_epi128_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdec_epi128(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-729289641, -729289641, -729289641, -729289641, -729289641, -729289641, -729289641, -729289641, -729289641, -729289641, -729289641, -729289641, -729289641, -729289641, -729289641, -729289641]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesdec_epi128(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesdec_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesdec_epi128_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesdec_epi128_boundary_min_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdec_epi128_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdec_epi128(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-972522460, -972522460, -972522460, -972522460, -972522460, -972522460, -972522460, -972522460, -972522460, -972522460, -972522460, -972522460, -972522460, -972522460, -972522460, -972522460]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesdec_epi128(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesdec_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesdec_epi128_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesdec_epi128_boundary_max_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdec_epi128_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdec_epi128(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738, 1381126738]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesdec_epi128(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesdec_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesdec_epi128_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesdec_epi128_boundary_zero_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdec_epi128_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdec_epi128(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126, -2105376126]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesdec_epi128(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesdec_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesdec_epi128_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesdec_epi128_boundary_allones_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdec_epi128_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdec_epi128(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[1736891818, 1943860188, 587997964, -183939623, 1736891818, 1943860188, 587997964, -183939623, 1736891818, 1943860188, 587997964, -183939623, 1736891818, 1943860188, 587997964, -183939623]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesdec_epi128(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesdec_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesdec_epi128_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesdec_epi128_boundary_mixed_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdec_epi128_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdec_epi128(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[729289640, 729289640, 729289640, 729289640, 729289640, 729289640, 729289640, 729289640, 729289640, 729289640, 729289640, 729289640, 729289640, 729289640, 729289640, 729289640]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesdec_epi128(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesdec_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesdec_epi128_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesdec_epi128_asym_min_max_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesdec_epi128_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesdec_epi128(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[972522459, 972522459, 972522459, 972522459, 972522459, 972522459, 972522459, 972522459, 972522459, 972522459, 972522459, 972522459, 972522459, 972522459, 972522459, 972522459]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesdec_epi128(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesdec_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesdec_epi128_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesdec_epi128_asym_max_min_impl() }
}
