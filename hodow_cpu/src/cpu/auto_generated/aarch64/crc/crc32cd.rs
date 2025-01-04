use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_crc_crc32cd() -> Result<Verdict, String> {
    unsafe {
        let result = __crc32cd(1u32, 2u64);
        check_int_equality(result, 3678701417).map_err(|e| crate::cpu::with_call(e, "__crc32cd(1u32, 2u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = __crc32cd(rand::random::<u32>(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}
