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

#[target_feature(enable = "pclmulqdq")]
fn test_x86_pclmulqdq_mm_clmulepi64_si128_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 12, 12, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_clmulepi64_si128::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_pclmulqdq_mm_clmulepi64_si128() -> Result<Verdict, String> {
    unsafe { test_x86_pclmulqdq_mm_clmulepi64_si128_impl() }
}

#[target_feature(enable = "pclmulqdq")]
fn test_x86_pclmulqdq_mm_clmulepi64_si128_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7])));
        check_array_equality(&result, &[0, 6, 1, 7]).map_err(|e| crate::cpu::with_call(e, "_mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), create__m128i_from_i32_array([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_clmulepi64_si128::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_pclmulqdq_mm_clmulepi64_si128_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_pclmulqdq_mm_clmulepi64_si128_normal2_impl() }
}

#[target_feature(enable = "pclmulqdq")]
fn test_x86_pclmulqdq_mm_clmulepi64_si128_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410])));
        check_array_equality(&result, &[6136, 632, 23312, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), create__m128i_from_i32_array([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_clmulepi64_si128::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_pclmulqdq_mm_clmulepi64_si128_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_pclmulqdq_mm_clmulepi64_si128_normal3_impl() }
}

#[target_feature(enable = "pclmulqdq")]
fn test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, 1073741824, 0, 1073741824]).map_err(|e| crate::cpu::with_call(e, "_mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_clmulepi64_si128::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_min_impl() }
}

#[target_feature(enable = "pclmulqdq")]
fn test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[1431655765, 357913941, 1431655765, 357913941]).map_err(|e| crate::cpu::with_call(e, "_mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_clmulepi64_si128::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_max_impl() }
}

#[target_feature(enable = "pclmulqdq")]
fn test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_clmulepi64_si128::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_zero_impl() }
}

#[target_feature(enable = "pclmulqdq")]
fn test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[1431655765, 1431655765, 1431655765, 1431655765]).map_err(|e| crate::cpu::with_call(e, "_mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_clmulepi64_si128::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_allones_impl() }
}

#[target_feature(enable = "pclmulqdq")]
fn test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 1073741824, 1431655765, 357913941]).map_err(|e| crate::cpu::with_call(e, "_mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_clmulepi64_si128::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_mixed_impl() }
}

#[target_feature(enable = "pclmulqdq")]
fn test_x86_pclmulqdq_mm_clmulepi64_si128_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-2147483648, 1073741823, -2147483648, 1073741823]).map_err(|e| crate::cpu::with_call(e, "_mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_clmulepi64_si128::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_pclmulqdq_mm_clmulepi64_si128_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_pclmulqdq_mm_clmulepi64_si128_asym_min_max_impl() }
}

#[target_feature(enable = "pclmulqdq")]
fn test_x86_pclmulqdq_mm_clmulepi64_si128_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, 1073741823, -2147483648, 1073741823]).map_err(|e| crate::cpu::with_call(e, "_mm_clmulepi64_si128::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_clmulepi64_si128::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_pclmulqdq_mm_clmulepi64_si128_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_pclmulqdq_mm_clmulepi64_si128_asym_max_min_impl() }
}

#[target_feature(enable = "pclmulqdq")]
fn test_x86_pclmulqdq_mm_clmulepi64_si128_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_clmulepi64_si128::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[15, 30, 24, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_clmulepi64_si128::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_clmulepi64_si128::<1>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_pclmulqdq_mm_clmulepi64_si128_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_pclmulqdq_mm_clmulepi64_si128_imm_1_impl() }
}

#[target_feature(enable = "pclmulqdq")]
fn test_x86_pclmulqdq_mm_clmulepi64_si128_imm_255_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_clmulepi64_si128::<255>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[9, 4, 32, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_clmulepi64_si128::<255>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_clmulepi64_si128::<255>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_pclmulqdq_mm_clmulepi64_si128_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_pclmulqdq_mm_clmulepi64_si128_imm_255_impl() }
}

#[target_feature(enable = "pclmulqdq")]
fn test_x86_pclmulqdq_mm_clmulepi64_si128_imm_31_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_clmulepi64_si128::<31>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[9, 4, 32, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_clmulepi64_si128::<31>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_clmulepi64_si128::<31>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_pclmulqdq_mm_clmulepi64_si128_imm_31() -> Result<Verdict, String> {
    unsafe { test_x86_pclmulqdq_mm_clmulepi64_si128_imm_31_impl() }
}

#[target_feature(enable = "pclmulqdq")]
fn test_x86_pclmulqdq_mm_clmulepi64_si128_imm_32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_clmulepi64_si128::<32>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 12, 12, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_clmulepi64_si128::<32>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_clmulepi64_si128::<32>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_pclmulqdq_mm_clmulepi64_si128_imm_32() -> Result<Verdict, String> {
    unsafe { test_x86_pclmulqdq_mm_clmulepi64_si128_imm_32_impl() }
}


use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct PCLMULQDQ;

impl ExtensionTest for PCLMULQDQ {
    fn get_name() -> &'static str {
        "x86::PCLMULQDQ"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_x86_pclmulqdq_mm_clmulepi64_si128, "test_x86_pclmulqdq_mm_clmulepi64_si128"),
            (test_x86_pclmulqdq_mm_clmulepi64_si128_normal2, "test_x86_pclmulqdq_mm_clmulepi64_si128_normal2"),
            (test_x86_pclmulqdq_mm_clmulepi64_si128_normal3, "test_x86_pclmulqdq_mm_clmulepi64_si128_normal3"),
            (test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_min, "test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_min"),
            (test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_max, "test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_max"),
            (test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_zero, "test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_zero"),
            (test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_allones, "test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_allones"),
            (test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_mixed, "test_x86_pclmulqdq_mm_clmulepi64_si128_boundary_mixed"),
            (test_x86_pclmulqdq_mm_clmulepi64_si128_asym_min_max, "test_x86_pclmulqdq_mm_clmulepi64_si128_asym_min_max"),
            (test_x86_pclmulqdq_mm_clmulepi64_si128_asym_max_min, "test_x86_pclmulqdq_mm_clmulepi64_si128_asym_max_min"),
            (test_x86_pclmulqdq_mm_clmulepi64_si128_imm_1, "test_x86_pclmulqdq_mm_clmulepi64_si128_imm_1"),
            (test_x86_pclmulqdq_mm_clmulepi64_si128_imm_255, "test_x86_pclmulqdq_mm_clmulepi64_si128_imm_255"),
            (test_x86_pclmulqdq_mm_clmulepi64_si128_imm_31, "test_x86_pclmulqdq_mm_clmulepi64_si128_imm_31"),
            (test_x86_pclmulqdq_mm_clmulepi64_si128_imm_32, "test_x86_pclmulqdq_mm_clmulepi64_si128_imm_32"),
        ]
    }
}
