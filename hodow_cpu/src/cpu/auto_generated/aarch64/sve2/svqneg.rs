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
fn test_aarch64_sve2_svqneg_s8_m_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqneg_s8_m(create_svint8_t_from(1i8), create_svbool_t(), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[-3]).map_err(|e| crate::cpu::with_call(e, "svqneg_s8_m(create_svint8_t_from(1i8), create_svbool_t(), create_svint8_t_from(3i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqneg_s8_m(create_random_svint8_t(), create_svbool_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqneg_s8_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqneg_s8_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqneg_s8_x_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqneg_s8_x(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[-2]).map_err(|e| crate::cpu::with_call(e, "svqneg_s8_x(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqneg_s8_x(create_svbool_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqneg_s8_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqneg_s8_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqneg_s8_z_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svqneg_s8_z(create_svbool_t(), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[-2]).map_err(|e| crate::cpu::with_call(e, "svqneg_s8_z(create_svbool_t(), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqneg_s8_z(create_svbool_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqneg_s8_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqneg_s8_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqneg_s16_m_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqneg_s16_m(create_svint16_t_from(1i16), create_svbool_t(), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[-3]).map_err(|e| crate::cpu::with_call(e, "svqneg_s16_m(create_svint16_t_from(1i16), create_svbool_t(), create_svint16_t_from(3i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqneg_s16_m(create_random_svint16_t(), create_svbool_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqneg_s16_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqneg_s16_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqneg_s16_x_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqneg_s16_x(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[-2]).map_err(|e| crate::cpu::with_call(e, "svqneg_s16_x(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqneg_s16_x(create_svbool_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqneg_s16_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqneg_s16_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqneg_s16_z_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svqneg_s16_z(create_svbool_t(), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[-2]).map_err(|e| crate::cpu::with_call(e, "svqneg_s16_z(create_svbool_t(), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqneg_s16_z(create_svbool_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqneg_s16_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqneg_s16_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqneg_s32_m_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqneg_s32_m(create_svint32_t_from(1i32), create_svbool_t(), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[-3]).map_err(|e| crate::cpu::with_call(e, "svqneg_s32_m(create_svint32_t_from(1i32), create_svbool_t(), create_svint32_t_from(3i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqneg_s32_m(create_random_svint32_t(), create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqneg_s32_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqneg_s32_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqneg_s32_x_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqneg_s32_x(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[-2]).map_err(|e| crate::cpu::with_call(e, "svqneg_s32_x(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqneg_s32_x(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqneg_s32_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqneg_s32_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqneg_s32_z_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svqneg_s32_z(create_svbool_t(), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[-2]).map_err(|e| crate::cpu::with_call(e, "svqneg_s32_z(create_svbool_t(), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqneg_s32_z(create_svbool_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqneg_s32_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqneg_s32_z_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqneg_s64_m_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqneg_s64_m(create_svint64_t_from(1i64), create_svbool_t(), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[-3]).map_err(|e| crate::cpu::with_call(e, "svqneg_s64_m(create_svint64_t_from(1i64), create_svbool_t(), create_svint64_t_from(3i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqneg_s64_m(create_random_svint64_t(), create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqneg_s64_m() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqneg_s64_m_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqneg_s64_x_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqneg_s64_x(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[-2]).map_err(|e| crate::cpu::with_call(e, "svqneg_s64_x(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqneg_s64_x(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqneg_s64_x() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqneg_s64_x_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svqneg_s64_z_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svqneg_s64_z(create_svbool_t(), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[-2]).map_err(|e| crate::cpu::with_call(e, "svqneg_s64_z(create_svbool_t(), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svqneg_s64_z(create_svbool_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svqneg_s64_z() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svqneg_s64_z_impl() }
}
