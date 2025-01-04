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
fn test_aarch64_sve_svcls_s8_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svcls_s8_m(create_svuint8_t_from(1u8), create_svbool_t(), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[5]).map_err(|e| crate::cpu::with_call(e, "svcls_s8_m(create_svuint8_t_from(1u8), create_svbool_t(), create_svint8_t_from(3i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcls_s8_m(create_random_svuint8_t(), create_svbool_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcls_s8_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcls_s8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcls_s8_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svcls_s8_x(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[5]).map_err(|e| crate::cpu::with_call(e, "svcls_s8_x(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcls_s8_x(create_svbool_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcls_s8_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcls_s8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcls_s8_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svcls_s8_z(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[5]).map_err(|e| crate::cpu::with_call(e, "svcls_s8_z(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcls_s8_z(create_svbool_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcls_s8_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcls_s8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcls_s16_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svcls_s16_m(create_svuint16_t_from(1u16), create_svbool_t(), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[13]).map_err(|e| crate::cpu::with_call(e, "svcls_s16_m(create_svuint16_t_from(1u16), create_svbool_t(), create_svint16_t_from(3i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcls_s16_m(create_random_svuint16_t(), create_svbool_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcls_s16_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcls_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcls_s16_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svcls_s16_x(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[13]).map_err(|e| crate::cpu::with_call(e, "svcls_s16_x(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcls_s16_x(create_svbool_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcls_s16_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcls_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcls_s16_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svcls_s16_z(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[13]).map_err(|e| crate::cpu::with_call(e, "svcls_s16_z(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcls_s16_z(create_svbool_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcls_s16_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcls_s16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcls_s32_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svcls_s32_m(create_svuint32_t_from(1u32), create_svbool_t(), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[29]).map_err(|e| crate::cpu::with_call(e, "svcls_s32_m(create_svuint32_t_from(1u32), create_svbool_t(), create_svint32_t_from(3i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcls_s32_m(create_random_svuint32_t(), create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcls_s32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcls_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcls_s32_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svcls_s32_x(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[29]).map_err(|e| crate::cpu::with_call(e, "svcls_s32_x(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcls_s32_x(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcls_s32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcls_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcls_s32_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svcls_s32_z(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[29]).map_err(|e| crate::cpu::with_call(e, "svcls_s32_z(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcls_s32_z(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcls_s32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcls_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcls_s64_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svcls_s64_m(create_svuint64_t_from(1u64), create_svbool_t(), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[61]).map_err(|e| crate::cpu::with_call(e, "svcls_s64_m(create_svuint64_t_from(1u64), create_svbool_t(), create_svint64_t_from(3i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcls_s64_m(create_random_svuint64_t(), create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcls_s64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcls_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcls_s64_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svcls_s64_x(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[61]).map_err(|e| crate::cpu::with_call(e, "svcls_s64_x(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcls_s64_x(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcls_s64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcls_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svcls_s64_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svcls_s64_z(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[61]).map_err(|e| crate::cpu::with_call(e, "svcls_s64_z(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcls_s64_z(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svcls_s64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svcls_s64_z_impl() }
}
