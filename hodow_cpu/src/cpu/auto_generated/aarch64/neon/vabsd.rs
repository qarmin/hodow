use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vabsd_s64() -> Result<Verdict, String> {
    unsafe {
        let result = vabsd_s64(1i64);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vabsd_s64(1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vabsd_s64(rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}
