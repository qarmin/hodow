#[cfg(target_arch = "arm")]
use std::arch::arm::*;
#[cfg(target_arch = "aarch64")]
use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_arm_shared_i8mm_vusdotq_lane_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vusdotq_lane_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x8_t_from([21, 22, 23, 24, 25, 26, 27, 28])));
        check_array_equality(&result, &[591, 952, 1313, 1674]).map_err(|e| crate::cpu::with_call(e, "vusdotq_lane_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x8_t_from([21, 22, 23, 24, 25, 26, 27, 28]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vusdotq_lane_s32::<0>(create_random_int32x4_t(), create_random_uint8x16_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_i8mm_vusdotq_lane_s32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vusdotq_lane_s32::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x8_t_from([21, 22, 23, 24, 25, 26, 27, 28])));
        check_array_equality(&result, &[695, 1120, 1545, 1970]).map_err(|e| crate::cpu::with_call(e, "vusdotq_lane_s32::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x8_t_from([21, 22, 23, 24, 25, 26, 27, 28]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vusdotq_lane_s32::<1>(create_random_int32x4_t(), create_random_uint8x16_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_i8mm_vusdotq_laneq_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vusdotq_laneq_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36])));
        check_array_equality(&result, &[591, 952, 1313, 1674]).map_err(|e| crate::cpu::with_call(e, "vusdotq_laneq_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vusdotq_laneq_s32::<0>(create_random_int32x4_t(), create_random_uint8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_i8mm_vusdotq_laneq_s32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vusdotq_laneq_s32::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36])));
        check_array_equality(&result, &[695, 1120, 1545, 1970]).map_err(|e| crate::cpu::with_call(e, "vusdotq_laneq_s32::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vusdotq_laneq_s32::<1>(create_random_int32x4_t(), create_random_uint8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_i8mm_vusdotq_laneq_s32_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vusdotq_laneq_s32::<3>(create_int32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36])));
        check_array_equality(&result, &[903, 1456, 2009, 2562]).map_err(|e| crate::cpu::with_call(e, "vusdotq_laneq_s32::<3>(create_int32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vusdotq_laneq_s32::<3>(create_random_int32x4_t(), create_random_uint8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_i8mm_vusdotq_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vusdotq_s32(create_int32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36])));
        check_array_equality(&result, &[591, 1120, 1777, 2562]).map_err(|e| crate::cpu::with_call(e, "vusdotq_s32(create_int32x4_t_from([1, 2, 3, 4]), create_uint8x16_t_from([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]), create_int8x16_t_from([21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vusdotq_s32(create_random_int32x4_t(), create_random_uint8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}
