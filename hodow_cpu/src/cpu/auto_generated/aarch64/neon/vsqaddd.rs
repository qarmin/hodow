use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vsqaddd_u64() -> Result<Verdict, String> {
    unsafe {
        let result = vsqaddd_u64(1u64, 2i64);
        check_int_equality(result, 3).map_err(|e| crate::cpu::with_call(e, "vsqaddd_u64(1u64, 2i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsqaddd_u64(rand::random::<u64>(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}
