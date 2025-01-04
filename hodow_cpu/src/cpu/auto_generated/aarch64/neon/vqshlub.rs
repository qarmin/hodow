use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vqshlub_n_s8() -> Result<Verdict, String> {
    unsafe {
        let result = vqshlub_n_s8::<0>(1i8);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqshlub_n_s8::<0>(1i8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshlub_n_s8::<0>(rand::random::<i8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqshlub_n_s8_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vqshlub_n_s8::<1>(1i8);
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "vqshlub_n_s8::<1>(1i8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshlub_n_s8::<1>(rand::random::<i8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqshlub_n_s8_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = vqshlub_n_s8::<7>(1i8);
        check_int_equality(result, 128).map_err(|e| crate::cpu::with_call(e, "vqshlub_n_s8::<7>(1i8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshlub_n_s8::<7>(rand::random::<i8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqshlub_n_s8_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = vqshlub_n_s8::<3>(1i8);
        check_int_equality(result, 8).map_err(|e| crate::cpu::with_call(e, "vqshlub_n_s8::<3>(1i8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshlub_n_s8::<3>(rand::random::<i8>());
        });
        Ok(Verdict::Checked)
    }
}
