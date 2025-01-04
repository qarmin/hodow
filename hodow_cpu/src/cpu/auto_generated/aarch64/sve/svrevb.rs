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
fn test_aarch64_sve_svrevb_s16_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svrevb_s16_m(create_svint16_t_from(1i16), create_svbool_t(), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[768]).map_err(|e| crate::cpu::with_call(e, "svrevb_s16_m(create_svint16_t_from(1i16), create_svbool_t(), create_svint16_t_from(3i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrevb_s16_m(create_random_svint16_t(), create_svbool_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrevb_s16_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrevb_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevb_s16_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svrevb_s16_x(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[512]).map_err(|e| crate::cpu::with_call(e, "svrevb_s16_x(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrevb_s16_x(create_svbool_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrevb_s16_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrevb_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevb_s16_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svrevb_s16_z(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[512]).map_err(|e| crate::cpu::with_call(e, "svrevb_s16_z(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrevb_s16_z(create_svbool_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrevb_s16_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrevb_s16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevb_s32_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svrevb_s32_m(create_svint32_t_from(1i32), create_svbool_t(), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[50331648]).map_err(|e| crate::cpu::with_call(e, "svrevb_s32_m(create_svint32_t_from(1i32), create_svbool_t(), create_svint32_t_from(3i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrevb_s32_m(create_random_svint32_t(), create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrevb_s32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrevb_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevb_s32_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svrevb_s32_x(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[33554432]).map_err(|e| crate::cpu::with_call(e, "svrevb_s32_x(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrevb_s32_x(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrevb_s32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrevb_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevb_s32_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svrevb_s32_z(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[33554432]).map_err(|e| crate::cpu::with_call(e, "svrevb_s32_z(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrevb_s32_z(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrevb_s32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrevb_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevb_s64_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svrevb_s64_m(create_svint64_t_from(1i64), create_svbool_t(), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[216172782113783808]).map_err(|e| crate::cpu::with_call(e, "svrevb_s64_m(create_svint64_t_from(1i64), create_svbool_t(), create_svint64_t_from(3i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrevb_s64_m(create_random_svint64_t(), create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrevb_s64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrevb_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevb_s64_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svrevb_s64_x(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[144115188075855872]).map_err(|e| crate::cpu::with_call(e, "svrevb_s64_x(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrevb_s64_x(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrevb_s64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrevb_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevb_s64_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svrevb_s64_z(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[144115188075855872]).map_err(|e| crate::cpu::with_call(e, "svrevb_s64_z(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrevb_s64_z(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrevb_s64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrevb_s64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevb_u16_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svrevb_u16_m(create_svuint16_t_from(1u16), create_svbool_t(), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[768]).map_err(|e| crate::cpu::with_call(e, "svrevb_u16_m(create_svuint16_t_from(1u16), create_svbool_t(), create_svuint16_t_from(3u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrevb_u16_m(create_random_svuint16_t(), create_svbool_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrevb_u16_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrevb_u16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevb_u16_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svrevb_u16_x(create_svbool_t(), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[512]).map_err(|e| crate::cpu::with_call(e, "svrevb_u16_x(create_svbool_t(), create_svuint16_t_from(2u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrevb_u16_x(create_svbool_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrevb_u16_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrevb_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevb_u16_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svrevb_u16_z(create_svbool_t(), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[512]).map_err(|e| crate::cpu::with_call(e, "svrevb_u16_z(create_svbool_t(), create_svuint16_t_from(2u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrevb_u16_z(create_svbool_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrevb_u16_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrevb_u16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevb_u32_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svrevb_u32_m(create_svuint32_t_from(1u32), create_svbool_t(), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[50331648]).map_err(|e| crate::cpu::with_call(e, "svrevb_u32_m(create_svuint32_t_from(1u32), create_svbool_t(), create_svuint32_t_from(3u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrevb_u32_m(create_random_svuint32_t(), create_svbool_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrevb_u32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrevb_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevb_u32_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svrevb_u32_x(create_svbool_t(), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[33554432]).map_err(|e| crate::cpu::with_call(e, "svrevb_u32_x(create_svbool_t(), create_svuint32_t_from(2u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrevb_u32_x(create_svbool_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrevb_u32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrevb_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevb_u32_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svrevb_u32_z(create_svbool_t(), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[33554432]).map_err(|e| crate::cpu::with_call(e, "svrevb_u32_z(create_svbool_t(), create_svuint32_t_from(2u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrevb_u32_z(create_svbool_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrevb_u32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrevb_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevb_u64_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svrevb_u64_m(create_svuint64_t_from(1u64), create_svbool_t(), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[216172782113783808]).map_err(|e| crate::cpu::with_call(e, "svrevb_u64_m(create_svuint64_t_from(1u64), create_svbool_t(), create_svuint64_t_from(3u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrevb_u64_m(create_random_svuint64_t(), create_svbool_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrevb_u64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrevb_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevb_u64_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svrevb_u64_x(create_svbool_t(), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[144115188075855872]).map_err(|e| crate::cpu::with_call(e, "svrevb_u64_x(create_svbool_t(), create_svuint64_t_from(2u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrevb_u64_x(create_svbool_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrevb_u64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrevb_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svrevb_u64_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svrevb_u64_z(create_svbool_t(), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[144115188075855872]).map_err(|e| crate::cpu::with_call(e, "svrevb_u64_z(create_svbool_t(), create_svuint64_t_from(2u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svrevb_u64_z(create_svbool_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svrevb_u64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svrevb_u64_z_impl() }
}
