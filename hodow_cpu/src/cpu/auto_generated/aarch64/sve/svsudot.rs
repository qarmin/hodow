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
fn test_aarch64_sve_svsudot_lane_s32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("i8mm")) {
            return Ok(Verdict::Skipped("i8mm not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svsudot_lane_s32::<0>(create_svint32_t_from(1i32), create_svint8_t_from(2i8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[25]).map_err(|e| crate::cpu::with_call(e, "svsudot_lane_s32::<0>(create_svint32_t_from(1i32), create_svint8_t_from(2i8), create_svuint8_t_from(3u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsudot_lane_s32::<0>(create_random_svint32_t(), create_random_svint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svsudot_lane_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svsudot_lane_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svsudot_lane_s32_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("i8mm")) {
            return Ok(Verdict::Skipped("i8mm not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svsudot_lane_s32::<1>(create_svint32_t_from(1i32), create_svint8_t_from(2i8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[25]).map_err(|e| crate::cpu::with_call(e, "svsudot_lane_s32::<1>(create_svint32_t_from(1i32), create_svint8_t_from(2i8), create_svuint8_t_from(3u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsudot_lane_s32::<1>(create_random_svint32_t(), create_random_svint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svsudot_lane_s32_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svsudot_lane_s32_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svsudot_lane_s32_imm_3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("i8mm")) {
            return Ok(Verdict::Skipped("i8mm not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svsudot_lane_s32::<3>(create_svint32_t_from(1i32), create_svint8_t_from(2i8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[25]).map_err(|e| crate::cpu::with_call(e, "svsudot_lane_s32::<3>(create_svint32_t_from(1i32), create_svint8_t_from(2i8), create_svuint8_t_from(3u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsudot_lane_s32::<3>(create_random_svint32_t(), create_random_svint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svsudot_lane_s32_imm_3() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svsudot_lane_s32_imm_3_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svsudot_s32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("i8mm")) {
            return Ok(Verdict::Skipped("i8mm not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svsudot_s32(create_svint32_t_from(1i32), create_svint8_t_from(2i8), create_svuint8_t_from(3u8)));
        check_array_equality(&result, &[25]).map_err(|e| crate::cpu::with_call(e, "svsudot_s32(create_svint32_t_from(1i32), create_svint8_t_from(2i8), create_svuint8_t_from(3u8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsudot_s32(create_random_svint32_t(), create_random_svint8_t(), create_random_svuint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svsudot_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svsudot_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svsudot_n_s32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("i8mm")) {
            return Ok(Verdict::Skipped("i8mm not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svsudot_n_s32(create_svint32_t_from(1i32), create_svint8_t_from(2i8), 3u8));
        check_array_equality(&result, &[25]).map_err(|e| crate::cpu::with_call(e, "svsudot_n_s32(create_svint32_t_from(1i32), create_svint8_t_from(2i8), 3u8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svsudot_n_s32(create_random_svint32_t(), create_random_svint8_t(), rand::random::<u8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svsudot_n_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svsudot_n_s32_impl() }
}
