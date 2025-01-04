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

#[target_feature(enable = "f16c")]
fn test_x86_f16c_mm_cvtph_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtph_ps(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[5.9604645e-8, 0.0, 1.1920929e-7, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvtph_ps(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtph_ps(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_f16c_mm_cvtph_ps() -> Result<Verdict, String> {
    unsafe { test_x86_f16c_mm_cvtph_ps_impl() }
}

#[target_feature(enable = "f16c")]
fn test_x86_f16c_mm256_cvtph_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m256_to_f32_array(_mm256_cvtph_ps(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[5.9604645e-8, 0.0, 1.1920929e-7, 0.0, 1.7881393e-7, 0.0, 2.3841858e-7, 0.0]).map_err(|e| crate::cpu::with_call(e, "_mm256_cvtph_ps(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm256_cvtph_ps(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_f16c_mm256_cvtph_ps() -> Result<Verdict, String> {
    unsafe { test_x86_f16c_mm256_cvtph_ps_impl() }
}
