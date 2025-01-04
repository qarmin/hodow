use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vcgtzs_f32() -> Result<Verdict, String> {
    unsafe {
        let result = vcgtzs_f32(1.0f32);
        check_int_equality(result, 4294967295).map_err(|e| crate::cpu::with_call(e, "vcgtzs_f32(1.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcgtzs_f32(rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}
