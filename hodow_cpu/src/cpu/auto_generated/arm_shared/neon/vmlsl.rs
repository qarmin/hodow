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

pub(super) fn test_arm_shared_neon_vmlsl_lane_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_lane_s16::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[-44, -52, -60, -68]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_s16::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_lane_s16::<0>(create_int32x4_t_from([0, -1, 2, -3]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-5, -11, -13, -23]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_s16::<0>(create_int32x4_t_from([0, -1, 2, -3]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_lane_s16::<0>(create_int32x4_t_from([100, 200, 300, 400]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[95, 190, 285, 380]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_s16::<0>(create_int32x4_t_from([100, 200, 300, 400]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_lane_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[2147483643, 2147483638, 2147483633, 2147483628]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_lane_s16::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[2147483642, 2147483637, 2147483632, 2147483627]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_s16::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_lane_s16::<0>(create_int32x4_t_from([0, 0, 0, 0]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-5, -10, -15, -20]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_s16::<0>(create_int32x4_t_from([0, 0, 0, 0]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_lane_s16::<0>(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-6, -11, -16, -21]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_s16::<0>(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_lane_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[2147483643, 2147483637, -15, -21]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_s16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_lane_s16::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[-49, -58, -67, -76]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_s16::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_s16::<1>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_s16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_lane_s16::<3>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[-59, -70, -81, -92]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_s16::<3>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_s16::<3>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_laneq_s16::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-44, -52, -60, -68]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_s16::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_laneq_s16::<0>(create_int32x4_t_from([0, -1, 2, -3]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[-5, -11, -13, -23]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_s16::<0>(create_int32x4_t_from([0, -1, 2, -3]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_laneq_s16::<0>(create_int32x4_t_from([100, 200, 300, 400]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[95, 190, 285, 380]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_s16::<0>(create_int32x4_t_from([100, 200, 300, 400]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_laneq_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[2147483643, 2147483638, 2147483633, 2147483628]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_laneq_s16::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[2147483642, 2147483637, 2147483632, 2147483627]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_s16::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_laneq_s16::<0>(create_int32x4_t_from([0, 0, 0, 0]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[-5, -10, -15, -20]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_s16::<0>(create_int32x4_t_from([0, 0, 0, 0]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_laneq_s16::<0>(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[-6, -11, -16, -21]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_s16::<0>(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_laneq_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[2147483643, 2147483637, -15, -21]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_s16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_laneq_s16::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-49, -58, -67, -76]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_s16::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_s16::<1>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_s16_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_laneq_s16::<7>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-79, -94, -109, -124]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_s16::<7>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_s16::<7>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_s16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_laneq_s16::<3>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-59, -70, -81, -92]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_s16::<3>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_s16::<3>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_lane_s32::<0>(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[-14, -18]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_s32::<0>(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_lane_s32::<0>(create_int64x2_t_from([0, -1]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[-3, -7]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_s32::<0>(create_int64x2_t_from([0, -1]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_lane_s32::<0>(create_int64x2_t_from([100, 200]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[97, 194]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_s32::<0>(create_int64x2_t_from([100, 200]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_lane_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[9223372036854775805, 9223372036854775802]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_lane_s32::<0>(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[9223372036854775804, 9223372036854775801]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_s32::<0>(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_lane_s32::<0>(create_int64x2_t_from([0, 0]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[-3, -6]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_s32::<0>(create_int64x2_t_from([0, 0]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_lane_s32::<0>(create_int64x2_t_from([-1, -1]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[-4, -7]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_s32::<0>(create_int64x2_t_from([-1, -1]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_lane_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[9223372036854775805, 9223372036854775801]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_s32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_lane_s32::<1>(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[-17, -22]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_s32::<1>(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_s32::<1>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_laneq_s32::<0>(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-14, -18]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_s32::<0>(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_laneq_s32::<0>(create_int64x2_t_from([0, -1]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[-3, -7]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_s32::<0>(create_int64x2_t_from([0, -1]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_laneq_s32::<0>(create_int64x2_t_from([100, 200]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[97, 194]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_s32::<0>(create_int64x2_t_from([100, 200]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_laneq_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[9223372036854775805, 9223372036854775802]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_laneq_s32::<0>(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[9223372036854775804, 9223372036854775801]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_s32::<0>(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_laneq_s32::<0>(create_int64x2_t_from([0, 0]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[-3, -6]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_s32::<0>(create_int64x2_t_from([0, 0]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_laneq_s32::<0>(create_int64x2_t_from([-1, -1]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[-4, -7]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_s32::<0>(create_int64x2_t_from([-1, -1]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_laneq_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[9223372036854775805, 9223372036854775801]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_s32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_laneq_s32::<1>(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-17, -22]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_s32::<1>(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_s32::<1>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_s32_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_laneq_s32::<3>(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-23, -30]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_s32::<3>(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_s32::<3>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_u16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_lane_u16::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[4294967252, 4294967244, 4294967236, 4294967228]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_u16::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_u16::<0>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_lane_u16::<0>(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[4294967291, 4294967285, 4294967283, 4294967273]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_u16::<0>(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_u16::<0>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_lane_u16::<0>(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[95, 190, 285, 380]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_u16::<0>(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_u16::<0>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_lane_u16::<0>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[4294967291, 4294967286, 4294967281, 4294967276]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_u16::<0>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_u16::<0>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_lane_u16::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[4294967290, 4294967285, 4294967280, 4294967275]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_u16::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_u16::<0>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_lane_u16::<0>(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[4294967291, 4294967286, 4294967281, 4294967276]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_u16::<0>(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_u16::<0>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_lane_u16::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[4294967290, 4294967285, 4294967280, 4294967275]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_u16::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_u16::<0>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_lane_u16::<0>(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[4294967291, 4294967285, 4294967281, 4294967275]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_u16::<0>(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_u16::<0>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_u16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_lane_u16::<1>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[4294967247, 4294967238, 4294967229, 4294967220]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_u16::<1>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_u16::<1>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_u16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_lane_u16::<3>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[4294967237, 4294967226, 4294967215, 4294967204]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_u16::<3>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_u16::<3>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_u16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_laneq_u16::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[4294967252, 4294967244, 4294967236, 4294967228]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_u16::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_u16::<0>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_laneq_u16::<0>(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[4294967291, 4294967285, 4294967283, 4294967273]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_u16::<0>(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_u16::<0>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_laneq_u16::<0>(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[95, 190, 285, 380]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_u16::<0>(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_u16::<0>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_laneq_u16::<0>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[4294967291, 4294967286, 4294967281, 4294967276]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_u16::<0>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_u16::<0>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_laneq_u16::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[4294967290, 4294967285, 4294967280, 4294967275]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_u16::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_u16::<0>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_laneq_u16::<0>(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[4294967291, 4294967286, 4294967281, 4294967276]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_u16::<0>(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_u16::<0>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_laneq_u16::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[4294967290, 4294967285, 4294967280, 4294967275]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_u16::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_u16::<0>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_laneq_u16::<0>(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[4294967291, 4294967285, 4294967281, 4294967275]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_u16::<0>(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_u16::<0>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_u16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_laneq_u16::<1>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[4294967247, 4294967238, 4294967229, 4294967220]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_u16::<1>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_u16::<1>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_u16_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_laneq_u16::<7>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[4294967217, 4294967202, 4294967187, 4294967172]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_u16::<7>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_u16::<7>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_u16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_laneq_u16::<3>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[4294967237, 4294967226, 4294967215, 4294967204]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_u16::<3>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_u16::<3>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_lane_u32::<0>(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x2_t_from([5, 6])));
        check_array_equality(&result, &[18446744073709551602, 18446744073709551598]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_u32::<0>(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_u32::<0>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_lane_u32::<0>(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[18446744073709551613, 18446744073709551609]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_u32::<0>(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_u32::<0>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_lane_u32::<0>(create_uint64x2_t_from([100, 200]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[97, 194]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_u32::<0>(create_uint64x2_t_from([100, 200]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_u32::<0>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_lane_u32::<0>(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[18446744073709551613, 18446744073709551610]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_u32::<0>(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_u32::<0>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_lane_u32::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[18446744073709551612, 18446744073709551609]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_u32::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_u32::<0>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_lane_u32::<0>(create_uint64x2_t_from([0, 0]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[18446744073709551613, 18446744073709551610]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_u32::<0>(create_uint64x2_t_from([0, 0]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_u32::<0>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_lane_u32::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[18446744073709551612, 18446744073709551609]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_u32::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_u32::<0>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_lane_u32::<0>(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[18446744073709551613, 18446744073709551609]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_u32::<0>(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_u32::<0>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_lane_u32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_lane_u32::<1>(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x2_t_from([5, 6])));
        check_array_equality(&result, &[18446744073709551599, 18446744073709551594]).map_err(|e| crate::cpu::with_call(e, "vmlsl_lane_u32::<1>(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_lane_u32::<1>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_laneq_u32::<0>(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[18446744073709551602, 18446744073709551598]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_u32::<0>(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_u32::<0>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_laneq_u32::<0>(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[18446744073709551613, 18446744073709551609]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_u32::<0>(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_u32::<0>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_laneq_u32::<0>(create_uint64x2_t_from([100, 200]), create_uint32x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[97, 194]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_u32::<0>(create_uint64x2_t_from([100, 200]), create_uint32x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_u32::<0>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_laneq_u32::<0>(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[18446744073709551613, 18446744073709551610]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_u32::<0>(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_u32::<0>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_laneq_u32::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[18446744073709551612, 18446744073709551609]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_u32::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_u32::<0>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_laneq_u32::<0>(create_uint64x2_t_from([0, 0]), create_uint32x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[18446744073709551613, 18446744073709551610]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_u32::<0>(create_uint64x2_t_from([0, 0]), create_uint32x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_u32::<0>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_laneq_u32::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[18446744073709551612, 18446744073709551609]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_u32::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_u32::<0>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_laneq_u32::<0>(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[18446744073709551613, 18446744073709551609]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_u32::<0>(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_u32::<0>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_u32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_laneq_u32::<1>(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[18446744073709551599, 18446744073709551594]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_u32::<1>(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_u32::<1>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_laneq_u32_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_laneq_u32::<3>(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[18446744073709551593, 18446744073709551586]).map_err(|e| crate::cpu::with_call(e, "vmlsl_laneq_u32::<3>(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_laneq_u32::<3>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_n_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_n_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), 9i16));
        check_array_equality(&result, &[-44, -52, -60, -68]).map_err(|e| crate::cpu::with_call(e, "vmlsl_n_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), 9i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_n_s16(create_random_int32x4_t(), create_random_int16x4_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_n_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_n_s16(create_int32x4_t_from([0, -1, 2, -3]), create_int16x4_t_from([1, 2, 3, 4]), 5i16));
        check_array_equality(&result, &[-5, -11, -13, -23]).map_err(|e| crate::cpu::with_call(e, "vmlsl_n_s16(create_int32x4_t_from([0, -1, 2, -3]), create_int16x4_t_from([1, 2, 3, 4]), 5i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_n_s16(create_random_int32x4_t(), create_random_int16x4_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_n_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_n_s16(create_int32x4_t_from([100, 200, 300, 400]), create_int16x4_t_from([1, 2, 3, 4]), 5i16));
        check_array_equality(&result, &[95, 190, 285, 380]).map_err(|e| crate::cpu::with_call(e, "vmlsl_n_s16(create_int32x4_t_from([100, 200, 300, 400]), create_int16x4_t_from([1, 2, 3, 4]), 5i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_n_s16(create_random_int32x4_t(), create_random_int16x4_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_n_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_n_s16(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x4_t_from([1, 2, 3, 4]), 5i16));
        check_array_equality(&result, &[2147483643, 2147483638, 2147483633, 2147483628]).map_err(|e| crate::cpu::with_call(e, "vmlsl_n_s16(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x4_t_from([1, 2, 3, 4]), 5i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_n_s16(create_random_int32x4_t(), create_random_int16x4_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_n_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_n_s16(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x4_t_from([1, 2, 3, 4]), 5i16));
        check_array_equality(&result, &[2147483642, 2147483637, 2147483632, 2147483627]).map_err(|e| crate::cpu::with_call(e, "vmlsl_n_s16(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x4_t_from([1, 2, 3, 4]), 5i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_n_s16(create_random_int32x4_t(), create_random_int16x4_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_n_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_n_s16(create_int32x4_t_from([0, 0, 0, 0]), create_int16x4_t_from([1, 2, 3, 4]), 5i16));
        check_array_equality(&result, &[-5, -10, -15, -20]).map_err(|e| crate::cpu::with_call(e, "vmlsl_n_s16(create_int32x4_t_from([0, 0, 0, 0]), create_int16x4_t_from([1, 2, 3, 4]), 5i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_n_s16(create_random_int32x4_t(), create_random_int16x4_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_n_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_n_s16(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x4_t_from([1, 2, 3, 4]), 5i16));
        check_array_equality(&result, &[-6, -11, -16, -21]).map_err(|e| crate::cpu::with_call(e, "vmlsl_n_s16(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x4_t_from([1, 2, 3, 4]), 5i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_n_s16(create_random_int32x4_t(), create_random_int16x4_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_n_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_n_s16(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x4_t_from([1, 2, 3, 4]), 5i16));
        check_array_equality(&result, &[2147483643, 2147483637, -15, -21]).map_err(|e| crate::cpu::with_call(e, "vmlsl_n_s16(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x4_t_from([1, 2, 3, 4]), 5i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_n_s16(create_random_int32x4_t(), create_random_int16x4_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_n_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_n_s32(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), 5i32));
        check_array_equality(&result, &[-14, -18]).map_err(|e| crate::cpu::with_call(e, "vmlsl_n_s32(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), 5i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_n_s32(create_random_int64x2_t(), create_random_int32x2_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_n_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_n_s32(create_int64x2_t_from([0, -1]), create_int32x2_t_from([1, 2]), 3i32));
        check_array_equality(&result, &[-3, -7]).map_err(|e| crate::cpu::with_call(e, "vmlsl_n_s32(create_int64x2_t_from([0, -1]), create_int32x2_t_from([1, 2]), 3i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_n_s32(create_random_int64x2_t(), create_random_int32x2_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_n_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_n_s32(create_int64x2_t_from([100, 200]), create_int32x2_t_from([1, 2]), 3i32));
        check_array_equality(&result, &[97, 194]).map_err(|e| crate::cpu::with_call(e, "vmlsl_n_s32(create_int64x2_t_from([100, 200]), create_int32x2_t_from([1, 2]), 3i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_n_s32(create_random_int64x2_t(), create_random_int32x2_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_n_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_n_s32(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x2_t_from([1, 2]), 3i32));
        check_array_equality(&result, &[9223372036854775805, 9223372036854775802]).map_err(|e| crate::cpu::with_call(e, "vmlsl_n_s32(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x2_t_from([1, 2]), 3i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_n_s32(create_random_int64x2_t(), create_random_int32x2_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_n_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_n_s32(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x2_t_from([1, 2]), 3i32));
        check_array_equality(&result, &[9223372036854775804, 9223372036854775801]).map_err(|e| crate::cpu::with_call(e, "vmlsl_n_s32(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x2_t_from([1, 2]), 3i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_n_s32(create_random_int64x2_t(), create_random_int32x2_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_n_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_n_s32(create_int64x2_t_from([0, 0]), create_int32x2_t_from([1, 2]), 3i32));
        check_array_equality(&result, &[-3, -6]).map_err(|e| crate::cpu::with_call(e, "vmlsl_n_s32(create_int64x2_t_from([0, 0]), create_int32x2_t_from([1, 2]), 3i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_n_s32(create_random_int64x2_t(), create_random_int32x2_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_n_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_n_s32(create_int64x2_t_from([-1, -1]), create_int32x2_t_from([1, 2]), 3i32));
        check_array_equality(&result, &[-4, -7]).map_err(|e| crate::cpu::with_call(e, "vmlsl_n_s32(create_int64x2_t_from([-1, -1]), create_int32x2_t_from([1, 2]), 3i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_n_s32(create_random_int64x2_t(), create_random_int32x2_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_n_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_n_s32(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x2_t_from([1, 2]), 3i32));
        check_array_equality(&result, &[9223372036854775805, 9223372036854775801]).map_err(|e| crate::cpu::with_call(e, "vmlsl_n_s32(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x2_t_from([1, 2]), 3i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_n_s32(create_random_int64x2_t(), create_random_int32x2_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_n_u16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_n_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), 9u16));
        check_array_equality(&result, &[4294967252, 4294967244, 4294967236, 4294967228]).map_err(|e| crate::cpu::with_call(e, "vmlsl_n_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), 9u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_n_u16(create_random_uint32x4_t(), create_random_uint16x4_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_n_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_n_u16(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x4_t_from([1, 2, 3, 4]), 5u16));
        check_array_equality(&result, &[4294967291, 4294967285, 4294967283, 4294967273]).map_err(|e| crate::cpu::with_call(e, "vmlsl_n_u16(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x4_t_from([1, 2, 3, 4]), 5u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_n_u16(create_random_uint32x4_t(), create_random_uint16x4_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_n_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_n_u16(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x4_t_from([1, 2, 3, 4]), 5u16));
        check_array_equality(&result, &[95, 190, 285, 380]).map_err(|e| crate::cpu::with_call(e, "vmlsl_n_u16(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x4_t_from([1, 2, 3, 4]), 5u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_n_u16(create_random_uint32x4_t(), create_random_uint16x4_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_n_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_n_u16(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x4_t_from([1, 2, 3, 4]), 5u16));
        check_array_equality(&result, &[4294967291, 4294967286, 4294967281, 4294967276]).map_err(|e| crate::cpu::with_call(e, "vmlsl_n_u16(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x4_t_from([1, 2, 3, 4]), 5u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_n_u16(create_random_uint32x4_t(), create_random_uint16x4_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_n_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_n_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), 5u16));
        check_array_equality(&result, &[4294967290, 4294967285, 4294967280, 4294967275]).map_err(|e| crate::cpu::with_call(e, "vmlsl_n_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), 5u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_n_u16(create_random_uint32x4_t(), create_random_uint16x4_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_n_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_n_u16(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x4_t_from([1, 2, 3, 4]), 5u16));
        check_array_equality(&result, &[4294967291, 4294967286, 4294967281, 4294967276]).map_err(|e| crate::cpu::with_call(e, "vmlsl_n_u16(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x4_t_from([1, 2, 3, 4]), 5u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_n_u16(create_random_uint32x4_t(), create_random_uint16x4_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_n_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_n_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), 5u16));
        check_array_equality(&result, &[4294967290, 4294967285, 4294967280, 4294967275]).map_err(|e| crate::cpu::with_call(e, "vmlsl_n_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), 5u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_n_u16(create_random_uint32x4_t(), create_random_uint16x4_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_n_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_n_u16(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), 5u16));
        check_array_equality(&result, &[4294967291, 4294967285, 4294967281, 4294967275]).map_err(|e| crate::cpu::with_call(e, "vmlsl_n_u16(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), 5u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_n_u16(create_random_uint32x4_t(), create_random_uint16x4_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_n_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_n_u32(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), 5u32));
        check_array_equality(&result, &[18446744073709551602, 18446744073709551598]).map_err(|e| crate::cpu::with_call(e, "vmlsl_n_u32(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), 5u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_n_u32(create_random_uint64x2_t(), create_random_uint32x2_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_n_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_n_u32(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x2_t_from([1, 2]), 3u32));
        check_array_equality(&result, &[18446744073709551613, 18446744073709551609]).map_err(|e| crate::cpu::with_call(e, "vmlsl_n_u32(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x2_t_from([1, 2]), 3u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_n_u32(create_random_uint64x2_t(), create_random_uint32x2_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_n_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_n_u32(create_uint64x2_t_from([100, 200]), create_uint32x2_t_from([1, 2]), 3u32));
        check_array_equality(&result, &[97, 194]).map_err(|e| crate::cpu::with_call(e, "vmlsl_n_u32(create_uint64x2_t_from([100, 200]), create_uint32x2_t_from([1, 2]), 3u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_n_u32(create_random_uint64x2_t(), create_random_uint32x2_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_n_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_n_u32(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x2_t_from([1, 2]), 3u32));
        check_array_equality(&result, &[18446744073709551613, 18446744073709551610]).map_err(|e| crate::cpu::with_call(e, "vmlsl_n_u32(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x2_t_from([1, 2]), 3u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_n_u32(create_random_uint64x2_t(), create_random_uint32x2_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_n_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_n_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2]), 3u32));
        check_array_equality(&result, &[18446744073709551612, 18446744073709551609]).map_err(|e| crate::cpu::with_call(e, "vmlsl_n_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2]), 3u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_n_u32(create_random_uint64x2_t(), create_random_uint32x2_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_n_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_n_u32(create_uint64x2_t_from([0, 0]), create_uint32x2_t_from([1, 2]), 3u32));
        check_array_equality(&result, &[18446744073709551613, 18446744073709551610]).map_err(|e| crate::cpu::with_call(e, "vmlsl_n_u32(create_uint64x2_t_from([0, 0]), create_uint32x2_t_from([1, 2]), 3u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_n_u32(create_random_uint64x2_t(), create_random_uint32x2_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_n_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_n_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2]), 3u32));
        check_array_equality(&result, &[18446744073709551612, 18446744073709551609]).map_err(|e| crate::cpu::with_call(e, "vmlsl_n_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2]), 3u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_n_u32(create_random_uint64x2_t(), create_random_uint32x2_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_n_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_n_u32(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x2_t_from([1, 2]), 3u32));
        check_array_equality(&result, &[18446744073709551613, 18446744073709551609]).map_err(|e| crate::cpu::with_call(e, "vmlsl_n_u32(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x2_t_from([1, 2]), 3u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_n_u32(create_random_uint64x2_t(), create_random_uint32x2_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_s8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsl_s8(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[-152, -178, -206, -236, -268, -302, -338, -376]).map_err(|e| crate::cpu::with_call(e, "vmlsl_s8(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_s8(create_random_int16x8_t(), create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_s8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsl_s8(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-9, -21, -31, -51, -61, -89, -99, -135]).map_err(|e| crate::cpu::with_call(e, "vmlsl_s8(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_s8(create_random_int16x8_t(), create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_s8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsl_s8(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[91, 180, 267, 352, 435, 516, 595, 672]).map_err(|e| crate::cpu::with_call(e, "vmlsl_s8(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_s8(create_random_int16x8_t(), create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_s8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsl_s8(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[32759, 32748, 32735, 32720, 32703, 32684, 32663, 32640]).map_err(|e| crate::cpu::with_call(e, "vmlsl_s8(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_s8(create_random_int16x8_t(), create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_s8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsl_s8(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[32758, 32747, 32734, 32719, 32702, 32683, 32662, 32639]).map_err(|e| crate::cpu::with_call(e, "vmlsl_s8(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_s8(create_random_int16x8_t(), create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_s8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsl_s8(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-9, -20, -33, -48, -65, -84, -105, -128]).map_err(|e| crate::cpu::with_call(e, "vmlsl_s8(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_s8(create_random_int16x8_t(), create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_s8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsl_s8(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-10, -21, -34, -49, -66, -85, -106, -129]).map_err(|e| crate::cpu::with_call(e, "vmlsl_s8(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_s8(create_random_int16x8_t(), create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_s8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsl_s8(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[32759, 32747, -33, -49, 32703, 32683, -105, -129]).map_err(|e| crate::cpu::with_call(e, "vmlsl_s8(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_s8(create_random_int16x8_t(), create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[-44, -58, -74, -92]).map_err(|e| crate::cpu::with_call(e, "vmlsl_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_s16(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_s16(create_int32x4_t_from([0, -1, 2, -3]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-5, -13, -19, -35]).map_err(|e| crate::cpu::with_call(e, "vmlsl_s16(create_int32x4_t_from([0, -1, 2, -3]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_s16(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_s16(create_int32x4_t_from([100, 200, 300, 400]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[95, 188, 279, 368]).map_err(|e| crate::cpu::with_call(e, "vmlsl_s16(create_int32x4_t_from([100, 200, 300, 400]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_s16(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_s16(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[2147483643, 2147483636, 2147483627, 2147483616]).map_err(|e| crate::cpu::with_call(e, "vmlsl_s16(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_s16(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_s16(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[2147483642, 2147483635, 2147483626, 2147483615]).map_err(|e| crate::cpu::with_call(e, "vmlsl_s16(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_s16(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_s16(create_int32x4_t_from([0, 0, 0, 0]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-5, -12, -21, -32]).map_err(|e| crate::cpu::with_call(e, "vmlsl_s16(create_int32x4_t_from([0, 0, 0, 0]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_s16(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_s16(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-6, -13, -22, -33]).map_err(|e| crate::cpu::with_call(e, "vmlsl_s16(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_s16(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_s16(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[2147483643, 2147483635, -21, -33]).map_err(|e| crate::cpu::with_call(e, "vmlsl_s16(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_s16(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_s32(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[-14, -22]).map_err(|e| crate::cpu::with_call(e, "vmlsl_s32(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_s32(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_s32(create_int64x2_t_from([0, -1]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[-3, -9]).map_err(|e| crate::cpu::with_call(e, "vmlsl_s32(create_int64x2_t_from([0, -1]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_s32(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_s32(create_int64x2_t_from([100, 200]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[97, 192]).map_err(|e| crate::cpu::with_call(e, "vmlsl_s32(create_int64x2_t_from([100, 200]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_s32(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_s32(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[9223372036854775805, 9223372036854775800]).map_err(|e| crate::cpu::with_call(e, "vmlsl_s32(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_s32(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_s32(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[9223372036854775804, 9223372036854775799]).map_err(|e| crate::cpu::with_call(e, "vmlsl_s32(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_s32(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_s32(create_int64x2_t_from([0, 0]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[-3, -8]).map_err(|e| crate::cpu::with_call(e, "vmlsl_s32(create_int64x2_t_from([0, 0]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_s32(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_s32(create_int64x2_t_from([-1, -1]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[-4, -9]).map_err(|e| crate::cpu::with_call(e, "vmlsl_s32(create_int64x2_t_from([-1, -1]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_s32(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_s32(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[9223372036854775805, 9223372036854775799]).map_err(|e| crate::cpu::with_call(e, "vmlsl_s32(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_s32(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_u8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsl_u8(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[65384, 65358, 65330, 65300, 65268, 65234, 65198, 65160]).map_err(|e| crate::cpu::with_call(e, "vmlsl_u8(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_u8(create_random_uint16x8_t(), create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_u8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsl_u8(create_uint16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[65527, 65515, 65505, 65485, 65475, 65447, 65437, 65401]).map_err(|e| crate::cpu::with_call(e, "vmlsl_u8(create_uint16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_u8(create_random_uint16x8_t(), create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_u8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsl_u8(create_uint16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[91, 180, 267, 352, 435, 516, 595, 672]).map_err(|e| crate::cpu::with_call(e, "vmlsl_u8(create_uint16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_u8(create_random_uint16x8_t(), create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_u8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsl_u8(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[65527, 65516, 65503, 65488, 65471, 65452, 65431, 65408]).map_err(|e| crate::cpu::with_call(e, "vmlsl_u8(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_u8(create_random_uint16x8_t(), create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_u8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsl_u8(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[65526, 65515, 65502, 65487, 65470, 65451, 65430, 65407]).map_err(|e| crate::cpu::with_call(e, "vmlsl_u8(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_u8(create_random_uint16x8_t(), create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_u8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsl_u8(create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[65527, 65516, 65503, 65488, 65471, 65452, 65431, 65408]).map_err(|e| crate::cpu::with_call(e, "vmlsl_u8(create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_u8(create_random_uint16x8_t(), create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_u8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsl_u8(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[65526, 65515, 65502, 65487, 65470, 65451, 65430, 65407]).map_err(|e| crate::cpu::with_call(e, "vmlsl_u8(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_u8(create_random_uint16x8_t(), create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_u8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsl_u8(create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[65527, 65515, 65503, 65487, 65471, 65451, 65431, 65407]).map_err(|e| crate::cpu::with_call(e, "vmlsl_u8(create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_u8(create_random_uint16x8_t(), create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_u16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[4294967252, 4294967238, 4294967222, 4294967204]).map_err(|e| crate::cpu::with_call(e, "vmlsl_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_u16(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_u16(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[4294967291, 4294967283, 4294967277, 4294967261]).map_err(|e| crate::cpu::with_call(e, "vmlsl_u16(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_u16(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_u16(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[95, 188, 279, 368]).map_err(|e| crate::cpu::with_call(e, "vmlsl_u16(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_u16(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_u16(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[4294967291, 4294967284, 4294967275, 4294967264]).map_err(|e| crate::cpu::with_call(e, "vmlsl_u16(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_u16(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[4294967290, 4294967283, 4294967274, 4294967263]).map_err(|e| crate::cpu::with_call(e, "vmlsl_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_u16(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_u16(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[4294967291, 4294967284, 4294967275, 4294967264]).map_err(|e| crate::cpu::with_call(e, "vmlsl_u16(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_u16(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[4294967290, 4294967283, 4294967274, 4294967263]).map_err(|e| crate::cpu::with_call(e, "vmlsl_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_u16(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_u16(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[4294967291, 4294967283, 4294967275, 4294967263]).map_err(|e| crate::cpu::with_call(e, "vmlsl_u16(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_u16(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_u32(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x2_t_from([5, 6])));
        check_array_equality(&result, &[18446744073709551602, 18446744073709551594]).map_err(|e| crate::cpu::with_call(e, "vmlsl_u32(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_u32(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_u32(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[18446744073709551613, 18446744073709551607]).map_err(|e| crate::cpu::with_call(e, "vmlsl_u32(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_u32(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_u32(create_uint64x2_t_from([100, 200]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[97, 192]).map_err(|e| crate::cpu::with_call(e, "vmlsl_u32(create_uint64x2_t_from([100, 200]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_u32(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_u32(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[18446744073709551613, 18446744073709551608]).map_err(|e| crate::cpu::with_call(e, "vmlsl_u32(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_u32(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[18446744073709551612, 18446744073709551607]).map_err(|e| crate::cpu::with_call(e, "vmlsl_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_u32(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_u32(create_uint64x2_t_from([0, 0]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[18446744073709551613, 18446744073709551608]).map_err(|e| crate::cpu::with_call(e, "vmlsl_u32(create_uint64x2_t_from([0, 0]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_u32(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[18446744073709551612, 18446744073709551607]).map_err(|e| crate::cpu::with_call(e, "vmlsl_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_u32(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlsl_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_u32(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[18446744073709551613, 18446744073709551607]).map_err(|e| crate::cpu::with_call(e, "vmlsl_u32(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_u32(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}
