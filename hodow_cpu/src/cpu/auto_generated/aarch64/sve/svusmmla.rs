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
fn test_aarch64_sve_svusmmla_s32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("i8mm")) {
            return Ok(Verdict::Skipped("i8mm not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svusmmla_s32(create_svint32_t_from(1i32), create_svuint8_t_from(2u8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[49]).map_err(|e| crate::cpu::with_call(e, "svusmmla_s32(create_svint32_t_from(1i32), create_svuint8_t_from(2u8), create_svint8_t_from(3i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svusmmla_s32(create_random_svint32_t(), create_random_svuint8_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svusmmla_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svusmmla_s32_impl() }
}
