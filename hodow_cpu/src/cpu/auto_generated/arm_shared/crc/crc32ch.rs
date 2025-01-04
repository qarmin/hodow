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

pub(super) fn test_arm_shared_crc_crc32ch() -> Result<Verdict, String> {
    unsafe {
        let result = __crc32ch(1u32, 2u16);
        check_int_equality(result, 887597209).map_err(|e| crate::cpu::with_call(e, "__crc32ch(1u32, 2u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = __crc32ch(rand::random::<u32>(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}
