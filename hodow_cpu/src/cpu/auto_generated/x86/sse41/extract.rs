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

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_extract_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 1065353216).map_err(|e| crate::cpu::with_call(e, "_mm_extract_ps::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_ps::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_extract_ps() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_extract_ps_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_extract_ps_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_ps::<0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_extract_ps::<0>(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_ps::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_extract_ps_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_extract_ps_normal2_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_extract_ps_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_ps::<0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]));
        check_int_equality(result, 1120403456).map_err(|e| crate::cpu::with_call(e, "_mm_extract_ps::<0>(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_ps::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_extract_ps_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_extract_ps_normal3_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_extract_ps_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result, -8388609).map_err(|e| crate::cpu::with_call(e, "_mm_extract_ps::<0>(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_ps::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_extract_ps_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_extract_ps_boundary_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_extract_ps_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result, 2139095039).map_err(|e| crate::cpu::with_call(e, "_mm_extract_ps::<0>(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_ps::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_extract_ps_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_extract_ps_boundary_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_extract_ps_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_ps::<0>(create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_extract_ps::<0>(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_ps::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_extract_ps_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_extract_ps_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_extract_ps_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_ps::<0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result, 2143289344).map_err(|e| crate::cpu::with_call(e, "_mm_extract_ps::<0>(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_ps::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_extract_ps_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_extract_ps_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_extract_ps_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_ps::<0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result, 2139095040).map_err(|e| crate::cpu::with_call(e, "_mm_extract_ps::<0>(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_ps::<0>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_extract_ps_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_extract_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_extract_ps_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_ps::<1>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 1073741824).map_err(|e| crate::cpu::with_call(e, "_mm_extract_ps::<1>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_ps::<1>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_extract_ps_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_extract_ps_imm_1_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_extract_ps_imm_3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_ps::<3>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result, 1082130432).map_err(|e| crate::cpu::with_call(e, "_mm_extract_ps::<3>(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_ps::<3>(create_random__m128());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_extract_ps_imm_3() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_extract_ps_imm_3_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_extract_epi8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_epi8::<0>(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_extract_epi8::<0>(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_epi8::<0>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_extract_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_extract_epi8_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_extract_epi8_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_epi8::<0>(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_extract_epi8::<0>(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_epi8::<0>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_extract_epi8_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_extract_epi8_normal2_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_extract_epi8_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_epi8::<0>(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "_mm_extract_epi8::<0>(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_epi8::<0>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_extract_epi8_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_extract_epi8_normal3_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_extract_epi8_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_epi8::<0>(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]));
        check_int_equality(result, 128).map_err(|e| crate::cpu::with_call(e, "_mm_extract_epi8::<0>(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_epi8::<0>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_extract_epi8_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_extract_epi8_boundary_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_extract_epi8_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_epi8::<0>(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]));
        check_int_equality(result, 127).map_err(|e| crate::cpu::with_call(e, "_mm_extract_epi8::<0>(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_epi8::<0>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_extract_epi8_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_extract_epi8_boundary_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_extract_epi8_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_epi8::<0>(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_extract_epi8::<0>(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_epi8::<0>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_extract_epi8_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_extract_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_extract_epi8_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_epi8::<0>(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, 255).map_err(|e| crate::cpu::with_call(e, "_mm_extract_epi8::<0>(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_epi8::<0>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_extract_epi8_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_extract_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_extract_epi8_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_epi8::<0>(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]));
        check_int_equality(result, 128).map_err(|e| crate::cpu::with_call(e, "_mm_extract_epi8::<0>(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_epi8::<0>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_extract_epi8_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_extract_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_extract_epi8_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_epi8::<1>(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_extract_epi8::<1>(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_epi8::<1>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_extract_epi8_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_extract_epi8_imm_1_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_extract_epi8_imm_15_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_epi8::<15>(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_extract_epi8::<15>(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_epi8::<15>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_extract_epi8_imm_15() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_extract_epi8_imm_15_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_extract_epi8_imm_7_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_epi8::<7>(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_extract_epi8::<7>(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_epi8::<7>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_extract_epi8_imm_7() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_extract_epi8_imm_7_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_extract_epi8_imm_8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_epi8::<8>(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result, 3).map_err(|e| crate::cpu::with_call(e, "_mm_extract_epi8::<8>(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_epi8::<8>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_extract_epi8_imm_8() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_extract_epi8_imm_8_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_extract_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_epi32::<0>(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_extract_epi32::<0>(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_epi32::<0>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_extract_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_extract_epi32_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_extract_epi32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_epi32::<0>(create__m128i_from_i32_array([0, -1, 2, -3]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_extract_epi32::<0>(create__m128i_from_i32_array([0, -1, 2, -3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_epi32::<0>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_extract_epi32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_extract_epi32_normal2_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_extract_epi32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_epi32::<0>(create__m128i_from_i32_array([100, 200, 300, 400]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "_mm_extract_epi32::<0>(create__m128i_from_i32_array([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_epi32::<0>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_extract_epi32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_extract_epi32_normal3_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_extract_epi32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_epi32::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, -2147483648).map_err(|e| crate::cpu::with_call(e, "_mm_extract_epi32::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_epi32::<0>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_extract_epi32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_extract_epi32_boundary_min_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_extract_epi32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_epi32::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, 2147483647).map_err(|e| crate::cpu::with_call(e, "_mm_extract_epi32::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_epi32::<0>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_extract_epi32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_extract_epi32_boundary_max_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_extract_epi32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_epi32::<0>(create__m128i_from_i32_array([0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_extract_epi32::<0>(create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_epi32::<0>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_extract_epi32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_extract_epi32_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_extract_epi32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_epi32::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "_mm_extract_epi32::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_epi32::<0>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_extract_epi32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_extract_epi32_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_extract_epi32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_epi32::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result, -2147483648).map_err(|e| crate::cpu::with_call(e, "_mm_extract_epi32::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_epi32::<0>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_extract_epi32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_extract_epi32_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_extract_epi32_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_epi32::<1>(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "_mm_extract_epi32::<1>(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_epi32::<1>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_extract_epi32_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_extract_epi32_imm_1_impl() }
}

#[target_feature(enable = "sse4.1")]
fn test_x86_sse41_mm_extract_epi32_imm_3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_extract_epi32::<3>(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result, 4).map_err(|e| crate::cpu::with_call(e, "_mm_extract_epi32::<3>(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_extract_epi32::<3>(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse41_mm_extract_epi32_imm_3() -> Result<Verdict, String> {
    unsafe { test_x86_sse41_mm_extract_epi32_imm_3_impl() }
}
