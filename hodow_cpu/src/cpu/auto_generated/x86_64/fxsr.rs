use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

#[target_feature(enable = "fxsr")]
fn test_x86_64_fxsr_fxsave64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1u8; 4096]);
        _fxsave64(ptr_mem_addr.0.as_mut_ptr());
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_x86_64_fxsr_fxsave64() -> Result<Verdict, String> {
    unsafe { test_x86_64_fxsr_fxsave64_impl() }
}


use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct FXSR;

impl ExtensionTest for FXSR {
    fn get_name() -> &'static str {
        "x86_64::FXSR"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_x86_64_fxsr_fxsave64, "test_x86_64_fxsr_fxsave64"),
        ]
    }
}
