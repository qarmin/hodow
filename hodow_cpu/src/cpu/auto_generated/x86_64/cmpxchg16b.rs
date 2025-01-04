use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

#[target_feature(enable = "cmpxchg16b")]
fn test_x86_64_cmpxchg16b_cmpxchg16b_impl() -> Result<Verdict, String> {
    unsafe {
        let mut ptr_dst = crate::cpu::common::Aligned64([1u128; 4]);
        let old = 1u128;
        let new = 1u128;
        let success = core::sync::atomic::Ordering::Relaxed;
        let failure = core::sync::atomic::Ordering::Relaxed;
        let ret_value = cmpxchg16b(ptr_dst.0.as_mut_ptr(), old, new, success, failure);
        let _ = core::hint::black_box(&mut ptr_dst);
        let out_dst = core::ptr::read(ptr_dst.0.as_ptr().cast::<[u128; 4]>());
        let result = (ret_value, out_dst);
        let expected = (1, [1, 1, 1, 1]);
        check_int_equality(result.0, expected.0).map_err(|e| crate::cpu::with_call(e, "cmpxchg16b(ptr_dst.0.as_mut_ptr(), old, new, success, failure)"))?;
        check_array_equality(&result.1, &expected.1).map_err(|e| crate::cpu::with_call(e, "cmpxchg16b(ptr_dst.0.as_mut_ptr(), old, new, success, failure)"))?;
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_cmpxchg16b_cmpxchg16b() -> Result<Verdict, String> {
    unsafe { test_x86_64_cmpxchg16b_cmpxchg16b_impl() }
}


use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct CMPXCHG16B;

impl ExtensionTest for CMPXCHG16B {
    fn get_name() -> &'static str {
        "x86_64::CMPXCHG16B"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_x86_64_cmpxchg16b_cmpxchg16b, "test_x86_64_cmpxchg16b_cmpxchg16b"),
        ]
    }
}
