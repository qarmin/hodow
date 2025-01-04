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

#[target_feature(enable = "tbm")]
fn test_x86_tbm_blci_u32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _blci_u32(1u32);
        check_int_equality(result, 4294967293).map_err(|e| crate::cpu::with_call(e, "_blci_u32(1u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _blci_u32(rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_tbm_blci_u32() -> Result<Verdict, String> {
    unsafe { test_x86_tbm_blci_u32_impl() }
}
