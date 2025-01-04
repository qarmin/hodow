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

pub(super) fn test_x86_bswap_bswap() -> Result<Verdict, String> {
    unsafe {
        let result = _bswap(1i32);

        crate::cpu::fuzz(&mut || {
            let _ = _bswap(rand::random::<i32>());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}


use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct BSWAP;

impl ExtensionTest for BSWAP {
    fn get_name() -> &'static str {
        "x86::BSWAP"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_x86_bswap_bswap, "test_x86_bswap_bswap"),
        ]
    }
}
