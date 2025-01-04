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
fn test_x86_sse2_mm_cvttpd_epi32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvttpd_epi32(create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 2, 0, 0]).map_err(|e| crate::cpu::with_call(e, "_mm_cvttpd_epi32(create__m128d_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvttpd_epi32(create_random__m128d());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_sse2_mm_cvttpd_epi32() -> Result<Verdict, String> {
    unsafe { test_x86_sse2_mm_cvttpd_epi32_impl() }
}
