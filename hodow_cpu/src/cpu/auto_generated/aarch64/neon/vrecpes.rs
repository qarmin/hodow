use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vrecpes_f32() -> Result<Verdict, String> {
    unsafe {
        let result = vrecpes_f32(1.0f32);
        check_float_equality(result, 0.9980469).map_err(|e| crate::cpu::with_call(e, "vrecpes_f32(1.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vrecpes_f32(rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}
