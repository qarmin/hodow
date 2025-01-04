use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

#[target_feature(enable = "xsave")]
fn test_x86_64_xsave_xsave64_impl() -> Result<Verdict, String> {
        if cfg!(miri) {
            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1u8; 4096]);
        let save_mask = 2u64;
        _xsave64(ptr_mem_addr.0.as_mut_ptr(), save_mask);
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_x86_64_xsave_xsave64() -> Result<Verdict, String> {
    unsafe { test_x86_64_xsave_xsave64_impl() }
}
