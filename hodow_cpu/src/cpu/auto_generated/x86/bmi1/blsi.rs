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

#[target_feature(enable = "bmi1")]
fn test_x86_bmi1_blsi_u32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _blsi_u32(1u32);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "_blsi_u32(1u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _blsi_u32(rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_bmi1_blsi_u32() -> Result<Verdict, String> {
    unsafe { test_x86_bmi1_blsi_u32_impl() }
}
