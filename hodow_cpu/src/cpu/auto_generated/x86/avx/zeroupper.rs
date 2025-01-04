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

#[target_feature(enable = "avx")]
fn test_x86_avx_mm256_zeroupper_impl() -> Result<Verdict, String> {
    unsafe {
        _mm256_zeroupper();

        crate::cpu::fuzz(&mut || {
            _mm256_zeroupper();
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_x86_avx_mm256_zeroupper() -> Result<Verdict, String> {
    unsafe { test_x86_avx_mm256_zeroupper_impl() }
}
