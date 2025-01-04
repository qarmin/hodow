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
fn test_x86_avx512f_mm512_castsi128_si512_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_castsi128_si512(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 2, 3, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_castsi128_si512(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_castsi128_si512(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_castsi128_si512() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_castsi128_si512_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_castsi128_si512_normal2_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_castsi128_si512(create__m128i_from_i32_array([0, -1, 2, -3])));
        check_array_equality(&result, &[0, -1, 2, -3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_castsi128_si512(create__m128i_from_i32_array([0, -1, 2, -3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_castsi128_si512(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_castsi128_si512_normal2() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_castsi128_si512_normal2_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_castsi128_si512_normal3_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_castsi128_si512(create__m128i_from_i32_array([100, 200, 300, 400])));
        check_array_equality(&result, &[100, 200, 300, 400, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_castsi128_si512(create__m128i_from_i32_array([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_castsi128_si512(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_castsi128_si512_normal3() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_castsi128_si512_normal3_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_castsi128_si512_boundary_min_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_castsi128_si512(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_castsi128_si512(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_castsi128_si512(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_castsi128_si512_boundary_min() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_castsi128_si512_boundary_min_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_castsi128_si512_boundary_max_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_castsi128_si512(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_castsi128_si512(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_castsi128_si512(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_castsi128_si512_boundary_max() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_castsi128_si512_boundary_max_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_castsi128_si512_boundary_zero_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_castsi128_si512(create__m128i_from_i32_array([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_castsi128_si512(create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_castsi128_si512(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_castsi128_si512_boundary_zero() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_castsi128_si512_boundary_zero_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_castsi128_si512_boundary_allones_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_castsi128_si512(create__m128i_from_i32_array([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_castsi128_si512(create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_castsi128_si512(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_castsi128_si512_boundary_allones() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_castsi128_si512_boundary_allones_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_castsi128_si512_boundary_mixed_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_castsi128_si512(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-2147483648, 2147483647, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_castsi128_si512(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_castsi128_si512(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_castsi128_si512_boundary_mixed() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_castsi128_si512_boundary_mixed_impl() }
}
