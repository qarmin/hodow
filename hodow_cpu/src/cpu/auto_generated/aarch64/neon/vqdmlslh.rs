use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vqdmlslh_lane_s16() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlslh_lane_s16::<0>(1i32, 2i16, create_int16x4_t_from([3, 4, 5, 6]));
        check_int_equality(result, -11).map_err(|e| crate::cpu::with_call(e, "vqdmlslh_lane_s16::<0>(1i32, 2i16, create_int16x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlslh_lane_s16::<0>(rand::random::<i32>(), rand::random::<i16>(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlslh_lane_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlslh_lane_s16::<0>(1i32, 2i16, create_int16x4_t_from([0, -1, 2, -3]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqdmlslh_lane_s16::<0>(1i32, 2i16, create_int16x4_t_from([0, -1, 2, -3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlslh_lane_s16::<0>(rand::random::<i32>(), rand::random::<i16>(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlslh_lane_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlslh_lane_s16::<0>(1i32, 2i16, create_int16x4_t_from([100, 200, 300, 400]));
        check_int_equality(result, -399).map_err(|e| crate::cpu::with_call(e, "vqdmlslh_lane_s16::<0>(1i32, 2i16, create_int16x4_t_from([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlslh_lane_s16::<0>(rand::random::<i32>(), rand::random::<i16>(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlslh_lane_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlslh_lane_s16::<0>(1i32, 2i16, create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]));
        check_int_equality(result, 131073).map_err(|e| crate::cpu::with_call(e, "vqdmlslh_lane_s16::<0>(1i32, 2i16, create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlslh_lane_s16::<0>(rand::random::<i32>(), rand::random::<i16>(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlslh_lane_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlslh_lane_s16::<0>(1i32, 2i16, create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]));
        check_int_equality(result, -131067).map_err(|e| crate::cpu::with_call(e, "vqdmlslh_lane_s16::<0>(1i32, 2i16, create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlslh_lane_s16::<0>(rand::random::<i32>(), rand::random::<i16>(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlslh_lane_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlslh_lane_s16::<0>(1i32, 2i16, create_int16x4_t_from([0, 0, 0, 0]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqdmlslh_lane_s16::<0>(1i32, 2i16, create_int16x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlslh_lane_s16::<0>(rand::random::<i32>(), rand::random::<i16>(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlslh_lane_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlslh_lane_s16::<0>(1i32, 2i16, create_int16x4_t_from([-1, -1, -1, -1]));
        check_int_equality(result, 5).map_err(|e| crate::cpu::with_call(e, "vqdmlslh_lane_s16::<0>(1i32, 2i16, create_int16x4_t_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlslh_lane_s16::<0>(rand::random::<i32>(), rand::random::<i16>(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlslh_lane_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlslh_lane_s16::<0>(1i32, 2i16, create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1]));
        check_int_equality(result, 131073).map_err(|e| crate::cpu::with_call(e, "vqdmlslh_lane_s16::<0>(1i32, 2i16, create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlslh_lane_s16::<0>(rand::random::<i32>(), rand::random::<i16>(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlslh_lane_s16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlslh_lane_s16::<1>(1i32, 2i16, create_int16x4_t_from([3, 4, 5, 6]));
        check_int_equality(result, -15).map_err(|e| crate::cpu::with_call(e, "vqdmlslh_lane_s16::<1>(1i32, 2i16, create_int16x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlslh_lane_s16::<1>(rand::random::<i32>(), rand::random::<i16>(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlslh_lane_s16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlslh_lane_s16::<3>(1i32, 2i16, create_int16x4_t_from([3, 4, 5, 6]));
        check_int_equality(result, -23).map_err(|e| crate::cpu::with_call(e, "vqdmlslh_lane_s16::<3>(1i32, 2i16, create_int16x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlslh_lane_s16::<3>(rand::random::<i32>(), rand::random::<i16>(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlslh_laneq_s16() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlslh_laneq_s16::<0>(1i32, 2i16, create_int16x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]));
        check_int_equality(result, -11).map_err(|e| crate::cpu::with_call(e, "vqdmlslh_laneq_s16::<0>(1i32, 2i16, create_int16x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlslh_laneq_s16::<0>(rand::random::<i32>(), rand::random::<i16>(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlslh_laneq_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlslh_laneq_s16::<0>(1i32, 2i16, create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqdmlslh_laneq_s16::<0>(1i32, 2i16, create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlslh_laneq_s16::<0>(rand::random::<i32>(), rand::random::<i16>(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlslh_laneq_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlslh_laneq_s16::<0>(1i32, 2i16, create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]));
        check_int_equality(result, -399).map_err(|e| crate::cpu::with_call(e, "vqdmlslh_laneq_s16::<0>(1i32, 2i16, create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlslh_laneq_s16::<0>(rand::random::<i32>(), rand::random::<i16>(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlslh_laneq_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlslh_laneq_s16::<0>(1i32, 2i16, create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]));
        check_int_equality(result, 131073).map_err(|e| crate::cpu::with_call(e, "vqdmlslh_laneq_s16::<0>(1i32, 2i16, create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlslh_laneq_s16::<0>(rand::random::<i32>(), rand::random::<i16>(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlslh_laneq_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlslh_laneq_s16::<0>(1i32, 2i16, create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]));
        check_int_equality(result, -131067).map_err(|e| crate::cpu::with_call(e, "vqdmlslh_laneq_s16::<0>(1i32, 2i16, create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlslh_laneq_s16::<0>(rand::random::<i32>(), rand::random::<i16>(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlslh_laneq_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlslh_laneq_s16::<0>(1i32, 2i16, create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqdmlslh_laneq_s16::<0>(1i32, 2i16, create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlslh_laneq_s16::<0>(rand::random::<i32>(), rand::random::<i16>(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlslh_laneq_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlslh_laneq_s16::<0>(1i32, 2i16, create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]));
        check_int_equality(result, 5).map_err(|e| crate::cpu::with_call(e, "vqdmlslh_laneq_s16::<0>(1i32, 2i16, create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlslh_laneq_s16::<0>(rand::random::<i32>(), rand::random::<i16>(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlslh_laneq_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlslh_laneq_s16::<0>(1i32, 2i16, create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]));
        check_int_equality(result, 131073).map_err(|e| crate::cpu::with_call(e, "vqdmlslh_laneq_s16::<0>(1i32, 2i16, create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlslh_laneq_s16::<0>(rand::random::<i32>(), rand::random::<i16>(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlslh_laneq_s16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlslh_laneq_s16::<1>(1i32, 2i16, create_int16x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]));
        check_int_equality(result, -15).map_err(|e| crate::cpu::with_call(e, "vqdmlslh_laneq_s16::<1>(1i32, 2i16, create_int16x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlslh_laneq_s16::<1>(rand::random::<i32>(), rand::random::<i16>(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlslh_laneq_s16_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlslh_laneq_s16::<7>(1i32, 2i16, create_int16x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]));
        check_int_equality(result, -39).map_err(|e| crate::cpu::with_call(e, "vqdmlslh_laneq_s16::<7>(1i32, 2i16, create_int16x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlslh_laneq_s16::<7>(rand::random::<i32>(), rand::random::<i16>(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlslh_laneq_s16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlslh_laneq_s16::<3>(1i32, 2i16, create_int16x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]));
        check_int_equality(result, -23).map_err(|e| crate::cpu::with_call(e, "vqdmlslh_laneq_s16::<3>(1i32, 2i16, create_int16x8_t_from([3, 4, 5, 6, 7, 8, 9, 10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlslh_laneq_s16::<3>(rand::random::<i32>(), rand::random::<i16>(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlslh_s16() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlslh_s16(1i32, 2i16, 3i16);
        check_int_equality(result, -11).map_err(|e| crate::cpu::with_call(e, "vqdmlslh_s16(1i32, 2i16, 3i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlslh_s16(rand::random::<i32>(), rand::random::<i16>(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}
