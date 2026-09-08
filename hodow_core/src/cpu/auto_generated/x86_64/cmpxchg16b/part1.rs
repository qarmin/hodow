use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "cmpxchg16b")]
fn test_x86_64_cmpxchg16b_cmpxchg16b_impl() -> Result<(), String> {
    unsafe {
        let mut ptr_dst = crate::cpu::common::Aligned64([1u128; 4]);
        let old = 1u128;
        let new = 1u128;
        let success = core::sync::atomic::Ordering::Relaxed;
        let failure = core::sync::atomic::Ordering::Relaxed;
        let _result = cmpxchg16b(ptr_dst.0.as_mut_ptr(), old, new, success, failure);
    }
    Ok(())
}

pub(super) fn test_x86_64_cmpxchg16b_cmpxchg16b() -> Result<(), String> {
    unsafe { test_x86_64_cmpxchg16b_cmpxchg16b_impl() }
}
