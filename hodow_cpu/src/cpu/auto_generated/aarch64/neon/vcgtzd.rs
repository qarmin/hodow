use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vcgtzd_f64() -> Result<Verdict, String> {
    unsafe {
        let result = vcgtzd_f64(1.0f64);
        check_int_equality(result, 18446744073709551615).map_err(|e| crate::cpu::with_call(e, "vcgtzd_f64(1.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcgtzd_f64(rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcgtzd_s64() -> Result<Verdict, String> {
    unsafe {
        let result = vcgtzd_s64(1i64);
        check_int_equality(result, 18446744073709551615).map_err(|e| crate::cpu::with_call(e, "vcgtzd_s64(1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcgtzd_s64(rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}
