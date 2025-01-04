use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svrax1_s64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve") && std::arch::is_aarch64_feature_detected!("sve2-sha3")) {
            return Ok(Verdict::Skipped("sve+sve2-sha3 not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svrax1_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[5]).map_err(|e| crate::cpu::with_call(e, "svrax1_s64(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrax1_s64(create_random_svint64_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svrax1_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svrax1_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svrax1_u64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve") && std::arch::is_aarch64_feature_detected!("sve2-sha3")) {
            return Ok(Verdict::Skipped("sve+sve2-sha3 not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svrax1_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[5]).map_err(|e| crate::cpu::with_call(e, "svrax1_u64(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrax1_u64(create_random_svuint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svrax1_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svrax1_u64_impl() }
}
