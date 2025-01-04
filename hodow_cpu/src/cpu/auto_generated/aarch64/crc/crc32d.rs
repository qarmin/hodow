use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_crc_crc32d() -> Result<Verdict, String> {
    unsafe {
        let result = __crc32d(1u32, 2u64);
        check_int_equality(result, 2391738339).map_err(|e| crate::cpu::with_call(e, "__crc32d(1u32, 2u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = __crc32d(rand::random::<u32>(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}
