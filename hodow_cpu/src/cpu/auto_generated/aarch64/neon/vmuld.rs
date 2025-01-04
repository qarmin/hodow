use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vmuld_lane_f64() -> Result<Verdict, String> {
    unsafe {
        let result = vmuld_lane_f64::<0>(1.0f64, create_float64x1_t_from([2.0]));
        check_float_equality(result, 2.0).map_err(|e| crate::cpu::with_call(e, "vmuld_lane_f64::<0>(1.0f64, create_float64x1_t_from([2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmuld_lane_f64::<0>(rand::random::<f64>(), create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmuld_lane_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vmuld_lane_f64::<0>(1.0f64, create_float64x1_t_from([0.0f64]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "vmuld_lane_f64::<0>(1.0f64, create_float64x1_t_from([0.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmuld_lane_f64::<0>(rand::random::<f64>(), create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmuld_lane_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vmuld_lane_f64::<0>(1.0f64, create_float64x1_t_from([100.0f64]));
        check_float_equality(result, 100.0).map_err(|e| crate::cpu::with_call(e, "vmuld_lane_f64::<0>(1.0f64, create_float64x1_t_from([100.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmuld_lane_f64::<0>(rand::random::<f64>(), create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmuld_lane_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vmuld_lane_f64::<0>(1.0f64, create_float64x1_t_from([f64::MIN]));
        check_float_equality(result, -1.7976931348623157e308).map_err(|e| crate::cpu::with_call(e, "vmuld_lane_f64::<0>(1.0f64, create_float64x1_t_from([f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmuld_lane_f64::<0>(rand::random::<f64>(), create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmuld_lane_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vmuld_lane_f64::<0>(1.0f64, create_float64x1_t_from([f64::MAX]));
        check_float_equality(result, 1.7976931348623157e308).map_err(|e| crate::cpu::with_call(e, "vmuld_lane_f64::<0>(1.0f64, create_float64x1_t_from([f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmuld_lane_f64::<0>(rand::random::<f64>(), create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmuld_lane_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vmuld_lane_f64::<0>(1.0f64, create_float64x1_t_from([0.0]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "vmuld_lane_f64::<0>(1.0f64, create_float64x1_t_from([0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmuld_lane_f64::<0>(rand::random::<f64>(), create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmuld_lane_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vmuld_lane_f64::<0>(1.0f64, create_float64x1_t_from([f64::NAN]));
        check_float_equality(result, f64::NAN).map_err(|e| crate::cpu::with_call(e, "vmuld_lane_f64::<0>(1.0f64, create_float64x1_t_from([f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmuld_lane_f64::<0>(rand::random::<f64>(), create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmuld_lane_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vmuld_lane_f64::<0>(1.0f64, create_float64x1_t_from([f64::INFINITY]));
        check_float_equality(result, f64::INFINITY).map_err(|e| crate::cpu::with_call(e, "vmuld_lane_f64::<0>(1.0f64, create_float64x1_t_from([f64::INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmuld_lane_f64::<0>(rand::random::<f64>(), create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmuld_laneq_f64() -> Result<Verdict, String> {
    unsafe {
        let result = vmuld_laneq_f64::<0>(1.0f64, create_float64x2_t_from([2.0, 3.0]));
        check_float_equality(result, 2.0).map_err(|e| crate::cpu::with_call(e, "vmuld_laneq_f64::<0>(1.0f64, create_float64x2_t_from([2.0, 3.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmuld_laneq_f64::<0>(rand::random::<f64>(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmuld_laneq_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vmuld_laneq_f64::<0>(1.0f64, create_float64x2_t_from([0.0f64, -1.0f64]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "vmuld_laneq_f64::<0>(1.0f64, create_float64x2_t_from([0.0f64, -1.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmuld_laneq_f64::<0>(rand::random::<f64>(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmuld_laneq_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vmuld_laneq_f64::<0>(1.0f64, create_float64x2_t_from([100.0f64, 200.0f64]));
        check_float_equality(result, 100.0).map_err(|e| crate::cpu::with_call(e, "vmuld_laneq_f64::<0>(1.0f64, create_float64x2_t_from([100.0f64, 200.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmuld_laneq_f64::<0>(rand::random::<f64>(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmuld_laneq_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vmuld_laneq_f64::<0>(1.0f64, create_float64x2_t_from([f64::MIN, f64::MIN]));
        check_float_equality(result, -1.7976931348623157e308).map_err(|e| crate::cpu::with_call(e, "vmuld_laneq_f64::<0>(1.0f64, create_float64x2_t_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmuld_laneq_f64::<0>(rand::random::<f64>(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmuld_laneq_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vmuld_laneq_f64::<0>(1.0f64, create_float64x2_t_from([f64::MAX, f64::MAX]));
        check_float_equality(result, 1.7976931348623157e308).map_err(|e| crate::cpu::with_call(e, "vmuld_laneq_f64::<0>(1.0f64, create_float64x2_t_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmuld_laneq_f64::<0>(rand::random::<f64>(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmuld_laneq_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vmuld_laneq_f64::<0>(1.0f64, create_float64x2_t_from([0.0, 0.0]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "vmuld_laneq_f64::<0>(1.0f64, create_float64x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmuld_laneq_f64::<0>(rand::random::<f64>(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmuld_laneq_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vmuld_laneq_f64::<0>(1.0f64, create_float64x2_t_from([f64::NAN, f64::NAN]));
        check_float_equality(result, f64::NAN).map_err(|e| crate::cpu::with_call(e, "vmuld_laneq_f64::<0>(1.0f64, create_float64x2_t_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmuld_laneq_f64::<0>(rand::random::<f64>(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmuld_laneq_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vmuld_laneq_f64::<0>(1.0f64, create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_float_equality(result, f64::INFINITY).map_err(|e| crate::cpu::with_call(e, "vmuld_laneq_f64::<0>(1.0f64, create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmuld_laneq_f64::<0>(rand::random::<f64>(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmuld_laneq_f64_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vmuld_laneq_f64::<1>(1.0f64, create_float64x2_t_from([2.0, 3.0]));
        check_float_equality(result, 3.0).map_err(|e| crate::cpu::with_call(e, "vmuld_laneq_f64::<1>(1.0f64, create_float64x2_t_from([2.0, 3.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmuld_laneq_f64::<1>(rand::random::<f64>(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}
