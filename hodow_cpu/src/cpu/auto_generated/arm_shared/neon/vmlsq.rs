#[cfg(target_arch = "arm")]
use std::arch::arm::*;
#[cfg(target_arch = "aarch64")]
use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_arm_shared_neon_vmlsq_f32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x4_t_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[-44.0, -58.0, -74.0, -92.0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x4_t_from([9.0, 10.0, 11.0, 12.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_f32(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_f32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_f32(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create_float32x4_t_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create_float32x4_t_from([20.0f32, 19.0f32, 22.0f32, 17.0f32])));
        check_float_array_equality(&result, &[-200.0, -172.0, -262.0, -122.0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_f32(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create_float32x4_t_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create_float32x4_t_from([20.0f32, 19.0f32, 22.0f32, 17.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_f32(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_f32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_f32(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create_float32x4_t_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create_float32x4_t_from([120.0f32, 220.0f32, 320.0f32, 420.0f32])));
        check_float_array_equality(&result, &[-13100.0, -46000.0, -98900.0, -171800.0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_f32(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create_float32x4_t_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create_float32x4_t_from([120.0f32, 220.0f32, 320.0f32, 420.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_f32(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_f32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_f32(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vmlsq_f32(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_f32(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_f32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_f32(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vmlsq_f32(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_f32(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_f32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_f32(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]), create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]), create_float32x4_t_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_f32(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]), create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]), create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_f32(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_f32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_f32(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "vmlsq_f32(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_f32(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_f32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_f32(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE]), create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE]), create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE])));
        check_float_array_equality(&result, &[f32::NAN, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| crate::cpu::with_call(e, "vmlsq_f32(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE]), create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE]), create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_f32(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_f32_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_f32(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vmlsq_f32(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_f32(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_f32_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_f32(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vmlsq_f32(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_f32(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_f32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_lane_f32::<0>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x2_t_from([9.0, 10.0])));
        check_float_array_equality(&result, &[-44.0, -52.0, -60.0, -68.0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_f32::<0>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x2_t_from([9.0, 10.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_f32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_lane_f32::<0>(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create_float32x4_t_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create_float32x2_t_from([20.0f32, 19.0f32])));
        check_float_array_equality(&result, &[-200.0, -181.0, -238.0, -143.0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_f32::<0>(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create_float32x4_t_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create_float32x2_t_from([20.0f32, 19.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_f32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_lane_f32::<0>(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create_float32x4_t_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create_float32x2_t_from([120.0f32, 220.0f32])));
        check_float_array_equality(&result, &[-13100.0, -25000.0, -36900.0, -48800.0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_f32::<0>(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create_float32x4_t_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create_float32x2_t_from([120.0f32, 220.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_f32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_lane_f32::<0>(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x2_t_from([f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_f32::<0>(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x2_t_from([f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_f32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_lane_f32::<0>(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x2_t_from([f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_f32::<0>(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x2_t_from([f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_f32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_lane_f32::<0>(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]), create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]), create_float32x2_t_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_f32::<0>(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]), create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]), create_float32x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_f32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_lane_f32::<0>(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create_float32x2_t_from([f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_f32::<0>(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create_float32x2_t_from([f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_f32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_lane_f32::<0>(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE]), create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE]), create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, -f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_f32::<0>(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE]), create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE]), create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_f32_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_lane_f32::<0>(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_f32::<0>(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_f32_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_lane_f32::<0>(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x2_t_from([1.0, 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_f32::<0>(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x2_t_from([1.0, 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_f32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_lane_f32::<1>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x2_t_from([9.0, 10.0])));
        check_float_array_equality(&result, &[-49.0, -58.0, -67.0, -76.0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_f32::<1>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x2_t_from([9.0, 10.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_f32::<1>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_f32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_laneq_f32::<0>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x4_t_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[-44.0, -52.0, -60.0, -68.0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_f32::<0>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x4_t_from([9.0, 10.0, 11.0, 12.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_f32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_laneq_f32::<0>(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create_float32x4_t_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create_float32x4_t_from([20.0f32, 19.0f32, 22.0f32, 17.0f32])));
        check_float_array_equality(&result, &[-200.0, -181.0, -238.0, -143.0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_f32::<0>(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create_float32x4_t_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), create_float32x4_t_from([20.0f32, 19.0f32, 22.0f32, 17.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_f32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_laneq_f32::<0>(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create_float32x4_t_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create_float32x4_t_from([120.0f32, 220.0f32, 320.0f32, 420.0f32])));
        check_float_array_equality(&result, &[-13100.0, -25000.0, -36900.0, -48800.0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_f32::<0>(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create_float32x4_t_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), create_float32x4_t_from([120.0f32, 220.0f32, 320.0f32, 420.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_f32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_laneq_f32::<0>(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_f32::<0>(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_f32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_laneq_f32::<0>(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_f32::<0>(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_f32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_laneq_f32::<0>(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]), create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]), create_float32x4_t_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_f32::<0>(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]), create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]), create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_f32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_laneq_f32::<0>(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_f32::<0>(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_f32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_laneq_f32::<0>(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE]), create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE]), create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, -f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_f32::<0>(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE]), create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE]), create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_f32_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_laneq_f32::<0>(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_f32::<0>(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_f32_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_laneq_f32::<0>(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_f32::<0>(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_f32::<0>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_f32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_laneq_f32::<1>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x4_t_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[-49.0, -58.0, -67.0, -76.0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_f32::<1>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x4_t_from([9.0, 10.0, 11.0, 12.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_f32::<1>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_f32_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_laneq_f32::<3>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x4_t_from([9.0, 10.0, 11.0, 12.0])));
        check_float_array_equality(&result, &[-59.0, -70.0, -81.0, -92.0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_f32::<3>(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), create_float32x4_t_from([9.0, 10.0, 11.0, 12.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_f32::<3>(create_random_float32x4_t(), create_random_float32x4_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_lane_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x4_t_from([17, 18, 19, 20])));
        check_array_equality(&result, &[-152, -168, -184, -200, -216, -232, -248, -264]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x4_t_from([17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_lane_s16::<0>(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3]), create_int16x4_t_from([20, 19, 22, 17])));
        check_array_equality(&result, &[-200, -181, -238, -143, -276, -105, -314, -67]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_s16::<0>(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3]), create_int16x4_t_from([20, 19, 22, 17]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_lane_s16::<0>(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_int16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810]), create_int16x4_t_from([120, 220, 320, 420])));
        check_array_equality(&result, &[-13100, -25000, 28636, 16736, 4836, -7064, -18964, -30864]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_s16::<0>(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_int16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810]), create_int16x4_t_from([120, 220, 320, 420]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_lane_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_lane_s16::<0>(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32766, 32766, 32766, 32766, 32766, 32766, 32766, 32766]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_s16::<0>(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_lane_s16::<0>(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int16x4_t_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_s16::<0>(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int16x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_lane_s16::<0>(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int16x4_t_from([-1, -1, -1, -1])));
        check_array_equality(&result, &[-2, -2, -2, -2, -2, -2, -2, -2]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_s16::<0>(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int16x4_t_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_lane_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, -1, 0, 32767, -32768, -1, 0, 32767]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_s16_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_lane_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_s16_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_lane_s16::<0>(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_s16::<0>(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_s16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_lane_s16::<1>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x4_t_from([17, 18, 19, 20])));
        check_array_equality(&result, &[-161, -178, -195, -212, -229, -246, -263, -280]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_s16::<1>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x4_t_from([17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_s16::<1>(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_s16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_lane_s16::<3>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x4_t_from([17, 18, 19, 20])));
        check_array_equality(&result, &[-179, -198, -217, -236, -255, -274, -293, -312]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_s16::<3>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x4_t_from([17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_s16::<3>(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_u16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_lane_u16::<0>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint16x4_t_from([17, 18, 19, 20])));
        check_array_equality(&result, &[65384, 65368, 65352, 65336, 65320, 65304, 65288, 65272]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_u16::<0>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint16x4_t_from([17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_u16::<0>(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_lane_u16::<0>(create_uint16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]), create_uint16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3]), create_uint16x4_t_from([20, 19, 22, 17])));
        check_array_equality(&result, &[65336, 65355, 65298, 65393, 65260, 65431, 65222, 65469]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_u16::<0>(create_uint16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]), create_uint16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3]), create_uint16x4_t_from([20, 19, 22, 17]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_u16::<0>(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_lane_u16::<0>(create_uint16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_uint16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810]), create_uint16x4_t_from([120, 220, 320, 420])));
        check_array_equality(&result, &[52436, 40536, 28636, 16736, 4836, 58472, 46572, 34672]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_u16::<0>(create_uint16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_uint16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810]), create_uint16x4_t_from([120, 220, 320, 420]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_u16::<0>(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_lane_u16::<0>(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_u16::<0>(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_u16::<0>(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_lane_u16::<0>(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65534, 65534, 65534, 65534, 65534, 65534, 65534, 65534]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_u16::<0>(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_u16::<0>(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_lane_u16::<0>(create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint16x4_t_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_u16::<0>(create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint16x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_u16::<0>(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_lane_u16::<0>(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65534, 65534, 65534, 65534, 65534, 65534, 65534, 65534]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_u16::<0>(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_u16::<0>(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_lane_u16::<0>(create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create_uint16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX])));
        check_array_equality(&result, &[0, 65535, 0, 65535, 0, 65535, 0, 65535]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_u16::<0>(create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create_uint16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_u16::<0>(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_u16_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_lane_u16::<0>(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_u16::<0>(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_u16::<0>(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_u16_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_lane_u16::<0>(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_u16::<0>(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_u16::<0>(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_u16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_lane_u16::<1>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint16x4_t_from([17, 18, 19, 20])));
        check_array_equality(&result, &[65375, 65358, 65341, 65324, 65307, 65290, 65273, 65256]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_u16::<1>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint16x4_t_from([17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_u16::<1>(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_u16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_lane_u16::<3>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint16x4_t_from([17, 18, 19, 20])));
        check_array_equality(&result, &[65357, 65338, 65319, 65300, 65281, 65262, 65243, 65224]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_u16::<3>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint16x4_t_from([17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_u16::<3>(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_laneq_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[-152, -168, -184, -200, -216, -232, -248, -264]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_laneq_s16::<0>(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3]), create_int16x8_t_from([20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[-200, -181, -238, -143, -276, -105, -314, -67]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_s16::<0>(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3]), create_int16x8_t_from([20, 19, 22, 17, 24, 15, 26, 13]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_laneq_s16::<0>(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_int16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810]), create_int16x8_t_from([120, 220, 320, 420, 520, 620, 720, 820])));
        check_array_equality(&result, &[-13100, -25000, 28636, 16736, 4836, -7064, -18964, -30864]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_s16::<0>(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_int16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810]), create_int16x8_t_from([120, 220, 320, 420, 520, 620, 720, 820]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_laneq_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_laneq_s16::<0>(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32766, 32766, 32766, 32766, 32766, 32766, 32766, 32766]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_s16::<0>(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_laneq_s16::<0>(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_s16::<0>(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_laneq_s16::<0>(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-2, -2, -2, -2, -2, -2, -2, -2]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_s16::<0>(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_laneq_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, -1, 0, 32767, -32768, -1, 0, 32767]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_s16_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_laneq_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_s16_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_laneq_s16::<0>(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_s16::<0>(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_s16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_laneq_s16::<1>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[-161, -178, -195, -212, -229, -246, -263, -280]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_s16::<1>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_s16::<1>(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_s16_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_laneq_s16::<7>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[-215, -238, -261, -284, -307, -330, -353, -376]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_s16::<7>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_s16::<7>(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_s16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_laneq_s16::<3>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[-179, -198, -217, -236, -255, -274, -293, -312]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_s16::<3>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_s16::<3>(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_u16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_laneq_u16::<0>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[65384, 65368, 65352, 65336, 65320, 65304, 65288, 65272]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_u16::<0>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_u16::<0>(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_laneq_u16::<0>(create_uint16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]), create_uint16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3]), create_uint16x8_t_from([20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[65336, 65355, 65298, 65393, 65260, 65431, 65222, 65469]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_u16::<0>(create_uint16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]), create_uint16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3]), create_uint16x8_t_from([20, 19, 22, 17, 24, 15, 26, 13]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_u16::<0>(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_laneq_u16::<0>(create_uint16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_uint16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810]), create_uint16x8_t_from([120, 220, 320, 420, 520, 620, 720, 820])));
        check_array_equality(&result, &[52436, 40536, 28636, 16736, 4836, 58472, 46572, 34672]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_u16::<0>(create_uint16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_uint16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810]), create_uint16x8_t_from([120, 220, 320, 420, 520, 620, 720, 820]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_u16::<0>(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_laneq_u16::<0>(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_u16::<0>(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_u16::<0>(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_laneq_u16::<0>(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65534, 65534, 65534, 65534, 65534, 65534, 65534, 65534]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_u16::<0>(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_u16::<0>(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_laneq_u16::<0>(create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_u16::<0>(create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_u16::<0>(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_laneq_u16::<0>(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65534, 65534, 65534, 65534, 65534, 65534, 65534, 65534]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_u16::<0>(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_u16::<0>(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_laneq_u16::<0>(create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX])));
        check_array_equality(&result, &[0, 65535, 0, 65535, 0, 65535, 0, 65535]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_u16::<0>(create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_u16::<0>(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_u16_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_laneq_u16::<0>(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_u16::<0>(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_u16::<0>(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_u16_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_laneq_u16::<0>(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_u16::<0>(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_u16::<0>(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_u16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_laneq_u16::<1>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[65375, 65358, 65341, 65324, 65307, 65290, 65273, 65256]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_u16::<1>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_u16::<1>(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_u16_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_laneq_u16::<7>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[65321, 65298, 65275, 65252, 65229, 65206, 65183, 65160]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_u16::<7>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_u16::<7>(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_u16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_laneq_u16::<3>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[65357, 65338, 65319, 65300, 65281, 65262, 65243, 65224]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_u16::<3>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_u16::<3>(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_lane_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x2_t_from([9, 10])));
        check_array_equality(&result, &[-44, -52, -60, -68]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x2_t_from([9, 10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_lane_s32::<0>(create_int32x4_t_from([0, -1, 2, -3]), create_int32x4_t_from([10, 9, 12, 7]), create_int32x2_t_from([20, 19])));
        check_array_equality(&result, &[-200, -181, -238, -143]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_s32::<0>(create_int32x4_t_from([0, -1, 2, -3]), create_int32x4_t_from([10, 9, 12, 7]), create_int32x2_t_from([20, 19]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_lane_s32::<0>(create_int32x4_t_from([100, 200, 300, 400]), create_int32x4_t_from([110, 210, 310, 410]), create_int32x2_t_from([120, 220])));
        check_array_equality(&result, &[-13100, -25000, -36900, -48800]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_s32::<0>(create_int32x4_t_from([100, 200, 300, 400]), create_int32x4_t_from([110, 210, 310, 410]), create_int32x2_t_from([120, 220]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_lane_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x2_t_from([i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x2_t_from([i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_lane_s32::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x2_t_from([i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483646, 2147483646, 2147483646, 2147483646]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_s32::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x2_t_from([i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_lane_s32::<0>(create_int32x4_t_from([0, 0, 0, 0]), create_int32x4_t_from([0, 0, 0, 0]), create_int32x2_t_from([0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_s32::<0>(create_int32x4_t_from([0, 0, 0, 0]), create_int32x4_t_from([0, 0, 0, 0]), create_int32x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_lane_s32::<0>(create_int32x4_t_from([-1, -1, -1, -1]), create_int32x4_t_from([-1, -1, -1, -1]), create_int32x2_t_from([-1, -1])));
        check_array_equality(&result, &[-2, -2, -2, -2]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_s32::<0>(create_int32x4_t_from([-1, -1, -1, -1]), create_int32x4_t_from([-1, -1, -1, -1]), create_int32x2_t_from([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_lane_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int32x2_t_from([i32::MIN, i32::MAX])));
        check_array_equality(&result, &[-2147483648, -1, 0, 2147483647]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int32x2_t_from([i32::MIN, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_s32_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_lane_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_s32_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_lane_s32::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x2_t_from([1, 2])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_s32::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_s32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_lane_s32::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x2_t_from([9, 10])));
        check_array_equality(&result, &[-49, -58, -67, -76]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_s32::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x2_t_from([9, 10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_s32::<1>(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_lane_u32::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]), create_uint32x2_t_from([9, 10])));
        check_array_equality(&result, &[4294967252, 4294967244, 4294967236, 4294967228]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_u32::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]), create_uint32x2_t_from([9, 10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_u32::<0>(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_lane_u32::<0>(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint32x4_t_from([10, 9, 12, 7]), create_uint32x2_t_from([20, 19])));
        check_array_equality(&result, &[4294967096, 4294967115, 4294967058, 4294967153]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_u32::<0>(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint32x4_t_from([10, 9, 12, 7]), create_uint32x2_t_from([20, 19]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_u32::<0>(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_lane_u32::<0>(create_uint32x4_t_from([100, 200, 300, 400]), create_uint32x4_t_from([110, 210, 310, 410]), create_uint32x2_t_from([120, 220])));
        check_array_equality(&result, &[4294954196, 4294942296, 4294930396, 4294918496]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_u32::<0>(create_uint32x4_t_from([100, 200, 300, 400]), create_uint32x4_t_from([110, 210, 310, 410]), create_uint32x2_t_from([120, 220]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_u32::<0>(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_lane_u32::<0>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x2_t_from([u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_u32::<0>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x2_t_from([u32::MIN, u32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_u32::<0>(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_lane_u32::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x2_t_from([u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967294, 4294967294, 4294967294, 4294967294]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_u32::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x2_t_from([u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_u32::<0>(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_lane_u32::<0>(create_uint32x4_t_from([0, 0, 0, 0]), create_uint32x4_t_from([0, 0, 0, 0]), create_uint32x2_t_from([0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_u32::<0>(create_uint32x4_t_from([0, 0, 0, 0]), create_uint32x4_t_from([0, 0, 0, 0]), create_uint32x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_u32::<0>(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_lane_u32::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x2_t_from([u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967294, 4294967294, 4294967294, 4294967294]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_u32::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x2_t_from([u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_u32::<0>(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_lane_u32::<0>(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint32x2_t_from([u32::MIN, u32::MAX])));
        check_array_equality(&result, &[0, 4294967295, 0, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_u32::<0>(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint32x2_t_from([u32::MIN, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_u32::<0>(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_u32_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_lane_u32::<0>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_u32::<0>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_u32::<0>(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_u32_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_lane_u32::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_u32::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_u32::<0>(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_lane_u32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_lane_u32::<1>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]), create_uint32x2_t_from([9, 10])));
        check_array_equality(&result, &[4294967247, 4294967238, 4294967229, 4294967220]).map_err(|e| crate::cpu::with_call(e, "vmlsq_lane_u32::<1>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]), create_uint32x2_t_from([9, 10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_lane_u32::<1>(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_laneq_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[-44, -52, -60, -68]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_laneq_s32::<0>(create_int32x4_t_from([0, -1, 2, -3]), create_int32x4_t_from([10, 9, 12, 7]), create_int32x4_t_from([20, 19, 22, 17])));
        check_array_equality(&result, &[-200, -181, -238, -143]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_s32::<0>(create_int32x4_t_from([0, -1, 2, -3]), create_int32x4_t_from([10, 9, 12, 7]), create_int32x4_t_from([20, 19, 22, 17]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_laneq_s32::<0>(create_int32x4_t_from([100, 200, 300, 400]), create_int32x4_t_from([110, 210, 310, 410]), create_int32x4_t_from([120, 220, 320, 420])));
        check_array_equality(&result, &[-13100, -25000, -36900, -48800]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_s32::<0>(create_int32x4_t_from([100, 200, 300, 400]), create_int32x4_t_from([110, 210, 310, 410]), create_int32x4_t_from([120, 220, 320, 420]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_laneq_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_laneq_s32::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483646, 2147483646, 2147483646, 2147483646]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_s32::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_laneq_s32::<0>(create_int32x4_t_from([0, 0, 0, 0]), create_int32x4_t_from([0, 0, 0, 0]), create_int32x4_t_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_s32::<0>(create_int32x4_t_from([0, 0, 0, 0]), create_int32x4_t_from([0, 0, 0, 0]), create_int32x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_laneq_s32::<0>(create_int32x4_t_from([-1, -1, -1, -1]), create_int32x4_t_from([-1, -1, -1, -1]), create_int32x4_t_from([-1, -1, -1, -1])));
        check_array_equality(&result, &[-2, -2, -2, -2]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_s32::<0>(create_int32x4_t_from([-1, -1, -1, -1]), create_int32x4_t_from([-1, -1, -1, -1]), create_int32x4_t_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_laneq_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-2147483648, -1, 0, 2147483647]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_s32_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_laneq_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_s32_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_laneq_s32::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_s32::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_s32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_laneq_s32::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[-49, -58, -67, -76]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_s32::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_s32::<1>(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_s32_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_laneq_s32::<3>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[-59, -70, -81, -92]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_s32::<3>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_s32::<3>(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_laneq_u32::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]), create_uint32x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[4294967252, 4294967244, 4294967236, 4294967228]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_u32::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]), create_uint32x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_u32::<0>(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_laneq_u32::<0>(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint32x4_t_from([10, 9, 12, 7]), create_uint32x4_t_from([20, 19, 22, 17])));
        check_array_equality(&result, &[4294967096, 4294967115, 4294967058, 4294967153]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_u32::<0>(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint32x4_t_from([10, 9, 12, 7]), create_uint32x4_t_from([20, 19, 22, 17]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_u32::<0>(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_laneq_u32::<0>(create_uint32x4_t_from([100, 200, 300, 400]), create_uint32x4_t_from([110, 210, 310, 410]), create_uint32x4_t_from([120, 220, 320, 420])));
        check_array_equality(&result, &[4294954196, 4294942296, 4294930396, 4294918496]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_u32::<0>(create_uint32x4_t_from([100, 200, 300, 400]), create_uint32x4_t_from([110, 210, 310, 410]), create_uint32x4_t_from([120, 220, 320, 420]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_u32::<0>(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_laneq_u32::<0>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_u32::<0>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_u32::<0>(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_laneq_u32::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967294, 4294967294, 4294967294, 4294967294]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_u32::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_u32::<0>(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_laneq_u32::<0>(create_uint32x4_t_from([0, 0, 0, 0]), create_uint32x4_t_from([0, 0, 0, 0]), create_uint32x4_t_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_u32::<0>(create_uint32x4_t_from([0, 0, 0, 0]), create_uint32x4_t_from([0, 0, 0, 0]), create_uint32x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_u32::<0>(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_laneq_u32::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967294, 4294967294, 4294967294, 4294967294]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_u32::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_u32::<0>(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_laneq_u32::<0>(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX])));
        check_array_equality(&result, &[0, 4294967295, 0, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_u32::<0>(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_u32::<0>(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_u32_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_laneq_u32::<0>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_u32::<0>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_u32::<0>(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_u32_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_laneq_u32::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_u32::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_u32::<0>(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_u32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_laneq_u32::<1>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]), create_uint32x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[4294967247, 4294967238, 4294967229, 4294967220]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_u32::<1>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]), create_uint32x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_u32::<1>(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_laneq_u32_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_laneq_u32::<3>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]), create_uint32x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[4294967237, 4294967226, 4294967215, 4294967204]).map_err(|e| crate::cpu::with_call(e, "vmlsq_laneq_u32::<3>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]), create_uint32x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_laneq_u32::<3>(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_f32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_n_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), 9.0f32));
        check_float_array_equality(&result, &[-44.0, -52.0, -60.0, -68.0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_f32(create_float32x4_t_from([1.0, 2.0, 3.0, 4.0]), create_float32x4_t_from([5.0, 6.0, 7.0, 8.0]), 9.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_f32(create_random_float32x4_t(), create_random_float32x4_t(), rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_f32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_n_f32(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create_float32x4_t_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), 1.0f32));
        check_float_array_equality(&result, &[-10.0, -10.0, -10.0, -10.0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_f32(create_float32x4_t_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create_float32x4_t_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]), 1.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_f32(create_random_float32x4_t(), create_random_float32x4_t(), rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_f32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_n_f32(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create_float32x4_t_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), 1.0f32));
        check_float_array_equality(&result, &[-10.0, -10.0, -10.0, -10.0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_f32(create_float32x4_t_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create_float32x4_t_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]), 1.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_f32(create_random_float32x4_t(), create_random_float32x4_t(), rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_f32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_n_f32(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), 1.0f32));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_f32(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), 1.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_f32(create_random_float32x4_t(), create_random_float32x4_t(), rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_f32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_n_f32(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), 1.0f32));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_f32(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), 1.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_f32(create_random_float32x4_t(), create_random_float32x4_t(), rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_f32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_n_f32(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]), create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]), 1.0f32));
        check_float_array_equality(&result, &[0.0, 0.0, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_f32(create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]), create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]), 1.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_f32(create_random_float32x4_t(), create_random_float32x4_t(), rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_f32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_n_f32(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), 1.0f32));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_f32(create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), 1.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_f32(create_random_float32x4_t(), create_random_float32x4_t(), rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_f32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_n_f32(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE]), create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE]), 1.0f32));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, 0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_f32(create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE]), create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE]), 1.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_f32(create_random_float32x4_t(), create_random_float32x4_t(), rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_f32_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_n_f32(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), 1.0f32));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY, -f32::INFINITY, -f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_f32(create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), 1.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_f32(create_random_float32x4_t(), create_random_float32x4_t(), rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_f32_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x4_t_to_f32_array(vmlsq_n_f32(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), 1.0f32));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_f32(create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), 1.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_f32(create_random_float32x4_t(), create_random_float32x4_t(), rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_n_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), 17i16));
        check_array_equality(&result, &[-152, -168, -184, -200, -216, -232, -248, -264]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), 17i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_s16(create_random_int16x8_t(), create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_n_s16(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3]), 1i16));
        check_array_equality(&result, &[-10, -10, -10, -10, -10, -10, -10, -10]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_s16(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3]), 1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_s16(create_random_int16x8_t(), create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_n_s16(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_int16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810]), 1i16));
        check_array_equality(&result, &[-10, -10, -10, -10, -10, -10, -10, -10]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_s16(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_int16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810]), 1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_s16(create_random_int16x8_t(), create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_n_s16(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), 1i16));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_s16(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), 1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_s16(create_random_int16x8_t(), create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_n_s16(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), 1i16));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_s16(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), 1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_s16(create_random_int16x8_t(), create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_n_s16(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), 1i16));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_s16(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), 1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_s16(create_random_int16x8_t(), create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_n_s16(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), 1i16));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_s16(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), 1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_s16(create_random_int16x8_t(), create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_n_s16(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), 1i16));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_s16(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), 1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_s16(create_random_int16x8_t(), create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_s16_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_n_s16(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), 1i16));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_s16(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), 1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_s16(create_random_int16x8_t(), create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_s16_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_n_s16(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), 1i16));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_s16(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), 1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_s16(create_random_int16x8_t(), create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_u16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_n_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), 17u16));
        check_array_equality(&result, &[65384, 65368, 65352, 65336, 65320, 65304, 65288, 65272]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), 17u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_u16(create_random_uint16x8_t(), create_random_uint16x8_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_n_u16(create_uint16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]), create_uint16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3]), 1u16));
        check_array_equality(&result, &[65526, 65526, 65526, 65526, 65526, 65526, 65526, 65526]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_u16(create_uint16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]), create_uint16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3]), 1u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_u16(create_random_uint16x8_t(), create_random_uint16x8_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_n_u16(create_uint16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_uint16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810]), 1u16));
        check_array_equality(&result, &[65526, 65526, 65526, 65526, 65526, 65526, 65526, 65526]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_u16(create_uint16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_uint16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810]), 1u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_u16(create_random_uint16x8_t(), create_random_uint16x8_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_n_u16(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), 1u16));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_u16(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), 1u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_u16(create_random_uint16x8_t(), create_random_uint16x8_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_n_u16(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), 1u16));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_u16(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), 1u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_u16(create_random_uint16x8_t(), create_random_uint16x8_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_n_u16(create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), 1u16));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_u16(create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), 1u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_u16(create_random_uint16x8_t(), create_random_uint16x8_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_n_u16(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), 1u16));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_u16(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), 1u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_u16(create_random_uint16x8_t(), create_random_uint16x8_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_n_u16(create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), 1u16));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_u16(create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), 1u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_u16(create_random_uint16x8_t(), create_random_uint16x8_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_u16_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_n_u16(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), 1u16));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_u16(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), 1u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_u16(create_random_uint16x8_t(), create_random_uint16x8_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_u16_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_n_u16(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), 1u16));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_u16(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), 1u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_u16(create_random_uint16x8_t(), create_random_uint16x8_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_n_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), 9i32));
        check_array_equality(&result, &[-44, -52, -60, -68]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), 9i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_s32(create_random_int32x4_t(), create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_n_s32(create_int32x4_t_from([0, -1, 2, -3]), create_int32x4_t_from([10, 9, 12, 7]), 1i32));
        check_array_equality(&result, &[-10, -10, -10, -10]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_s32(create_int32x4_t_from([0, -1, 2, -3]), create_int32x4_t_from([10, 9, 12, 7]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_s32(create_random_int32x4_t(), create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_n_s32(create_int32x4_t_from([100, 200, 300, 400]), create_int32x4_t_from([110, 210, 310, 410]), 1i32));
        check_array_equality(&result, &[-10, -10, -10, -10]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_s32(create_int32x4_t_from([100, 200, 300, 400]), create_int32x4_t_from([110, 210, 310, 410]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_s32(create_random_int32x4_t(), create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_n_s32(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_s32(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_s32(create_random_int32x4_t(), create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_n_s32(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_s32(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_s32(create_random_int32x4_t(), create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_n_s32(create_int32x4_t_from([0, 0, 0, 0]), create_int32x4_t_from([0, 0, 0, 0]), 1i32));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_s32(create_int32x4_t_from([0, 0, 0, 0]), create_int32x4_t_from([0, 0, 0, 0]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_s32(create_random_int32x4_t(), create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_n_s32(create_int32x4_t_from([-1, -1, -1, -1]), create_int32x4_t_from([-1, -1, -1, -1]), 1i32));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_s32(create_int32x4_t_from([-1, -1, -1, -1]), create_int32x4_t_from([-1, -1, -1, -1]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_s32(create_random_int32x4_t(), create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_n_s32(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), 1i32));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_s32(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_s32(create_random_int32x4_t(), create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_s32_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_n_s32(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_s32(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_s32(create_random_int32x4_t(), create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_s32_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_n_s32(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_s32(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_s32(create_random_int32x4_t(), create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_n_u32(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]), 9u32));
        check_array_equality(&result, &[4294967252, 4294967244, 4294967236, 4294967228]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_u32(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]), 9u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_u32(create_random_uint32x4_t(), create_random_uint32x4_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_n_u32(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint32x4_t_from([10, 9, 12, 7]), 1u32));
        check_array_equality(&result, &[4294967286, 4294967286, 4294967286, 4294967286]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_u32(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint32x4_t_from([10, 9, 12, 7]), 1u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_u32(create_random_uint32x4_t(), create_random_uint32x4_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_n_u32(create_uint32x4_t_from([100, 200, 300, 400]), create_uint32x4_t_from([110, 210, 310, 410]), 1u32));
        check_array_equality(&result, &[4294967286, 4294967286, 4294967286, 4294967286]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_u32(create_uint32x4_t_from([100, 200, 300, 400]), create_uint32x4_t_from([110, 210, 310, 410]), 1u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_u32(create_random_uint32x4_t(), create_random_uint32x4_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_n_u32(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), 1u32));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_u32(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), 1u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_u32(create_random_uint32x4_t(), create_random_uint32x4_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_n_u32(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), 1u32));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_u32(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), 1u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_u32(create_random_uint32x4_t(), create_random_uint32x4_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_n_u32(create_uint32x4_t_from([0, 0, 0, 0]), create_uint32x4_t_from([0, 0, 0, 0]), 1u32));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_u32(create_uint32x4_t_from([0, 0, 0, 0]), create_uint32x4_t_from([0, 0, 0, 0]), 1u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_u32(create_random_uint32x4_t(), create_random_uint32x4_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_n_u32(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), 1u32));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_u32(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), 1u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_u32(create_random_uint32x4_t(), create_random_uint32x4_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_n_u32(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), 1u32));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_u32(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), 1u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_u32(create_random_uint32x4_t(), create_random_uint32x4_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_u32_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_n_u32(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), 1u32));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_u32(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), 1u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_u32(create_random_uint32x4_t(), create_random_uint32x4_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_n_u32_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_n_u32(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), 1u32));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vmlsq_n_u32(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), 1u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_n_u32(create_random_uint32x4_t(), create_random_uint32x4_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_s8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vmlsq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create_int8x16_t_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[-48, -98, 106, 52, -4, -62, -122, 72, 8, -58, -126, 60, -12, -86, 94, 16]).map_err(|e| crate::cpu::with_call(e, "vmlsq_s8(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create_int8x16_t_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_s8(create_random_int8x16_t(), create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_s8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vmlsq_s8(create_int8x16_t_from([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create_int8x16_t_from([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create_int8x16_t_from([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[56, 84, -6, -122, -76, -80, 102, -46, 56, 84, -6, -122, -76, -80, 102, -46]).map_err(|e| crate::cpu::with_call(e, "vmlsq_s8(create_int8x16_t_from([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create_int8x16_t_from([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create_int8x16_t_from([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_s8(create_random_int8x16_t(), create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_s8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vmlsq_s8(create_int8x16_t_from([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), create_int8x16_t_from([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74]), create_int8x16_t_from([120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84])));
        check_array_equality(&result, &[-44, 80, -84, -24, 4, 0, -36, -104, 52, -80, 12, 72, 100, 96, 60, -8]).map_err(|e| crate::cpu::with_call(e, "vmlsq_s8(create_int8x16_t_from([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), create_int8x16_t_from([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74]), create_int8x16_t_from([120, -36, 64, -92, 8, 108, -48, 52, -104, -4, 96, -60, 40, -116, -16, 84]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_s8(create_random_int8x16_t(), create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_s8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vmlsq_s8(create_int8x16_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create_int8x16_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create_int8x16_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128]).map_err(|e| crate::cpu::with_call(e, "vmlsq_s8(create_int8x16_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create_int8x16_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create_int8x16_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_s8(create_random_int8x16_t(), create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_s8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vmlsq_s8(create_int8x16_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create_int8x16_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create_int8x16_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[126, 126, 126, 126, 126, 126, 126, 126, 126, 126, 126, 126, 126, 126, 126, 126]).map_err(|e| crate::cpu::with_call(e, "vmlsq_s8(create_int8x16_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create_int8x16_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create_int8x16_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_s8(create_random_int8x16_t(), create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_s8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vmlsq_s8(create_int8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create_int8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create_int8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_s8(create_int8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create_int8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create_int8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_s8(create_random_int8x16_t(), create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_s8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vmlsq_s8(create_int8x16_t_from([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create_int8x16_t_from([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create_int8x16_t_from([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2]).map_err(|e| crate::cpu::with_call(e, "vmlsq_s8(create_int8x16_t_from([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create_int8x16_t_from([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create_int8x16_t_from([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_s8(create_random_int8x16_t(), create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_s8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vmlsq_s8(create_int8x16_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create_int8x16_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create_int8x16_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-128, 126, 0, -2, -128, 126, 0, -2, -128, 126, 0, -2, -128, 126, 0, -2]).map_err(|e| crate::cpu::with_call(e, "vmlsq_s8(create_int8x16_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create_int8x16_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create_int8x16_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_s8(create_random_int8x16_t(), create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_s8_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vmlsq_s8(create_int8x16_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create_int8x16_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, -126, 3, -124, 5, -122, 7, -120, 9, -118, 11, -116, 13, -114, 15, -112]).map_err(|e| crate::cpu::with_call(e, "vmlsq_s8(create_int8x16_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create_int8x16_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_s8(create_random_int8x16_t(), create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_s8_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vmlsq_s8(create_int8x16_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create_int8x16_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127, -1, 127]).map_err(|e| crate::cpu::with_call(e, "vmlsq_s8(create_int8x16_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create_int8x16_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_s8(create_random_int8x16_t(), create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[-152, -178, -206, -236, -268, -302, -338, -376]).map_err(|e| crate::cpu::with_call(e, "vmlsq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_s16(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_s16(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3]), create_int16x8_t_from([20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[-200, -172, -262, -122, -332, -80, -410, -46]).map_err(|e| crate::cpu::with_call(e, "vmlsq_s16(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3]), create_int16x8_t_from([20, 19, 22, 17, 24, 15, 26, 13]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_s16(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_s16(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_int16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810]), create_int16x8_t_from([120, 220, 320, 420, 520, 620, 720, 820])));
        check_array_equality(&result, &[-13100, 19536, 32172, 24808, -2556, 15616, 13788, -8040]).map_err(|e| crate::cpu::with_call(e, "vmlsq_s16(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_int16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810]), create_int16x8_t_from([120, 220, 320, 420, 520, 620, 720, 820]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_s16(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_s16(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768]).map_err(|e| crate::cpu::with_call(e, "vmlsq_s16(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_s16(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_s16(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32766, 32766, 32766, 32766, 32766, 32766, 32766, 32766]).map_err(|e| crate::cpu::with_call(e, "vmlsq_s16(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_s16(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_s16(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_s16(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_s16(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_s16(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-2, -2, -2, -2, -2, -2, -2, -2]).map_err(|e| crate::cpu::with_call(e, "vmlsq_s16(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_s16(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_s16(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, 32766, 0, -2, -32768, 32766, 0, -2]).map_err(|e| crate::cpu::with_call(e, "vmlsq_s16(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_s16(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_s16_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_s16(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, -32766, 3, -32764, 5, -32762, 7, -32760]).map_err(|e| crate::cpu::with_call(e, "vmlsq_s16(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_s16(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_s16_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsq_s16(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[-1, 32767, -1, 32767, -1, 32767, -1, 32767]).map_err(|e| crate::cpu::with_call(e, "vmlsq_s16(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_s16(create_random_int16x8_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[-44, -58, -74, -92]).map_err(|e| crate::cpu::with_call(e, "vmlsq_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]), create_int32x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_s32(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_s32(create_int32x4_t_from([0, -1, 2, -3]), create_int32x4_t_from([10, 9, 12, 7]), create_int32x4_t_from([20, 19, 22, 17])));
        check_array_equality(&result, &[-200, -172, -262, -122]).map_err(|e| crate::cpu::with_call(e, "vmlsq_s32(create_int32x4_t_from([0, -1, 2, -3]), create_int32x4_t_from([10, 9, 12, 7]), create_int32x4_t_from([20, 19, 22, 17]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_s32(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_s32(create_int32x4_t_from([100, 200, 300, 400]), create_int32x4_t_from([110, 210, 310, 410]), create_int32x4_t_from([120, 220, 320, 420])));
        check_array_equality(&result, &[-13100, -46000, -98900, -171800]).map_err(|e| crate::cpu::with_call(e, "vmlsq_s32(create_int32x4_t_from([100, 200, 300, 400]), create_int32x4_t_from([110, 210, 310, 410]), create_int32x4_t_from([120, 220, 320, 420]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_s32(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_s32(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "vmlsq_s32(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_s32(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_s32(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483646, 2147483646, 2147483646, 2147483646]).map_err(|e| crate::cpu::with_call(e, "vmlsq_s32(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_s32(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_s32(create_int32x4_t_from([0, 0, 0, 0]), create_int32x4_t_from([0, 0, 0, 0]), create_int32x4_t_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_s32(create_int32x4_t_from([0, 0, 0, 0]), create_int32x4_t_from([0, 0, 0, 0]), create_int32x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_s32(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_s32(create_int32x4_t_from([-1, -1, -1, -1]), create_int32x4_t_from([-1, -1, -1, -1]), create_int32x4_t_from([-1, -1, -1, -1])));
        check_array_equality(&result, &[-2, -2, -2, -2]).map_err(|e| crate::cpu::with_call(e, "vmlsq_s32(create_int32x4_t_from([-1, -1, -1, -1]), create_int32x4_t_from([-1, -1, -1, -1]), create_int32x4_t_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_s32(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_s32(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-2147483648, 2147483646, 0, -2]).map_err(|e| crate::cpu::with_call(e, "vmlsq_s32(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_s32(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_s32_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_s32(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, -2147483646, 3, -2147483644]).map_err(|e| crate::cpu::with_call(e, "vmlsq_s32(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_s32(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_s32_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsq_s32(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[-1, 2147483647, -1, 2147483647]).map_err(|e| crate::cpu::with_call(e, "vmlsq_s32(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_s32(create_random_int32x4_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_u8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vmlsq_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create_uint8x16_t_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48])));
        check_array_equality(&result, &[208, 158, 106, 52, 252, 194, 134, 72, 8, 198, 130, 60, 244, 170, 94, 16]).map_err(|e| crate::cpu::with_call(e, "vmlsq_u8(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]), create_uint8x16_t_from([33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_u8(create_random_uint8x16_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_u8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vmlsq_u8(create_uint8x16_t_from([0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249]), create_uint8x16_t_from([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create_uint8x16_t_from([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[56, 84, 250, 134, 180, 176, 102, 210, 56, 84, 250, 134, 180, 176, 102, 210]).map_err(|e| crate::cpu::with_call(e, "vmlsq_u8(create_uint8x16_t_from([0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249]), create_uint8x16_t_from([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]), create_uint8x16_t_from([20, 19, 22, 17, 24, 15, 26, 13, 20, 19, 22, 17, 24, 15, 26, 13]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_u8(create_random_uint8x16_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_u8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vmlsq_u8(create_uint8x16_t_from([100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64]), create_uint8x16_t_from([110, 210, 54, 154, 254, 98, 198, 42, 142, 242, 86, 186, 30, 130, 230, 74]), create_uint8x16_t_from([120, 220, 64, 164, 8, 108, 208, 52, 152, 252, 96, 196, 40, 140, 240, 84])));
        check_array_equality(&result, &[212, 80, 172, 232, 4, 0, 220, 152, 52, 176, 12, 72, 100, 96, 60, 248]).map_err(|e| crate::cpu::with_call(e, "vmlsq_u8(create_uint8x16_t_from([100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64]), create_uint8x16_t_from([110, 210, 54, 154, 254, 98, 198, 42, 142, 242, 86, 186, 30, 130, 230, 74]), create_uint8x16_t_from([120, 220, 64, 164, 8, 108, 208, 52, 152, 252, 96, 196, 40, 140, 240, 84]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_u8(create_random_uint8x16_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_u8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vmlsq_u8(create_uint8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_uint8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_uint8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_u8(create_uint8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_uint8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_uint8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_u8(create_random_uint8x16_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_u8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vmlsq_u8(create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[254, 254, 254, 254, 254, 254, 254, 254, 254, 254, 254, 254, 254, 254, 254, 254]).map_err(|e| crate::cpu::with_call(e, "vmlsq_u8(create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_u8(create_random_uint8x16_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_u8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vmlsq_u8(create_uint8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create_uint8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create_uint8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_u8(create_uint8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create_uint8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create_uint8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_u8(create_random_uint8x16_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_u8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vmlsq_u8(create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[254, 254, 254, 254, 254, 254, 254, 254, 254, 254, 254, 254, 254, 254, 254, 254]).map_err(|e| crate::cpu::with_call(e, "vmlsq_u8(create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_u8(create_random_uint8x16_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_u8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vmlsq_u8(create_uint8x16_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create_uint8x16_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create_uint8x16_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX])));
        check_array_equality(&result, &[0, 254, 0, 254, 0, 254, 0, 254, 0, 254, 0, 254, 0, 254, 0, 254]).map_err(|e| crate::cpu::with_call(e, "vmlsq_u8(create_uint8x16_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create_uint8x16_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create_uint8x16_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_u8(create_random_uint8x16_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_u8_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vmlsq_u8(create_uint8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| crate::cpu::with_call(e, "vmlsq_u8(create_uint8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_u8(create_random_uint8x16_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_u8_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vmlsq_u8(create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "vmlsq_u8(create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_u8(create_random_uint8x16_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_u16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[65384, 65358, 65330, 65300, 65268, 65234, 65198, 65160]).map_err(|e| crate::cpu::with_call(e, "vmlsq_u16(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint16x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_u16(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_u16(create_uint16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]), create_uint16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3]), create_uint16x8_t_from([20, 19, 22, 17, 24, 15, 26, 13])));
        check_array_equality(&result, &[65336, 65364, 65274, 65414, 65204, 65456, 65126, 65490]).map_err(|e| crate::cpu::with_call(e, "vmlsq_u16(create_uint16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]), create_uint16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3]), create_uint16x8_t_from([20, 19, 22, 17, 24, 15, 26, 13]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_u16(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_u16(create_uint16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_uint16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810]), create_uint16x8_t_from([120, 220, 320, 420, 520, 620, 720, 820])));
        check_array_equality(&result, &[52436, 19536, 32172, 24808, 62980, 15616, 13788, 57496]).map_err(|e| crate::cpu::with_call(e, "vmlsq_u16(create_uint16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_uint16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810]), create_uint16x8_t_from([120, 220, 320, 420, 520, 620, 720, 820]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_u16(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_u16(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_u16(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_u16(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_u16(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65534, 65534, 65534, 65534, 65534, 65534, 65534, 65534]).map_err(|e| crate::cpu::with_call(e, "vmlsq_u16(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_u16(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_u16(create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_u16(create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_u16(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_u16(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65534, 65534, 65534, 65534, 65534, 65534, 65534, 65534]).map_err(|e| crate::cpu::with_call(e, "vmlsq_u16(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_u16(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_u16(create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX])));
        check_array_equality(&result, &[0, 65534, 0, 65534, 0, 65534, 0, 65534]).map_err(|e| crate::cpu::with_call(e, "vmlsq_u16(create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_u16(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_u16_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_u16(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| crate::cpu::with_call(e, "vmlsq_u16(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_u16(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_u16_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsq_u16(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "vmlsq_u16(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_u16(create_random_uint16x8_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_u32(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]), create_uint32x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[4294967252, 4294967238, 4294967222, 4294967204]).map_err(|e| crate::cpu::with_call(e, "vmlsq_u32(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]), create_uint32x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_u32(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_u32(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint32x4_t_from([10, 9, 12, 7]), create_uint32x4_t_from([20, 19, 22, 17])));
        check_array_equality(&result, &[4294967096, 4294967124, 4294967034, 4294967174]).map_err(|e| crate::cpu::with_call(e, "vmlsq_u32(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint32x4_t_from([10, 9, 12, 7]), create_uint32x4_t_from([20, 19, 22, 17]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_u32(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_u32(create_uint32x4_t_from([100, 200, 300, 400]), create_uint32x4_t_from([110, 210, 310, 410]), create_uint32x4_t_from([120, 220, 320, 420])));
        check_array_equality(&result, &[4294954196, 4294921296, 4294868396, 4294795496]).map_err(|e| crate::cpu::with_call(e, "vmlsq_u32(create_uint32x4_t_from([100, 200, 300, 400]), create_uint32x4_t_from([110, 210, 310, 410]), create_uint32x4_t_from([120, 220, 320, 420]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_u32(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_u32(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_u32(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_u32(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_u32(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967294, 4294967294, 4294967294, 4294967294]).map_err(|e| crate::cpu::with_call(e, "vmlsq_u32(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_u32(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_u32(create_uint32x4_t_from([0, 0, 0, 0]), create_uint32x4_t_from([0, 0, 0, 0]), create_uint32x4_t_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vmlsq_u32(create_uint32x4_t_from([0, 0, 0, 0]), create_uint32x4_t_from([0, 0, 0, 0]), create_uint32x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_u32(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_u32(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967294, 4294967294, 4294967294, 4294967294]).map_err(|e| crate::cpu::with_call(e, "vmlsq_u32(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_u32(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_u32(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX])));
        check_array_equality(&result, &[0, 4294967294, 0, 4294967294]).map_err(|e| crate::cpu::with_call(e, "vmlsq_u32(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_u32(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_u32_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_u32(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| crate::cpu::with_call(e, "vmlsq_u32(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_u32(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsq_u32_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsq_u32(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vmlsq_u32(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsq_u32(create_random_uint32x4_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}
