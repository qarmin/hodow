use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vcreate_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcreate_f64(1u64));
        check_float_array_equality(&result, &[5e-324]).map_err(|e| crate::cpu::with_call(e, "vcreate_f64(1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcreate_f64(rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}
