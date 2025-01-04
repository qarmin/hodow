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
fn test_aarch64_sve_svdivr_f32_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svdivr_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[1.5]).map_err(|e| crate::cpu::with_call(e, "svdivr_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_f32_m(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_f32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdivr_n_f32_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svdivr_n_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32));
        check_float_array_equality(&result, &[1.5]).map_err(|e| crate::cpu::with_call(e, "svdivr_n_f32_m(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_n_f32_m(create_svbool_t(), create_random_svfloat32_t(), rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_n_f32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_n_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdivr_f32_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svdivr_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[1.5]).map_err(|e| crate::cpu::with_call(e, "svdivr_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_f32_x(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_f32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdivr_n_f32_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svdivr_n_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32));
        check_float_array_equality(&result, &[1.5]).map_err(|e| crate::cpu::with_call(e, "svdivr_n_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_n_f32_x(create_svbool_t(), create_random_svfloat32_t(), rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_n_f32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_n_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdivr_f32_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svdivr_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[1.5]).map_err(|e| crate::cpu::with_call(e, "svdivr_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), create_svfloat32_t_from(3.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_f32_z(create_svbool_t(), create_random_svfloat32_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_f32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdivr_n_f32_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svdivr_n_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32));
        check_float_array_equality(&result, &[1.5]).map_err(|e| crate::cpu::with_call(e, "svdivr_n_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32), 3.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_n_f32_z(create_svbool_t(), create_random_svfloat32_t(), rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_n_f32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_n_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdivr_f64_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svdivr_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[1.5]).map_err(|e| crate::cpu::with_call(e, "svdivr_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_f64_m(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_f64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdivr_n_f64_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svdivr_n_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3.0f64));
        check_float_array_equality(&result, &[1.5]).map_err(|e| crate::cpu::with_call(e, "svdivr_n_f64_m(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_n_f64_m(create_svbool_t(), create_random_svfloat64_t(), rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_n_f64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_n_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdivr_f64_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svdivr_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[1.5]).map_err(|e| crate::cpu::with_call(e, "svdivr_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_f64_x(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_f64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdivr_n_f64_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svdivr_n_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3.0f64));
        check_float_array_equality(&result, &[1.5]).map_err(|e| crate::cpu::with_call(e, "svdivr_n_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_n_f64_x(create_svbool_t(), create_random_svfloat64_t(), rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_n_f64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_n_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdivr_f64_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svdivr_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[1.5]).map_err(|e| crate::cpu::with_call(e, "svdivr_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), create_svfloat64_t_from(3.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_f64_z(create_svbool_t(), create_random_svfloat64_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_f64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdivr_n_f64_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svdivr_n_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3.0f64));
        check_float_array_equality(&result, &[1.5]).map_err(|e| crate::cpu::with_call(e, "svdivr_n_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64), 3.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_n_f64_z(create_svbool_t(), create_random_svfloat64_t(), rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_n_f64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_n_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdivr_s32_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svdivr_s32_m(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svdivr_s32_m(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_s32_m(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_s32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdivr_n_s32_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svdivr_n_s32_m(create_svbool_t(), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svdivr_n_s32_m(create_svbool_t(), create_svint32_t_from(2i32), 3i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_n_s32_m(create_svbool_t(), create_random_svint32_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_n_s32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_n_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdivr_s32_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svdivr_s32_x(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svdivr_s32_x(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_s32_x(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_s32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdivr_n_s32_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svdivr_n_s32_x(create_svbool_t(), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svdivr_n_s32_x(create_svbool_t(), create_svint32_t_from(2i32), 3i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_n_s32_x(create_svbool_t(), create_random_svint32_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_n_s32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_n_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdivr_s32_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svdivr_s32_z(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svdivr_s32_z(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_s32_z(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_s32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdivr_n_s32_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svdivr_n_s32_z(create_svbool_t(), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svdivr_n_s32_z(create_svbool_t(), create_svint32_t_from(2i32), 3i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_n_s32_z(create_svbool_t(), create_random_svint32_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_n_s32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_n_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdivr_s64_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svdivr_s64_m(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svdivr_s64_m(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_s64_m(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_s64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdivr_n_s64_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svdivr_n_s64_m(create_svbool_t(), create_svint64_t_from(2i64), 3i64));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svdivr_n_s64_m(create_svbool_t(), create_svint64_t_from(2i64), 3i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_n_s64_m(create_svbool_t(), create_random_svint64_t(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_n_s64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_n_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdivr_s64_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svdivr_s64_x(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svdivr_s64_x(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_s64_x(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_s64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdivr_n_s64_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svdivr_n_s64_x(create_svbool_t(), create_svint64_t_from(2i64), 3i64));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svdivr_n_s64_x(create_svbool_t(), create_svint64_t_from(2i64), 3i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_n_s64_x(create_svbool_t(), create_random_svint64_t(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_n_s64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_n_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdivr_s64_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svdivr_s64_z(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svdivr_s64_z(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_s64_z(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_s64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_s64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdivr_n_s64_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svdivr_n_s64_z(create_svbool_t(), create_svint64_t_from(2i64), 3i64));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svdivr_n_s64_z(create_svbool_t(), create_svint64_t_from(2i64), 3i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_n_s64_z(create_svbool_t(), create_random_svint64_t(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_n_s64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_n_s64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdivr_u32_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svdivr_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svdivr_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_u32_m(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_u32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdivr_n_u32_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svdivr_n_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svdivr_n_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_n_u32_m(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_n_u32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_n_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdivr_u32_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svdivr_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svdivr_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_u32_x(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_u32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdivr_n_u32_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svdivr_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svdivr_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_n_u32_x(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_n_u32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_n_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdivr_u32_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svdivr_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svdivr_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_u32_z(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_u32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdivr_n_u32_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svdivr_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svdivr_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_n_u32_z(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_n_u32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_n_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdivr_u64_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svdivr_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svdivr_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_u64_m(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_u64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdivr_n_u64_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svdivr_n_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svdivr_n_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_n_u64_m(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_n_u64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_n_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdivr_u64_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svdivr_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svdivr_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_u64_x(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_u64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdivr_n_u64_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svdivr_n_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svdivr_n_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_n_u64_x(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_n_u64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_n_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdivr_u64_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svdivr_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svdivr_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_u64_z(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_u64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svdivr_n_u64_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svdivr_n_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svdivr_n_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svdivr_n_u64_z(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svdivr_n_u64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svdivr_n_u64_z_impl() }
}
