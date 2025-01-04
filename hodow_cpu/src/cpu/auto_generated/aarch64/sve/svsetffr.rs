use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svsetffr_impl() -> Result<Verdict, String> {
    unsafe {
        svsetffr();

        crate::cpu::fuzz(&mut || {
            svsetffr();
        });
        Ok(Verdict::Unverified(None))
    }
}

pub(super) fn test_aarch64_sve_svsetffr() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svsetffr_impl() }
}
