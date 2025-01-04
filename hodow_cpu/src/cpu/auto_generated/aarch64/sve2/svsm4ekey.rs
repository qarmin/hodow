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
fn test_aarch64_sve2_svsm4ekey_u32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve") && std::arch::is_aarch64_feature_detected!("sve2-sm4")) {
            return Ok(Verdict::Skipped("sve+sve2-sm4 not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svsm4ekey_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[1492370698]).map_err(|e| crate::cpu::with_call(e, "svsm4ekey_u32(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsm4ekey_u32(create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svsm4ekey_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svsm4ekey_u32_impl() }
}
