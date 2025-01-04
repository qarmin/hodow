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
fn test_aarch64_sve_svnmla_f32_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svnmla_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32)));
        check_float_array_equality(&result, &[-14.0]).map_err(|e| crate::cpu::with_call(e, "svnmla_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svnmla_f32_m(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svnmla_f32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svnmla_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmla_n_f32_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svnmla_n_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32));
        check_float_array_equality(&result, &[-14.0]).map_err(|e| crate::cpu::with_call(e, "svnmla_n_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svnmla_n_f32_m(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svnmla_n_f32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svnmla_n_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmla_f32_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svnmla_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32)));
        check_float_array_equality(&result, &[-14.0]).map_err(|e| crate::cpu::with_call(e, "svnmla_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svnmla_f32_x(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svnmla_f32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svnmla_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmla_n_f32_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svnmla_n_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32));
        check_float_array_equality(&result, &[-14.0]).map_err(|e| crate::cpu::with_call(e, "svnmla_n_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svnmla_n_f32_x(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svnmla_n_f32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svnmla_n_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmla_f32_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svnmla_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32)));
        check_float_array_equality(&result, &[-14.0]).map_err(|e| crate::cpu::with_call(e, "svnmla_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), create_svfloat32_t_from(4.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svnmla_f32_z(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svnmla_f32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svnmla_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmla_n_f32_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svnmla_n_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32));
        check_float_array_equality(&result, &[-14.0]).map_err(|e| crate::cpu::with_call(e, "svnmla_n_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32), 4.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svnmla_n_f32_z(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t(), rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svnmla_n_f32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svnmla_n_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmla_f64_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svnmla_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64)));
        check_float_array_equality(&result, &[-14.0]).map_err(|e| crate::cpu::with_call(e, "svnmla_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svnmla_f64_m(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svnmla_f64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svnmla_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmla_n_f64_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svnmla_n_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), 4.0f64));
        check_float_array_equality(&result, &[-14.0]).map_err(|e| crate::cpu::with_call(e, "svnmla_n_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), 4.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svnmla_n_f64_m(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svnmla_n_f64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svnmla_n_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmla_f64_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svnmla_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64)));
        check_float_array_equality(&result, &[-14.0]).map_err(|e| crate::cpu::with_call(e, "svnmla_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svnmla_f64_x(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svnmla_f64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svnmla_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmla_n_f64_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svnmla_n_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), 4.0f64));
        check_float_array_equality(&result, &[-14.0]).map_err(|e| crate::cpu::with_call(e, "svnmla_n_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), 4.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svnmla_n_f64_x(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svnmla_n_f64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svnmla_n_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmla_f64_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svnmla_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64)));
        check_float_array_equality(&result, &[-14.0]).map_err(|e| crate::cpu::with_call(e, "svnmla_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), create_svfloat64_t_from(4.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svnmla_f64_z(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svnmla_f64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svnmla_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svnmla_n_f64_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svnmla_n_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), 4.0f64));
        check_float_array_equality(&result, &[-14.0]).map_err(|e| crate::cpu::with_call(e, "svnmla_n_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64), 4.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svnmla_n_f64_z(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t(), rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svnmla_n_f64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svnmla_n_f64_z_impl() }
}
