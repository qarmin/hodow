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

pub(super) fn test_arm_shared_crc_crc32cb() -> Result<Verdict, String> {
    unsafe {
        let result = __crc32cb(1u32, 2u8);
        check_int_equality(result, 324072436).map_err(|e| crate::cpu::with_call(e, "__crc32cb(1u32, 2u8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = __crc32cb(rand::random::<u32>(), rand::random::<u8>());
        });
        Ok(Verdict::Checked)
    }
}
