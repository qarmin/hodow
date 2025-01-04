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
fn test_aarch64_sve2_svcadd_s8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svcadd_s8::<90>(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svcadd_s8::<90>(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcadd_s8::<90>(create_random_svint8_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcadd_s8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcadd_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcadd_s8_imm_270_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svcadd_s8::<270>(create_svint8_t_from(1i8), create_svint8_t_from(2i8)));
        check_array_equality(&result, &[-1]).map_err(|e| crate::cpu::with_call(e, "svcadd_s8::<270>(create_svint8_t_from(1i8), create_svint8_t_from(2i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcadd_s8::<270>(create_random_svint8_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcadd_s8_imm_270() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcadd_s8_imm_270_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcadd_s16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svcadd_s16::<90>(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svcadd_s16::<90>(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcadd_s16::<90>(create_random_svint16_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcadd_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcadd_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcadd_s16_imm_270_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svcadd_s16::<270>(create_svint16_t_from(1i16), create_svint16_t_from(2i16)));
        check_array_equality(&result, &[-1]).map_err(|e| crate::cpu::with_call(e, "svcadd_s16::<270>(create_svint16_t_from(1i16), create_svint16_t_from(2i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcadd_s16::<270>(create_random_svint16_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcadd_s16_imm_270() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcadd_s16_imm_270_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcadd_s32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svcadd_s32::<90>(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svcadd_s32::<90>(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcadd_s32::<90>(create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcadd_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcadd_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcadd_s32_imm_270_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svcadd_s32::<270>(create_svint32_t_from(1i32), create_svint32_t_from(2i32)));
        check_array_equality(&result, &[-1]).map_err(|e| crate::cpu::with_call(e, "svcadd_s32::<270>(create_svint32_t_from(1i32), create_svint32_t_from(2i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcadd_s32::<270>(create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcadd_s32_imm_270() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcadd_s32_imm_270_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcadd_s64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svcadd_s64::<90>(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svcadd_s64::<90>(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcadd_s64::<90>(create_random_svint64_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcadd_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcadd_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcadd_s64_imm_270_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svcadd_s64::<270>(create_svint64_t_from(1i64), create_svint64_t_from(2i64)));
        check_array_equality(&result, &[-1]).map_err(|e| crate::cpu::with_call(e, "svcadd_s64::<270>(create_svint64_t_from(1i64), create_svint64_t_from(2i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcadd_s64::<270>(create_random_svint64_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcadd_s64_imm_270() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcadd_s64_imm_270_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcadd_u8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svcadd_u8::<90>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svcadd_u8::<90>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcadd_u8::<90>(create_random_svuint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcadd_u8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcadd_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcadd_u8_imm_270_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svcadd_u8::<270>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8)));
        check_array_equality(&result, &[255]).map_err(|e| crate::cpu::with_call(e, "svcadd_u8::<270>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcadd_u8::<270>(create_random_svuint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcadd_u8_imm_270() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcadd_u8_imm_270_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcadd_u16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svcadd_u16::<90>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svcadd_u16::<90>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcadd_u16::<90>(create_random_svuint16_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcadd_u16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcadd_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcadd_u16_imm_270_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svcadd_u16::<270>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16)));
        check_array_equality(&result, &[65535]).map_err(|e| crate::cpu::with_call(e, "svcadd_u16::<270>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcadd_u16::<270>(create_random_svuint16_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcadd_u16_imm_270() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcadd_u16_imm_270_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcadd_u32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svcadd_u32::<90>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svcadd_u32::<90>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcadd_u32::<90>(create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcadd_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcadd_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcadd_u32_imm_270_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svcadd_u32::<270>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32)));
        check_array_equality(&result, &[4294967295]).map_err(|e| crate::cpu::with_call(e, "svcadd_u32::<270>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcadd_u32::<270>(create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcadd_u32_imm_270() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcadd_u32_imm_270_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcadd_u64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svcadd_u64::<90>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "svcadd_u64::<90>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcadd_u64::<90>(create_random_svuint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcadd_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcadd_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcadd_u64_imm_270_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svcadd_u64::<270>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64)));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "svcadd_u64::<270>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcadd_u64::<270>(create_random_svuint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcadd_u64_imm_270() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcadd_u64_imm_270_impl() }
}
