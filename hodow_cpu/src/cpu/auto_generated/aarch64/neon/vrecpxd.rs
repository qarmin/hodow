use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vrecpxd_f64() -> Result<Verdict, String> {
    unsafe {
        let result = vrecpxd_f64(1.0f64);
        check_float_equality(result, 2.0).map_err(|e| crate::cpu::with_call(e, "vrecpxd_f64(1.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vrecpxd_f64(rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}
