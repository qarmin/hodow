use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vqshruns_n_s32() -> Result<Verdict, String> {
    unsafe {
        let result = vqshruns_n_s32::<1>(1i32);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vqshruns_n_s32::<1>(1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshruns_n_s32::<1>(rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqshruns_n_s32_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = vqshruns_n_s32::<2>(1i32);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vqshruns_n_s32::<2>(1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshruns_n_s32::<2>(rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqshruns_n_s32_imm_16() -> Result<Verdict, String> {
    unsafe {
        let result = vqshruns_n_s32::<16>(1i32);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vqshruns_n_s32::<16>(1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshruns_n_s32::<16>(rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqshruns_n_s32_imm_8() -> Result<Verdict, String> {
    unsafe {
        let result = vqshruns_n_s32::<8>(1i32);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vqshruns_n_s32::<8>(1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshruns_n_s32::<8>(rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}
