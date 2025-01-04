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
fn test_aarch64_sve_svcvt_f32_f64_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcvt_f32_f64_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat64_t_from(3.0f64)));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "svcvt_f32_f64_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svfloat64_t_from(3.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_f32_f64_m(create_random_svfloat32_t(), create_svbool_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_f32_f64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_f32_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_f32_f64_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcvt_f32_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "svcvt_f32_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_f32_f64_x(create_svbool_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_f32_f64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_f32_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_f32_f64_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcvt_f32_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "svcvt_f32_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_f32_f64_z(create_svbool_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_f32_f64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_f32_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_f64_f32_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svcvt_f64_f32_m(create_svfloat64_t_from(1.0f64), create_svbool_t(), create_svfloat32_t_from(3.0f32)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| crate::cpu::with_call(e, "svcvt_f64_f32_m(create_svfloat64_t_from(1.0f64), create_svbool_t(), create_svfloat32_t_from(3.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_f64_f32_m(create_random_svfloat64_t(), create_svbool_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_f64_f32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_f64_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_f64_f32_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svcvt_f64_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| crate::cpu::with_call(e, "svcvt_f64_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_f64_f32_x(create_svbool_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_f64_f32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_f64_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_f64_f32_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svcvt_f64_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| crate::cpu::with_call(e, "svcvt_f64_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_f64_f32_z(create_svbool_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_f64_f32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_f64_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_f32_s32_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcvt_f32_s32_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svint32_t_from(3i32)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| crate::cpu::with_call(e, "svcvt_f32_s32_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svint32_t_from(3i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_f32_s32_m(create_random_svfloat32_t(), create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_f32_s32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_f32_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_f32_s32_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcvt_f32_s32_x(create_svbool_t(), create_svint32_t_from(2i32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| crate::cpu::with_call(e, "svcvt_f32_s32_x(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_f32_s32_x(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_f32_s32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_f32_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_f32_s32_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcvt_f32_s32_z(create_svbool_t(), create_svint32_t_from(2i32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| crate::cpu::with_call(e, "svcvt_f32_s32_z(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_f32_s32_z(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_f32_s32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_f32_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_f32_u32_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcvt_f32_u32_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svuint32_t_from(3u32)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| crate::cpu::with_call(e, "svcvt_f32_u32_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svuint32_t_from(3u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_f32_u32_m(create_random_svfloat32_t(), create_svbool_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_f32_u32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_f32_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_f32_u32_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcvt_f32_u32_x(create_svbool_t(), create_svuint32_t_from(2u32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| crate::cpu::with_call(e, "svcvt_f32_u32_x(create_svbool_t(), create_svuint32_t_from(2u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_f32_u32_x(create_svbool_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_f32_u32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_f32_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_f32_u32_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcvt_f32_u32_z(create_svbool_t(), create_svuint32_t_from(2u32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| crate::cpu::with_call(e, "svcvt_f32_u32_z(create_svbool_t(), create_svuint32_t_from(2u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_f32_u32_z(create_svbool_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_f32_u32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_f32_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_f64_s64_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svcvt_f64_s64_m(create_svfloat64_t_from(1.0f64), create_svbool_t(), create_svint64_t_from(3i64)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| crate::cpu::with_call(e, "svcvt_f64_s64_m(create_svfloat64_t_from(1.0f64), create_svbool_t(), create_svint64_t_from(3i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_f64_s64_m(create_random_svfloat64_t(), create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_f64_s64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_f64_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_f64_s64_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svcvt_f64_s64_x(create_svbool_t(), create_svint64_t_from(2i64)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| crate::cpu::with_call(e, "svcvt_f64_s64_x(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_f64_s64_x(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_f64_s64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_f64_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_f64_s64_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svcvt_f64_s64_z(create_svbool_t(), create_svint64_t_from(2i64)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| crate::cpu::with_call(e, "svcvt_f64_s64_z(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_f64_s64_z(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_f64_s64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_f64_s64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_f64_u64_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svcvt_f64_u64_m(create_svfloat64_t_from(1.0f64), create_svbool_t(), create_svuint64_t_from(3u64)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| crate::cpu::with_call(e, "svcvt_f64_u64_m(create_svfloat64_t_from(1.0f64), create_svbool_t(), create_svuint64_t_from(3u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_f64_u64_m(create_random_svfloat64_t(), create_svbool_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_f64_u64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_f64_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_f64_u64_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svcvt_f64_u64_x(create_svbool_t(), create_svuint64_t_from(2u64)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| crate::cpu::with_call(e, "svcvt_f64_u64_x(create_svbool_t(), create_svuint64_t_from(2u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_f64_u64_x(create_svbool_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_f64_u64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_f64_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_f64_u64_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svcvt_f64_u64_z(create_svbool_t(), create_svuint64_t_from(2u64)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| crate::cpu::with_call(e, "svcvt_f64_u64_z(create_svbool_t(), create_svuint64_t_from(2u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_f64_u64_z(create_svbool_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_f64_u64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_f64_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_f32_s64_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcvt_f32_s64_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svint64_t_from(3i64)));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "svcvt_f32_s64_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svint64_t_from(3i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_f32_s64_m(create_random_svfloat32_t(), create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_f32_s64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_f32_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_f32_s64_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcvt_f32_s64_x(create_svbool_t(), create_svint64_t_from(2i64)));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "svcvt_f32_s64_x(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_f32_s64_x(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_f32_s64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_f32_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_f32_s64_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcvt_f32_s64_z(create_svbool_t(), create_svint64_t_from(2i64)));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "svcvt_f32_s64_z(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_f32_s64_z(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_f32_s64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_f32_s64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_f32_u64_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcvt_f32_u64_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svuint64_t_from(3u64)));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "svcvt_f32_u64_m(create_svfloat32_t_from(1.0f32), create_svbool_t(), create_svuint64_t_from(3u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_f32_u64_m(create_random_svfloat32_t(), create_svbool_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_f32_u64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_f32_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_f32_u64_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcvt_f32_u64_x(create_svbool_t(), create_svuint64_t_from(2u64)));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "svcvt_f32_u64_x(create_svbool_t(), create_svuint64_t_from(2u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_f32_u64_x(create_svbool_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_f32_u64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_f32_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_f32_u64_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat32_t_to_f32_array(svcvt_f32_u64_z(create_svbool_t(), create_svuint64_t_from(2u64)));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "svcvt_f32_u64_z(create_svbool_t(), create_svuint64_t_from(2u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_f32_u64_z(create_svbool_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_f32_u64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_f32_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_f64_s32_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svcvt_f64_s32_m(create_svfloat64_t_from(1.0f64), create_svbool_t(), create_svint32_t_from(3i32)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| crate::cpu::with_call(e, "svcvt_f64_s32_m(create_svfloat64_t_from(1.0f64), create_svbool_t(), create_svint32_t_from(3i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_f64_s32_m(create_random_svfloat64_t(), create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_f64_s32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_f64_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_f64_s32_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svcvt_f64_s32_x(create_svbool_t(), create_svint32_t_from(2i32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| crate::cpu::with_call(e, "svcvt_f64_s32_x(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_f64_s32_x(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_f64_s32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_f64_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_f64_s32_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svcvt_f64_s32_z(create_svbool_t(), create_svint32_t_from(2i32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| crate::cpu::with_call(e, "svcvt_f64_s32_z(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_f64_s32_z(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_f64_s32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_f64_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_f64_u32_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svcvt_f64_u32_m(create_svfloat64_t_from(1.0f64), create_svbool_t(), create_svuint32_t_from(3u32)));
        check_float_array_equality(&result, &[3.0]).map_err(|e| crate::cpu::with_call(e, "svcvt_f64_u32_m(create_svfloat64_t_from(1.0f64), create_svbool_t(), create_svuint32_t_from(3u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_f64_u32_m(create_random_svfloat64_t(), create_svbool_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_f64_u32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_f64_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_f64_u32_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svcvt_f64_u32_x(create_svbool_t(), create_svuint32_t_from(2u32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| crate::cpu::with_call(e, "svcvt_f64_u32_x(create_svbool_t(), create_svuint32_t_from(2u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_f64_u32_x(create_svbool_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_f64_u32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_f64_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_f64_u32_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svfloat64_t_to_f64_array(svcvt_f64_u32_z(create_svbool_t(), create_svuint32_t_from(2u32)));
        check_float_array_equality(&result, &[2.0]).map_err(|e| crate::cpu::with_call(e, "svcvt_f64_u32_z(create_svbool_t(), create_svuint32_t_from(2u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_f64_u32_z(create_svbool_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_f64_u32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_f64_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_s32_f32_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svcvt_s32_f32_m(create_svint32_t_from(1i32), create_svbool_t(), create_svfloat32_t_from(3.0f32)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svcvt_s32_f32_m(create_svint32_t_from(1i32), create_svbool_t(), create_svfloat32_t_from(3.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_s32_f32_m(create_random_svint32_t(), create_svbool_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_s32_f32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_s32_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_s32_f32_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svcvt_s32_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svcvt_s32_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_s32_f32_x(create_svbool_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_s32_f32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_s32_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_s32_f32_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svcvt_s32_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svcvt_s32_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_s32_f32_z(create_svbool_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_s32_f32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_s32_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_s64_f64_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svcvt_s64_f64_m(create_svint64_t_from(1i64), create_svbool_t(), create_svfloat64_t_from(3.0f64)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svcvt_s64_f64_m(create_svint64_t_from(1i64), create_svbool_t(), create_svfloat64_t_from(3.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_s64_f64_m(create_random_svint64_t(), create_svbool_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_s64_f64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_s64_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_s64_f64_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svcvt_s64_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svcvt_s64_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_s64_f64_x(create_svbool_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_s64_f64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_s64_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_s64_f64_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svcvt_s64_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svcvt_s64_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_s64_f64_z(create_svbool_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_s64_f64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_s64_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_u32_f32_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svcvt_u32_f32_m(create_svuint32_t_from(1u32), create_svbool_t(), create_svfloat32_t_from(3.0f32)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svcvt_u32_f32_m(create_svuint32_t_from(1u32), create_svbool_t(), create_svfloat32_t_from(3.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_u32_f32_m(create_random_svuint32_t(), create_svbool_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_u32_f32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_u32_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_u32_f32_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svcvt_u32_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svcvt_u32_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_u32_f32_x(create_svbool_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_u32_f32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_u32_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_u32_f32_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svcvt_u32_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svcvt_u32_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_u32_f32_z(create_svbool_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_u32_f32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_u32_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_u64_f64_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svcvt_u64_f64_m(create_svuint64_t_from(1u64), create_svbool_t(), create_svfloat64_t_from(3.0f64)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svcvt_u64_f64_m(create_svuint64_t_from(1u64), create_svbool_t(), create_svfloat64_t_from(3.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_u64_f64_m(create_random_svuint64_t(), create_svbool_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_u64_f64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_u64_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_u64_f64_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svcvt_u64_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svcvt_u64_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_u64_f64_x(create_svbool_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_u64_f64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_u64_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_u64_f64_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svcvt_u64_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svcvt_u64_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_u64_f64_z(create_svbool_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_u64_f64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_u64_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_s32_f64_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svcvt_s32_f64_m(create_svint32_t_from(1i32), create_svbool_t(), create_svfloat64_t_from(3.0f64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svcvt_s32_f64_m(create_svint32_t_from(1i32), create_svbool_t(), create_svfloat64_t_from(3.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_s32_f64_m(create_random_svint32_t(), create_svbool_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_s32_f64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_s32_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_s32_f64_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svcvt_s32_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svcvt_s32_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_s32_f64_x(create_svbool_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_s32_f64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_s32_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_s32_f64_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svcvt_s32_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svcvt_s32_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_s32_f64_z(create_svbool_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_s32_f64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_s32_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_s64_f32_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svcvt_s64_f32_m(create_svint64_t_from(1i64), create_svbool_t(), create_svfloat32_t_from(3.0f32)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svcvt_s64_f32_m(create_svint64_t_from(1i64), create_svbool_t(), create_svfloat32_t_from(3.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_s64_f32_m(create_random_svint64_t(), create_svbool_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_s64_f32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_s64_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_s64_f32_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svcvt_s64_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svcvt_s64_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_s64_f32_x(create_svbool_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_s64_f32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_s64_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_s64_f32_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svcvt_s64_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svcvt_s64_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_s64_f32_z(create_svbool_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_s64_f32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_s64_f32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_u32_f64_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svcvt_u32_f64_m(create_svuint32_t_from(1u32), create_svbool_t(), create_svfloat64_t_from(3.0f64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svcvt_u32_f64_m(create_svuint32_t_from(1u32), create_svbool_t(), create_svfloat64_t_from(3.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_u32_f64_m(create_random_svuint32_t(), create_svbool_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_u32_f64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_u32_f64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_u32_f64_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svcvt_u32_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svcvt_u32_f64_x(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_u32_f64_x(create_svbool_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_u32_f64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_u32_f64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_u32_f64_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svcvt_u32_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64)));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "svcvt_u32_f64_z(create_svbool_t(), create_svfloat64_t_from(2.0f64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_u32_f64_z(create_svbool_t(), create_random_svfloat64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_u32_f64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_u32_f64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_u64_f32_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svcvt_u64_f32_m(create_svuint64_t_from(1u64), create_svbool_t(), create_svfloat32_t_from(3.0f32)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svcvt_u64_f32_m(create_svuint64_t_from(1u64), create_svbool_t(), create_svfloat32_t_from(3.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_u64_f32_m(create_random_svuint64_t(), create_svbool_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_u64_f32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_u64_f32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_u64_f32_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svcvt_u64_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svcvt_u64_f32_x(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_u64_f32_x(create_svbool_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_u64_f32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_u64_f32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcvt_u64_f32_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svcvt_u64_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32)));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "svcvt_u64_f32_z(create_svbool_t(), create_svfloat32_t_from(2.0f32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcvt_u64_f32_z(create_svbool_t(), create_random_svfloat32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcvt_u64_f32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcvt_u64_f32_z_impl() }
}
