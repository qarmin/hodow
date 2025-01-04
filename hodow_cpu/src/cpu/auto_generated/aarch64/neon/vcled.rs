use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vcled_f64() -> Result<Verdict, String> {
    unsafe {
        let result = vcled_f64(1.0f64, 2.0f64);
        check_int_equality(result, 18446744073709551615).map_err(|e| crate::cpu::with_call(e, "vcled_f64(1.0f64, 2.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcled_f64(rand::random::<f64>(), rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcled_u64() -> Result<Verdict, String> {
    unsafe {
        let result = vcled_u64(1u64, 2u64);
        check_int_equality(result, 18446744073709551615).map_err(|e| crate::cpu::with_call(e, "vcled_u64(1u64, 2u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcled_u64(rand::random::<u64>(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcled_s64() -> Result<Verdict, String> {
    unsafe {
        let result = vcled_s64(1i64, 2i64);
        check_int_equality(result, 18446744073709551615).map_err(|e| crate::cpu::with_call(e, "vcled_s64(1i64, 2i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcled_s64(rand::random::<i64>(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}
