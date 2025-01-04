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

#[target_feature(enable = "tbm")]
fn test_x86_tbm_bextri_u32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _bextri_u32::<0>(1u32);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_bextri_u32::<0>(1u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _bextri_u32::<0>(rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_tbm_bextri_u32() -> Result<Verdict, String> {
    unsafe { test_x86_tbm_bextri_u32_impl() }
}

#[target_feature(enable = "tbm")]
fn test_x86_tbm_bextri_u32_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _bextri_u32::<1>(1u32);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_bextri_u32::<1>(1u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _bextri_u32::<1>(rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_tbm_bextri_u32_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_tbm_bextri_u32_imm_1_impl() }
}

#[target_feature(enable = "tbm")]
fn test_x86_tbm_bextri_u32_imm_65535_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _bextri_u32::<65535>(1u32);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_bextri_u32::<65535>(1u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _bextri_u32::<65535>(rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_tbm_bextri_u32_imm_65535() -> Result<Verdict, String> {
    unsafe { test_x86_tbm_bextri_u32_imm_65535_impl() }
}

#[target_feature(enable = "tbm")]
fn test_x86_tbm_bextri_u32_imm_31_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _bextri_u32::<31>(1u32);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_bextri_u32::<31>(1u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _bextri_u32::<31>(rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_tbm_bextri_u32_imm_31() -> Result<Verdict, String> {
    unsafe { test_x86_tbm_bextri_u32_imm_31_impl() }
}

#[target_feature(enable = "tbm")]
fn test_x86_tbm_bextri_u32_imm_32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _bextri_u32::<32>(1u32);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_bextri_u32::<32>(1u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _bextri_u32::<32>(rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_tbm_bextri_u32_imm_32() -> Result<Verdict, String> {
    unsafe { test_x86_tbm_bextri_u32_imm_32_impl() }
}
