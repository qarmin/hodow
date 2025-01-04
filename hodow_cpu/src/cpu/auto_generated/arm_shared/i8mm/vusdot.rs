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

pub(super) fn test_arm_shared_i8mm_vusdot_lane_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vusdot_lane_s32::<0>(create_int32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18])));
        check_array_equality(&result, &[231, 432]).map_err(|e| crate::cpu::with_call(e, "vusdot_lane_s32::<0>(create_int32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vusdot_lane_s32::<0>(create_random_int32x2_t(), create_random_uint8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_i8mm_vusdot_lane_s32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vusdot_lane_s32::<1>(create_int32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18])));
        check_array_equality(&result, &[303, 568]).map_err(|e| crate::cpu::with_call(e, "vusdot_lane_s32::<1>(create_int32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vusdot_lane_s32::<1>(create_random_int32x2_t(), create_random_uint8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_i8mm_vusdot_laneq_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vusdot_laneq_s32::<0>(create_int32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x16_t_from([11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26])));
        check_array_equality(&result, &[231, 432]).map_err(|e| crate::cpu::with_call(e, "vusdot_laneq_s32::<0>(create_int32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x16_t_from([11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vusdot_laneq_s32::<0>(create_random_int32x2_t(), create_random_uint8x8_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_i8mm_vusdot_laneq_s32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vusdot_laneq_s32::<1>(create_int32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x16_t_from([11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26])));
        check_array_equality(&result, &[303, 568]).map_err(|e| crate::cpu::with_call(e, "vusdot_laneq_s32::<1>(create_int32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x16_t_from([11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vusdot_laneq_s32::<1>(create_random_int32x2_t(), create_random_uint8x8_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_i8mm_vusdot_laneq_s32_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vusdot_laneq_s32::<3>(create_int32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x16_t_from([11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26])));
        check_array_equality(&result, &[447, 840]).map_err(|e| crate::cpu::with_call(e, "vusdot_laneq_s32::<3>(create_int32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x16_t_from([11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vusdot_laneq_s32::<3>(create_random_int32x2_t(), create_random_uint8x8_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_i8mm_vusdot_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vusdot_s32(create_int32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18])));
        check_array_equality(&result, &[231, 568]).map_err(|e| crate::cpu::with_call(e, "vusdot_s32(create_int32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vusdot_s32(create_random_int32x2_t(), create_random_uint8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}
