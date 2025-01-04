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
fn test_aarch64_sve_svexpa_f32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svexpa_f32(create_svuint32_t_from(1u32)));
        check_float_array_equality(&result, &[1.28003e-40]).map_err(|e| crate::cpu::with_call(e, "svexpa_f32(create_svuint32_t_from(1u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svexpa_f32(create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svexpa_f32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svexpa_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svexpa_f64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svexpa_f64(create_svuint64_t_from(1u64)));
        check_float_array_equality(&result, &[2.4229465731446e-310]).map_err(|e| crate::cpu::with_call(e, "svexpa_f64(create_svuint64_t_from(1u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svexpa_f64(create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svexpa_f64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svexpa_f64_impl() }
}
