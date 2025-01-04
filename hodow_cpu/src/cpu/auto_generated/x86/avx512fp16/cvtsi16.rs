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

#[target_feature(enable = "avx512fp16")]
fn test_x86_avx512fp16_mm_cvtsi16_si128_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtsi16_si128(1i16));

        crate::cpu::fuzz(&mut || {
            let _ = _mm_cvtsi16_si128(rand::random::<i16>());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_avx512fp16_mm_cvtsi16_si128() -> Result<Verdict, String> {
    unsafe { test_x86_avx512fp16_mm_cvtsi16_si128_impl() }
}
