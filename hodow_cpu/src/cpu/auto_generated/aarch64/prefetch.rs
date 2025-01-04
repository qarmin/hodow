use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_prefetch_prefetch() -> Result<Verdict, String> {
    unsafe {
        let ptr_p = crate::cpu::common::Aligned64([1i8; 64]);
        _prefetch::<0, 0>(ptr_p.0.as_ptr());
        Ok(Verdict::Unverified(None))
    }
}


use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct PREFETCH;

impl ExtensionTest for PREFETCH {
    fn get_name() -> &'static str {
        "aarch64::PREFETCH"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_aarch64_prefetch_prefetch, "test_aarch64_prefetch_prefetch"),
        ]
    }
}
