use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vcaltd_f64() -> Result<Verdict, String> {
    unsafe {
        let result = vcaltd_f64(1.0f64, 2.0f64);
        check_int_equality(result, 18446744073709551615).map_err(|e| crate::cpu::with_call(e, "vcaltd_f64(1.0f64, 2.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcaltd_f64(rand::random::<f64>(), rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}
