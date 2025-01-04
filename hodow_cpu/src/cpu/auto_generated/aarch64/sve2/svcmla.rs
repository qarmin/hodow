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
fn test_aarch64_sve2_svcmla_lane_s16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svcmla_lane_s16::<0, 0>(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svcmla_lane_s16::<0, 0>(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmla_lane_s16::<0, 0>(create_random_svint16_t(), create_random_svint16_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcmla_lane_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcmla_lane_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcmla_lane_s32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svcmla_lane_s32::<0, 0>(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svcmla_lane_s32::<0, 0>(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmla_lane_s32::<0, 0>(create_random_svint32_t(), create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcmla_lane_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcmla_lane_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcmla_lane_u16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svcmla_lane_u16::<0, 0>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svcmla_lane_u16::<0, 0>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmla_lane_u16::<0, 0>(create_random_svuint16_t(), create_random_svuint16_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcmla_lane_u16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcmla_lane_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcmla_lane_u32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svcmla_lane_u32::<0, 0>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svcmla_lane_u32::<0, 0>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmla_lane_u32::<0, 0>(create_random_svuint32_t(), create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcmla_lane_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcmla_lane_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcmla_s8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svcmla_s8::<0>(create_svint8_t_from(1i8), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svcmla_s8::<0>(create_svint8_t_from(1i8), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmla_s8::<0>(create_random_svint8_t(), create_random_svint8_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcmla_s8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcmla_s8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcmla_s8_imm_270_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint8_t_to_i8_array(svcmla_s8::<270>(create_svint8_t_from(1i8), create_svint8_t_from(2i8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[-5]).map_err(|e| crate::cpu::with_call(e, "svcmla_s8::<270>(create_svint8_t_from(1i8), create_svint8_t_from(2i8), create_svint8_t_from(3i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmla_s8::<270>(create_random_svint8_t(), create_random_svint8_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcmla_s8_imm_270() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcmla_s8_imm_270_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcmla_s16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svcmla_s16::<0>(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svcmla_s16::<0>(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmla_s16::<0>(create_random_svint16_t(), create_random_svint16_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcmla_s16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcmla_s16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcmla_s16_imm_270_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint16_t_to_i16_array(svcmla_s16::<270>(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16)));
        check_array_equality(&result, &[-5]).map_err(|e| crate::cpu::with_call(e, "svcmla_s16::<270>(create_svint16_t_from(1i16), create_svint16_t_from(2i16), create_svint16_t_from(3i16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmla_s16::<270>(create_random_svint16_t(), create_random_svint16_t(), create_random_svint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcmla_s16_imm_270() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcmla_s16_imm_270_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcmla_s32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svcmla_s32::<0>(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svcmla_s32::<0>(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmla_s32::<0>(create_random_svint32_t(), create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcmla_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcmla_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcmla_s32_imm_270_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svcmla_s32::<270>(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32)));
        check_array_equality(&result, &[-5]).map_err(|e| crate::cpu::with_call(e, "svcmla_s32::<270>(create_svint32_t_from(1i32), create_svint32_t_from(2i32), create_svint32_t_from(3i32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmla_s32::<270>(create_random_svint32_t(), create_random_svint32_t(), create_random_svint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcmla_s32_imm_270() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcmla_s32_imm_270_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcmla_s64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svcmla_s64::<0>(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svcmla_s64::<0>(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmla_s64::<0>(create_random_svint64_t(), create_random_svint64_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcmla_s64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcmla_s64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcmla_s64_imm_270_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svint64_t_to_i64_array(svcmla_s64::<270>(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svint64_t_from(3i64)));
        check_array_equality(&result, &[-5]).map_err(|e| crate::cpu::with_call(e, "svcmla_s64::<270>(create_svint64_t_from(1i64), create_svint64_t_from(2i64), create_svint64_t_from(3i64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmla_s64::<270>(create_random_svint64_t(), create_random_svint64_t(), create_random_svint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcmla_s64_imm_270() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcmla_s64_imm_270_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcmla_u8_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svcmla_u8::<0>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svcmla_u8::<0>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmla_u8::<0>(create_random_svuint8_t(), create_random_svuint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcmla_u8() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcmla_u8_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcmla_u8_imm_270_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint8_t_to_u8_array(svcmla_u8::<270>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[251]).map_err(|e| crate::cpu::with_call(e, "svcmla_u8::<270>(create_svuint8_t_from(1u8), create_svuint8_t_from(2u8), create_svuint8_t_from(3u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmla_u8::<270>(create_random_svuint8_t(), create_random_svuint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcmla_u8_imm_270() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcmla_u8_imm_270_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcmla_u16_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svcmla_u16::<0>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svcmla_u16::<0>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmla_u16::<0>(create_random_svuint16_t(), create_random_svuint16_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcmla_u16() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcmla_u16_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcmla_u16_imm_270_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint16_t_to_u16_array(svcmla_u16::<270>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16)));
        check_array_equality(&result, &[65531]).map_err(|e| crate::cpu::with_call(e, "svcmla_u16::<270>(create_svuint16_t_from(1u16), create_svuint16_t_from(2u16), create_svuint16_t_from(3u16))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmla_u16::<270>(create_random_svuint16_t(), create_random_svuint16_t(), create_random_svuint16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcmla_u16_imm_270() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcmla_u16_imm_270_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcmla_u32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svcmla_u32::<0>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svcmla_u32::<0>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmla_u32::<0>(create_random_svuint32_t(), create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcmla_u32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcmla_u32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcmla_u32_imm_270_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint32_t_to_u32_array(svcmla_u32::<270>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32)));
        check_array_equality(&result, &[4294967291]).map_err(|e| crate::cpu::with_call(e, "svcmla_u32::<270>(create_svuint32_t_from(1u32), create_svuint32_t_from(2u32), create_svuint32_t_from(3u32))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmla_u32::<270>(create_random_svuint32_t(), create_random_svuint32_t(), create_random_svuint32_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcmla_u32_imm_270() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcmla_u32_imm_270_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcmla_u64_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svcmla_u64::<0>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[7]).map_err(|e| crate::cpu::with_call(e, "svcmla_u64::<0>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmla_u64::<0>(create_random_svuint64_t(), create_random_svuint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcmla_u64() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcmla_u64_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve2_svcmla_u64_imm_270_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("sve")) {
            return Ok(Verdict::Skipped("sve not present"));
        }
    unsafe {
        let result = unpack_svuint64_t_to_u64_array(svcmla_u64::<270>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64)));
        check_array_equality(&result, &[18446744073709551611]).map_err(|e| crate::cpu::with_call(e, "svcmla_u64::<270>(create_svuint64_t_from(1u64), create_svuint64_t_from(2u64), create_svuint64_t_from(3u64))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svcmla_u64::<270>(create_random_svuint64_t(), create_random_svuint64_t(), create_random_svuint64_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve2_svcmla_u64_imm_270() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve2_svcmla_u64_imm_270_impl() }
}
