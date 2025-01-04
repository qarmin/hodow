use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

#[target_feature(enable = "tbm")]
fn test_x86_64_tbm_blcmsk_u64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = _blcmsk_u64(1u64);
        check_int_equality(result, 3).map_err(|e| crate::cpu::with_call(e, "_blcmsk_u64(1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = _blcmsk_u64(rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_x86_64_tbm_blcmsk_u64() -> Result<Verdict, String> {
    unsafe { test_x86_64_tbm_blcmsk_u64_impl() }
}
