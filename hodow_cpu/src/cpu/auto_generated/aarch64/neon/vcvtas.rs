use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vcvtas_s32_f32() -> Result<Verdict, String> {
    unsafe {
        let result = vcvtas_s32_f32(1.0f32);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vcvtas_s32_f32(1.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtas_s32_f32(rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcvtas_u32_f32() -> Result<Verdict, String> {
    unsafe {
        let result = vcvtas_u32_f32(1.0f32);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vcvtas_u32_f32(1.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcvtas_u32_f32(rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}
