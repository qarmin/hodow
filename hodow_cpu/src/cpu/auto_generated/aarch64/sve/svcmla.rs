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
fn test_aarch64_sve_svcmla_f32_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcmla_f32_m::<0>(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32)));
        check_float_array_equality(&result, &[14.0]).map_err(|e| crate::cpu::with_call(e, "svcmla_f32_m::<0>(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmla_f32_m::<0>(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmla_f32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmla_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmla_f32_m_imm_270_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcmla_f32_m::<270>(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32)));
        check_float_array_equality(&result, &[-10.0]).map_err(|e| crate::cpu::with_call(e, "svcmla_f32_m::<270>(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmla_f32_m::<270>(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmla_f32_m_imm_270() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmla_f32_m_imm_270_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmla_f32_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcmla_f32_x::<0>(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32)));
        check_float_array_equality(&result, &[14.0]).map_err(|e| crate::cpu::with_call(e, "svcmla_f32_x::<0>(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmla_f32_x::<0>(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmla_f32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmla_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmla_f32_x_imm_270_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcmla_f32_x::<270>(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32)));
        check_float_array_equality(&result, &[-10.0]).map_err(|e| crate::cpu::with_call(e, "svcmla_f32_x::<270>(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmla_f32_x::<270>(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmla_f32_x_imm_270() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmla_f32_x_imm_270_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmla_f32_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcmla_f32_z::<0>(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32)));
        check_float_array_equality(&result, &[14.0]).map_err(|e| crate::cpu::with_call(e, "svcmla_f32_z::<0>(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmla_f32_z::<0>(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmla_f32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmla_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmla_f32_z_imm_270_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcmla_f32_z::<270>(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32)));
        check_float_array_equality(&result, &[-10.0]).map_err(|e| crate::cpu::with_call(e, "svcmla_f32_z::<270>(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmla_f32_z::<270>(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmla_f32_z_imm_270() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmla_f32_z_imm_270_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmla_f64_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svcmla_f64_m::<0>(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64)));
        check_float_array_equality(&result, &[14.0]).map_err(|e| crate::cpu::with_call(e, "svcmla_f64_m::<0>(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmla_f64_m::<0>(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmla_f64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmla_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmla_f64_m_imm_270_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svcmla_f64_m::<270>(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64)));
        check_float_array_equality(&result, &[-10.0]).map_err(|e| crate::cpu::with_call(e, "svcmla_f64_m::<270>(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmla_f64_m::<270>(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmla_f64_m_imm_270() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmla_f64_m_imm_270_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmla_f64_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svcmla_f64_x::<0>(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64)));
        check_float_array_equality(&result, &[14.0]).map_err(|e| crate::cpu::with_call(e, "svcmla_f64_x::<0>(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmla_f64_x::<0>(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmla_f64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmla_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmla_f64_x_imm_270_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svcmla_f64_x::<270>(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64)));
        check_float_array_equality(&result, &[-10.0]).map_err(|e| crate::cpu::with_call(e, "svcmla_f64_x::<270>(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmla_f64_x::<270>(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmla_f64_x_imm_270() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmla_f64_x_imm_270_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmla_f64_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svcmla_f64_z::<0>(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64)));
        check_float_array_equality(&result, &[14.0]).map_err(|e| crate::cpu::with_call(e, "svcmla_f64_z::<0>(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmla_f64_z::<0>(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmla_f64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmla_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmla_f64_z_imm_270_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svcmla_f64_z::<270>(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64)));
        check_float_array_equality(&result, &[-10.0]).map_err(|e| crate::cpu::with_call(e, "svcmla_f64_z::<270>(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmla_f64_z::<270>(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmla_f64_z_imm_270() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmla_f64_z_imm_270_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcmla_lane_f32_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcmla_lane_f32::<0, 0>(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[7.0]).map_err(|e| crate::cpu::with_call(e, "svcmla_lane_f32::<0, 0>(create_svfloat32_t_from(1.0f32), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmla_lane_f32::<0, 0>(create_random_svfloat32_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcmla_lane_f32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcmla_lane_f32_impl() }
}
