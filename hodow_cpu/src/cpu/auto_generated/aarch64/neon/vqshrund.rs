use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vqshrund_n_s64() -> Result<Verdict, String> {
    unsafe {
        let result = vqshrund_n_s64::<1>(1i64);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vqshrund_n_s64::<1>(1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrund_n_s64::<1>(rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqshrund_n_s64_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = vqshrund_n_s64::<2>(1i64);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vqshrund_n_s64::<2>(1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrund_n_s64::<2>(rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqshrund_n_s64_imm_32() -> Result<Verdict, String> {
    unsafe {
        let result = vqshrund_n_s64::<32>(1i64);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vqshrund_n_s64::<32>(1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrund_n_s64::<32>(rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqshrund_n_s64_imm_31() -> Result<Verdict, String> {
    unsafe {
        let result = vqshrund_n_s64::<31>(1i64);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vqshrund_n_s64::<31>(1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrund_n_s64::<31>(rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqshrund_n_s64_imm_16() -> Result<Verdict, String> {
    unsafe {
        let result = vqshrund_n_s64::<16>(1i64);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vqshrund_n_s64::<16>(1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrund_n_s64::<16>(rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}
