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
fn test_x86_vaes_mm256_aesenc_epi128_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenc_epi128(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1115454548, 1601664833, 1266383704, -873270698, 2070637438, 2003791733, -1832532677, -1775226667]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesenc_epi128(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesenc_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesenc_epi128() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesenc_epi128_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenc_epi128_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenc_epi128(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[-58065789, -1979938315, -1063393107, 1337903999, 1410887102, -1562013493, -393875327, 57870074]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesenc_epi128(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesenc_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesenc_epi128_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesenc_epi128_normal2_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenc_epi128_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenc_epi128(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[54739789, -84420963, 1248742992, 1717592575, 145462786, 1820213295, 1904039809, 464030427]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesenc_epi128(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesenc_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesenc_epi128_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesenc_epi128_normal3_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenc_epi128_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenc_epi128(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-1534407219, -1534407219, -1534407219, -1534407219, -1534407219, -1534407219, -1534407219, -1534407219]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesenc_epi128(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesenc_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesenc_epi128_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesenc_epi128_boundary_min_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenc_epi128_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenc_epi128(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-88199891, -88199891, -88199891, -88199891, -88199891, -88199891, -88199891, -88199891]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesenc_epi128(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesenc_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesenc_epi128_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesenc_epi128_boundary_max_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenc_epi128_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenc_epi128(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesenc_epi128(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesenc_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesenc_epi128_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesenc_epi128_boundary_zero_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenc_epi128_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenc_epi128(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesenc_epi128(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesenc_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesenc_epi128_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesenc_epi128_boundary_allones_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenc_epi128_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenc_epi128(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[2089417865, -1310009171, 1876834381, 1979938307, 2089417865, -1310009171, 1876834381, 1979938307]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesenc_epi128(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesenc_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesenc_epi128_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesenc_epi128_boundary_mixed_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenc_epi128_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenc_epi128(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[1534407218, 1534407218, 1534407218, 1534407218, 1534407218, 1534407218, 1534407218, 1534407218]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesenc_epi128(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesenc_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesenc_epi128_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesenc_epi128_asym_min_max_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm256_aesenc_epi128_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_aesenc_epi128(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[88199890, 88199890, 88199890, 88199890, 88199890, 88199890, 88199890, 88199890]).map_err(|e| crate::cpu::with_call(e, "_mm256_aesenc_epi128(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_aesenc_epi128(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm256_aesenc_epi128_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm256_aesenc_epi128_asym_max_min_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenc_epi128_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenc_epi128(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[1115454540, 1601664857, 1266383680, -873270706, 2070637414, 2003791725, -1832532701, -1775226659, -989789762, 1869047665, -1154798616, -536936866, -1529358579, 548121590, 1551267414, -2083862006]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesenc_epi128(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesenc_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesenc_epi128() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesenc_epi128_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenc_epi128_normal2_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenc_epi128(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[-58065789, -1979938315, -1063393107, 1337903999, 1410887102, -1562013493, -393875327, 57870074, -58065789, -1979938315, -1063393107, 1337903999, 1410887102, -1562013493, -393875327, 57870074]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesenc_epi128(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesenc_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesenc_epi128_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesenc_epi128_normal2_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenc_epi128_normal3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenc_epi128(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[54739789, -84420963, 1248742992, 1717592575, 145462786, 1820213295, 1904039809, 464030427, 1061645501, -519396910, 750261257, -318778398, -604836020, 297052508, 1535810368, -721346587]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesenc_epi128(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesenc_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesenc_epi128_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesenc_epi128_normal3_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenc_epi128_boundary_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenc_epi128(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-1534407219, -1534407219, -1534407219, -1534407219, -1534407219, -1534407219, -1534407219, -1534407219, -1534407219, -1534407219, -1534407219, -1534407219, -1534407219, -1534407219, -1534407219, -1534407219]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesenc_epi128(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesenc_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesenc_epi128_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesenc_epi128_boundary_min_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenc_epi128_boundary_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenc_epi128(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-88199891, -88199891, -88199891, -88199891, -88199891, -88199891, -88199891, -88199891, -88199891, -88199891, -88199891, -88199891, -88199891, -88199891, -88199891, -88199891]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesenc_epi128(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesenc_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesenc_epi128_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesenc_epi128_boundary_max_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenc_epi128_boundary_zero_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenc_epi128(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891, 1667457891]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesenc_epi128(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesenc_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesenc_epi128_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesenc_epi128_boundary_zero_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenc_epi128_boundary_allones_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenc_epi128(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199, -370546199]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesenc_epi128(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesenc_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesenc_epi128_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesenc_epi128_boundary_allones_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenc_epi128_boundary_mixed_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenc_epi128(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[2089417865, -1310009171, 1876834381, 1979938307, 2089417865, -1310009171, 1876834381, 1979938307, 2089417865, -1310009171, 1876834381, 1979938307, 2089417865, -1310009171, 1876834381, 1979938307]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesenc_epi128(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesenc_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesenc_epi128_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesenc_epi128_boundary_mixed_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenc_epi128_asym_min_max_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenc_epi128(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[1534407218, 1534407218, 1534407218, 1534407218, 1534407218, 1534407218, 1534407218, 1534407218, 1534407218, 1534407218, 1534407218, 1534407218, 1534407218, 1534407218, 1534407218, 1534407218]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesenc_epi128(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesenc_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesenc_epi128_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesenc_epi128_asym_min_max_impl() }
}

#[target_feature(enable = "vaes")]
fn test_x86_vaes_mm512_aesenc_epi128_asym_max_min_impl() -> Result<Verdict, String> {
        if !(std::arch::is_x86_feature_detected!("avx512f")) {
            return Ok(Verdict::Skipped("avx512f not present"));
        }
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_aesenc_epi128(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[88199890, 88199890, 88199890, 88199890, 88199890, 88199890, 88199890, 88199890, 88199890, 88199890, 88199890, 88199890, 88199890, 88199890, 88199890, 88199890]).map_err(|e| crate::cpu::with_call(e, "_mm512_aesenc_epi128(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_aesenc_epi128(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vaes_mm512_aesenc_epi128_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_vaes_mm512_aesenc_epi128_asym_max_min_impl() }
}
