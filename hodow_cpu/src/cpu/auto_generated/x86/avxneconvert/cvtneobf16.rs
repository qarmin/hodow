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

#[target_feature(enable = "avxneconvert")]
fn test_x86_avxneconvert_mm_cvtneobf16_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_a = crate::cpu::common::Aligned64([create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]); 4]);
        let result = unpack__m128_to_f32_array(_mm_cvtneobf16_ps(ptr_a.0.as_ptr()));
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_avxneconvert_mm_cvtneobf16_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avxneconvert_mm_cvtneobf16_ps_impl() }
}

#[target_feature(enable = "avxneconvert")]
fn test_x86_avxneconvert_mm256_cvtneobf16_ps_impl() -> Result<Verdict, String> {
    unsafe {
        let ptr_a = crate::cpu::common::Aligned64([create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]); 2]);
        let result = unpack__m256_to_f32_array(_mm256_cvtneobf16_ps(ptr_a.0.as_ptr()));
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_x86_avxneconvert_mm256_cvtneobf16_ps() -> Result<Verdict, String> {
    unsafe { test_x86_avxneconvert_mm256_cvtneobf16_ps_impl() }
}
