use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vfmas_lane_f32() -> Result<Verdict, String> {
    unsafe {
        let result = vfmas_lane_f32::<0>(1.0f32, 2.0f32, create_float32x2_t_from([3.0, 4.0]));
        check_float_equality(result, 7.0).map_err(|e| crate::cpu::with_call(e, "vfmas_lane_f32::<0>(1.0f32, 2.0f32, create_float32x2_t_from([3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmas_lane_f32::<0>(rand::random::<f32>(), rand::random::<f32>(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmas_lane_f32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vfmas_lane_f32::<0>(1.0f32, 2.0f32, create_float32x2_t_from([0.0f32, -1.0f32]));
        check_float_equality(result, 1.0).map_err(|e| crate::cpu::with_call(e, "vfmas_lane_f32::<0>(1.0f32, 2.0f32, create_float32x2_t_from([0.0f32, -1.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmas_lane_f32::<0>(rand::random::<f32>(), rand::random::<f32>(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmas_lane_f32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vfmas_lane_f32::<0>(1.0f32, 2.0f32, create_float32x2_t_from([100.0f32, 200.0f32]));
        check_float_equality(result, 201.0).map_err(|e| crate::cpu::with_call(e, "vfmas_lane_f32::<0>(1.0f32, 2.0f32, create_float32x2_t_from([100.0f32, 200.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmas_lane_f32::<0>(rand::random::<f32>(), rand::random::<f32>(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmas_lane_f32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vfmas_lane_f32::<0>(1.0f32, 2.0f32, create_float32x2_t_from([f32::MIN, f32::MIN]));
        check_float_equality(result, -f32::INFINITY).map_err(|e| crate::cpu::with_call(e, "vfmas_lane_f32::<0>(1.0f32, 2.0f32, create_float32x2_t_from([f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmas_lane_f32::<0>(rand::random::<f32>(), rand::random::<f32>(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmas_lane_f32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vfmas_lane_f32::<0>(1.0f32, 2.0f32, create_float32x2_t_from([f32::MAX, f32::MAX]));
        check_float_equality(result, f32::INFINITY).map_err(|e| crate::cpu::with_call(e, "vfmas_lane_f32::<0>(1.0f32, 2.0f32, create_float32x2_t_from([f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmas_lane_f32::<0>(rand::random::<f32>(), rand::random::<f32>(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmas_lane_f32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vfmas_lane_f32::<0>(1.0f32, 2.0f32, create_float32x2_t_from([0.0, 0.0]));
        check_float_equality(result, 1.0).map_err(|e| crate::cpu::with_call(e, "vfmas_lane_f32::<0>(1.0f32, 2.0f32, create_float32x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmas_lane_f32::<0>(rand::random::<f32>(), rand::random::<f32>(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmas_lane_f32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vfmas_lane_f32::<0>(1.0f32, 2.0f32, create_float32x2_t_from([f32::NAN, f32::NAN]));
        check_float_equality(result, f32::NAN).map_err(|e| crate::cpu::with_call(e, "vfmas_lane_f32::<0>(1.0f32, 2.0f32, create_float32x2_t_from([f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmas_lane_f32::<0>(rand::random::<f32>(), rand::random::<f32>(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmas_lane_f32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vfmas_lane_f32::<0>(1.0f32, 2.0f32, create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]));
        check_float_equality(result, f32::INFINITY).map_err(|e| crate::cpu::with_call(e, "vfmas_lane_f32::<0>(1.0f32, 2.0f32, create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmas_lane_f32::<0>(rand::random::<f32>(), rand::random::<f32>(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmas_lane_f32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vfmas_lane_f32::<1>(1.0f32, 2.0f32, create_float32x2_t_from([3.0, 4.0]));
        check_float_equality(result, 9.0).map_err(|e| crate::cpu::with_call(e, "vfmas_lane_f32::<1>(1.0f32, 2.0f32, create_float32x2_t_from([3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmas_lane_f32::<1>(rand::random::<f32>(), rand::random::<f32>(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmas_laneq_f32() -> Result<Verdict, String> {
    unsafe {
        let result = vfmas_laneq_f32::<0>(1.0f32, 2.0f32, create_float32x4_t_from([3.0, 4.0, 5.0, 6.0]));
        check_float_equality(result, 7.0).map_err(|e| crate::cpu::with_call(e, "vfmas_laneq_f32::<0>(1.0f32, 2.0f32, create_float32x4_t_from([3.0, 4.0, 5.0, 6.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmas_laneq_f32::<0>(rand::random::<f32>(), rand::random::<f32>(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmas_laneq_f32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vfmas_laneq_f32::<0>(1.0f32, 2.0f32, create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]));
        check_float_equality(result, 1.0).map_err(|e| crate::cpu::with_call(e, "vfmas_laneq_f32::<0>(1.0f32, 2.0f32, create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmas_laneq_f32::<0>(rand::random::<f32>(), rand::random::<f32>(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmas_laneq_f32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vfmas_laneq_f32::<0>(1.0f32, 2.0f32, create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]));
        check_float_equality(result, 201.0).map_err(|e| crate::cpu::with_call(e, "vfmas_laneq_f32::<0>(1.0f32, 2.0f32, create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmas_laneq_f32::<0>(rand::random::<f32>(), rand::random::<f32>(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmas_laneq_f32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vfmas_laneq_f32::<0>(1.0f32, 2.0f32, create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_float_equality(result, -f32::INFINITY).map_err(|e| crate::cpu::with_call(e, "vfmas_laneq_f32::<0>(1.0f32, 2.0f32, create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmas_laneq_f32::<0>(rand::random::<f32>(), rand::random::<f32>(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmas_laneq_f32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vfmas_laneq_f32::<0>(1.0f32, 2.0f32, create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_float_equality(result, f32::INFINITY).map_err(|e| crate::cpu::with_call(e, "vfmas_laneq_f32::<0>(1.0f32, 2.0f32, create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmas_laneq_f32::<0>(rand::random::<f32>(), rand::random::<f32>(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmas_laneq_f32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vfmas_laneq_f32::<0>(1.0f32, 2.0f32, create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]));
        check_float_equality(result, 1.0).map_err(|e| crate::cpu::with_call(e, "vfmas_laneq_f32::<0>(1.0f32, 2.0f32, create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmas_laneq_f32::<0>(rand::random::<f32>(), rand::random::<f32>(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmas_laneq_f32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vfmas_laneq_f32::<0>(1.0f32, 2.0f32, create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_float_equality(result, f32::NAN).map_err(|e| crate::cpu::with_call(e, "vfmas_laneq_f32::<0>(1.0f32, 2.0f32, create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmas_laneq_f32::<0>(rand::random::<f32>(), rand::random::<f32>(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmas_laneq_f32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vfmas_laneq_f32::<0>(1.0f32, 2.0f32, create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_float_equality(result, f32::INFINITY).map_err(|e| crate::cpu::with_call(e, "vfmas_laneq_f32::<0>(1.0f32, 2.0f32, create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmas_laneq_f32::<0>(rand::random::<f32>(), rand::random::<f32>(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmas_laneq_f32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vfmas_laneq_f32::<1>(1.0f32, 2.0f32, create_float32x4_t_from([3.0, 4.0, 5.0, 6.0]));
        check_float_equality(result, 9.0).map_err(|e| crate::cpu::with_call(e, "vfmas_laneq_f32::<1>(1.0f32, 2.0f32, create_float32x4_t_from([3.0, 4.0, 5.0, 6.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmas_laneq_f32::<1>(rand::random::<f32>(), rand::random::<f32>(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmas_laneq_f32_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = vfmas_laneq_f32::<3>(1.0f32, 2.0f32, create_float32x4_t_from([3.0, 4.0, 5.0, 6.0]));
        check_float_equality(result, 13.0).map_err(|e| crate::cpu::with_call(e, "vfmas_laneq_f32::<3>(1.0f32, 2.0f32, create_float32x4_t_from([3.0, 4.0, 5.0, 6.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmas_laneq_f32::<3>(rand::random::<f32>(), rand::random::<f32>(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}
