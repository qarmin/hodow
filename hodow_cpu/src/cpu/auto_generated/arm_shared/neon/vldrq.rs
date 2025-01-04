#[cfg(target_arch = "arm")]
use std::arch::arm::*;
#[cfg(target_arch = "aarch64")]
use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_arm_shared_neon_vldrq_p128() -> Result<Verdict, String> {
    unsafe {
        let ptr_a = crate::cpu::common::Aligned64([1u128; 64]);
        let result = vldrq_p128(ptr_a.0.as_ptr());
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vldrq_p128(ptr_a.0.as_ptr())"))?;
        Ok(Verdict::Checked)
    }
}
