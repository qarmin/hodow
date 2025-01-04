use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vtstd_s64() -> Result<Verdict, String> {
    unsafe {
        let result = vtstd_s64(1i64, 2i64);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vtstd_s64(1i64, 2i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtstd_s64(rand::random::<i64>(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vtstd_u64() -> Result<Verdict, String> {
    unsafe {
        let result = vtstd_u64(1u64, 2u64);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vtstd_u64(1u64, 2u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vtstd_u64(rand::random::<u64>(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}
