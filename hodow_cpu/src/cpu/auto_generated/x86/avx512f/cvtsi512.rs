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

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtsi512_si32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_cvtsi512_si32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtsi512_si32(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtsi512_si32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_cvtsi512_si32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_cvtsi512_si32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtsi512_si32_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_cvtsi512_si32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtsi512_si32(create__m512i_from_i32_array([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtsi512_si32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_cvtsi512_si32_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_cvtsi512_si32_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtsi512_si32_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_cvtsi512_si32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtsi512_si32(create__m512i_from_i32_array([100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtsi512_si32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_cvtsi512_si32_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_cvtsi512_si32_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtsi512_si32_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_cvtsi512_si32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, -2147483648).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtsi512_si32(create__m512i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtsi512_si32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_cvtsi512_si32_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_cvtsi512_si32_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtsi512_si32_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_cvtsi512_si32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, 2147483647).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtsi512_si32(create__m512i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtsi512_si32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_cvtsi512_si32_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_cvtsi512_si32_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtsi512_si32_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_cvtsi512_si32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtsi512_si32(create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtsi512_si32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_cvtsi512_si32_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_cvtsi512_si32_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtsi512_si32_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_cvtsi512_si32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtsi512_si32(create__m512i_from_i32_array([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtsi512_si32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_cvtsi512_si32_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_cvtsi512_si32_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_cvtsi512_si32_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_cvtsi512_si32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result, -2147483648).map_err(|e| crate::cpu::with_call(e, "_mm512_cvtsi512_si32(create__m512i_from_i32_array([i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1, i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_cvtsi512_si32(create_random__m512i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_cvtsi512_si32_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_cvtsi512_si32_boundary_mixed_impl() }
}
