use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_rdm_vqrdmlshs_lane_s32() -> Result<Verdict, String> {
    unsafe {
        let result = vqrdmlshs_lane_s32::<0>(1i32, 2i32, create_int32x2_t_from([3, 4]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqrdmlshs_lane_s32::<0>(1i32, 2i32, create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrdmlshs_lane_s32::<0>(rand::random::<i32>(), rand::random::<i32>(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_rdm_vqrdmlshs_lane_s32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vqrdmlshs_lane_s32::<1>(1i32, 2i32, create_int32x2_t_from([3, 4]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqrdmlshs_lane_s32::<1>(1i32, 2i32, create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrdmlshs_lane_s32::<1>(rand::random::<i32>(), rand::random::<i32>(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_rdm_vqrdmlshs_laneq_s32() -> Result<Verdict, String> {
    unsafe {
        let result = vqrdmlshs_laneq_s32::<0>(1i32, 2i32, create_int32x4_t_from([3, 4, 5, 6]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqrdmlshs_laneq_s32::<0>(1i32, 2i32, create_int32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrdmlshs_laneq_s32::<0>(rand::random::<i32>(), rand::random::<i32>(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_rdm_vqrdmlshs_laneq_s32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vqrdmlshs_laneq_s32::<1>(1i32, 2i32, create_int32x4_t_from([3, 4, 5, 6]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqrdmlshs_laneq_s32::<1>(1i32, 2i32, create_int32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrdmlshs_laneq_s32::<1>(rand::random::<i32>(), rand::random::<i32>(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_rdm_vqrdmlshs_laneq_s32_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = vqrdmlshs_laneq_s32::<3>(1i32, 2i32, create_int32x4_t_from([3, 4, 5, 6]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqrdmlshs_laneq_s32::<3>(1i32, 2i32, create_int32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrdmlshs_laneq_s32::<3>(rand::random::<i32>(), rand::random::<i32>(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_rdm_vqrdmlshs_s32() -> Result<Verdict, String> {
    unsafe {
        let result = vqrdmlshs_s32(1i32, 2i32, 3i32);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqrdmlshs_s32(1i32, 2i32, 3i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrdmlshs_s32(rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}
