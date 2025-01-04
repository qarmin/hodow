use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vdups_lane_f32() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_lane_f32::<0>(create_float32x2_t_from([1.0, 2.0]));
        check_float_equality(result, 1.0).map_err(|e| crate::cpu::with_call(e, "vdups_lane_f32::<0>(create_float32x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_lane_f32::<0>(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_lane_f32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_lane_f32::<0>(create_float32x2_t_from([0.0f32, -1.0f32]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "vdups_lane_f32::<0>(create_float32x2_t_from([0.0f32, -1.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_lane_f32::<0>(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_lane_f32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_lane_f32::<0>(create_float32x2_t_from([100.0f32, 200.0f32]));
        check_float_equality(result, 100.0).map_err(|e| crate::cpu::with_call(e, "vdups_lane_f32::<0>(create_float32x2_t_from([100.0f32, 200.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_lane_f32::<0>(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_lane_f32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_lane_f32::<0>(create_float32x2_t_from([f32::MIN, f32::MIN]));
        check_float_equality(result, -3.4028235e38).map_err(|e| crate::cpu::with_call(e, "vdups_lane_f32::<0>(create_float32x2_t_from([f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_lane_f32::<0>(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_lane_f32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_lane_f32::<0>(create_float32x2_t_from([f32::MAX, f32::MAX]));
        check_float_equality(result, 3.4028235e38).map_err(|e| crate::cpu::with_call(e, "vdups_lane_f32::<0>(create_float32x2_t_from([f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_lane_f32::<0>(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_lane_f32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_lane_f32::<0>(create_float32x2_t_from([0.0, 0.0]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "vdups_lane_f32::<0>(create_float32x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_lane_f32::<0>(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_lane_f32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_lane_f32::<0>(create_float32x2_t_from([f32::NAN, f32::NAN]));
        check_float_equality(result, f32::NAN).map_err(|e| crate::cpu::with_call(e, "vdups_lane_f32::<0>(create_float32x2_t_from([f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_lane_f32::<0>(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_lane_f32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_lane_f32::<0>(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]));
        check_float_equality(result, f32::INFINITY).map_err(|e| crate::cpu::with_call(e, "vdups_lane_f32::<0>(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_lane_f32::<0>(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_lane_f32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_lane_f32::<1>(create_float32x2_t_from([1.0, 2.0]));
        check_float_equality(result, 2.0).map_err(|e| crate::cpu::with_call(e, "vdups_lane_f32::<1>(create_float32x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_lane_f32::<1>(create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_lane_s32() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_lane_s32::<0>(create_int32x2_t_from([1, 2]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vdups_lane_s32::<0>(create_int32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_lane_s32::<0>(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_lane_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_lane_s32::<0>(create_int32x2_t_from([0, -1]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vdups_lane_s32::<0>(create_int32x2_t_from([0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_lane_s32::<0>(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_lane_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_lane_s32::<0>(create_int32x2_t_from([100, 200]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "vdups_lane_s32::<0>(create_int32x2_t_from([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_lane_s32::<0>(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_lane_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_lane_s32::<0>(create_int32x2_t_from([i32::MIN, i32::MIN]));
        check_int_equality(result, -2147483648).map_err(|e| crate::cpu::with_call(e, "vdups_lane_s32::<0>(create_int32x2_t_from([i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_lane_s32::<0>(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_lane_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_lane_s32::<0>(create_int32x2_t_from([i32::MAX, i32::MAX]));
        check_int_equality(result, 2147483647).map_err(|e| crate::cpu::with_call(e, "vdups_lane_s32::<0>(create_int32x2_t_from([i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_lane_s32::<0>(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_lane_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_lane_s32::<0>(create_int32x2_t_from([0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vdups_lane_s32::<0>(create_int32x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_lane_s32::<0>(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_lane_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_lane_s32::<0>(create_int32x2_t_from([-1, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "vdups_lane_s32::<0>(create_int32x2_t_from([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_lane_s32::<0>(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_lane_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_lane_s32::<0>(create_int32x2_t_from([i32::MIN, i32::MAX]));
        check_int_equality(result, -2147483648).map_err(|e| crate::cpu::with_call(e, "vdups_lane_s32::<0>(create_int32x2_t_from([i32::MIN, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_lane_s32::<0>(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_lane_s32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_lane_s32::<1>(create_int32x2_t_from([1, 2]));
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "vdups_lane_s32::<1>(create_int32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_lane_s32::<1>(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_lane_u32() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_lane_u32::<0>(create_uint32x2_t_from([1, 2]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vdups_lane_u32::<0>(create_uint32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_lane_u32::<0>(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_lane_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_lane_u32::<0>(create_uint32x2_t_from([0, 4294967295]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vdups_lane_u32::<0>(create_uint32x2_t_from([0, 4294967295]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_lane_u32::<0>(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_lane_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_lane_u32::<0>(create_uint32x2_t_from([100, 200]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "vdups_lane_u32::<0>(create_uint32x2_t_from([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_lane_u32::<0>(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_lane_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_lane_u32::<0>(create_uint32x2_t_from([u32::MIN, u32::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vdups_lane_u32::<0>(create_uint32x2_t_from([u32::MIN, u32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_lane_u32::<0>(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_lane_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_lane_u32::<0>(create_uint32x2_t_from([u32::MAX, u32::MAX]));
        check_int_equality(result, 4294967295).map_err(|e| crate::cpu::with_call(e, "vdups_lane_u32::<0>(create_uint32x2_t_from([u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_lane_u32::<0>(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_lane_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_lane_u32::<0>(create_uint32x2_t_from([0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vdups_lane_u32::<0>(create_uint32x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_lane_u32::<0>(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_lane_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_lane_u32::<0>(create_uint32x2_t_from([u32::MAX, u32::MAX]));
        check_int_equality(result, 4294967295).map_err(|e| crate::cpu::with_call(e, "vdups_lane_u32::<0>(create_uint32x2_t_from([u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_lane_u32::<0>(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_lane_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_lane_u32::<0>(create_uint32x2_t_from([u32::MIN, u32::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vdups_lane_u32::<0>(create_uint32x2_t_from([u32::MIN, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_lane_u32::<0>(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_lane_u32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_lane_u32::<1>(create_uint32x2_t_from([1, 2]));
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "vdups_lane_u32::<1>(create_uint32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_lane_u32::<1>(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_laneq_f32() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_laneq_f32::<0>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]));
        check_float_equality(result, 1.0).map_err(|e| crate::cpu::with_call(e, "vdups_laneq_f32::<0>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_laneq_f32::<0>(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_laneq_f32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_laneq_f32::<0>(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "vdups_laneq_f32::<0>(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_laneq_f32::<0>(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_laneq_f32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_laneq_f32::<0>(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]));
        check_float_equality(result, 100.0).map_err(|e| crate::cpu::with_call(e, "vdups_laneq_f32::<0>(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_laneq_f32::<0>(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_laneq_f32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_laneq_f32::<0>(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_float_equality(result, -3.4028235e38).map_err(|e| crate::cpu::with_call(e, "vdups_laneq_f32::<0>(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_laneq_f32::<0>(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_laneq_f32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_laneq_f32::<0>(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_float_equality(result, 3.4028235e38).map_err(|e| crate::cpu::with_call(e, "vdups_laneq_f32::<0>(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_laneq_f32::<0>(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_laneq_f32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_laneq_f32::<0>(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "vdups_laneq_f32::<0>(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_laneq_f32::<0>(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_laneq_f32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_laneq_f32::<0>(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_float_equality(result, f32::NAN).map_err(|e| crate::cpu::with_call(e, "vdups_laneq_f32::<0>(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_laneq_f32::<0>(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_laneq_f32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_laneq_f32::<0>(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_float_equality(result, f32::INFINITY).map_err(|e| crate::cpu::with_call(e, "vdups_laneq_f32::<0>(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_laneq_f32::<0>(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_laneq_f32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_laneq_f32::<1>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]));
        check_float_equality(result, 2.0).map_err(|e| crate::cpu::with_call(e, "vdups_laneq_f32::<1>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_laneq_f32::<1>(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_laneq_f32_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_laneq_f32::<3>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]));
        check_float_equality(result, 4.0).map_err(|e| crate::cpu::with_call(e, "vdups_laneq_f32::<3>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_laneq_f32::<3>(create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_laneq_s32() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_laneq_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vdups_laneq_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_laneq_s32::<0>(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_laneq_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_laneq_s32::<0>(create_int32x4_t_from([0, -1, 2, -3]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vdups_laneq_s32::<0>(create_int32x4_t_from([0, -1, 2, -3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_laneq_s32::<0>(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_laneq_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_laneq_s32::<0>(create_int32x4_t_from([100, 200, 300, 400]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "vdups_laneq_s32::<0>(create_int32x4_t_from([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_laneq_s32::<0>(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_laneq_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_laneq_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result, -2147483648).map_err(|e| crate::cpu::with_call(e, "vdups_laneq_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_laneq_s32::<0>(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_laneq_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_laneq_s32::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result, 2147483647).map_err(|e| crate::cpu::with_call(e, "vdups_laneq_s32::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_laneq_s32::<0>(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_laneq_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_laneq_s32::<0>(create_int32x4_t_from([0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vdups_laneq_s32::<0>(create_int32x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_laneq_s32::<0>(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_laneq_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_laneq_s32::<0>(create_int32x4_t_from([-1, -1, -1, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "vdups_laneq_s32::<0>(create_int32x4_t_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_laneq_s32::<0>(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_laneq_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_laneq_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result, -2147483648).map_err(|e| crate::cpu::with_call(e, "vdups_laneq_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_laneq_s32::<0>(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_laneq_s32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_laneq_s32::<1>(create_int32x4_t_from([1, 2, 3, 4]));
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "vdups_laneq_s32::<1>(create_int32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_laneq_s32::<1>(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_laneq_s32_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_laneq_s32::<3>(create_int32x4_t_from([1, 2, 3, 4]));
        check_int_equality(result, 4).map_err(|e| crate::cpu::with_call(e, "vdups_laneq_s32::<3>(create_int32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_laneq_s32::<3>(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_laneq_u32() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_laneq_u32::<0>(create_uint32x4_t_from([1, 2, 3, 4]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vdups_laneq_u32::<0>(create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_laneq_u32::<0>(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_laneq_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_laneq_u32::<0>(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vdups_laneq_u32::<0>(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_laneq_u32::<0>(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_laneq_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_laneq_u32::<0>(create_uint32x4_t_from([100, 200, 300, 400]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "vdups_laneq_u32::<0>(create_uint32x4_t_from([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_laneq_u32::<0>(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_laneq_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_laneq_u32::<0>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vdups_laneq_u32::<0>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_laneq_u32::<0>(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_laneq_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_laneq_u32::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]));
        check_int_equality(result, 4294967295).map_err(|e| crate::cpu::with_call(e, "vdups_laneq_u32::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_laneq_u32::<0>(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_laneq_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_laneq_u32::<0>(create_uint32x4_t_from([0, 0, 0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vdups_laneq_u32::<0>(create_uint32x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_laneq_u32::<0>(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_laneq_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_laneq_u32::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]));
        check_int_equality(result, 4294967295).map_err(|e| crate::cpu::with_call(e, "vdups_laneq_u32::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_laneq_u32::<0>(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_laneq_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_laneq_u32::<0>(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vdups_laneq_u32::<0>(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_laneq_u32::<0>(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_laneq_u32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_laneq_u32::<1>(create_uint32x4_t_from([1, 2, 3, 4]));
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "vdups_laneq_u32::<1>(create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_laneq_u32::<1>(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdups_laneq_u32_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = vdups_laneq_u32::<3>(create_uint32x4_t_from([1, 2, 3, 4]));
        check_int_equality(result, 4).map_err(|e| crate::cpu::with_call(e, "vdups_laneq_u32::<3>(create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdups_laneq_u32::<3>(create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}
