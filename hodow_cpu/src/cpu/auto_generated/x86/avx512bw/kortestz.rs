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
fn test_x86_avx512bw_kortestz_mask32_u8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _kortestz_mask32_u8(create__mmask32_from(0x55555555u32), create__mmask32_from(0x55555555u32));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_kortestz_mask32_u8(create__mmask32_from(0x55555555u32), create__mmask32_from(0x55555555u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _kortestz_mask32_u8(create_random__mmask32(), create_random__mmask32());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_kortestz_mask32_u8() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_kortestz_mask32_u8_impl() }
}

#[target_feature(enable = "avx512bw")]
fn test_x86_avx512bw_kortestz_mask64_u8_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _kortestz_mask64_u8(create__mmask64_from(0x5555555555555555u64), create__mmask64_from(0x5555555555555555u64));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_kortestz_mask64_u8(create__mmask64_from(0x5555555555555555u64), create__mmask64_from(0x5555555555555555u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _kortestz_mask64_u8(create_random__mmask64(), create_random__mmask64());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_avx512bw_kortestz_mask64_u8() -> Result<Verdict, String> {
    unsafe { test_x86_avx512bw_kortestz_mask64_u8_impl() }
}
