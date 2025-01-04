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
fn test_aarch64_sve_svminnmv_f32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = svminnmv_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32));
        check_float_equality(result, 2.0).map_err(|e| crate::cpu::with_call(e, "svminnmv_f32(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svminnmv_f32(create_svbool_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svminnmv_f32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svminnmv_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svminnmv_f64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = svminnmv_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64));
        check_float_equality(result, 2.0).map_err(|e| crate::cpu::with_call(e, "svminnmv_f64(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svminnmv_f64(create_svbool_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svminnmv_f64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svminnmv_f64_impl() }
}
