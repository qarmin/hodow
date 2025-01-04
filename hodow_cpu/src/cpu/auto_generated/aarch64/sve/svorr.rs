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
fn test_aarch64_sve_svorr_b_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svbool_t_to_i32_array(svorr_b_z(create_svbool_t(), create_svbool_t(), create_svbool_t()));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "svorr_b_z(create_svbool_t(), create_svbool_t(), create_svbool_t())"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_b_z(create_svbool_t(), create_svbool_t(), create_svbool_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_b_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_b_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_s8_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svorr_s8_m(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_s8_m(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_s8_m(create_svbool_t(), create_random_svint8_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_s8_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_s8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_n_s8_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svorr_n_s8_m(create_svbool_t(), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_n_s8_m(create_svbool_t(), create_svint8_t_from(2i8), 3i8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_n_s8_m(create_svbool_t(), create_random_svint8_t(), rand::random::<i8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_n_s8_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_n_s8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_s8_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svorr_s8_x(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_s8_x(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_s8_x(create_svbool_t(), create_random_svint8_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_s8_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_s8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_n_s8_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svorr_n_s8_x(create_svbool_t(), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_n_s8_x(create_svbool_t(), create_svint8_t_from(2i8), 3i8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_n_s8_x(create_svbool_t(), create_random_svint8_t(), rand::random::<i8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_n_s8_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_n_s8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_s8_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svorr_s8_z(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_s8_z(create_svbool_t(), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_s8_z(create_svbool_t(), create_random_svint8_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_s8_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_s8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_n_s8_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svorr_n_s8_z(create_svbool_t(), create_svint8_t_from(2i8), 3i8));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_n_s8_z(create_svbool_t(), create_svint8_t_from(2i8), 3i8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_n_s8_z(create_svbool_t(), create_random_svint8_t(), rand::random::<i8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_n_s8_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_n_s8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_s16_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svorr_s16_m(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_s16_m(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_s16_m(create_svbool_t(), create_random_svint16_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_s16_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_n_s16_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svorr_n_s16_m(create_svbool_t(), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_n_s16_m(create_svbool_t(), create_svint16_t_from(2i16), 3i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_n_s16_m(create_svbool_t(), create_random_svint16_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_n_s16_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_n_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_s16_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svorr_s16_x(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_s16_x(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_s16_x(create_svbool_t(), create_random_svint16_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_s16_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_n_s16_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svorr_n_s16_x(create_svbool_t(), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_n_s16_x(create_svbool_t(), create_svint16_t_from(2i16), 3i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_n_s16_x(create_svbool_t(), create_random_svint16_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_n_s16_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_n_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_s16_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svorr_s16_z(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_s16_z(create_svbool_t(), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_s16_z(create_svbool_t(), create_random_svint16_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_s16_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_s16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_n_s16_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svorr_n_s16_z(create_svbool_t(), create_svint16_t_from(2i16), 3i16));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_n_s16_z(create_svbool_t(), create_svint16_t_from(2i16), 3i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_n_s16_z(create_svbool_t(), create_random_svint16_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_n_s16_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_n_s16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_s32_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svorr_s32_m(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_s32_m(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_s32_m(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_s32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_n_s32_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svorr_n_s32_m(create_svbool_t(), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_n_s32_m(create_svbool_t(), create_svint32_t_from(2i32), 3i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_n_s32_m(create_svbool_t(), create_random_svint32_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_n_s32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_n_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_s32_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svorr_s32_x(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_s32_x(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_s32_x(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_s32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_n_s32_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svorr_n_s32_x(create_svbool_t(), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_n_s32_x(create_svbool_t(), create_svint32_t_from(2i32), 3i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_n_s32_x(create_svbool_t(), create_random_svint32_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_n_s32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_n_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_s32_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svorr_s32_z(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_s32_z(create_svbool_t(), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_s32_z(create_svbool_t(), create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_s32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_n_s32_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svorr_n_s32_z(create_svbool_t(), create_svint32_t_from(2i32), 3i32));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_n_s32_z(create_svbool_t(), create_svint32_t_from(2i32), 3i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_n_s32_z(create_svbool_t(), create_random_svint32_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_n_s32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_n_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_s64_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svorr_s64_m(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_s64_m(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_s64_m(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_s64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_n_s64_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svorr_n_s64_m(create_svbool_t(), create_svint64_t_from(2i64), 3i64));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_n_s64_m(create_svbool_t(), create_svint64_t_from(2i64), 3i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_n_s64_m(create_svbool_t(), create_random_svint64_t(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_n_s64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_n_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_s64_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svorr_s64_x(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_s64_x(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_s64_x(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_s64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_n_s64_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svorr_n_s64_x(create_svbool_t(), create_svint64_t_from(2i64), 3i64));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_n_s64_x(create_svbool_t(), create_svint64_t_from(2i64), 3i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_n_s64_x(create_svbool_t(), create_random_svint64_t(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_n_s64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_n_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_s64_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svorr_s64_z(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_s64_z(create_svbool_t(), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_s64_z(create_svbool_t(), create_random_svint64_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_s64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_s64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_n_s64_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svorr_n_s64_z(create_svbool_t(), create_svint64_t_from(2i64), 3i64));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_n_s64_z(create_svbool_t(), create_svint64_t_from(2i64), 3i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_n_s64_z(create_svbool_t(), create_random_svint64_t(), rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_n_s64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_n_s64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_u8_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svorr_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_u8_m(create_svbool_t(), create_random_svuint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_u8_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_u8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_n_u8_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svorr_n_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), 3u8));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_n_u8_m(create_svbool_t(), create_svuint8_t_from(2u8), 3u8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_n_u8_m(create_svbool_t(), create_random_svuint8_t(), rand::random::<u8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_n_u8_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_n_u8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_u8_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svorr_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_u8_x(create_svbool_t(), create_random_svuint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_u8_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_u8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_n_u8_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svorr_n_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), 3u8));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_n_u8_x(create_svbool_t(), create_svuint8_t_from(2u8), 3u8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_n_u8_x(create_svbool_t(), create_random_svuint8_t(), rand::random::<u8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_n_u8_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_n_u8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_u8_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svorr_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_u8_z(create_svbool_t(), create_random_svuint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_u8_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_u8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_n_u8_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svorr_n_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), 3u8));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_n_u8_z(create_svbool_t(), create_svuint8_t_from(2u8), 3u8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_n_u8_z(create_svbool_t(), create_random_svuint8_t(), rand::random::<u8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_n_u8_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_n_u8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_u16_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svorr_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_u16_m(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_u16_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_u16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_n_u16_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svorr_n_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_n_u16_m(create_svbool_t(), create_svuint16_t_from(2u16), 3u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_n_u16_m(create_svbool_t(), create_random_svuint16_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_n_u16_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_n_u16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_u16_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svorr_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_u16_x(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_u16_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_n_u16_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svorr_n_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_n_u16_x(create_svbool_t(), create_svuint16_t_from(2u16), 3u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_n_u16_x(create_svbool_t(), create_random_svuint16_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_n_u16_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_n_u16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_u16_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svorr_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_u16_z(create_svbool_t(), create_random_svuint16_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_u16_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_u16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_n_u16_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svorr_n_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), 3u16));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_n_u16_z(create_svbool_t(), create_svuint16_t_from(2u16), 3u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_n_u16_z(create_svbool_t(), create_random_svuint16_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_n_u16_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_n_u16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_u32_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svorr_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_u32_m(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_u32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_n_u32_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svorr_n_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_n_u32_m(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_n_u32_m(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_n_u32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_n_u32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_u32_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svorr_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_u32_x(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_u32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_n_u32_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svorr_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_n_u32_x(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_n_u32_x(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_n_u32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_n_u32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_u32_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svorr_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_u32_z(create_svbool_t(), create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_u32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_n_u32_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svorr_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), 3u32));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_n_u32_z(create_svbool_t(), create_svuint32_t_from(2u32), 3u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_n_u32_z(create_svbool_t(), create_random_svuint32_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_n_u32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_n_u32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_u64_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svorr_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_u64_m(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_u64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_n_u64_m_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svorr_n_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_n_u64_m(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_n_u64_m(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_n_u64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_n_u64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_u64_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svorr_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_u64_x(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_u64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_n_u64_x_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svorr_n_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_n_u64_x(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_n_u64_x(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_n_u64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_n_u64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_u64_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svorr_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_u64_z(create_svbool_t(), create_random_svuint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_u64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_u64_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svorr_n_u64_z_impl() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svorr_n_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), 3u64));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svorr_n_u64_z(create_svbool_t(), create_svuint64_t_from(2u64), 3u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svorr_n_u64_z(create_svbool_t(), create_random_svuint64_t(), rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svorr_n_u64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svorr_n_u64_z_impl() }
}
