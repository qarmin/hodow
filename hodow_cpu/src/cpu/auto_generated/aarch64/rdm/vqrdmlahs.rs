use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_rdm_vqrdmlahs_lane_s32() -> Result<Verdict, String> {
    unsafe {
        let result = vqrdmlahs_lane_s32::<0>(1i32, 2i32, create_int32x2_t_from([3, 4]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqrdmlahs_lane_s32::<0>(1i32, 2i32, create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrdmlahs_lane_s32::<0>(rand::random::<i32>(), rand::random::<i32>(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_rdm_vqrdmlahs_lane_s32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vqrdmlahs_lane_s32::<1>(1i32, 2i32, create_int32x2_t_from([3, 4]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqrdmlahs_lane_s32::<1>(1i32, 2i32, create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrdmlahs_lane_s32::<1>(rand::random::<i32>(), rand::random::<i32>(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_rdm_vqrdmlahs_laneq_s32() -> Result<Verdict, String> {
    unsafe {
        let result = vqrdmlahs_laneq_s32::<0>(1i32, 2i32, create_int32x4_t_from([3, 4, 5, 6]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqrdmlahs_laneq_s32::<0>(1i32, 2i32, create_int32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrdmlahs_laneq_s32::<0>(rand::random::<i32>(), rand::random::<i32>(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_rdm_vqrdmlahs_laneq_s32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vqrdmlahs_laneq_s32::<1>(1i32, 2i32, create_int32x4_t_from([3, 4, 5, 6]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqrdmlahs_laneq_s32::<1>(1i32, 2i32, create_int32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrdmlahs_laneq_s32::<1>(rand::random::<i32>(), rand::random::<i32>(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_rdm_vqrdmlahs_laneq_s32_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = vqrdmlahs_laneq_s32::<3>(1i32, 2i32, create_int32x4_t_from([3, 4, 5, 6]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqrdmlahs_laneq_s32::<3>(1i32, 2i32, create_int32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrdmlahs_laneq_s32::<3>(rand::random::<i32>(), rand::random::<i32>(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_rdm_vqrdmlahs_s32() -> Result<Verdict, String> {
    unsafe {
        let result = vqrdmlahs_s32(1i32, 2i32, 3i32);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqrdmlahs_s32(1i32, 2i32, 3i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrdmlahs_s32(rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}
