use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_rdm_vqrdmlahh_lane_s16() -> Result<Verdict, String> {
    unsafe {
        let result = vqrdmlahh_lane_s16::<0>(1i16, 2i16, create_int16x4_t_from([3, 4, 5, 6]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqrdmlahh_lane_s16::<0>(1i16, 2i16, create_int16x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrdmlahh_lane_s16::<0>(rand::random::<i16>(), rand::random::<i16>(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_rdm_vqrdmlahh_lane_s16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vqrdmlahh_lane_s16::<1>(1i16, 2i16, create_int16x4_t_from([3, 4, 5, 6]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqrdmlahh_lane_s16::<1>(1i16, 2i16, create_int16x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrdmlahh_lane_s16::<1>(rand::random::<i16>(), rand::random::<i16>(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_rdm_vqrdmlahh_lane_s16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = vqrdmlahh_lane_s16::<3>(1i16, 2i16, create_int16x4_t_from([3, 4, 5, 6]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqrdmlahh_lane_s16::<3>(1i16, 2i16, create_int16x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrdmlahh_lane_s16::<3>(rand::random::<i16>(), rand::random::<i16>(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_rdm_vqrdmlahh_laneq_s16() -> Result<Verdict, String> {
    unsafe {
        let result = vqrdmlahh_laneq_s16::<0>(1i16, 2i16, create_int16x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqrdmlahh_laneq_s16::<0>(1i16, 2i16, create_int16x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrdmlahh_laneq_s16::<0>(rand::random::<i16>(), rand::random::<i16>(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_rdm_vqrdmlahh_laneq_s16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vqrdmlahh_laneq_s16::<1>(1i16, 2i16, create_int16x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqrdmlahh_laneq_s16::<1>(1i16, 2i16, create_int16x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrdmlahh_laneq_s16::<1>(rand::random::<i16>(), rand::random::<i16>(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_rdm_vqrdmlahh_laneq_s16_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = vqrdmlahh_laneq_s16::<7>(1i16, 2i16, create_int16x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqrdmlahh_laneq_s16::<7>(1i16, 2i16, create_int16x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrdmlahh_laneq_s16::<7>(rand::random::<i16>(), rand::random::<i16>(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_rdm_vqrdmlahh_laneq_s16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = vqrdmlahh_laneq_s16::<3>(1i16, 2i16, create_int16x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqrdmlahh_laneq_s16::<3>(1i16, 2i16, create_int16x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrdmlahh_laneq_s16::<3>(rand::random::<i16>(), rand::random::<i16>(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_rdm_vqrdmlahh_s16() -> Result<Verdict, String> {
    unsafe {
        let result = vqrdmlahh_s16(1i16, 2i16, 3i16);
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqrdmlahh_s16(1i16, 2i16, 3i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrdmlahh_s16(rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}
