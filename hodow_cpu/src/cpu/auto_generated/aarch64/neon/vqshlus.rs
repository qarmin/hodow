use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vqshlus_n_s32() -> Result<Verdict, String> {
    unsafe {
        let result = vqshlus_n_s32::<0>(1i32);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqshlus_n_s32::<0>(1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshlus_n_s32::<0>(rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqshlus_n_s32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vqshlus_n_s32::<1>(1i32);
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "vqshlus_n_s32::<1>(1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshlus_n_s32::<1>(rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqshlus_n_s32_imm_31() -> Result<Verdict, String> {
    unsafe {
        let result = vqshlus_n_s32::<31>(1i32);
        check_int_equality(result, 2147483648).map_err(|e| crate::cpu::with_call(e, "vqshlus_n_s32::<31>(1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshlus_n_s32::<31>(rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqshlus_n_s32_imm_15() -> Result<Verdict, String> {
    unsafe {
        let result = vqshlus_n_s32::<15>(1i32);
        check_int_equality(result, 32768).map_err(|e| crate::cpu::with_call(e, "vqshlus_n_s32::<15>(1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshlus_n_s32::<15>(rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}
