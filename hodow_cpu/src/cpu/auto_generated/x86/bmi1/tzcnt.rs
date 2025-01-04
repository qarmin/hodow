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

#[target_feature(enable = "bmi1")]
fn test_x86_bmi1_tzcnt_u16_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _tzcnt_u16(1u16);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_tzcnt_u16(1u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _tzcnt_u16(rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_bmi1_tzcnt_u16() -> Result<Verdict, String> {
    unsafe { test_x86_bmi1_tzcnt_u16_impl() }
}

#[target_feature(enable = "bmi1")]
fn test_x86_bmi1_tzcnt_u32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _tzcnt_u32(1u32);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_tzcnt_u32(1u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _tzcnt_u32(rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_bmi1_tzcnt_u32() -> Result<Verdict, String> {
    unsafe { test_x86_bmi1_tzcnt_u32_impl() }
}

#[target_feature(enable = "bmi1")]
fn test_x86_bmi1_mm_tzcnt_32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _mm_tzcnt_32(1u32);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_mm_tzcnt_32(1u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _mm_tzcnt_32(rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_bmi1_mm_tzcnt_32() -> Result<Verdict, String> {
    unsafe { test_x86_bmi1_mm_tzcnt_32_impl() }
}
