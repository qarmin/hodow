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
fn test_aarch64_sve_svtsmul_f32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svtsmul_f32(create_svfloat32_t_from(1.0f32), create_svuint32_t_from(2u32)));
        check_float_array_equality(&result, &[1.0]).map_err(|e| crate::cpu::with_call(e, "svtsmul_f32(create_svfloat32_t_from(1.0f32), create_svuint32_t_from(2u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svtsmul_f32(create_random_svfloat32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svtsmul_f32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svtsmul_f32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svtsmul_f64_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svtsmul_f64(create_svfloat64_t_from(1.0f64), create_svuint64_t_from(2u64)));
        check_float_array_equality(&result, &[1.0]).map_err(|e| crate::cpu::with_call(e, "svtsmul_f64(create_svfloat64_t_from(1.0f64), create_svuint64_t_from(2u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svtsmul_f64(create_random_svfloat64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svtsmul_f64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svtsmul_f64_impl() }
}
