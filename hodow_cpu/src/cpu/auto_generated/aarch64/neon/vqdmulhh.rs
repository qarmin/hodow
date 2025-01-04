use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vqdmulhh_lane_s16() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmulhh_lane_s16::<0>(1i16, create_int16x4_t_from([2, 3, 4, 5]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vqdmulhh_lane_s16::<0>(1i16, create_int16x4_t_from([2, 3, 4, 5]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhh_lane_s16::<0>(rand::random::<i16>(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmulhh_lane_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmulhh_lane_s16::<0>(1i16, create_int16x4_t_from([0, -1, 2, -3]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vqdmulhh_lane_s16::<0>(1i16, create_int16x4_t_from([0, -1, 2, -3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhh_lane_s16::<0>(rand::random::<i16>(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmulhh_lane_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmulhh_lane_s16::<0>(1i16, create_int16x4_t_from([100, 200, 300, 400]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vqdmulhh_lane_s16::<0>(1i16, create_int16x4_t_from([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhh_lane_s16::<0>(rand::random::<i16>(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmulhh_lane_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmulhh_lane_s16::<0>(1i16, create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "vqdmulhh_lane_s16::<0>(1i16, create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhh_lane_s16::<0>(rand::random::<i16>(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmulhh_lane_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmulhh_lane_s16::<0>(1i16, create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vqdmulhh_lane_s16::<0>(1i16, create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhh_lane_s16::<0>(rand::random::<i16>(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmulhh_lane_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmulhh_lane_s16::<0>(1i16, create_int16x4_t_from([0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vqdmulhh_lane_s16::<0>(1i16, create_int16x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhh_lane_s16::<0>(rand::random::<i16>(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmulhh_lane_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmulhh_lane_s16::<0>(1i16, create_int16x4_t_from([-1, -1, -1, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "vqdmulhh_lane_s16::<0>(1i16, create_int16x4_t_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhh_lane_s16::<0>(rand::random::<i16>(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmulhh_lane_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmulhh_lane_s16::<0>(1i16, create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "vqdmulhh_lane_s16::<0>(1i16, create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhh_lane_s16::<0>(rand::random::<i16>(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmulhh_lane_s16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmulhh_lane_s16::<1>(1i16, create_int16x4_t_from([2, 3, 4, 5]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vqdmulhh_lane_s16::<1>(1i16, create_int16x4_t_from([2, 3, 4, 5]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhh_lane_s16::<1>(rand::random::<i16>(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmulhh_lane_s16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmulhh_lane_s16::<3>(1i16, create_int16x4_t_from([2, 3, 4, 5]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vqdmulhh_lane_s16::<3>(1i16, create_int16x4_t_from([2, 3, 4, 5]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhh_lane_s16::<3>(rand::random::<i16>(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmulhh_laneq_s16() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmulhh_laneq_s16::<0>(1i16, create_int16x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vqdmulhh_laneq_s16::<0>(1i16, create_int16x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhh_laneq_s16::<0>(rand::random::<i16>(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmulhh_laneq_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmulhh_laneq_s16::<0>(1i16, create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vqdmulhh_laneq_s16::<0>(1i16, create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhh_laneq_s16::<0>(rand::random::<i16>(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmulhh_laneq_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmulhh_laneq_s16::<0>(1i16, create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vqdmulhh_laneq_s16::<0>(1i16, create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhh_laneq_s16::<0>(rand::random::<i16>(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmulhh_laneq_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmulhh_laneq_s16::<0>(1i16, create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "vqdmulhh_laneq_s16::<0>(1i16, create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhh_laneq_s16::<0>(rand::random::<i16>(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmulhh_laneq_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmulhh_laneq_s16::<0>(1i16, create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vqdmulhh_laneq_s16::<0>(1i16, create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhh_laneq_s16::<0>(rand::random::<i16>(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmulhh_laneq_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmulhh_laneq_s16::<0>(1i16, create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vqdmulhh_laneq_s16::<0>(1i16, create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhh_laneq_s16::<0>(rand::random::<i16>(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmulhh_laneq_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmulhh_laneq_s16::<0>(1i16, create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "vqdmulhh_laneq_s16::<0>(1i16, create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhh_laneq_s16::<0>(rand::random::<i16>(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmulhh_laneq_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmulhh_laneq_s16::<0>(1i16, create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "vqdmulhh_laneq_s16::<0>(1i16, create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhh_laneq_s16::<0>(rand::random::<i16>(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmulhh_laneq_s16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmulhh_laneq_s16::<1>(1i16, create_int16x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vqdmulhh_laneq_s16::<1>(1i16, create_int16x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhh_laneq_s16::<1>(rand::random::<i16>(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmulhh_laneq_s16_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmulhh_laneq_s16::<7>(1i16, create_int16x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vqdmulhh_laneq_s16::<7>(1i16, create_int16x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhh_laneq_s16::<7>(rand::random::<i16>(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmulhh_laneq_s16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmulhh_laneq_s16::<3>(1i16, create_int16x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vqdmulhh_laneq_s16::<3>(1i16, create_int16x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhh_laneq_s16::<3>(rand::random::<i16>(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmulhh_s16() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmulhh_s16(1i16, 2i16);
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vqdmulhh_s16(1i16, 2i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhh_s16(rand::random::<i16>(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}
