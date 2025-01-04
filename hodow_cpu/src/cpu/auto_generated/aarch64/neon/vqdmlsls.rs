use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vqdmlsls_lane_s32() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlsls_lane_s32::<0>(1i64, 2i32, create_int32x2_t_from([3, 4]));
        check_int_equality(result, -11).map_err(|e| crate::cpu::with_call(e, "vqdmlsls_lane_s32::<0>(1i64, 2i32, create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlsls_lane_s32::<0>(rand::random::<i64>(), rand::random::<i32>(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlsls_lane_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlsls_lane_s32::<0>(1i64, 2i32, create_int32x2_t_from([0, -1]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqdmlsls_lane_s32::<0>(1i64, 2i32, create_int32x2_t_from([0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlsls_lane_s32::<0>(rand::random::<i64>(), rand::random::<i32>(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlsls_lane_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlsls_lane_s32::<0>(1i64, 2i32, create_int32x2_t_from([100, 200]));
        check_int_equality(result, -399).map_err(|e| crate::cpu::with_call(e, "vqdmlsls_lane_s32::<0>(1i64, 2i32, create_int32x2_t_from([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlsls_lane_s32::<0>(rand::random::<i64>(), rand::random::<i32>(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlsls_lane_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlsls_lane_s32::<0>(1i64, 2i32, create_int32x2_t_from([i32::MIN, i32::MIN]));
        check_int_equality(result, 8589934593).map_err(|e| crate::cpu::with_call(e, "vqdmlsls_lane_s32::<0>(1i64, 2i32, create_int32x2_t_from([i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlsls_lane_s32::<0>(rand::random::<i64>(), rand::random::<i32>(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlsls_lane_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlsls_lane_s32::<0>(1i64, 2i32, create_int32x2_t_from([i32::MAX, i32::MAX]));
        check_int_equality(result, -8589934587).map_err(|e| crate::cpu::with_call(e, "vqdmlsls_lane_s32::<0>(1i64, 2i32, create_int32x2_t_from([i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlsls_lane_s32::<0>(rand::random::<i64>(), rand::random::<i32>(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlsls_lane_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlsls_lane_s32::<0>(1i64, 2i32, create_int32x2_t_from([0, 0]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqdmlsls_lane_s32::<0>(1i64, 2i32, create_int32x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlsls_lane_s32::<0>(rand::random::<i64>(), rand::random::<i32>(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlsls_lane_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlsls_lane_s32::<0>(1i64, 2i32, create_int32x2_t_from([-1, -1]));
        check_int_equality(result, 5).map_err(|e| crate::cpu::with_call(e, "vqdmlsls_lane_s32::<0>(1i64, 2i32, create_int32x2_t_from([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlsls_lane_s32::<0>(rand::random::<i64>(), rand::random::<i32>(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlsls_lane_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlsls_lane_s32::<0>(1i64, 2i32, create_int32x2_t_from([i32::MIN, i32::MAX]));
        check_int_equality(result, 8589934593).map_err(|e| crate::cpu::with_call(e, "vqdmlsls_lane_s32::<0>(1i64, 2i32, create_int32x2_t_from([i32::MIN, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlsls_lane_s32::<0>(rand::random::<i64>(), rand::random::<i32>(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlsls_lane_s32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlsls_lane_s32::<1>(1i64, 2i32, create_int32x2_t_from([3, 4]));
        check_int_equality(result, -15).map_err(|e| crate::cpu::with_call(e, "vqdmlsls_lane_s32::<1>(1i64, 2i32, create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlsls_lane_s32::<1>(rand::random::<i64>(), rand::random::<i32>(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlsls_laneq_s32() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlsls_laneq_s32::<0>(1i64, 2i32, create_int32x4_t_from([3, 4, 5, 6]));
        check_int_equality(result, -11).map_err(|e| crate::cpu::with_call(e, "vqdmlsls_laneq_s32::<0>(1i64, 2i32, create_int32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlsls_laneq_s32::<0>(rand::random::<i64>(), rand::random::<i32>(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlsls_laneq_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlsls_laneq_s32::<0>(1i64, 2i32, create_int32x4_t_from([0, -1, 2, -3]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqdmlsls_laneq_s32::<0>(1i64, 2i32, create_int32x4_t_from([0, -1, 2, -3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlsls_laneq_s32::<0>(rand::random::<i64>(), rand::random::<i32>(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlsls_laneq_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlsls_laneq_s32::<0>(1i64, 2i32, create_int32x4_t_from([100, 200, 300, 400]));
        check_int_equality(result, -399).map_err(|e| crate::cpu::with_call(e, "vqdmlsls_laneq_s32::<0>(1i64, 2i32, create_int32x4_t_from([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlsls_laneq_s32::<0>(rand::random::<i64>(), rand::random::<i32>(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlsls_laneq_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlsls_laneq_s32::<0>(1i64, 2i32, create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, 8589934593).map_err(|e| crate::cpu::with_call(e, "vqdmlsls_laneq_s32::<0>(1i64, 2i32, create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlsls_laneq_s32::<0>(rand::random::<i64>(), rand::random::<i32>(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlsls_laneq_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlsls_laneq_s32::<0>(1i64, 2i32, create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, -8589934587).map_err(|e| crate::cpu::with_call(e, "vqdmlsls_laneq_s32::<0>(1i64, 2i32, create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlsls_laneq_s32::<0>(rand::random::<i64>(), rand::random::<i32>(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlsls_laneq_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlsls_laneq_s32::<0>(1i64, 2i32, create_int32x4_t_from([0, 0, 0, 0]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vqdmlsls_laneq_s32::<0>(1i64, 2i32, create_int32x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlsls_laneq_s32::<0>(rand::random::<i64>(), rand::random::<i32>(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlsls_laneq_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlsls_laneq_s32::<0>(1i64, 2i32, create_int32x4_t_from([-1, -1, -1, -1]));
        check_int_equality(result, 5).map_err(|e| crate::cpu::with_call(e, "vqdmlsls_laneq_s32::<0>(1i64, 2i32, create_int32x4_t_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlsls_laneq_s32::<0>(rand::random::<i64>(), rand::random::<i32>(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlsls_laneq_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlsls_laneq_s32::<0>(1i64, 2i32, create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result, 8589934593).map_err(|e| crate::cpu::with_call(e, "vqdmlsls_laneq_s32::<0>(1i64, 2i32, create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlsls_laneq_s32::<0>(rand::random::<i64>(), rand::random::<i32>(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlsls_laneq_s32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlsls_laneq_s32::<1>(1i64, 2i32, create_int32x4_t_from([3, 4, 5, 6]));
        check_int_equality(result, -15).map_err(|e| crate::cpu::with_call(e, "vqdmlsls_laneq_s32::<1>(1i64, 2i32, create_int32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlsls_laneq_s32::<1>(rand::random::<i64>(), rand::random::<i32>(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlsls_laneq_s32_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlsls_laneq_s32::<3>(1i64, 2i32, create_int32x4_t_from([3, 4, 5, 6]));
        check_int_equality(result, -23).map_err(|e| crate::cpu::with_call(e, "vqdmlsls_laneq_s32::<3>(1i64, 2i32, create_int32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlsls_laneq_s32::<3>(rand::random::<i64>(), rand::random::<i32>(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlsls_s32() -> Result<Verdict, String> {
    unsafe {
        let result = vqdmlsls_s32(1i64, 2i32, 3i32);
        check_int_equality(result, -11).map_err(|e| crate::cpu::with_call(e, "vqdmlsls_s32(1i64, 2i32, 3i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlsls_s32(rand::random::<i64>(), rand::random::<i32>(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}
