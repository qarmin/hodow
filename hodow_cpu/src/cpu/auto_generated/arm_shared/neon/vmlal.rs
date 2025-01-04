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

pub(super) fn test_arm_shared_neon_vmlal_lane_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_lane_s16::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[46, 56, 66, 76]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_s16::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_lane_s16::<0>(create_int32x4_t_from([0, -1, 2, -3]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 9, 17, 17]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_s16::<0>(create_int32x4_t_from([0, -1, 2, -3]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_lane_s16::<0>(create_int32x4_t_from([100, 200, 300, 400]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[105, 210, 315, 420]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_s16::<0>(create_int32x4_t_from([100, 200, 300, 400]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_lane_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-2147483643, -2147483638, -2147483633, -2147483628]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_lane_s16::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-2147483644, -2147483639, -2147483634, -2147483629]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_s16::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_lane_s16::<0>(create_int32x4_t_from([0, 0, 0, 0]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 10, 15, 20]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_s16::<0>(create_int32x4_t_from([0, 0, 0, 0]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_lane_s16::<0>(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[4, 9, 14, 19]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_s16::<0>(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_lane_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-2147483643, -2147483639, 15, 19]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_s16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_lane_s16::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[51, 62, 73, 84]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_s16::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_s16::<1>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_s16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_lane_s16::<3>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[61, 74, 87, 100]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_s16::<3>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_s16::<3>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_laneq_s16::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[46, 56, 66, 76]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_s16::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_laneq_s16::<0>(create_int32x4_t_from([0, -1, 2, -3]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[5, 9, 17, 17]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_s16::<0>(create_int32x4_t_from([0, -1, 2, -3]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_laneq_s16::<0>(create_int32x4_t_from([100, 200, 300, 400]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[105, 210, 315, 420]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_s16::<0>(create_int32x4_t_from([100, 200, 300, 400]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_laneq_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[-2147483643, -2147483638, -2147483633, -2147483628]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_laneq_s16::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[-2147483644, -2147483639, -2147483634, -2147483629]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_s16::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_laneq_s16::<0>(create_int32x4_t_from([0, 0, 0, 0]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[5, 10, 15, 20]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_s16::<0>(create_int32x4_t_from([0, 0, 0, 0]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_laneq_s16::<0>(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[4, 9, 14, 19]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_s16::<0>(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_laneq_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[-2147483643, -2147483639, 15, 19]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_s16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_laneq_s16::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[51, 62, 73, 84]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_s16::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_s16::<1>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_s16_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_laneq_s16::<7>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[81, 98, 115, 132]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_s16::<7>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_s16::<7>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_s16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_laneq_s16::<3>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[61, 74, 87, 100]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_s16::<3>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_s16::<3>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_lane_s32::<0>(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[16, 22]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_s32::<0>(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_lane_s32::<0>(create_int64x2_t_from([0, -1]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[3, 5]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_s32::<0>(create_int64x2_t_from([0, -1]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_lane_s32::<0>(create_int64x2_t_from([100, 200]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[103, 206]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_s32::<0>(create_int64x2_t_from([100, 200]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_lane_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[-9223372036854775805, -9223372036854775802]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_lane_s32::<0>(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[-9223372036854775806, -9223372036854775803]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_s32::<0>(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_lane_s32::<0>(create_int64x2_t_from([0, 0]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[3, 6]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_s32::<0>(create_int64x2_t_from([0, 0]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_lane_s32::<0>(create_int64x2_t_from([-1, -1]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[2, 5]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_s32::<0>(create_int64x2_t_from([-1, -1]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_lane_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[-9223372036854775805, -9223372036854775803]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_s32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_lane_s32::<1>(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[19, 26]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_s32::<1>(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_s32::<1>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_laneq_s32::<0>(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[16, 22]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_s32::<0>(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_laneq_s32::<0>(create_int64x2_t_from([0, -1]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[3, 5]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_s32::<0>(create_int64x2_t_from([0, -1]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_laneq_s32::<0>(create_int64x2_t_from([100, 200]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[103, 206]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_s32::<0>(create_int64x2_t_from([100, 200]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_laneq_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[-9223372036854775805, -9223372036854775802]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_laneq_s32::<0>(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[-9223372036854775806, -9223372036854775803]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_s32::<0>(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_laneq_s32::<0>(create_int64x2_t_from([0, 0]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[3, 6]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_s32::<0>(create_int64x2_t_from([0, 0]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_laneq_s32::<0>(create_int64x2_t_from([-1, -1]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[2, 5]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_s32::<0>(create_int64x2_t_from([-1, -1]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_laneq_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[-9223372036854775805, -9223372036854775803]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_s32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_laneq_s32::<1>(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[19, 26]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_s32::<1>(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_s32::<1>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_s32_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_laneq_s32::<3>(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[25, 34]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_s32::<3>(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_s32::<3>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_u16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_lane_u16::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[46, 56, 66, 76]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_u16::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_u16::<0>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_lane_u16::<0>(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 9, 17, 17]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_u16::<0>(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_u16::<0>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_lane_u16::<0>(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[105, 210, 315, 420]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_u16::<0>(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_u16::<0>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_lane_u16::<0>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 10, 15, 20]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_u16::<0>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_u16::<0>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_lane_u16::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[4, 9, 14, 19]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_u16::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_u16::<0>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_lane_u16::<0>(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 10, 15, 20]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_u16::<0>(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_u16::<0>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_lane_u16::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[4, 9, 14, 19]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_u16::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_u16::<0>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_lane_u16::<0>(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 9, 15, 19]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_u16::<0>(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_u16::<0>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_u16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_lane_u16::<1>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[51, 62, 73, 84]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_u16::<1>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_u16::<1>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_u16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_lane_u16::<3>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[61, 74, 87, 100]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_u16::<3>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_u16::<3>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_u16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_laneq_u16::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[46, 56, 66, 76]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_u16::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_u16::<0>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_laneq_u16::<0>(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[5, 9, 17, 17]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_u16::<0>(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_u16::<0>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_laneq_u16::<0>(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[105, 210, 315, 420]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_u16::<0>(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_u16::<0>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_laneq_u16::<0>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[5, 10, 15, 20]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_u16::<0>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_u16::<0>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_laneq_u16::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[4, 9, 14, 19]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_u16::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_u16::<0>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_laneq_u16::<0>(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[5, 10, 15, 20]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_u16::<0>(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_u16::<0>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_laneq_u16::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[4, 9, 14, 19]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_u16::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_u16::<0>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_laneq_u16::<0>(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[5, 9, 15, 19]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_u16::<0>(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_u16::<0>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_u16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_laneq_u16::<1>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[51, 62, 73, 84]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_u16::<1>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_u16::<1>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_u16_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_laneq_u16::<7>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[81, 98, 115, 132]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_u16::<7>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_u16::<7>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_u16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_laneq_u16::<3>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[61, 74, 87, 100]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_u16::<3>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_u16::<3>(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_lane_u32::<0>(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x2_t_from([5, 6])));
        check_array_equality(&result, &[16, 22]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_u32::<0>(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_u32::<0>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_lane_u32::<0>(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[3, 5]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_u32::<0>(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_u32::<0>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_lane_u32::<0>(create_uint64x2_t_from([100, 200]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[103, 206]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_u32::<0>(create_uint64x2_t_from([100, 200]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_u32::<0>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_lane_u32::<0>(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[3, 6]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_u32::<0>(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_u32::<0>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_lane_u32::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[2, 5]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_u32::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_u32::<0>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_lane_u32::<0>(create_uint64x2_t_from([0, 0]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[3, 6]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_u32::<0>(create_uint64x2_t_from([0, 0]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_u32::<0>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_lane_u32::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[2, 5]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_u32::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_u32::<0>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_lane_u32::<0>(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[3, 5]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_u32::<0>(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_u32::<0>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_lane_u32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_lane_u32::<1>(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x2_t_from([5, 6])));
        check_array_equality(&result, &[19, 26]).map_err(|e| crate::cpu::with_call(e, "vmlal_lane_u32::<1>(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_lane_u32::<1>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_laneq_u32::<0>(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[16, 22]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_u32::<0>(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_u32::<0>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_laneq_u32::<0>(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[3, 5]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_u32::<0>(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_u32::<0>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_laneq_u32::<0>(create_uint64x2_t_from([100, 200]), create_uint32x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[103, 206]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_u32::<0>(create_uint64x2_t_from([100, 200]), create_uint32x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_u32::<0>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_laneq_u32::<0>(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[3, 6]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_u32::<0>(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_u32::<0>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_laneq_u32::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[2, 5]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_u32::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_u32::<0>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_laneq_u32::<0>(create_uint64x2_t_from([0, 0]), create_uint32x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[3, 6]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_u32::<0>(create_uint64x2_t_from([0, 0]), create_uint32x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_u32::<0>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_laneq_u32::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[2, 5]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_u32::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_u32::<0>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_laneq_u32::<0>(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[3, 5]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_u32::<0>(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_u32::<0>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_u32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_laneq_u32::<1>(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[19, 26]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_u32::<1>(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_u32::<1>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_laneq_u32_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_laneq_u32::<3>(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[25, 34]).map_err(|e| crate::cpu::with_call(e, "vmlal_laneq_u32::<3>(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_laneq_u32::<3>(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_n_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_n_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), 9i16));
        check_array_equality(&result, &[46, 56, 66, 76]).map_err(|e| crate::cpu::with_call(e, "vmlal_n_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), 9i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_n_s16(create_random_int32x4_t(), create_random_int16x4_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_n_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_n_s16(create_int32x4_t_from([0, -1, 2, -3]), create_int16x4_t_from([1, 2, 3, 4]), 5i16));
        check_array_equality(&result, &[5, 9, 17, 17]).map_err(|e| crate::cpu::with_call(e, "vmlal_n_s16(create_int32x4_t_from([0, -1, 2, -3]), create_int16x4_t_from([1, 2, 3, 4]), 5i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_n_s16(create_random_int32x4_t(), create_random_int16x4_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_n_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_n_s16(create_int32x4_t_from([100, 200, 300, 400]), create_int16x4_t_from([1, 2, 3, 4]), 5i16));
        check_array_equality(&result, &[105, 210, 315, 420]).map_err(|e| crate::cpu::with_call(e, "vmlal_n_s16(create_int32x4_t_from([100, 200, 300, 400]), create_int16x4_t_from([1, 2, 3, 4]), 5i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_n_s16(create_random_int32x4_t(), create_random_int16x4_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_n_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_n_s16(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x4_t_from([1, 2, 3, 4]), 5i16));
        check_array_equality(&result, &[-2147483643, -2147483638, -2147483633, -2147483628]).map_err(|e| crate::cpu::with_call(e, "vmlal_n_s16(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x4_t_from([1, 2, 3, 4]), 5i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_n_s16(create_random_int32x4_t(), create_random_int16x4_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_n_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_n_s16(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x4_t_from([1, 2, 3, 4]), 5i16));
        check_array_equality(&result, &[-2147483644, -2147483639, -2147483634, -2147483629]).map_err(|e| crate::cpu::with_call(e, "vmlal_n_s16(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x4_t_from([1, 2, 3, 4]), 5i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_n_s16(create_random_int32x4_t(), create_random_int16x4_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_n_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_n_s16(create_int32x4_t_from([0, 0, 0, 0]), create_int16x4_t_from([1, 2, 3, 4]), 5i16));
        check_array_equality(&result, &[5, 10, 15, 20]).map_err(|e| crate::cpu::with_call(e, "vmlal_n_s16(create_int32x4_t_from([0, 0, 0, 0]), create_int16x4_t_from([1, 2, 3, 4]), 5i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_n_s16(create_random_int32x4_t(), create_random_int16x4_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_n_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_n_s16(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x4_t_from([1, 2, 3, 4]), 5i16));
        check_array_equality(&result, &[4, 9, 14, 19]).map_err(|e| crate::cpu::with_call(e, "vmlal_n_s16(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x4_t_from([1, 2, 3, 4]), 5i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_n_s16(create_random_int32x4_t(), create_random_int16x4_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_n_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_n_s16(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x4_t_from([1, 2, 3, 4]), 5i16));
        check_array_equality(&result, &[-2147483643, -2147483639, 15, 19]).map_err(|e| crate::cpu::with_call(e, "vmlal_n_s16(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x4_t_from([1, 2, 3, 4]), 5i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_n_s16(create_random_int32x4_t(), create_random_int16x4_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_n_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_n_s32(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), 5i32));
        check_array_equality(&result, &[16, 22]).map_err(|e| crate::cpu::with_call(e, "vmlal_n_s32(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), 5i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_n_s32(create_random_int64x2_t(), create_random_int32x2_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_n_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_n_s32(create_int64x2_t_from([0, -1]), create_int32x2_t_from([1, 2]), 3i32));
        check_array_equality(&result, &[3, 5]).map_err(|e| crate::cpu::with_call(e, "vmlal_n_s32(create_int64x2_t_from([0, -1]), create_int32x2_t_from([1, 2]), 3i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_n_s32(create_random_int64x2_t(), create_random_int32x2_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_n_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_n_s32(create_int64x2_t_from([100, 200]), create_int32x2_t_from([1, 2]), 3i32));
        check_array_equality(&result, &[103, 206]).map_err(|e| crate::cpu::with_call(e, "vmlal_n_s32(create_int64x2_t_from([100, 200]), create_int32x2_t_from([1, 2]), 3i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_n_s32(create_random_int64x2_t(), create_random_int32x2_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_n_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_n_s32(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x2_t_from([1, 2]), 3i32));
        check_array_equality(&result, &[-9223372036854775805, -9223372036854775802]).map_err(|e| crate::cpu::with_call(e, "vmlal_n_s32(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x2_t_from([1, 2]), 3i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_n_s32(create_random_int64x2_t(), create_random_int32x2_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_n_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_n_s32(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x2_t_from([1, 2]), 3i32));
        check_array_equality(&result, &[-9223372036854775806, -9223372036854775803]).map_err(|e| crate::cpu::with_call(e, "vmlal_n_s32(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x2_t_from([1, 2]), 3i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_n_s32(create_random_int64x2_t(), create_random_int32x2_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_n_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_n_s32(create_int64x2_t_from([0, 0]), create_int32x2_t_from([1, 2]), 3i32));
        check_array_equality(&result, &[3, 6]).map_err(|e| crate::cpu::with_call(e, "vmlal_n_s32(create_int64x2_t_from([0, 0]), create_int32x2_t_from([1, 2]), 3i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_n_s32(create_random_int64x2_t(), create_random_int32x2_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_n_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_n_s32(create_int64x2_t_from([-1, -1]), create_int32x2_t_from([1, 2]), 3i32));
        check_array_equality(&result, &[2, 5]).map_err(|e| crate::cpu::with_call(e, "vmlal_n_s32(create_int64x2_t_from([-1, -1]), create_int32x2_t_from([1, 2]), 3i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_n_s32(create_random_int64x2_t(), create_random_int32x2_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_n_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_n_s32(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x2_t_from([1, 2]), 3i32));
        check_array_equality(&result, &[-9223372036854775805, -9223372036854775803]).map_err(|e| crate::cpu::with_call(e, "vmlal_n_s32(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x2_t_from([1, 2]), 3i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_n_s32(create_random_int64x2_t(), create_random_int32x2_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_n_u16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_n_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), 9u16));
        check_array_equality(&result, &[46, 56, 66, 76]).map_err(|e| crate::cpu::with_call(e, "vmlal_n_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), 9u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_n_u16(create_random_uint32x4_t(), create_random_uint16x4_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_n_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_n_u16(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x4_t_from([1, 2, 3, 4]), 5u16));
        check_array_equality(&result, &[5, 9, 17, 17]).map_err(|e| crate::cpu::with_call(e, "vmlal_n_u16(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x4_t_from([1, 2, 3, 4]), 5u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_n_u16(create_random_uint32x4_t(), create_random_uint16x4_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_n_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_n_u16(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x4_t_from([1, 2, 3, 4]), 5u16));
        check_array_equality(&result, &[105, 210, 315, 420]).map_err(|e| crate::cpu::with_call(e, "vmlal_n_u16(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x4_t_from([1, 2, 3, 4]), 5u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_n_u16(create_random_uint32x4_t(), create_random_uint16x4_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_n_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_n_u16(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x4_t_from([1, 2, 3, 4]), 5u16));
        check_array_equality(&result, &[5, 10, 15, 20]).map_err(|e| crate::cpu::with_call(e, "vmlal_n_u16(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x4_t_from([1, 2, 3, 4]), 5u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_n_u16(create_random_uint32x4_t(), create_random_uint16x4_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_n_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_n_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), 5u16));
        check_array_equality(&result, &[4, 9, 14, 19]).map_err(|e| crate::cpu::with_call(e, "vmlal_n_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), 5u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_n_u16(create_random_uint32x4_t(), create_random_uint16x4_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_n_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_n_u16(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x4_t_from([1, 2, 3, 4]), 5u16));
        check_array_equality(&result, &[5, 10, 15, 20]).map_err(|e| crate::cpu::with_call(e, "vmlal_n_u16(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x4_t_from([1, 2, 3, 4]), 5u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_n_u16(create_random_uint32x4_t(), create_random_uint16x4_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_n_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_n_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), 5u16));
        check_array_equality(&result, &[4, 9, 14, 19]).map_err(|e| crate::cpu::with_call(e, "vmlal_n_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), 5u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_n_u16(create_random_uint32x4_t(), create_random_uint16x4_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_n_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_n_u16(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), 5u16));
        check_array_equality(&result, &[5, 9, 15, 19]).map_err(|e| crate::cpu::with_call(e, "vmlal_n_u16(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), 5u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_n_u16(create_random_uint32x4_t(), create_random_uint16x4_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_n_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_n_u32(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), 5u32));
        check_array_equality(&result, &[16, 22]).map_err(|e| crate::cpu::with_call(e, "vmlal_n_u32(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), 5u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_n_u32(create_random_uint64x2_t(), create_random_uint32x2_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_n_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_n_u32(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x2_t_from([1, 2]), 3u32));
        check_array_equality(&result, &[3, 5]).map_err(|e| crate::cpu::with_call(e, "vmlal_n_u32(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x2_t_from([1, 2]), 3u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_n_u32(create_random_uint64x2_t(), create_random_uint32x2_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_n_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_n_u32(create_uint64x2_t_from([100, 200]), create_uint32x2_t_from([1, 2]), 3u32));
        check_array_equality(&result, &[103, 206]).map_err(|e| crate::cpu::with_call(e, "vmlal_n_u32(create_uint64x2_t_from([100, 200]), create_uint32x2_t_from([1, 2]), 3u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_n_u32(create_random_uint64x2_t(), create_random_uint32x2_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_n_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_n_u32(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x2_t_from([1, 2]), 3u32));
        check_array_equality(&result, &[3, 6]).map_err(|e| crate::cpu::with_call(e, "vmlal_n_u32(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x2_t_from([1, 2]), 3u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_n_u32(create_random_uint64x2_t(), create_random_uint32x2_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_n_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_n_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2]), 3u32));
        check_array_equality(&result, &[2, 5]).map_err(|e| crate::cpu::with_call(e, "vmlal_n_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2]), 3u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_n_u32(create_random_uint64x2_t(), create_random_uint32x2_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_n_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_n_u32(create_uint64x2_t_from([0, 0]), create_uint32x2_t_from([1, 2]), 3u32));
        check_array_equality(&result, &[3, 6]).map_err(|e| crate::cpu::with_call(e, "vmlal_n_u32(create_uint64x2_t_from([0, 0]), create_uint32x2_t_from([1, 2]), 3u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_n_u32(create_random_uint64x2_t(), create_random_uint32x2_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_n_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_n_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2]), 3u32));
        check_array_equality(&result, &[2, 5]).map_err(|e| crate::cpu::with_call(e, "vmlal_n_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2]), 3u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_n_u32(create_random_uint64x2_t(), create_random_uint32x2_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_n_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_n_u32(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x2_t_from([1, 2]), 3u32));
        check_array_equality(&result, &[3, 5]).map_err(|e| crate::cpu::with_call(e, "vmlal_n_u32(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x2_t_from([1, 2]), 3u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_n_u32(create_random_uint64x2_t(), create_random_uint32x2_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_s8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlal_s8(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[154, 182, 212, 244, 278, 314, 352, 392]).map_err(|e| crate::cpu::with_call(e, "vmlal_s8(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_int8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_s8(create_random_int16x8_t(), create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_s8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlal_s8(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 19, 35, 45, 69, 79, 111, 121]).map_err(|e| crate::cpu::with_call(e, "vmlal_s8(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_s8(create_random_int16x8_t(), create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_s8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlal_s8(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[109, 220, 333, 448, 565, 684, 805, 928]).map_err(|e| crate::cpu::with_call(e, "vmlal_s8(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_s8(create_random_int16x8_t(), create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_s8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlal_s8(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-32759, -32748, -32735, -32720, -32703, -32684, -32663, -32640]).map_err(|e| crate::cpu::with_call(e, "vmlal_s8(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_s8(create_random_int16x8_t(), create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_s8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlal_s8(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-32760, -32749, -32736, -32721, -32704, -32685, -32664, -32641]).map_err(|e| crate::cpu::with_call(e, "vmlal_s8(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_s8(create_random_int16x8_t(), create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_s8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlal_s8(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 20, 33, 48, 65, 84, 105, 128]).map_err(|e| crate::cpu::with_call(e, "vmlal_s8(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_s8(create_random_int16x8_t(), create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_s8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlal_s8(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[8, 19, 32, 47, 64, 83, 104, 127]).map_err(|e| crate::cpu::with_call(e, "vmlal_s8(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_s8(create_random_int16x8_t(), create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_s8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlal_s8(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-32759, -32749, 33, 47, -32703, -32685, 105, 127]).map_err(|e| crate::cpu::with_call(e, "vmlal_s8(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_s8(create_random_int16x8_t(), create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[46, 62, 80, 100]).map_err(|e| crate::cpu::with_call(e, "vmlal_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_s16(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_s16(create_int32x4_t_from([0, -1, 2, -3]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 11, 23, 29]).map_err(|e| crate::cpu::with_call(e, "vmlal_s16(create_int32x4_t_from([0, -1, 2, -3]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_s16(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_s16(create_int32x4_t_from([100, 200, 300, 400]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[105, 212, 321, 432]).map_err(|e| crate::cpu::with_call(e, "vmlal_s16(create_int32x4_t_from([100, 200, 300, 400]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_s16(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_s16(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-2147483643, -2147483636, -2147483627, -2147483616]).map_err(|e| crate::cpu::with_call(e, "vmlal_s16(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_s16(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_s16(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-2147483644, -2147483637, -2147483628, -2147483617]).map_err(|e| crate::cpu::with_call(e, "vmlal_s16(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_s16(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_s16(create_int32x4_t_from([0, 0, 0, 0]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 12, 21, 32]).map_err(|e| crate::cpu::with_call(e, "vmlal_s16(create_int32x4_t_from([0, 0, 0, 0]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_s16(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_s16(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[4, 11, 20, 31]).map_err(|e| crate::cpu::with_call(e, "vmlal_s16(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_s16(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_s16(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-2147483643, -2147483637, 21, 31]).map_err(|e| crate::cpu::with_call(e, "vmlal_s16(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_s16(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_s32(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[16, 26]).map_err(|e| crate::cpu::with_call(e, "vmlal_s32(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_s32(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_s32(create_int64x2_t_from([0, -1]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[3, 7]).map_err(|e| crate::cpu::with_call(e, "vmlal_s32(create_int64x2_t_from([0, -1]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_s32(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_s32(create_int64x2_t_from([100, 200]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[103, 208]).map_err(|e| crate::cpu::with_call(e, "vmlal_s32(create_int64x2_t_from([100, 200]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_s32(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_s32(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[-9223372036854775805, -9223372036854775800]).map_err(|e| crate::cpu::with_call(e, "vmlal_s32(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_s32(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_s32(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[-9223372036854775806, -9223372036854775801]).map_err(|e| crate::cpu::with_call(e, "vmlal_s32(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_s32(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_s32(create_int64x2_t_from([0, 0]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[3, 8]).map_err(|e| crate::cpu::with_call(e, "vmlal_s32(create_int64x2_t_from([0, 0]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_s32(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_s32(create_int64x2_t_from([-1, -1]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[2, 7]).map_err(|e| crate::cpu::with_call(e, "vmlal_s32(create_int64x2_t_from([-1, -1]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_s32(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_s32(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[-9223372036854775805, -9223372036854775801]).map_err(|e| crate::cpu::with_call(e, "vmlal_s32(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_s32(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_u8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlal_u8(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[154, 182, 212, 244, 278, 314, 352, 392]).map_err(|e| crate::cpu::with_call(e, "vmlal_u8(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_u8(create_random_uint16x8_t(), create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_u8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlal_u8(create_uint16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 19, 35, 45, 69, 79, 111, 121]).map_err(|e| crate::cpu::with_call(e, "vmlal_u8(create_uint16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_u8(create_random_uint16x8_t(), create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_u8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlal_u8(create_uint16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[109, 220, 333, 448, 565, 684, 805, 928]).map_err(|e| crate::cpu::with_call(e, "vmlal_u8(create_uint16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_u8(create_random_uint16x8_t(), create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_u8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlal_u8(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 20, 33, 48, 65, 84, 105, 128]).map_err(|e| crate::cpu::with_call(e, "vmlal_u8(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_u8(create_random_uint16x8_t(), create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_u8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlal_u8(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[8, 19, 32, 47, 64, 83, 104, 127]).map_err(|e| crate::cpu::with_call(e, "vmlal_u8(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_u8(create_random_uint16x8_t(), create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_u8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlal_u8(create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 20, 33, 48, 65, 84, 105, 128]).map_err(|e| crate::cpu::with_call(e, "vmlal_u8(create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_u8(create_random_uint16x8_t(), create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_u8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlal_u8(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[8, 19, 32, 47, 64, 83, 104, 127]).map_err(|e| crate::cpu::with_call(e, "vmlal_u8(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_u8(create_random_uint16x8_t(), create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_u8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlal_u8(create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 19, 33, 47, 65, 83, 105, 127]).map_err(|e| crate::cpu::with_call(e, "vmlal_u8(create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_u8(create_random_uint16x8_t(), create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_u16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[46, 62, 80, 100]).map_err(|e| crate::cpu::with_call(e, "vmlal_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_u16(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_u16(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 11, 23, 29]).map_err(|e| crate::cpu::with_call(e, "vmlal_u16(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_u16(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_u16(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[105, 212, 321, 432]).map_err(|e| crate::cpu::with_call(e, "vmlal_u16(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_u16(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_u16(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 12, 21, 32]).map_err(|e| crate::cpu::with_call(e, "vmlal_u16(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_u16(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[4, 11, 20, 31]).map_err(|e| crate::cpu::with_call(e, "vmlal_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_u16(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_u16(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 12, 21, 32]).map_err(|e| crate::cpu::with_call(e, "vmlal_u16(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_u16(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[4, 11, 20, 31]).map_err(|e| crate::cpu::with_call(e, "vmlal_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_u16(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_u16(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 11, 21, 31]).map_err(|e| crate::cpu::with_call(e, "vmlal_u16(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_u16(create_random_uint32x4_t(), create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_u32(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x2_t_from([5, 6])));
        check_array_equality(&result, &[16, 26]).map_err(|e| crate::cpu::with_call(e, "vmlal_u32(create_uint64x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]), create_uint32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_u32(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_u32(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[3, 7]).map_err(|e| crate::cpu::with_call(e, "vmlal_u32(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_u32(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_u32(create_uint64x2_t_from([100, 200]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[103, 208]).map_err(|e| crate::cpu::with_call(e, "vmlal_u32(create_uint64x2_t_from([100, 200]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_u32(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_u32(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[3, 8]).map_err(|e| crate::cpu::with_call(e, "vmlal_u32(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_u32(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[2, 7]).map_err(|e| crate::cpu::with_call(e, "vmlal_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_u32(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_u32(create_uint64x2_t_from([0, 0]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[3, 8]).map_err(|e| crate::cpu::with_call(e, "vmlal_u32(create_uint64x2_t_from([0, 0]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_u32(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[2, 7]).map_err(|e| crate::cpu::with_call(e, "vmlal_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_u32(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmlal_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_u32(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[3, 7]).map_err(|e| crate::cpu::with_call(e, "vmlal_u32(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_u32(create_random_uint64x2_t(), create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}
