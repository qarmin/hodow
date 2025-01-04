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

pub(super) fn test_arm_shared_dotprod_vdot_lane_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vdot_lane_s32::<0>(create_int32x2_t_from([1, 2]), create_int8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18])));
        check_array_equality(&result, &[231, 432]).map_err(|e| crate::cpu::with_call(e, "vdot_lane_s32::<0>(create_int32x2_t_from([1, 2]), create_int8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdot_lane_s32::<0>(create_random_int32x2_t(), create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_dotprod_vdot_lane_s32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vdot_lane_s32::<1>(create_int32x2_t_from([1, 2]), create_int8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18])));
        check_array_equality(&result, &[303, 568]).map_err(|e| crate::cpu::with_call(e, "vdot_lane_s32::<1>(create_int32x2_t_from([1, 2]), create_int8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdot_lane_s32::<1>(create_random_int32x2_t(), create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_dotprod_vdot_lane_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vdot_lane_u32::<0>(create_uint32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_uint8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18])));
        check_array_equality(&result, &[231, 432]).map_err(|e| crate::cpu::with_call(e, "vdot_lane_u32::<0>(create_uint32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_uint8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdot_lane_u32::<0>(create_random_uint32x2_t(), create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_dotprod_vdot_lane_u32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vdot_lane_u32::<1>(create_uint32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_uint8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18])));
        check_array_equality(&result, &[303, 568]).map_err(|e| crate::cpu::with_call(e, "vdot_lane_u32::<1>(create_uint32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_uint8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdot_lane_u32::<1>(create_random_uint32x2_t(), create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_dotprod_vdot_laneq_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vdot_laneq_s32::<0>(create_int32x2_t_from([1, 2]), create_int8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x16_t_from([11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26])));
        check_array_equality(&result, &[231, 432]).map_err(|e| crate::cpu::with_call(e, "vdot_laneq_s32::<0>(create_int32x2_t_from([1, 2]), create_int8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x16_t_from([11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdot_laneq_s32::<0>(create_random_int32x2_t(), create_random_int8x8_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_dotprod_vdot_laneq_s32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vdot_laneq_s32::<1>(create_int32x2_t_from([1, 2]), create_int8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x16_t_from([11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26])));
        check_array_equality(&result, &[303, 568]).map_err(|e| crate::cpu::with_call(e, "vdot_laneq_s32::<1>(create_int32x2_t_from([1, 2]), create_int8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x16_t_from([11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdot_laneq_s32::<1>(create_random_int32x2_t(), create_random_int8x8_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_dotprod_vdot_laneq_s32_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vdot_laneq_s32::<3>(create_int32x2_t_from([1, 2]), create_int8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x16_t_from([11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26])));
        check_array_equality(&result, &[447, 840]).map_err(|e| crate::cpu::with_call(e, "vdot_laneq_s32::<3>(create_int32x2_t_from([1, 2]), create_int8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x16_t_from([11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdot_laneq_s32::<3>(create_random_int32x2_t(), create_random_int8x8_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_dotprod_vdot_laneq_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vdot_laneq_u32::<0>(create_uint32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_uint8x16_t_from([11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26])));
        check_array_equality(&result, &[231, 432]).map_err(|e| crate::cpu::with_call(e, "vdot_laneq_u32::<0>(create_uint32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_uint8x16_t_from([11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdot_laneq_u32::<0>(create_random_uint32x2_t(), create_random_uint8x8_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_dotprod_vdot_laneq_u32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vdot_laneq_u32::<1>(create_uint32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_uint8x16_t_from([11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26])));
        check_array_equality(&result, &[303, 568]).map_err(|e| crate::cpu::with_call(e, "vdot_laneq_u32::<1>(create_uint32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_uint8x16_t_from([11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdot_laneq_u32::<1>(create_random_uint32x2_t(), create_random_uint8x8_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_dotprod_vdot_laneq_u32_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vdot_laneq_u32::<3>(create_uint32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_uint8x16_t_from([11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26])));
        check_array_equality(&result, &[447, 840]).map_err(|e| crate::cpu::with_call(e, "vdot_laneq_u32::<3>(create_uint32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_uint8x16_t_from([11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdot_laneq_u32::<3>(create_random_uint32x2_t(), create_random_uint8x8_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_dotprod_vdot_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vdot_s32(create_int32x2_t_from([1, 2]), create_int8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18])));
        check_array_equality(&result, &[231, 568]).map_err(|e| crate::cpu::with_call(e, "vdot_s32(create_int32x2_t_from([1, 2]), create_int8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_int8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdot_s32(create_random_int32x2_t(), create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_dotprod_vdot_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vdot_u32(create_uint32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_uint8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18])));
        check_array_equality(&result, &[231, 568]).map_err(|e| crate::cpu::with_call(e, "vdot_u32(create_uint32x2_t_from([1, 2]), create_uint8x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]), create_uint8x8_t_from([11, 12, 13, 14, 15, 16, 17, 18]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdot_u32(create_random_uint32x2_t(), create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}
