use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vsqadds_u32() -> Result<Verdict, String> {
    unsafe {
        let result = vsqadds_u32(1u32, 2i32);
        check_int_equality(result, 3).map_err(|e| crate::cpu::with_call(e, "vsqadds_u32(1u32, 2i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsqadds_u32(rand::random::<u32>(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}
