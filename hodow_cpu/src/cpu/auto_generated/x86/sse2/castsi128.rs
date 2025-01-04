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
fn test_x86_sse2_mm_castsi128_pd_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_castsi128_pd(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[4.2439915824e-314, 8.4879831653e-314]).map_err(|e| crate::cpu::with_call(e, "_mm_castsi128_pd(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_castsi128_pd(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_castsi128_pd() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_castsi128_pd_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_castsi128_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_castsi128_ps(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_float_array_equality(&result, &[1e-45, 3e-45, 4e-45, 6e-45]).map_err(|e| crate::cpu::with_call(e, "_mm_castsi128_ps(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_castsi128_ps(create_random__m128i());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_castsi128_ps() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_castsi128_ps_impl() }
}
