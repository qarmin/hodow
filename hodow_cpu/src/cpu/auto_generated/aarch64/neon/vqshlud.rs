use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vqshlud_n_s64() -> Result<Verdict, String> {
    unsafe {
        let result = vqshlud_n_s64::<0>(1i64);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqshlud_n_s64::<0>(1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshlud_n_s64::<0>(rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqshlud_n_s64_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vqshlud_n_s64::<1>(1i64);
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "vqshlud_n_s64::<1>(1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshlud_n_s64::<1>(rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqshlud_n_s64_imm_63() -> Result<Verdict, String> {
    unsafe {
        let result = vqshlud_n_s64::<63>(1i64);
        check_int_equality(result, 9223372036854775808).map_err(|e| crate::cpu::with_call(e, "vqshlud_n_s64::<63>(1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshlud_n_s64::<63>(rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqshlud_n_s64_imm_31() -> Result<Verdict, String> {
    unsafe {
        let result = vqshlud_n_s64::<31>(1i64);
        check_int_equality(result, 2147483648).map_err(|e| crate::cpu::with_call(e, "vqshlud_n_s64::<31>(1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshlud_n_s64::<31>(rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqshlud_n_s64_imm_32() -> Result<Verdict, String> {
    unsafe {
        let result = vqshlud_n_s64::<32>(1i64);
        check_int_equality(result, 4294967296).map_err(|e| crate::cpu::with_call(e, "vqshlud_n_s64::<32>(1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshlud_n_s64::<32>(rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}
