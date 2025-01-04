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
fn test_x86_avx512f_mm512_int2mask_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_int2mask(1i32);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_mm512_int2mask(1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_int2mask(rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512f_mm512_int2mask() -> Result<Verdict, String> {
    unsafe { test_x86_avx512f_mm512_int2mask_impl() }
}
