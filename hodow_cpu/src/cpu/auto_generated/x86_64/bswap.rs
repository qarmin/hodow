use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_x86_64_bswap_bswap64() -> Result<Verdict, String> {
    unsafe {
        let result = _bswap64(1i64);

        crate::cpu::fuzz(&mut || {
            let _ = _bswap64(rand::random::<i64>());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}


use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct BSWAP;

impl ExtensionTest for BSWAP {
    fn get_name() -> &'static str {
        "x86_64::BSWAP"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_x86_64_bswap_bswap64, "test_x86_64_bswap_bswap64"),
        ]
    }
}
