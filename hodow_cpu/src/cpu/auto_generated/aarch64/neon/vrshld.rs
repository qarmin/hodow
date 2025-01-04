use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vrshld_s64() -> Result<Verdict, String> {
    unsafe {
        let result = vrshld_s64(1i64, 2i64);
        check_int_equality(result, 4).map_err(|e| crate::cpu::with_call(e, "vrshld_s64(1i64, 2i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vrshld_s64(rand::random::<i64>(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vrshld_u64() -> Result<Verdict, String> {
    unsafe {
        let result = vrshld_u64(1u64, 2i64);
        check_int_equality(result, 4).map_err(|e| crate::cpu::with_call(e, "vrshld_u64(1u64, 2i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vrshld_u64(rand::random::<u64>(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}
