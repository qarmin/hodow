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

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_extract_epi16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_epi16::<0>(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_extract_epi16::<0>(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_epi16::<0>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_extract_epi16() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_extract_epi16_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_extract_epi16_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_epi16::<0>(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_extract_epi16::<0>(create__m128i_from_i16_array([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_epi16::<0>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_extract_epi16_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_extract_epi16_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_extract_epi16_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_epi16::<0>(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "_mm_extract_epi16::<0>(create__m128i_from_i16_array([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_epi16::<0>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_extract_epi16_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_extract_epi16_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_extract_epi16_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_epi16::<0>(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]));
        check_int_equality(result, 32768).map_err(|e| crate::cpu::with_call(e, "_mm_extract_epi16::<0>(create__m128i_from_i16_array([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_epi16::<0>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_extract_epi16_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_extract_epi16_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_extract_epi16_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_epi16::<0>(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]));
        check_int_equality(result, 32767).map_err(|e| crate::cpu::with_call(e, "_mm_extract_epi16::<0>(create__m128i_from_i16_array([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_epi16::<0>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_extract_epi16_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_extract_epi16_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_extract_epi16_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_epi16::<0>(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_extract_epi16::<0>(create__m128i_from_i16_array([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_epi16::<0>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_extract_epi16_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_extract_epi16_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_extract_epi16_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_epi16::<0>(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, 65535).map_err(|e| crate::cpu::with_call(e, "_mm_extract_epi16::<0>(create__m128i_from_i16_array([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_epi16::<0>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_extract_epi16_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_extract_epi16_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_extract_epi16_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_epi16::<0>(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]));
        check_int_equality(result, 32768).map_err(|e| crate::cpu::with_call(e, "_mm_extract_epi16::<0>(create__m128i_from_i16_array([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_epi16::<0>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_extract_epi16_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_extract_epi16_boundary_mixed_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_extract_epi16_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_epi16::<1>(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_extract_epi16::<1>(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_epi16::<1>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_extract_epi16_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_extract_epi16_imm_1_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_extract_epi16_imm_7_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_epi16::<7>(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_extract_epi16::<7>(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_epi16::<7>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_extract_epi16_imm_7() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_extract_epi16_imm_7_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_extract_epi16_imm_3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_epi16::<3>(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_extract_epi16::<3>(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_epi16::<3>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_extract_epi16_imm_3() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_extract_epi16_imm_3_impl() }
}
