use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

#[target_feature(enable = "tbm")]
fn test_x86_64_tbm_bextri_u64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _bextri_u64::<0>(1u64);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_bextri_u64::<0>(1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _bextri_u64::<0>(rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_tbm_bextri_u64() -> Result<Verdict, String> {
    unsafe { test_x86_64_tbm_bextri_u64_impl() }
}

#[target_feature(enable = "tbm")]
fn test_x86_64_tbm_bextri_u64_imm_1_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _bextri_u64::<1>(1u64);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_bextri_u64::<1>(1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _bextri_u64::<1>(rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_tbm_bextri_u64_imm_1() -> Result<Verdict, String> {
    unsafe { test_x86_64_tbm_bextri_u64_imm_1_impl() }
}

#[target_feature(enable = "tbm")]
fn test_x86_64_tbm_bextri_u64_imm_65535_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _bextri_u64::<65535>(1u64);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_bextri_u64::<65535>(1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _bextri_u64::<65535>(rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_tbm_bextri_u64_imm_65535() -> Result<Verdict, String> {
    unsafe { test_x86_64_tbm_bextri_u64_imm_65535_impl() }
}

#[target_feature(enable = "tbm")]
fn test_x86_64_tbm_bextri_u64_imm_31_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _bextri_u64::<31>(1u64);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_bextri_u64::<31>(1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _bextri_u64::<31>(rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_tbm_bextri_u64_imm_31() -> Result<Verdict, String> {
    unsafe { test_x86_64_tbm_bextri_u64_imm_31_impl() }
}

#[target_feature(enable = "tbm")]
fn test_x86_64_tbm_bextri_u64_imm_32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _bextri_u64::<32>(1u64);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "_bextri_u64::<32>(1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _bextri_u64::<32>(rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_tbm_bextri_u64_imm_32() -> Result<Verdict, String> {
    unsafe { test_x86_64_tbm_bextri_u64_imm_32_impl() }
}
