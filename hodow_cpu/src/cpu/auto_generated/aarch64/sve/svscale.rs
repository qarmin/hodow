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
fn test_aarch64_sve_svscale_f32_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svscale_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svint32_t_from(3i32)));
        check_float_array_equality(&result, &[16.0]).map_err(|e| crate::cpu::with_call(e, "svscale_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svint32_t_from(3i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svscale_f32_m(create_svbool_t(), create_random_svfloat32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svscale_f32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svscale_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svscale_n_f32_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svscale_n_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3i32));
        check_float_array_equality(&result, &[16.0]).map_err(|e| crate::cpu::with_call(e, "svscale_n_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svscale_n_f32_m(create_svbool_t(), create_random_svfloat32_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svscale_n_f32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svscale_n_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svscale_f32_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svscale_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svint32_t_from(3i32)));
        check_float_array_equality(&result, &[16.0]).map_err(|e| crate::cpu::with_call(e, "svscale_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svint32_t_from(3i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svscale_f32_x(create_svbool_t(), create_random_svfloat32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svscale_f32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svscale_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svscale_n_f32_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svscale_n_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3i32));
        check_float_array_equality(&result, &[16.0]).map_err(|e| crate::cpu::with_call(e, "svscale_n_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svscale_n_f32_x(create_svbool_t(), create_random_svfloat32_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svscale_n_f32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svscale_n_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svscale_f32_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svscale_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svint32_t_from(3i32)));
        check_float_array_equality(&result, &[16.0]).map_err(|e| crate::cpu::with_call(e, "svscale_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svint32_t_from(3i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svscale_f32_z(create_svbool_t(), create_random_svfloat32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svscale_f32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svscale_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svscale_n_f32_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svscale_n_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3i32));
        check_float_array_equality(&result, &[16.0]).map_err(|e| crate::cpu::with_call(e, "svscale_n_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svscale_n_f32_z(create_svbool_t(), create_random_svfloat32_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svscale_n_f32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svscale_n_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svscale_f64_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svscale_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svint64_t_from(3i64)));
        check_float_array_equality(&result, &[16.0]).map_err(|e| crate::cpu::with_call(e, "svscale_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svint64_t_from(3i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svscale_f64_m(create_svbool_t(), create_random_svfloat64_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svscale_f64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svscale_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svscale_n_f64_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svscale_n_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3i64));
        check_float_array_equality(&result, &[16.0]).map_err(|e| crate::cpu::with_call(e, "svscale_n_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svscale_n_f64_m(create_svbool_t(), create_random_svfloat64_t(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svscale_n_f64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svscale_n_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svscale_f64_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svscale_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svint64_t_from(3i64)));
        check_float_array_equality(&result, &[16.0]).map_err(|e| crate::cpu::with_call(e, "svscale_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svint64_t_from(3i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svscale_f64_x(create_svbool_t(), create_random_svfloat64_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svscale_f64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svscale_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svscale_n_f64_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svscale_n_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3i64));
        check_float_array_equality(&result, &[16.0]).map_err(|e| crate::cpu::with_call(e, "svscale_n_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svscale_n_f64_x(create_svbool_t(), create_random_svfloat64_t(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svscale_n_f64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svscale_n_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svscale_f64_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svscale_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svint64_t_from(3i64)));
        check_float_array_equality(&result, &[16.0]).map_err(|e| crate::cpu::with_call(e, "svscale_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svint64_t_from(3i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svscale_f64_z(create_svbool_t(), create_random_svfloat64_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svscale_f64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svscale_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svscale_n_f64_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svscale_n_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3i64));
        check_float_array_equality(&result, &[16.0]).map_err(|e| crate::cpu::with_call(e, "svscale_n_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svscale_n_f64_z(create_svbool_t(), create_random_svfloat64_t(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svscale_n_f64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svscale_n_f64_z_impl() }
}
