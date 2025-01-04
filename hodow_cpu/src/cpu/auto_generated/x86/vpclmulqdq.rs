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

#[target_feature(enable = "vpclmulqdq")]
fn test_x86_vpclmulqdq_mm512_clmulepi64_epi128_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_clmulepi64_epi128::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[17, 48, 36, 0, 65, 48, 116, 0, 209, 48, 228, 0, 129, 48, 180, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_clmulepi64_epi128::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_clmulepi64_epi128::<0>(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vpclmulqdq_mm512_clmulepi64_epi128() -> Result<Verdict, String> {
    unsafe { test_x86_vpclmulqdq_mm512_clmulepi64_epi128_impl() }
}

#[target_feature(enable = "vpclmulqdq")]
fn test_x86_vpclmulqdq_mm512_clmulepi64_epi128_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_clmulepi64_epi128::<0>(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 6, 1, 7, 56, -42, 18, 3, 0, 6, 1, 7, 56, -42, 18, 3]).map_err(|e| crate::cpu::with_call(e, "_mm512_clmulepi64_epi128::<0>(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m512i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_clmulepi64_epi128::<0>(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vpclmulqdq_mm512_clmulepi64_epi128_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_vpclmulqdq_mm512_clmulepi64_epi128_normal2_impl() }
}

#[target_feature(enable = "vpclmulqdq")]
fn test_x86_vpclmulqdq_mm512_clmulepi64_epi128_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_clmulepi64_epi128::<0>(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610])));
        check_array_equality(&result, &[6136, 632, 23312, 0, 88408, 15352, 289200, 0, 351032, 15352, 356944, 0, 1123224, 212856, 1191664, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_clmulepi64_epi128::<0>(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]), create__m512i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810, 910, 1010, 1110, 1210, 1310, 1410, 1510, 1610]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_clmulepi64_epi128::<0>(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vpclmulqdq_mm512_clmulepi64_epi128_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_vpclmulqdq_mm512_clmulepi64_epi128_normal3_impl() }
}

#[target_feature(enable = "vpclmulqdq")]
fn test_x86_vpclmulqdq_mm512_clmulepi64_epi128_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_clmulepi64_epi128::<0>(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, 1073741824, 0, 1073741824, 0, 1073741824, 0, 1073741824, 0, 1073741824, 0, 1073741824, 0, 1073741824, 0, 1073741824]).map_err(|e| crate::cpu::with_call(e, "_mm512_clmulepi64_epi128::<0>(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_clmulepi64_epi128::<0>(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vpclmulqdq_mm512_clmulepi64_epi128_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_vpclmulqdq_mm512_clmulepi64_epi128_boundary_min_impl() }
}

#[target_feature(enable = "vpclmulqdq")]
fn test_x86_vpclmulqdq_mm512_clmulepi64_epi128_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_clmulepi64_epi128::<0>(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[1431655765, 357913941, 1431655765, 357913941, 1431655765, 357913941, 1431655765, 357913941, 1431655765, 357913941, 1431655765, 357913941, 1431655765, 357913941, 1431655765, 357913941]).map_err(|e| crate::cpu::with_call(e, "_mm512_clmulepi64_epi128::<0>(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_clmulepi64_epi128::<0>(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vpclmulqdq_mm512_clmulepi64_epi128_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_vpclmulqdq_mm512_clmulepi64_epi128_boundary_max_impl() }
}

#[target_feature(enable = "vpclmulqdq")]
fn test_x86_vpclmulqdq_mm512_clmulepi64_epi128_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_clmulepi64_epi128::<0>(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_clmulepi64_epi128::<0>(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_clmulepi64_epi128::<0>(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vpclmulqdq_mm512_clmulepi64_epi128_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_vpclmulqdq_mm512_clmulepi64_epi128_boundary_zero_impl() }
}

#[target_feature(enable = "vpclmulqdq")]
fn test_x86_vpclmulqdq_mm512_clmulepi64_epi128_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_clmulepi64_epi128::<0>(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[1431655765, 1431655765, 1431655765, 1431655765, 1431655765, 1431655765, 1431655765, 1431655765, 1431655765, 1431655765, 1431655765, 1431655765, 1431655765, 1431655765, 1431655765, 1431655765]).map_err(|e| crate::cpu::with_call(e, "_mm512_clmulepi64_epi128::<0>(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_clmulepi64_epi128::<0>(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vpclmulqdq_mm512_clmulepi64_epi128_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_vpclmulqdq_mm512_clmulepi64_epi128_boundary_allones_impl() }
}

#[target_feature(enable = "vpclmulqdq")]
fn test_x86_vpclmulqdq_mm512_clmulepi64_epi128_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_clmulepi64_epi128::<0>(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 1073741824, 1431655765, 357913941, 0, 1073741824, 1431655765, 357913941, 0, 1073741824, 1431655765, 357913941, 0, 1073741824, 1431655765, 357913941]).map_err(|e| crate::cpu::with_call(e, "_mm512_clmulepi64_epi128::<0>(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_clmulepi64_epi128::<0>(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vpclmulqdq_mm512_clmulepi64_epi128_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_vpclmulqdq_mm512_clmulepi64_epi128_boundary_mixed_impl() }
}

#[target_feature(enable = "vpclmulqdq")]
fn test_x86_vpclmulqdq_mm512_clmulepi64_epi128_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_clmulepi64_epi128::<0>(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-2147483648, 1073741823, -2147483648, 1073741823, -2147483648, 1073741823, -2147483648, 1073741823, -2147483648, 1073741823, -2147483648, 1073741823, -2147483648, 1073741823, -2147483648, 1073741823]).map_err(|e| crate::cpu::with_call(e, "_mm512_clmulepi64_epi128::<0>(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_clmulepi64_epi128::<0>(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vpclmulqdq_mm512_clmulepi64_epi128_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_vpclmulqdq_mm512_clmulepi64_epi128_asym_min_max_impl() }
}

#[target_feature(enable = "vpclmulqdq")]
fn test_x86_vpclmulqdq_mm512_clmulepi64_epi128_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_clmulepi64_epi128::<0>(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, 1073741823, -2147483648, 1073741823, -2147483648, 1073741823, -2147483648, 1073741823, -2147483648, 1073741823, -2147483648, 1073741823, -2147483648, 1073741823, -2147483648, 1073741823]).map_err(|e| crate::cpu::with_call(e, "_mm512_clmulepi64_epi128::<0>(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_clmulepi64_epi128::<0>(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vpclmulqdq_mm512_clmulepi64_epi128_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_vpclmulqdq_mm512_clmulepi64_epi128_asym_max_min_impl() }
}

#[target_feature(enable = "vpclmulqdq")]
fn test_x86_vpclmulqdq_mm512_clmulepi64_epi128_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_clmulepi64_epi128::<1>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[51, 114, 72, 0, 107, 202, 176, 0, 227, 82, 184, 0, 187, 378, 480, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_clmulepi64_epi128::<1>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_clmulepi64_epi128::<1>(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vpclmulqdq_mm512_clmulepi64_epi128_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_vpclmulqdq_mm512_clmulepi64_epi128_imm_1_impl() }
}

#[target_feature(enable = "vpclmulqdq")]
fn test_x86_vpclmulqdq_mm512_clmulepi64_epi128_imm_255_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_clmulepi64_epi128::<255>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[53, 112, 80, 0, 101, 240, 192, 0, 245, 112, 144, 0, 165, 16, 512, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_clmulepi64_epi128::<255>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_clmulepi64_epi128::<255>(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vpclmulqdq_mm512_clmulepi64_epi128_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_vpclmulqdq_mm512_clmulepi64_epi128_imm_255_impl() }
}

#[target_feature(enable = "vpclmulqdq")]
fn test_x86_vpclmulqdq_mm512_clmulepi64_epi128_imm_31_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_clmulepi64_epi128::<31>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[53, 112, 80, 0, 101, 240, 192, 0, 245, 112, 144, 0, 165, 16, 512, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_clmulepi64_epi128::<31>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_clmulepi64_epi128::<31>(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vpclmulqdq_mm512_clmulepi64_epi128_imm_31() -> Result<Verdict, String> {
    unsafe { test_x86_vpclmulqdq_mm512_clmulepi64_epi128_imm_31_impl() }
}

#[target_feature(enable = "vpclmulqdq")]
fn test_x86_vpclmulqdq_mm512_clmulepi64_epi128_imm_32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_clmulepi64_epi128::<32>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[17, 48, 36, 0, 65, 48, 116, 0, 209, 48, 228, 0, 129, 48, 180, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_clmulepi64_epi128::<32>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_clmulepi64_epi128::<32>(create_random__m512i(), create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vpclmulqdq_mm512_clmulepi64_epi128_imm_32() -> Result<Verdict, String> {
    unsafe { test_x86_vpclmulqdq_mm512_clmulepi64_epi128_imm_32_impl() }
}

#[target_feature(enable = "vpclmulqdq")]
fn test_x86_vpclmulqdq_mm256_clmulepi64_epi128_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_clmulepi64_epi128::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 24, 20, 0, 57, 24, 36, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_clmulepi64_epi128::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_clmulepi64_epi128::<0>(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vpclmulqdq_mm256_clmulepi64_epi128() -> Result<Verdict, String> {
    unsafe { test_x86_vpclmulqdq_mm256_clmulepi64_epi128_impl() }
}

#[target_feature(enable = "vpclmulqdq")]
fn test_x86_vpclmulqdq_mm256_clmulepi64_epi128_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_clmulepi64_epi128::<0>(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, 6, 1, 7, 56, -42, 18, 3]).map_err(|e| crate::cpu::with_call(e, "_mm256_clmulepi64_epi128::<0>(create__m256i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7]), create__m256i_from_i32_array([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_clmulepi64_epi128::<0>(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vpclmulqdq_mm256_clmulepi64_epi128_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_vpclmulqdq_mm256_clmulepi64_epi128_normal2_impl() }
}

#[target_feature(enable = "vpclmulqdq")]
fn test_x86_vpclmulqdq_mm256_clmulepi64_epi128_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_clmulepi64_epi128::<0>(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[6136, 632, 23312, 0, 88408, 15352, 289200, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_clmulepi64_epi128::<0>(create__m256i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800]), create__m256i_from_i32_array([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_clmulepi64_epi128::<0>(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vpclmulqdq_mm256_clmulepi64_epi128_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_vpclmulqdq_mm256_clmulepi64_epi128_normal3_impl() }
}

#[target_feature(enable = "vpclmulqdq")]
fn test_x86_vpclmulqdq_mm256_clmulepi64_epi128_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_clmulepi64_epi128::<0>(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, 1073741824, 0, 1073741824, 0, 1073741824, 0, 1073741824]).map_err(|e| crate::cpu::with_call(e, "_mm256_clmulepi64_epi128::<0>(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_clmulepi64_epi128::<0>(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vpclmulqdq_mm256_clmulepi64_epi128_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_vpclmulqdq_mm256_clmulepi64_epi128_boundary_min_impl() }
}

#[target_feature(enable = "vpclmulqdq")]
fn test_x86_vpclmulqdq_mm256_clmulepi64_epi128_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_clmulepi64_epi128::<0>(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[1431655765, 357913941, 1431655765, 357913941, 1431655765, 357913941, 1431655765, 357913941]).map_err(|e| crate::cpu::with_call(e, "_mm256_clmulepi64_epi128::<0>(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_clmulepi64_epi128::<0>(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vpclmulqdq_mm256_clmulepi64_epi128_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_vpclmulqdq_mm256_clmulepi64_epi128_boundary_max_impl() }
}

#[target_feature(enable = "vpclmulqdq")]
fn test_x86_vpclmulqdq_mm256_clmulepi64_epi128_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_clmulepi64_epi128::<0>(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_clmulepi64_epi128::<0>(create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]), create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_clmulepi64_epi128::<0>(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vpclmulqdq_mm256_clmulepi64_epi128_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_vpclmulqdq_mm256_clmulepi64_epi128_boundary_zero_impl() }
}

#[target_feature(enable = "vpclmulqdq")]
fn test_x86_vpclmulqdq_mm256_clmulepi64_epi128_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_clmulepi64_epi128::<0>(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[1431655765, 1431655765, 1431655765, 1431655765, 1431655765, 1431655765, 1431655765, 1431655765]).map_err(|e| crate::cpu::with_call(e, "_mm256_clmulepi64_epi128::<0>(create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]), create__m256i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_clmulepi64_epi128::<0>(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vpclmulqdq_mm256_clmulepi64_epi128_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_vpclmulqdq_mm256_clmulepi64_epi128_boundary_allones_impl() }
}

#[target_feature(enable = "vpclmulqdq")]
fn test_x86_vpclmulqdq_mm256_clmulepi64_epi128_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_clmulepi64_epi128::<0>(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 1073741824, 1431655765, 357913941, 0, 1073741824, 1431655765, 357913941]).map_err(|e| crate::cpu::with_call(e, "_mm256_clmulepi64_epi128::<0>(create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]), create__m256i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_clmulepi64_epi128::<0>(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vpclmulqdq_mm256_clmulepi64_epi128_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_vpclmulqdq_mm256_clmulepi64_epi128_boundary_mixed_impl() }
}

#[target_feature(enable = "vpclmulqdq")]
fn test_x86_vpclmulqdq_mm256_clmulepi64_epi128_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_clmulepi64_epi128::<0>(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-2147483648, 1073741823, -2147483648, 1073741823, -2147483648, 1073741823, -2147483648, 1073741823]).map_err(|e| crate::cpu::with_call(e, "_mm256_clmulepi64_epi128::<0>(create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_clmulepi64_epi128::<0>(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vpclmulqdq_mm256_clmulepi64_epi128_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_vpclmulqdq_mm256_clmulepi64_epi128_asym_min_max_impl() }
}

#[target_feature(enable = "vpclmulqdq")]
fn test_x86_vpclmulqdq_mm256_clmulepi64_epi128_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_clmulepi64_epi128::<0>(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, 1073741823, -2147483648, 1073741823, -2147483648, 1073741823, -2147483648, 1073741823]).map_err(|e| crate::cpu::with_call(e, "_mm256_clmulepi64_epi128::<0>(create__m256i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m256i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_clmulepi64_epi128::<0>(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vpclmulqdq_mm256_clmulepi64_epi128_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_vpclmulqdq_mm256_clmulepi64_epi128_asym_max_min_impl() }
}

#[target_feature(enable = "vpclmulqdq")]
fn test_x86_vpclmulqdq_mm256_clmulepi64_epi128_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_clmulepi64_epi128::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[27, 58, 40, 0, 35, 66, 112, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_clmulepi64_epi128::<1>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_clmulepi64_epi128::<1>(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vpclmulqdq_mm256_clmulepi64_epi128_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_vpclmulqdq_mm256_clmulepi64_epi128_imm_1_impl() }
}

#[target_feature(enable = "vpclmulqdq")]
fn test_x86_vpclmulqdq_mm256_clmulepi64_epi128_imm_255_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_clmulepi64_epi128::<255>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[29, 56, 48, 0, 45, 8, 128, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_clmulepi64_epi128::<255>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_clmulepi64_epi128::<255>(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vpclmulqdq_mm256_clmulepi64_epi128_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_vpclmulqdq_mm256_clmulepi64_epi128_imm_255_impl() }
}

#[target_feature(enable = "vpclmulqdq")]
fn test_x86_vpclmulqdq_mm256_clmulepi64_epi128_imm_31_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_clmulepi64_epi128::<31>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[29, 56, 48, 0, 45, 8, 128, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_clmulepi64_epi128::<31>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_clmulepi64_epi128::<31>(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vpclmulqdq_mm256_clmulepi64_epi128_imm_31() -> Result<Verdict, String> {
    unsafe { test_x86_vpclmulqdq_mm256_clmulepi64_epi128_imm_31_impl() }
}

#[target_feature(enable = "vpclmulqdq")]
fn test_x86_vpclmulqdq_mm256_clmulepi64_epi128_imm_32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_clmulepi64_epi128::<32>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 24, 20, 0, 57, 24, 36, 0]).map_err(|e| crate::cpu::with_call(e, "_mm256_clmulepi64_epi128::<32>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_clmulepi64_epi128::<32>(create_random__m256i(), create_random__m256i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_vpclmulqdq_mm256_clmulepi64_epi128_imm_32() -> Result<Verdict, String> {
    unsafe { test_x86_vpclmulqdq_mm256_clmulepi64_epi128_imm_32_impl() }
}


use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct VPCLMULQDQ;

impl ExtensionTest for VPCLMULQDQ {
    fn get_name() -> &'static str {
        "x86::VPCLMULQDQ"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_x86_vpclmulqdq_mm512_clmulepi64_epi128, "test_x86_vpclmulqdq_mm512_clmulepi64_epi128"),
            (test_x86_vpclmulqdq_mm512_clmulepi64_epi128_normal2, "test_x86_vpclmulqdq_mm512_clmulepi64_epi128_normal2"),
            (test_x86_vpclmulqdq_mm512_clmulepi64_epi128_normal3, "test_x86_vpclmulqdq_mm512_clmulepi64_epi128_normal3"),
            (test_x86_vpclmulqdq_mm512_clmulepi64_epi128_boundary_min, "test_x86_vpclmulqdq_mm512_clmulepi64_epi128_boundary_min"),
            (test_x86_vpclmulqdq_mm512_clmulepi64_epi128_boundary_max, "test_x86_vpclmulqdq_mm512_clmulepi64_epi128_boundary_max"),
            (test_x86_vpclmulqdq_mm512_clmulepi64_epi128_boundary_zero, "test_x86_vpclmulqdq_mm512_clmulepi64_epi128_boundary_zero"),
            (test_x86_vpclmulqdq_mm512_clmulepi64_epi128_boundary_allones, "test_x86_vpclmulqdq_mm512_clmulepi64_epi128_boundary_allones"),
            (test_x86_vpclmulqdq_mm512_clmulepi64_epi128_boundary_mixed, "test_x86_vpclmulqdq_mm512_clmulepi64_epi128_boundary_mixed"),
            (test_x86_vpclmulqdq_mm512_clmulepi64_epi128_asym_min_max, "test_x86_vpclmulqdq_mm512_clmulepi64_epi128_asym_min_max"),
            (test_x86_vpclmulqdq_mm512_clmulepi64_epi128_asym_max_min, "test_x86_vpclmulqdq_mm512_clmulepi64_epi128_asym_max_min"),
            (test_x86_vpclmulqdq_mm512_clmulepi64_epi128_imm_1, "test_x86_vpclmulqdq_mm512_clmulepi64_epi128_imm_1"),
            (test_x86_vpclmulqdq_mm512_clmulepi64_epi128_imm_255, "test_x86_vpclmulqdq_mm512_clmulepi64_epi128_imm_255"),
            (test_x86_vpclmulqdq_mm512_clmulepi64_epi128_imm_31, "test_x86_vpclmulqdq_mm512_clmulepi64_epi128_imm_31"),
            (test_x86_vpclmulqdq_mm512_clmulepi64_epi128_imm_32, "test_x86_vpclmulqdq_mm512_clmulepi64_epi128_imm_32"),
            (test_x86_vpclmulqdq_mm256_clmulepi64_epi128, "test_x86_vpclmulqdq_mm256_clmulepi64_epi128"),
            (test_x86_vpclmulqdq_mm256_clmulepi64_epi128_normal2, "test_x86_vpclmulqdq_mm256_clmulepi64_epi128_normal2"),
            (test_x86_vpclmulqdq_mm256_clmulepi64_epi128_normal3, "test_x86_vpclmulqdq_mm256_clmulepi64_epi128_normal3"),
            (test_x86_vpclmulqdq_mm256_clmulepi64_epi128_boundary_min, "test_x86_vpclmulqdq_mm256_clmulepi64_epi128_boundary_min"),
            (test_x86_vpclmulqdq_mm256_clmulepi64_epi128_boundary_max, "test_x86_vpclmulqdq_mm256_clmulepi64_epi128_boundary_max"),
            (test_x86_vpclmulqdq_mm256_clmulepi64_epi128_boundary_zero, "test_x86_vpclmulqdq_mm256_clmulepi64_epi128_boundary_zero"),
            (test_x86_vpclmulqdq_mm256_clmulepi64_epi128_boundary_allones, "test_x86_vpclmulqdq_mm256_clmulepi64_epi128_boundary_allones"),
            (test_x86_vpclmulqdq_mm256_clmulepi64_epi128_boundary_mixed, "test_x86_vpclmulqdq_mm256_clmulepi64_epi128_boundary_mixed"),
            (test_x86_vpclmulqdq_mm256_clmulepi64_epi128_asym_min_max, "test_x86_vpclmulqdq_mm256_clmulepi64_epi128_asym_min_max"),
            (test_x86_vpclmulqdq_mm256_clmulepi64_epi128_asym_max_min, "test_x86_vpclmulqdq_mm256_clmulepi64_epi128_asym_max_min"),
            (test_x86_vpclmulqdq_mm256_clmulepi64_epi128_imm_1, "test_x86_vpclmulqdq_mm256_clmulepi64_epi128_imm_1"),
            (test_x86_vpclmulqdq_mm256_clmulepi64_epi128_imm_255, "test_x86_vpclmulqdq_mm256_clmulepi64_epi128_imm_255"),
            (test_x86_vpclmulqdq_mm256_clmulepi64_epi128_imm_31, "test_x86_vpclmulqdq_mm256_clmulepi64_epi128_imm_31"),
            (test_x86_vpclmulqdq_mm256_clmulepi64_epi128_imm_32, "test_x86_vpclmulqdq_mm256_clmulepi64_epi128_imm_32"),
        ]
    }
}
