use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vuqadds_s32() -> Result<Verdict, String> {
    unsafe {
        let result = vuqadds_s32(1i32, 2u32);
        check_int_equality(result, 3).map_err(|e| crate::cpu::with_call(e, "vuqadds_s32(1i32, 2u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vuqadds_s32(rand::random::<i32>(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}
