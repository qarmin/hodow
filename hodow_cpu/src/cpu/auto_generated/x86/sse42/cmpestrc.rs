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

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrc_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cmpestrc::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_cmpestrc::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cmpestrc::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse42_mm_cmpestrc() -> Result<Verdict, String> {
    unsafe { test_x86_sse42_mm_cmpestrc_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrc_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cmpestrc::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), 1i32, create__m128i_from_i32_array([10, 9, 12, 7]), 2i32);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_cmpestrc::<0>(create__m128i_from_i32_array([0, -1, 2, -3]), 1i32, create__m128i_from_i32_array([10, 9, 12, 7]), 2i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cmpestrc::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse42_mm_cmpestrc_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_sse42_mm_cmpestrc_normal2_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrc_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cmpestrc::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), 1i32, create__m128i_from_i32_array([110, 210, 310, 410]), 2i32);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_cmpestrc::<0>(create__m128i_from_i32_array([100, 200, 300, 400]), 1i32, create__m128i_from_i32_array([110, 210, 310, 410]), 2i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cmpestrc::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse42_mm_cmpestrc_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_sse42_mm_cmpestrc_normal3_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrc_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cmpestrc::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 2i32);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_cmpestrc::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 2i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cmpestrc::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse42_mm_cmpestrc_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse42_mm_cmpestrc_boundary_min_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrc_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cmpestrc::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32, create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 2i32);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_cmpestrc::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32, create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 2i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cmpestrc::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse42_mm_cmpestrc_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse42_mm_cmpestrc_boundary_max_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrc_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cmpestrc::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), 1i32, create__m128i_from_i32_array([0, 0, 0, 0]), 2i32);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_cmpestrc::<0>(create__m128i_from_i32_array([0, 0, 0, 0]), 1i32, create__m128i_from_i32_array([0, 0, 0, 0]), 2i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cmpestrc::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse42_mm_cmpestrc_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_sse42_mm_cmpestrc_boundary_zero_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrc_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cmpestrc::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), 1i32, create__m128i_from_i32_array([-1, -1, -1, -1]), 2i32);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_cmpestrc::<0>(create__m128i_from_i32_array([-1, -1, -1, -1]), 1i32, create__m128i_from_i32_array([-1, -1, -1, -1]), 2i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cmpestrc::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse42_mm_cmpestrc_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_sse42_mm_cmpestrc_boundary_allones_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrc_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cmpestrc::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), 2i32);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_cmpestrc::<0>(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]), 2i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cmpestrc::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse42_mm_cmpestrc_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_sse42_mm_cmpestrc_boundary_mixed_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrc_asym_min_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cmpestrc::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32, create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 2i32);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_cmpestrc::<0>(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32, create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 2i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cmpestrc::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse42_mm_cmpestrc_asym_min_max() -> Result<Verdict, String> {
    unsafe { test_x86_sse42_mm_cmpestrc_asym_min_max_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrc_asym_max_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cmpestrc::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 2i32);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_cmpestrc::<0>(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32, create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 2i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cmpestrc::<0>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse42_mm_cmpestrc_asym_max_min() -> Result<Verdict, String> {
    unsafe { test_x86_sse42_mm_cmpestrc_asym_max_min_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrc_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cmpestrc::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_cmpestrc::<1>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cmpestrc::<1>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse42_mm_cmpestrc_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_sse42_mm_cmpestrc_imm_1_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrc_imm_255_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cmpestrc::<255>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_cmpestrc::<255>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cmpestrc::<255>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse42_mm_cmpestrc_imm_255() -> Result<Verdict, String> {
    unsafe { test_x86_sse42_mm_cmpestrc_imm_255_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrc_imm_31_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cmpestrc::<31>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_cmpestrc::<31>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cmpestrc::<31>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse42_mm_cmpestrc_imm_31() -> Result<Verdict, String> {
    unsafe { test_x86_sse42_mm_cmpestrc_imm_31_impl() }
}

#[target_feature(enable = "sse4.2")]
fn test_x86_sse42_mm_cmpestrc_imm_32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_cmpestrc::<32>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm_cmpestrc::<32>(create__m128i_from_i32_array([1, 2, 3, 4]), 5i32, create__m128i_from_i32_array([6, 7, 8, 9]), 10i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cmpestrc::<32>(create_random__m128i(), rand::random::<i32>(), create_random__m128i(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse42_mm_cmpestrc_imm_32() -> Result<Verdict, String> {
    unsafe { test_x86_sse42_mm_cmpestrc_imm_32_impl() }
}
