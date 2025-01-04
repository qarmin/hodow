use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vceqzd_s64() -> Result<Verdict, String> {
    unsafe {
        let result = vceqzd_s64(1i64);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vceqzd_s64(1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vceqzd_s64(rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vceqzd_u64() -> Result<Verdict, String> {
    unsafe {
        let result = vceqzd_u64(1u64);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vceqzd_u64(1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vceqzd_u64(rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vceqzd_f64() -> Result<Verdict, String> {
    unsafe {
        let result = vceqzd_f64(1.0f64);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vceqzd_f64(1.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vceqzd_f64(rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}
