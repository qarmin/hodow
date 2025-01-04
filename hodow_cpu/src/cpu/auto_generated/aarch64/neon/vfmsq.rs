use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vfmsq_lane_f32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vfmsq_lane_f32::<0>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x2_t_from([9.0, 10.0])));
        check_float_array_equality(&result, &[-44.0, -52.0, -60.0, -68.0]).map_err(|e| crate::cpu::with_call(e, "vfmsq_lane_f32::<0>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x2_t_from([9.0, 10.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_lane_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_lane_f32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vfmsq_lane_f32::<0>(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create_float32x4_t_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create_float32x2_t_from([20.0f32, 19.0f32])));
        check_float_array_equality(&result, &[-200.0, -181.0, -238.0, -143.0]).map_err(|e| crate::cpu::with_call(e, "vfmsq_lane_f32::<0>(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create_float32x4_t_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create_float32x2_t_from([20.0f32, 19.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_lane_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_lane_f32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vfmsq_lane_f32::<0>(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create_float32x4_t_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create_float32x2_t_from([120.0f32, 220.0f32])));
        check_float_array_equality(&result, &[-13100.0, -25000.0, -36900.0, -48800.0]).map_err(|e| crate::cpu::with_call(e, "vfmsq_lane_f32::<0>(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create_float32x4_t_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create_float32x2_t_from([120.0f32, 220.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_lane_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_lane_f32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vfmsq_lane_f32::<0>(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x2_t_from([f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vfmsq_lane_f32::<0>(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x2_t_from([f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_lane_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_lane_f32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vfmsq_lane_f32::<0>(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x2_t_from([f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vfmsq_lane_f32::<0>(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x2_t_from([f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_lane_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_lane_f32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vfmsq_lane_f32::<0>(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]), create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]), create_float32x2_t_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vfmsq_lane_f32::<0>(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]), create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]), create_float32x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_lane_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_lane_f32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vfmsq_lane_f32::<0>(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create_float32x2_t_from([f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "vfmsq_lane_f32::<0>(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create_float32x2_t_from([f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_lane_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_lane_f32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vfmsq_lane_f32::<0>(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, -f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vfmsq_lane_f32::<0>(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_lane_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_lane_f32_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vfmsq_lane_f32::<0>(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vfmsq_lane_f32::<0>(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_lane_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_lane_f32_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vfmsq_lane_f32::<0>(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vfmsq_lane_f32::<0>(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_lane_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_lane_f32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vfmsq_lane_f32::<1>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x2_t_from([9.0, 10.0])));
        check_float_array_equality(&result, &[-49.0, -58.0, -67.0, -76.0]).map_err(|e| crate::cpu::with_call(e, "vfmsq_lane_f32::<1>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x2_t_from([9.0, 10.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_lane_f32::<1>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_laneq_f32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vfmsq_laneq_f32::<0>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x4_t_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[-44.0, -52.0, -60.0, -68.0]).map_err(|e| crate::cpu::with_call(e, "vfmsq_laneq_f32::<0>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x4_t_from([9.0, 10.0, 11.0, 12.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_laneq_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_laneq_f32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vfmsq_laneq_f32::<0>(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create_float32x4_t_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create_float32x4_t_from([20.0f32, 19.0f32, 22.0f32, 17.0f32])));
        check_float_array_equality(&result, &[-200.0, -181.0, -238.0, -143.0]).map_err(|e| crate::cpu::with_call(e, "vfmsq_laneq_f32::<0>(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create_float32x4_t_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create_float32x4_t_from([20.0f32, 19.0f32, 22.0f32, 17.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_laneq_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_laneq_f32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vfmsq_laneq_f32::<0>(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create_float32x4_t_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create_float32x4_t_from([120.0f32, 220.0f32, 320.0f32, 420.0f32])));
        check_float_array_equality(&result, &[-13100.0, -25000.0, -36900.0, -48800.0]).map_err(|e| crate::cpu::with_call(e, "vfmsq_laneq_f32::<0>(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create_float32x4_t_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create_float32x4_t_from([120.0f32, 220.0f32, 320.0f32, 420.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_laneq_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_laneq_f32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vfmsq_laneq_f32::<0>(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vfmsq_laneq_f32::<0>(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_laneq_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_laneq_f32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vfmsq_laneq_f32::<0>(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vfmsq_laneq_f32::<0>(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_laneq_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_laneq_f32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vfmsq_laneq_f32::<0>(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]), create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]), create_float32x4_t_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vfmsq_laneq_f32::<0>(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]), create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]), create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_laneq_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_laneq_f32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vfmsq_laneq_f32::<0>(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "vfmsq_laneq_f32::<0>(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_laneq_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_laneq_f32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vfmsq_laneq_f32::<0>(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, -f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vfmsq_laneq_f32::<0>(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_laneq_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_laneq_f32_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vfmsq_laneq_f32::<0>(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vfmsq_laneq_f32::<0>(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_laneq_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_laneq_f32_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vfmsq_laneq_f32::<0>(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vfmsq_laneq_f32::<0>(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_laneq_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_laneq_f32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vfmsq_laneq_f32::<1>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x4_t_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[-49.0, -58.0, -67.0, -76.0]).map_err(|e| crate::cpu::with_call(e, "vfmsq_laneq_f32::<1>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x4_t_from([9.0, 10.0, 11.0, 12.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_laneq_f32::<1>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_laneq_f32_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vfmsq_laneq_f32::<3>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x4_t_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[-59.0, -70.0, -81.0, -92.0]).map_err(|e| crate::cpu::with_call(e, "vfmsq_laneq_f32::<3>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x4_t_from([9.0, 10.0, 11.0, 12.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_laneq_f32::<3>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_laneq_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_laneq_f64::<0>(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]), create_float64x2_t_from([5.0, 6.0])));
        check_float_array_equality(&result, &[-14.0, -18.0]).map_err(|e| crate::cpu::with_call(e, "vfmsq_laneq_f64::<0>(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]), create_float64x2_t_from([5.0, 6.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_laneq_f64::<0>(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_laneq_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_laneq_f64::<0>(create_float64x2_t_from([0.0f64, -1.0f64]), create_float64x2_t_from([10.0f64, 9.0f64]), create_float64x2_t_from([20.0f64, 19.0f64])));
        check_float_array_equality(&result, &[-200.0, -181.0]).map_err(|e| crate::cpu::with_call(e, "vfmsq_laneq_f64::<0>(create_float64x2_t_from([0.0f64, -1.0f64]), create_float64x2_t_from([10.0f64, 9.0f64]), create_float64x2_t_from([20.0f64, 19.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_laneq_f64::<0>(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_laneq_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_laneq_f64::<0>(create_float64x2_t_from([100.0f64, 200.0f64]), create_float64x2_t_from([110.0f64, 210.0f64]), create_float64x2_t_from([120.0f64, 220.0f64])));
        check_float_array_equality(&result, &[-13100.0, -25000.0]).map_err(|e| crate::cpu::with_call(e, "vfmsq_laneq_f64::<0>(create_float64x2_t_from([100.0f64, 200.0f64]), create_float64x2_t_from([110.0f64, 210.0f64]), create_float64x2_t_from([120.0f64, 220.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_laneq_f64::<0>(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_laneq_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_laneq_f64::<0>(create_float64x2_t_from([f64::MIN, f64::MIN]), create_float64x2_t_from([f64::MIN, f64::MIN]), create_float64x2_t_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vfmsq_laneq_f64::<0>(create_float64x2_t_from([f64::MIN, f64::MIN]), create_float64x2_t_from([f64::MIN, f64::MIN]), create_float64x2_t_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_laneq_f64::<0>(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_laneq_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_laneq_f64::<0>(create_float64x2_t_from([f64::MAX, f64::MAX]), create_float64x2_t_from([f64::MAX, f64::MAX]), create_float64x2_t_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vfmsq_laneq_f64::<0>(create_float64x2_t_from([f64::MAX, f64::MAX]), create_float64x2_t_from([f64::MAX, f64::MAX]), create_float64x2_t_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_laneq_f64::<0>(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_laneq_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_laneq_f64::<0>(create_float64x2_t_from([0.0, 0.0]), create_float64x2_t_from([0.0, 0.0]), create_float64x2_t_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vfmsq_laneq_f64::<0>(create_float64x2_t_from([0.0, 0.0]), create_float64x2_t_from([0.0, 0.0]), create_float64x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_laneq_f64::<0>(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_laneq_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_laneq_f64::<0>(create_float64x2_t_from([f64::NAN, f64::NAN]), create_float64x2_t_from([f64::NAN, f64::NAN]), create_float64x2_t_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vfmsq_laneq_f64::<0>(create_float64x2_t_from([f64::NAN, f64::NAN]), create_float64x2_t_from([f64::NAN, f64::NAN]), create_float64x2_t_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_laneq_f64::<0>(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_laneq_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_laneq_f64::<0>(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]), create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]), create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vfmsq_laneq_f64::<0>(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]), create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]), create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_laneq_f64::<0>(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_laneq_f64_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_laneq_f64::<0>(create_float64x2_t_from([f64::MIN, f64::MIN]), create_float64x2_t_from([f64::MAX, f64::MAX]), create_float64x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vfmsq_laneq_f64::<0>(create_float64x2_t_from([f64::MIN, f64::MIN]), create_float64x2_t_from([f64::MAX, f64::MAX]), create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_laneq_f64::<0>(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_laneq_f64_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_laneq_f64::<0>(create_float64x2_t_from([f64::MAX, f64::MAX]), create_float64x2_t_from([f64::MIN, f64::MIN]), create_float64x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vfmsq_laneq_f64::<0>(create_float64x2_t_from([f64::MAX, f64::MAX]), create_float64x2_t_from([f64::MIN, f64::MIN]), create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_laneq_f64::<0>(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_laneq_f64_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_laneq_f64::<1>(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]), create_float64x2_t_from([5.0, 6.0])));
        check_float_array_equality(&result, &[-17.0, -22.0]).map_err(|e| crate::cpu::with_call(e, "vfmsq_laneq_f64::<1>(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]), create_float64x2_t_from([5.0, 6.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_laneq_f64::<1>(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]), create_float64x2_t_from([5.0, 6.0])));
        check_float_array_equality(&result, &[-14.0, -22.0]).map_err(|e| crate::cpu::with_call(e, "vfmsq_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]), create_float64x2_t_from([5.0, 6.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_f64(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_f64(create_float64x2_t_from([0.0f64, -1.0f64]), create_float64x2_t_from([10.0f64, 9.0f64]), create_float64x2_t_from([20.0f64, 19.0f64])));
        check_float_array_equality(&result, &[-200.0, -172.0]).map_err(|e| crate::cpu::with_call(e, "vfmsq_f64(create_float64x2_t_from([0.0f64, -1.0f64]), create_float64x2_t_from([10.0f64, 9.0f64]), create_float64x2_t_from([20.0f64, 19.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_f64(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_f64(create_float64x2_t_from([100.0f64, 200.0f64]), create_float64x2_t_from([110.0f64, 210.0f64]), create_float64x2_t_from([120.0f64, 220.0f64])));
        check_float_array_equality(&result, &[-13100.0, -46000.0]).map_err(|e| crate::cpu::with_call(e, "vfmsq_f64(create_float64x2_t_from([100.0f64, 200.0f64]), create_float64x2_t_from([110.0f64, 210.0f64]), create_float64x2_t_from([120.0f64, 220.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_f64(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_f64(create_float64x2_t_from([f64::MIN, f64::MIN]), create_float64x2_t_from([f64::MIN, f64::MIN]), create_float64x2_t_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vfmsq_f64(create_float64x2_t_from([f64::MIN, f64::MIN]), create_float64x2_t_from([f64::MIN, f64::MIN]), create_float64x2_t_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_f64(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_f64(create_float64x2_t_from([f64::MAX, f64::MAX]), create_float64x2_t_from([f64::MAX, f64::MAX]), create_float64x2_t_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vfmsq_f64(create_float64x2_t_from([f64::MAX, f64::MAX]), create_float64x2_t_from([f64::MAX, f64::MAX]), create_float64x2_t_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_f64(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_f64(create_float64x2_t_from([0.0, 0.0]), create_float64x2_t_from([0.0, 0.0]), create_float64x2_t_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vfmsq_f64(create_float64x2_t_from([0.0, 0.0]), create_float64x2_t_from([0.0, 0.0]), create_float64x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_f64(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_f64(create_float64x2_t_from([f64::NAN, f64::NAN]), create_float64x2_t_from([f64::NAN, f64::NAN]), create_float64x2_t_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vfmsq_f64(create_float64x2_t_from([f64::NAN, f64::NAN]), create_float64x2_t_from([f64::NAN, f64::NAN]), create_float64x2_t_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_f64(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]), create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]), create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::NAN, -f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vfmsq_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]), create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]), create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_f64(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_f64_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_f64(create_float64x2_t_from([f64::MIN, f64::MIN]), create_float64x2_t_from([f64::MAX, f64::MAX]), create_float64x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vfmsq_f64(create_float64x2_t_from([f64::MIN, f64::MIN]), create_float64x2_t_from([f64::MAX, f64::MAX]), create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_f64(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_f64_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_f64(create_float64x2_t_from([f64::MAX, f64::MAX]), create_float64x2_t_from([f64::MIN, f64::MIN]), create_float64x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vfmsq_f64(create_float64x2_t_from([f64::MAX, f64::MAX]), create_float64x2_t_from([f64::MIN, f64::MIN]), create_float64x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_f64(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_lane_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_lane_f64::<0>(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]), create_float64x1_t_from([5.0])));
        check_float_array_equality(&result, &[-14.0, -18.0]).map_err(|e| crate::cpu::with_call(e, "vfmsq_lane_f64::<0>(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]), create_float64x1_t_from([5.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_lane_f64::<0>(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_lane_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_lane_f64::<0>(create_float64x2_t_from([0.0f64, -1.0f64]), create_float64x2_t_from([10.0f64, 9.0f64]), create_float64x1_t_from([20.0f64])));
        check_float_array_equality(&result, &[-200.0, -181.0]).map_err(|e| crate::cpu::with_call(e, "vfmsq_lane_f64::<0>(create_float64x2_t_from([0.0f64, -1.0f64]), create_float64x2_t_from([10.0f64, 9.0f64]), create_float64x1_t_from([20.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_lane_f64::<0>(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_lane_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_lane_f64::<0>(create_float64x2_t_from([100.0f64, 200.0f64]), create_float64x2_t_from([110.0f64, 210.0f64]), create_float64x1_t_from([120.0f64])));
        check_float_array_equality(&result, &[-13100.0, -25000.0]).map_err(|e| crate::cpu::with_call(e, "vfmsq_lane_f64::<0>(create_float64x2_t_from([100.0f64, 200.0f64]), create_float64x2_t_from([110.0f64, 210.0f64]), create_float64x1_t_from([120.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_lane_f64::<0>(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_lane_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_lane_f64::<0>(create_float64x2_t_from([f64::MIN, f64::MIN]), create_float64x2_t_from([f64::MIN, f64::MIN]), create_float64x1_t_from([f64::MIN])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vfmsq_lane_f64::<0>(create_float64x2_t_from([f64::MIN, f64::MIN]), create_float64x2_t_from([f64::MIN, f64::MIN]), create_float64x1_t_from([f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_lane_f64::<0>(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_lane_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_lane_f64::<0>(create_float64x2_t_from([f64::MAX, f64::MAX]), create_float64x2_t_from([f64::MAX, f64::MAX]), create_float64x1_t_from([f64::MAX])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vfmsq_lane_f64::<0>(create_float64x2_t_from([f64::MAX, f64::MAX]), create_float64x2_t_from([f64::MAX, f64::MAX]), create_float64x1_t_from([f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_lane_f64::<0>(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_lane_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_lane_f64::<0>(create_float64x2_t_from([0.0, 0.0]), create_float64x2_t_from([0.0, 0.0]), create_float64x1_t_from([0.0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vfmsq_lane_f64::<0>(create_float64x2_t_from([0.0, 0.0]), create_float64x2_t_from([0.0, 0.0]), create_float64x1_t_from([0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_lane_f64::<0>(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_lane_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_lane_f64::<0>(create_float64x2_t_from([f64::NAN, f64::NAN]), create_float64x2_t_from([f64::NAN, f64::NAN]), create_float64x1_t_from([f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vfmsq_lane_f64::<0>(create_float64x2_t_from([f64::NAN, f64::NAN]), create_float64x2_t_from([f64::NAN, f64::NAN]), create_float64x1_t_from([f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_lane_f64::<0>(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_lane_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_lane_f64::<0>(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]), create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]), create_float64x1_t_from([f64::INFINITY])));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vfmsq_lane_f64::<0>(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]), create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]), create_float64x1_t_from([f64::INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_lane_f64::<0>(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_lane_f64_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_lane_f64::<0>(create_float64x2_t_from([f64::MIN, f64::MIN]), create_float64x2_t_from([f64::MAX, f64::MAX]), create_float64x1_t_from([1.0])));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vfmsq_lane_f64::<0>(create_float64x2_t_from([f64::MIN, f64::MIN]), create_float64x2_t_from([f64::MAX, f64::MAX]), create_float64x1_t_from([1.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_lane_f64::<0>(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_lane_f64_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_lane_f64::<0>(create_float64x2_t_from([f64::MAX, f64::MAX]), create_float64x2_t_from([f64::MIN, f64::MIN]), create_float64x1_t_from([1.0])));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vfmsq_lane_f64::<0>(create_float64x2_t_from([f64::MAX, f64::MAX]), create_float64x2_t_from([f64::MIN, f64::MIN]), create_float64x1_t_from([1.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_lane_f64::<0>(create_random_float64x2_t(), create_random_float64x2_t(), create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_n_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_n_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]), 5.0f64));
        check_float_array_equality(&result, &[-14.0, -18.0]).map_err(|e| crate::cpu::with_call(e, "vfmsq_n_f64(create_float64x2_t_from([1.0, 2.0]), create_float64x2_t_from([3.0, 4.0]), 5.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_n_f64(create_random_float64x2_t(), create_random_float64x2_t(), rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_n_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_n_f64(create_float64x2_t_from([0.0f64, -1.0f64]), create_float64x2_t_from([10.0f64, 9.0f64]), 1.0f64));
        check_float_array_equality(&result, &[-10.0, -10.0]).map_err(|e| crate::cpu::with_call(e, "vfmsq_n_f64(create_float64x2_t_from([0.0f64, -1.0f64]), create_float64x2_t_from([10.0f64, 9.0f64]), 1.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_n_f64(create_random_float64x2_t(), create_random_float64x2_t(), rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_n_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_n_f64(create_float64x2_t_from([100.0f64, 200.0f64]), create_float64x2_t_from([110.0f64, 210.0f64]), 1.0f64));
        check_float_array_equality(&result, &[-10.0, -10.0]).map_err(|e| crate::cpu::with_call(e, "vfmsq_n_f64(create_float64x2_t_from([100.0f64, 200.0f64]), create_float64x2_t_from([110.0f64, 210.0f64]), 1.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_n_f64(create_random_float64x2_t(), create_random_float64x2_t(), rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_n_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_n_f64(create_float64x2_t_from([f64::MIN, f64::MIN]), create_float64x2_t_from([f64::MIN, f64::MIN]), 1.0f64));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vfmsq_n_f64(create_float64x2_t_from([f64::MIN, f64::MIN]), create_float64x2_t_from([f64::MIN, f64::MIN]), 1.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_n_f64(create_random_float64x2_t(), create_random_float64x2_t(), rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_n_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_n_f64(create_float64x2_t_from([f64::MAX, f64::MAX]), create_float64x2_t_from([f64::MAX, f64::MAX]), 1.0f64));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vfmsq_n_f64(create_float64x2_t_from([f64::MAX, f64::MAX]), create_float64x2_t_from([f64::MAX, f64::MAX]), 1.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_n_f64(create_random_float64x2_t(), create_random_float64x2_t(), rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_n_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_n_f64(create_float64x2_t_from([0.0, 0.0]), create_float64x2_t_from([0.0, 0.0]), 1.0f64));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vfmsq_n_f64(create_float64x2_t_from([0.0, 0.0]), create_float64x2_t_from([0.0, 0.0]), 1.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_n_f64(create_random_float64x2_t(), create_random_float64x2_t(), rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_n_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_n_f64(create_float64x2_t_from([f64::NAN, f64::NAN]), create_float64x2_t_from([f64::NAN, f64::NAN]), 1.0f64));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vfmsq_n_f64(create_float64x2_t_from([f64::NAN, f64::NAN]), create_float64x2_t_from([f64::NAN, f64::NAN]), 1.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_n_f64(create_random_float64x2_t(), create_random_float64x2_t(), rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_n_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_n_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]), create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]), 1.0f64));
        check_float_array_equality(&result, &[f64::NAN, f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vfmsq_n_f64(create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]), create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]), 1.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_n_f64(create_random_float64x2_t(), create_random_float64x2_t(), rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_n_f64_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_n_f64(create_float64x2_t_from([f64::MIN, f64::MIN]), create_float64x2_t_from([f64::MAX, f64::MAX]), 1.0f64));
        check_float_array_equality(&result, &[-f64::INFINITY, -f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vfmsq_n_f64(create_float64x2_t_from([f64::MIN, f64::MIN]), create_float64x2_t_from([f64::MAX, f64::MAX]), 1.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_n_f64(create_random_float64x2_t(), create_random_float64x2_t(), rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vfmsq_n_f64_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x2_t_to_f64_array(vfmsq_n_f64(create_float64x2_t_from([f64::MAX, f64::MAX]), create_float64x2_t_from([f64::MIN, f64::MIN]), 1.0f64));
        check_float_array_equality(&result, &[f64::INFINITY, f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vfmsq_n_f64(create_float64x2_t_from([f64::MAX, f64::MAX]), create_float64x2_t_from([f64::MIN, f64::MIN]), 1.0f64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vfmsq_n_f64(create_random_float64x2_t(), create_random_float64x2_t(), rand::random::<f64>());
        });
        Ok(Verdict::Checked)
    }
}
