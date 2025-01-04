use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vrecped_f64() -> Result<Verdict, String> {
    unsafe {
        let result = vrecped_f64(1.0f64);
        check_float_equality(result, 0.998046875).map_err(|e| crate::cpu::with_call(e, "vrecped_f64(1.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vrecped_f64(rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}
