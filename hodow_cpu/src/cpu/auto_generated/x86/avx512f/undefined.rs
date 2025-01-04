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
fn test_x86_avx512f_mm512_undefined_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_undefined_pd());
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_undefined_pd()"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_undefined_pd();
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_undefined_pd() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_undefined_pd_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_undefined_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_undefined_ps());
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_undefined_ps()"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_undefined_ps();
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_undefined_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_undefined_ps_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_undefined_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_undefined_epi32());
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm512_undefined_epi32()"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_undefined_epi32();
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_undefined_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_undefined_epi32_impl() }
}

#[target_feature(enable = "avx512f")]
fn test_x86_avx512f_mm512_undefined_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_undefined());
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm512_undefined()"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_undefined();
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_undefined() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_undefined_impl() }
}
