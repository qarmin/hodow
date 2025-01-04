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

#[target_feature(enable = "ssse3")]
fn test_x86_ssse3_mm_alignr_epi8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_alignr_epi8::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 0, 0, 0, 6, 0, 0, 0, 7, 0, 0, 0, 8, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_alignr_epi8::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_alignr_epi8::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_ssse3_mm_alignr_epi8() -> Result<Verdict, String> {
    unsafe { test_x86_ssse3_mm_alignr_epi8_impl() }
}

#[target_feature(enable = "ssse3")]
fn test_x86_ssse3_mm_alignr_epi8_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_alignr_epi8::<0>(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]).map_err(|e| crate::cpu::with_call(e, "_mm_alignr_epi8::<0>(create__m128i_from_i8_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create__m128i_from_i8_array([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_alignr_epi8::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_ssse3_mm_alignr_epi8_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_ssse3_mm_alignr_epi8_normal2_impl() }
}

#[target_feature(enable = "ssse3")]
fn test_x86_ssse3_mm_alignr_epi8_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_alignr_epi8::<0>(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), create__m128i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74])));
        check_array_equality(&result, &[110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74]).map_err(|e| crate::cpu::with_call(e, "_mm_alignr_epi8::<0>(create__m128i_from_i8_array([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), create__m128i_from_i8_array([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_alignr_epi8::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_ssse3_mm_alignr_epi8_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_ssse3_mm_alignr_epi8_normal3_impl() }
}

#[target_feature(enable = "ssse3")]
fn test_x86_ssse3_mm_alignr_epi8_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_alignr_epi8::<0>(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128]).map_err(|e| crate::cpu::with_call(e, "_mm_alignr_epi8::<0>(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_alignr_epi8::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_ssse3_mm_alignr_epi8_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_ssse3_mm_alignr_epi8_boundary_min_impl() }
}

#[target_feature(enable = "ssse3")]
fn test_x86_ssse3_mm_alignr_epi8_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_alignr_epi8::<0>(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127]).map_err(|e| crate::cpu::with_call(e, "_mm_alignr_epi8::<0>(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_alignr_epi8::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_ssse3_mm_alignr_epi8_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_ssse3_mm_alignr_epi8_boundary_max_impl() }
}

#[target_feature(enable = "ssse3")]
fn test_x86_ssse3_mm_alignr_epi8_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_alignr_epi8::<0>(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_alignr_epi8::<0>(create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create__m128i_from_i8_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_alignr_epi8::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_ssse3_mm_alignr_epi8_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_ssse3_mm_alignr_epi8_boundary_zero_impl() }
}

#[target_feature(enable = "ssse3")]
fn test_x86_ssse3_mm_alignr_epi8_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_alignr_epi8::<0>(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_alignr_epi8::<0>(create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create__m128i_from_i8_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_alignr_epi8::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_ssse3_mm_alignr_epi8_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_ssse3_mm_alignr_epi8_boundary_allones_impl() }
}

#[target_feature(enable = "ssse3")]
fn test_x86_ssse3_mm_alignr_epi8_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_alignr_epi8::<0>(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1]).map_err(|e| crate::cpu::with_call(e, "_mm_alignr_epi8::<0>(create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create__m128i_from_i8_array([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_alignr_epi8::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_ssse3_mm_alignr_epi8_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_ssse3_mm_alignr_epi8_boundary_mixed_impl() }
}

#[target_feature(enable = "ssse3")]
fn test_x86_ssse3_mm_alignr_epi8_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_alignr_epi8::<0>(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127]).map_err(|e| crate::cpu::with_call(e, "_mm_alignr_epi8::<0>(create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_alignr_epi8::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_ssse3_mm_alignr_epi8_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_ssse3_mm_alignr_epi8_asym_min_max_impl() }
}

#[target_feature(enable = "ssse3")]
fn test_x86_ssse3_mm_alignr_epi8_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_alignr_epi8::<0>(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128]).map_err(|e| crate::cpu::with_call(e, "_mm_alignr_epi8::<0>(create__m128i_from_i8_array([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create__m128i_from_i8_array([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_alignr_epi8::<0>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_ssse3_mm_alignr_epi8_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_ssse3_mm_alignr_epi8_asym_max_min_impl() }
}

#[target_feature(enable = "ssse3")]
fn test_x86_ssse3_mm_alignr_epi8_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_alignr_epi8::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[0, 0, 0, 6, 0, 0, 0, 7, 0, 0, 0, 8, 0, 0, 0, 1]).map_err(|e| crate::cpu::with_call(e, "_mm_alignr_epi8::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_alignr_epi8::<1>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_ssse3_mm_alignr_epi8_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_ssse3_mm_alignr_epi8_imm_1_impl() }
}

#[target_feature(enable = "ssse3")]
fn test_x86_ssse3_mm_alignr_epi8_imm_255_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_alignr_epi8::<255>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_alignr_epi8::<255>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_alignr_epi8::<255>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_ssse3_mm_alignr_epi8_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_ssse3_mm_alignr_epi8_imm_255_impl() }
}

#[target_feature(enable = "ssse3")]
fn test_x86_ssse3_mm_alignr_epi8_imm_7_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_alignr_epi8::<7>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[0, 7, 0, 0, 0, 8, 0, 0, 0, 1, 0, 0, 0, 2, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_alignr_epi8::<7>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_alignr_epi8::<7>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_ssse3_mm_alignr_epi8_imm_7() -> Result<Verdict, String> {
    unsafe { test_x86_ssse3_mm_alignr_epi8_imm_7_impl() }
}

#[target_feature(enable = "ssse3")]
fn test_x86_ssse3_mm_alignr_epi8_imm_8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i8_array(_mm_alignr_epi8::<8>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8])));
        check_array_equality(&result, &[7, 0, 0, 0, 8, 0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_alignr_epi8::<8>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_alignr_epi8::<8>(create_random__m128i(), create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_ssse3_mm_alignr_epi8_imm_8() -> Result<Verdict, String> {
    unsafe { test_x86_ssse3_mm_alignr_epi8_imm_8_impl() }
}
