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
fn test_aarch64_sve_svusdot_lane_s32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("i8mm")) {
            return Ok(Verdict::Skipped("i8mm not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svusdot_lane_s32::<0>(create_svint32_t_from(1i32), create_svuint8_t_from(2u8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[25]).map_err(|e| crate::cpu::with_call(e, "svusdot_lane_s32::<0>(create_svint32_t_from(1i32), create_svuint8_t_from(2u8), create_svint8_t_from(3i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svusdot_lane_s32::<0>(create_random_svint32_t(), create_random_svuint8_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svusdot_lane_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svusdot_lane_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svusdot_lane_s32_imm_1_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("i8mm")) {
            return Ok(Verdict::Skipped("i8mm not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svusdot_lane_s32::<1>(create_svint32_t_from(1i32), create_svuint8_t_from(2u8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[25]).map_err(|e| crate::cpu::with_call(e, "svusdot_lane_s32::<1>(create_svint32_t_from(1i32), create_svuint8_t_from(2u8), create_svint8_t_from(3i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svusdot_lane_s32::<1>(create_random_svint32_t(), create_random_svuint8_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svusdot_lane_s32_imm_1() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svusdot_lane_s32_imm_1_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svusdot_lane_s32_imm_3_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("i8mm")) {
            return Ok(Verdict::Skipped("i8mm not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svusdot_lane_s32::<3>(create_svint32_t_from(1i32), create_svuint8_t_from(2u8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[25]).map_err(|e| crate::cpu::with_call(e, "svusdot_lane_s32::<3>(create_svint32_t_from(1i32), create_svuint8_t_from(2u8), create_svint8_t_from(3i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svusdot_lane_s32::<3>(create_random_svint32_t(), create_random_svuint8_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svusdot_lane_s32_imm_3() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svusdot_lane_s32_imm_3_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svusdot_s32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("i8mm")) {
            return Ok(Verdict::Skipped("i8mm not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svusdot_s32(create_svint32_t_from(1i32), create_svuint8_t_from(2u8), create_svint8_t_from(3i8)));
        check_array_equality(&result, &[25]).map_err(|e| crate::cpu::with_call(e, "svusdot_s32(create_svint32_t_from(1i32), create_svuint8_t_from(2u8), create_svint8_t_from(3i8))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svusdot_s32(create_random_svint32_t(), create_random_svuint8_t(), create_random_svint8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svusdot_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svusdot_s32_impl() }
}

#[target_feature(enable = "sve")]
fn test_aarch64_sve_svusdot_n_s32_impl() -> Result<Verdict, String> {
        if !(std::arch::is_aarch64_feature_detected!("i8mm")) {
            return Ok(Verdict::Skipped("i8mm not present"));
        }
    unsafe {
        let result = unpack_svint32_t_to_i32_array(svusdot_n_s32(create_svint32_t_from(1i32), create_svuint8_t_from(2u8), 3i8));
        check_array_equality(&result, &[25]).map_err(|e| crate::cpu::with_call(e, "svusdot_n_s32(create_svint32_t_from(1i32), create_svuint8_t_from(2u8), 3i8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = svusdot_n_s32(create_random_svint32_t(), create_random_svuint8_t(), rand::random::<i8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_sve_svusdot_n_s32() -> Result<Verdict, String> {
    unsafe { test_aarch64_sve_svusdot_n_s32_impl() }
}
