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

pub(super) fn test_arm_shared_sha2_vsha1h_u32() -> Result<Verdict, String> {
    unsafe {
        let result = vsha1h_u32(1u32);
        check_int_equality(result, 1073741824).map_err(|e| crate::cpu::with_call(e, "vsha1h_u32(1u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsha1h_u32(rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}
