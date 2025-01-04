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

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_mm512_kunpackw_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm512_kunpackw(create__mmask32_from(0x55555555u32), create__mmask32_from(0x55555555u32));
        check_int_equality(result, 1431655765).map_err(|e| crate::cpu::with_call(e, "_mm512_kunpackw(create__mmask32_from(0x55555555u32), create__mmask32_from(0x55555555u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm512_kunpackw(create_random__mmask32(), create_random__mmask32());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_mm512_kunpackw() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_mm512_kunpackw_impl() }
}
