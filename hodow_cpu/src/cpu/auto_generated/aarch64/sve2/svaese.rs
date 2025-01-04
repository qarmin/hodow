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
fn test_aarch64_sve2_svaese_u8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve") && std::arch::is_aarch64_feature_detected!("sve2-aes")) {
            return Ok(Verdict::Skipped("sve+sve2-aes not present"));
        }
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svaese_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[123]).map_err(|e| crate::cpu::with_call(e, "svaese_u8(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svaese_u8(create_random_svuint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svaese_u8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svaese_u8_impl() }
}
