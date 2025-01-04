use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vdupd_lane_f64() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_lane_f64::<0>(create_float64x1_t_from([1.0]));
        check_float_equality(result, 1.0).map_err(|e| crate::cpu::with_call(e, "vdupd_lane_f64::<0>(create_float64x1_t_from([1.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_lane_f64::<0>(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_lane_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_lane_f64::<0>(create_float64x1_t_from([0.0f64]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "vdupd_lane_f64::<0>(create_float64x1_t_from([0.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_lane_f64::<0>(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_lane_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_lane_f64::<0>(create_float64x1_t_from([100.0f64]));
        check_float_equality(result, 100.0).map_err(|e| crate::cpu::with_call(e, "vdupd_lane_f64::<0>(create_float64x1_t_from([100.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_lane_f64::<0>(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_lane_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_lane_f64::<0>(create_float64x1_t_from([f64::MIN]));
        check_float_equality(result, -1.7976931348623157e308).map_err(|e| crate::cpu::with_call(e, "vdupd_lane_f64::<0>(create_float64x1_t_from([f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_lane_f64::<0>(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_lane_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_lane_f64::<0>(create_float64x1_t_from([f64::MAX]));
        check_float_equality(result, 1.7976931348623157e308).map_err(|e| crate::cpu::with_call(e, "vdupd_lane_f64::<0>(create_float64x1_t_from([f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_lane_f64::<0>(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_lane_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_lane_f64::<0>(create_float64x1_t_from([0.0]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "vdupd_lane_f64::<0>(create_float64x1_t_from([0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_lane_f64::<0>(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_lane_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_lane_f64::<0>(create_float64x1_t_from([f64::NAN]));
        check_float_equality(result, f64::NAN).map_err(|e| crate::cpu::with_call(e, "vdupd_lane_f64::<0>(create_float64x1_t_from([f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_lane_f64::<0>(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_lane_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_lane_f64::<0>(create_float64x1_t_from([f64::INFINITY]));
        check_float_equality(result, f64::INFINITY).map_err(|e| crate::cpu::with_call(e, "vdupd_lane_f64::<0>(create_float64x1_t_from([f64::INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_lane_f64::<0>(create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_lane_s64() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_lane_s64::<0>(create_int64x1_t_from([1]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vdupd_lane_s64::<0>(create_int64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_lane_s64::<0>(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_lane_s64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_lane_s64::<0>(create_int64x1_t_from([0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vdupd_lane_s64::<0>(create_int64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_lane_s64::<0>(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_lane_s64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_lane_s64::<0>(create_int64x1_t_from([100]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "vdupd_lane_s64::<0>(create_int64x1_t_from([100]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_lane_s64::<0>(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_lane_s64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_lane_s64::<0>(create_int64x1_t_from([i64::MIN]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "vdupd_lane_s64::<0>(create_int64x1_t_from([i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_lane_s64::<0>(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_lane_s64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_lane_s64::<0>(create_int64x1_t_from([i64::MAX]));
        check_int_equality(result, 9223372036854775807).map_err(|e| crate::cpu::with_call(e, "vdupd_lane_s64::<0>(create_int64x1_t_from([i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_lane_s64::<0>(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_lane_s64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_lane_s64::<0>(create_int64x1_t_from([0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vdupd_lane_s64::<0>(create_int64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_lane_s64::<0>(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_lane_s64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_lane_s64::<0>(create_int64x1_t_from([-1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "vdupd_lane_s64::<0>(create_int64x1_t_from([-1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_lane_s64::<0>(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_lane_s64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_lane_s64::<0>(create_int64x1_t_from([i64::MIN]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "vdupd_lane_s64::<0>(create_int64x1_t_from([i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_lane_s64::<0>(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_lane_u64() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_lane_u64::<0>(create_uint64x1_t_from([1]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vdupd_lane_u64::<0>(create_uint64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_lane_u64::<0>(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_lane_u64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_lane_u64::<0>(create_uint64x1_t_from([0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vdupd_lane_u64::<0>(create_uint64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_lane_u64::<0>(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_lane_u64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_lane_u64::<0>(create_uint64x1_t_from([100]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "vdupd_lane_u64::<0>(create_uint64x1_t_from([100]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_lane_u64::<0>(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_lane_u64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_lane_u64::<0>(create_uint64x1_t_from([u64::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vdupd_lane_u64::<0>(create_uint64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_lane_u64::<0>(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_lane_u64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_lane_u64::<0>(create_uint64x1_t_from([u64::MAX]));
        check_int_equality(result, 18446744073709551615).map_err(|e| crate::cpu::with_call(e, "vdupd_lane_u64::<0>(create_uint64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_lane_u64::<0>(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_lane_u64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_lane_u64::<0>(create_uint64x1_t_from([0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vdupd_lane_u64::<0>(create_uint64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_lane_u64::<0>(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_lane_u64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_lane_u64::<0>(create_uint64x1_t_from([u64::MAX]));
        check_int_equality(result, 18446744073709551615).map_err(|e| crate::cpu::with_call(e, "vdupd_lane_u64::<0>(create_uint64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_lane_u64::<0>(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_lane_u64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_lane_u64::<0>(create_uint64x1_t_from([u64::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vdupd_lane_u64::<0>(create_uint64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_lane_u64::<0>(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_laneq_f64() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_laneq_f64::<0>(create_float64x2_t_from([1.0, 2.0]));
        check_float_equality(result, 1.0).map_err(|e| crate::cpu::with_call(e, "vdupd_laneq_f64::<0>(create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_laneq_f64::<0>(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_laneq_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_laneq_f64::<0>(create_float64x2_t_from([0.0f64, -1.0f64]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "vdupd_laneq_f64::<0>(create_float64x2_t_from([0.0f64, -1.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_laneq_f64::<0>(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_laneq_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_laneq_f64::<0>(create_float64x2_t_from([100.0f64, 200.0f64]));
        check_float_equality(result, 100.0).map_err(|e| crate::cpu::with_call(e, "vdupd_laneq_f64::<0>(create_float64x2_t_from([100.0f64, 200.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_laneq_f64::<0>(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_laneq_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_laneq_f64::<0>(create_float64x2_t_from([f64::MIN, f64::MIN]));
        check_float_equality(result, -1.7976931348623157e308).map_err(|e| crate::cpu::with_call(e, "vdupd_laneq_f64::<0>(create_float64x2_t_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_laneq_f64::<0>(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_laneq_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_laneq_f64::<0>(create_float64x2_t_from([f64::MAX, f64::MAX]));
        check_float_equality(result, 1.7976931348623157e308).map_err(|e| crate::cpu::with_call(e, "vdupd_laneq_f64::<0>(create_float64x2_t_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_laneq_f64::<0>(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_laneq_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_laneq_f64::<0>(create_float64x2_t_from([0.0, 0.0]));
        check_float_equality(result, 0.0).map_err(|e| crate::cpu::with_call(e, "vdupd_laneq_f64::<0>(create_float64x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_laneq_f64::<0>(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_laneq_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_laneq_f64::<0>(create_float64x2_t_from([f64::NAN, f64::NAN]));
        check_float_equality(result, f64::NAN).map_err(|e| crate::cpu::with_call(e, "vdupd_laneq_f64::<0>(create_float64x2_t_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_laneq_f64::<0>(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_laneq_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_laneq_f64::<0>(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_float_equality(result, f64::INFINITY).map_err(|e| crate::cpu::with_call(e, "vdupd_laneq_f64::<0>(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_laneq_f64::<0>(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_laneq_f64_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_laneq_f64::<1>(create_float64x2_t_from([1.0, 2.0]));
        check_float_equality(result, 2.0).map_err(|e| crate::cpu::with_call(e, "vdupd_laneq_f64::<1>(create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_laneq_f64::<1>(create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_laneq_s64() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_laneq_s64::<0>(create_int64x2_t_from([1, 2]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vdupd_laneq_s64::<0>(create_int64x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_laneq_s64::<0>(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_laneq_s64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_laneq_s64::<0>(create_int64x2_t_from([0, -1]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vdupd_laneq_s64::<0>(create_int64x2_t_from([0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_laneq_s64::<0>(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_laneq_s64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_laneq_s64::<0>(create_int64x2_t_from([100, 200]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "vdupd_laneq_s64::<0>(create_int64x2_t_from([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_laneq_s64::<0>(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_laneq_s64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_laneq_s64::<0>(create_int64x2_t_from([i64::MIN, i64::MIN]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "vdupd_laneq_s64::<0>(create_int64x2_t_from([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_laneq_s64::<0>(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_laneq_s64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_laneq_s64::<0>(create_int64x2_t_from([i64::MAX, i64::MAX]));
        check_int_equality(result, 9223372036854775807).map_err(|e| crate::cpu::with_call(e, "vdupd_laneq_s64::<0>(create_int64x2_t_from([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_laneq_s64::<0>(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_laneq_s64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_laneq_s64::<0>(create_int64x2_t_from([0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vdupd_laneq_s64::<0>(create_int64x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_laneq_s64::<0>(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_laneq_s64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_laneq_s64::<0>(create_int64x2_t_from([-1, -1]));
        check_int_equality(result, -1).map_err(|e| crate::cpu::with_call(e, "vdupd_laneq_s64::<0>(create_int64x2_t_from([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_laneq_s64::<0>(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_laneq_s64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_laneq_s64::<0>(create_int64x2_t_from([i64::MIN, i64::MAX]));
        check_int_equality(result, -9223372036854775808).map_err(|e| crate::cpu::with_call(e, "vdupd_laneq_s64::<0>(create_int64x2_t_from([i64::MIN, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_laneq_s64::<0>(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_laneq_s64_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_laneq_s64::<1>(create_int64x2_t_from([1, 2]));
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "vdupd_laneq_s64::<1>(create_int64x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_laneq_s64::<1>(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_laneq_u64() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_laneq_u64::<0>(create_uint64x2_t_from([1, 2]));
        check_int_equality(result, 1).map_err(|e| crate::cpu::with_call(e, "vdupd_laneq_u64::<0>(create_uint64x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_laneq_u64::<0>(create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_laneq_u64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_laneq_u64::<0>(create_uint64x2_t_from([0, 18446744073709551615]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vdupd_laneq_u64::<0>(create_uint64x2_t_from([0, 18446744073709551615]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_laneq_u64::<0>(create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_laneq_u64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_laneq_u64::<0>(create_uint64x2_t_from([100, 200]));
        check_int_equality(result, 100).map_err(|e| crate::cpu::with_call(e, "vdupd_laneq_u64::<0>(create_uint64x2_t_from([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_laneq_u64::<0>(create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_laneq_u64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_laneq_u64::<0>(create_uint64x2_t_from([u64::MIN, u64::MIN]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vdupd_laneq_u64::<0>(create_uint64x2_t_from([u64::MIN, u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_laneq_u64::<0>(create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_laneq_u64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_laneq_u64::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]));
        check_int_equality(result, 18446744073709551615).map_err(|e| crate::cpu::with_call(e, "vdupd_laneq_u64::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_laneq_u64::<0>(create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_laneq_u64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_laneq_u64::<0>(create_uint64x2_t_from([0, 0]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vdupd_laneq_u64::<0>(create_uint64x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_laneq_u64::<0>(create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_laneq_u64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_laneq_u64::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]));
        check_int_equality(result, 18446744073709551615).map_err(|e| crate::cpu::with_call(e, "vdupd_laneq_u64::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_laneq_u64::<0>(create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_laneq_u64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_laneq_u64::<0>(create_uint64x2_t_from([u64::MIN, u64::MAX]));
        check_int_equality(result, 0).map_err(|e| crate::cpu::with_call(e, "vdupd_laneq_u64::<0>(create_uint64x2_t_from([u64::MIN, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_laneq_u64::<0>(create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vdupd_laneq_u64_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = vdupd_laneq_u64::<1>(create_uint64x2_t_from([1, 2]));
        check_int_equality(result, 2).map_err(|e| crate::cpu::with_call(e, "vdupd_laneq_u64::<1>(create_uint64x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vdupd_laneq_u64::<1>(create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}
