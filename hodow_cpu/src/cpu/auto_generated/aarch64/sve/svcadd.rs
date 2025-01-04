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
fn test_aarch64_sve_svcadd_f32_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcadd_f32_m::<90>(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[5.0]).map_err(|e| crate::cpu::with_call(e, "svcadd_f32_m::<90>(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcadd_f32_m::<90>(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcadd_f32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcadd_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcadd_f32_m_imm_270_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcadd_f32_m::<270>(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[-1.0]).map_err(|e| crate::cpu::with_call(e, "svcadd_f32_m::<270>(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcadd_f32_m::<270>(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcadd_f32_m_imm_270() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcadd_f32_m_imm_270_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcadd_f32_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcadd_f32_x::<90>(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[5.0]).map_err(|e| crate::cpu::with_call(e, "svcadd_f32_x::<90>(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcadd_f32_x::<90>(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcadd_f32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcadd_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcadd_f32_x_imm_270_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcadd_f32_x::<270>(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[-1.0]).map_err(|e| crate::cpu::with_call(e, "svcadd_f32_x::<270>(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcadd_f32_x::<270>(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcadd_f32_x_imm_270() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcadd_f32_x_imm_270_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcadd_f32_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcadd_f32_z::<90>(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[5.0]).map_err(|e| crate::cpu::with_call(e, "svcadd_f32_z::<90>(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcadd_f32_z::<90>(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcadd_f32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcadd_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcadd_f32_z_imm_270_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcadd_f32_z::<270>(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[-1.0]).map_err(|e| crate::cpu::with_call(e, "svcadd_f32_z::<270>(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcadd_f32_z::<270>(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcadd_f32_z_imm_270() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcadd_f32_z_imm_270_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcadd_f64_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svcadd_f64_m::<90>(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[5.0]).map_err(|e| crate::cpu::with_call(e, "svcadd_f64_m::<90>(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcadd_f64_m::<90>(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcadd_f64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcadd_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcadd_f64_m_imm_270_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svcadd_f64_m::<270>(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[-1.0]).map_err(|e| crate::cpu::with_call(e, "svcadd_f64_m::<270>(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcadd_f64_m::<270>(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcadd_f64_m_imm_270() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcadd_f64_m_imm_270_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcadd_f64_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svcadd_f64_x::<90>(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[5.0]).map_err(|e| crate::cpu::with_call(e, "svcadd_f64_x::<90>(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcadd_f64_x::<90>(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcadd_f64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcadd_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcadd_f64_x_imm_270_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svcadd_f64_x::<270>(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[-1.0]).map_err(|e| crate::cpu::with_call(e, "svcadd_f64_x::<270>(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcadd_f64_x::<270>(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcadd_f64_x_imm_270() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcadd_f64_x_imm_270_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcadd_f64_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svcadd_f64_z::<90>(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[5.0]).map_err(|e| crate::cpu::with_call(e, "svcadd_f64_z::<90>(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcadd_f64_z::<90>(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcadd_f64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcadd_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcadd_f64_z_imm_270_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svcadd_f64_z::<270>(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[-1.0]).map_err(|e| crate::cpu::with_call(e, "svcadd_f64_z::<270>(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcadd_f64_z::<270>(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcadd_f64_z_imm_270() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcadd_f64_z_imm_270_impl() }
}
