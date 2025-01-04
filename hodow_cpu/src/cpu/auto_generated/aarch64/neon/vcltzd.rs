use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vcltzd_f64() -> Result<Verdict, String> {
    unsafe {
        let result = vcltzd_f64(1.0f64);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vcltzd_f64(1.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcltzd_f64(rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcltzd_s64() -> Result<Verdict, String> {
    unsafe {
        let result = vcltzd_s64(1i64);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vcltzd_s64(1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcltzd_s64(rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}
