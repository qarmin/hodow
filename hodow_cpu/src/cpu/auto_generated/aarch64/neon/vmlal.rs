use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vmlal_high_lane_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_lane_s16::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x4_t_from([13, 14, 15, 16])));
        check_array_equality(&result, &[118, 132, 146, 160]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_s16::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x4_t_from([13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_lane_s16::<0>(create_int32x4_t_from([0, -1, 2, -3]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[45, 53, 65, 69]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_s16::<0>(create_int32x4_t_from([0, -1, 2, -3]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_lane_s16::<0>(create_int32x4_t_from([100, 200, 300, 400]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[145, 254, 363, 472]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_s16::<0>(create_int32x4_t_from([100, 200, 300, 400]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_lane_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[-2147483603, -2147483594, -2147483585, -2147483576]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_lane_s16::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[-2147483604, -2147483595, -2147483586, -2147483577]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_s16::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_lane_s16::<0>(create_int32x4_t_from([0, 0, 0, 0]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[45, 54, 63, 72]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_s16::<0>(create_int32x4_t_from([0, 0, 0, 0]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_lane_s16::<0>(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[44, 53, 62, 71]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_s16::<0>(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_lane_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[-2147483603, -2147483595, 63, 71]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_s16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_lane_s16::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x4_t_from([13, 14, 15, 16])));
        check_array_equality(&result, &[127, 142, 157, 172]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_s16::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x4_t_from([13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_s16::<1>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_s16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_lane_s16::<3>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x4_t_from([13, 14, 15, 16])));
        check_array_equality(&result, &[145, 162, 179, 196]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_s16::<3>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x4_t_from([13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_s16::<3>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_laneq_s16::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[118, 132, 146, 160]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_s16::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_laneq_s16::<0>(create_int32x4_t_from([0, -1, 2, -3]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[45, 53, 65, 69]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_s16::<0>(create_int32x4_t_from([0, -1, 2, -3]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_laneq_s16::<0>(create_int32x4_t_from([100, 200, 300, 400]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[145, 254, 363, 472]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_s16::<0>(create_int32x4_t_from([100, 200, 300, 400]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_laneq_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-2147483603, -2147483594, -2147483585, -2147483576]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_laneq_s16::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-2147483604, -2147483595, -2147483586, -2147483577]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_s16::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_laneq_s16::<0>(create_int32x4_t_from([0, 0, 0, 0]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[45, 54, 63, 72]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_s16::<0>(create_int32x4_t_from([0, 0, 0, 0]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_laneq_s16::<0>(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[44, 53, 62, 71]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_s16::<0>(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_laneq_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-2147483603, -2147483595, 63, 71]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_s16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_laneq_s16::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[127, 142, 157, 172]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_s16::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_s16::<1>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_s16_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_laneq_s16::<7>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[181, 202, 223, 244]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_s16::<7>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_s16::<7>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_s16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_laneq_s16::<3>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[145, 162, 179, 196]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_s16::<3>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_s16::<3>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_lane_s32::<0>(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x2_t_from([7, 8])));
        check_array_equality(&result, &[36, 44]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_s32::<0>(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x2_t_from([7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_lane_s32::<0>(create_int64x2_t_from([0, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[15, 19]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_s32::<0>(create_int64x2_t_from([0, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_lane_s32::<0>(create_int64x2_t_from([100, 200]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[115, 220]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_s32::<0>(create_int64x2_t_from([100, 200]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_lane_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[-9223372036854775793, -9223372036854775788]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_lane_s32::<0>(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[-9223372036854775794, -9223372036854775789]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_s32::<0>(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_lane_s32::<0>(create_int64x2_t_from([0, 0]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[15, 20]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_s32::<0>(create_int64x2_t_from([0, 0]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_lane_s32::<0>(create_int64x2_t_from([-1, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[14, 19]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_s32::<0>(create_int64x2_t_from([-1, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_lane_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[-9223372036854775793, -9223372036854775789]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_s32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_lane_s32::<1>(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x2_t_from([7, 8])));
        check_array_equality(&result, &[41, 50]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_s32::<1>(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x2_t_from([7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_s32::<1>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_laneq_s32::<0>(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x4_t_from([7, 8, 9, 10])));
        check_array_equality(&result, &[36, 44]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_s32::<0>(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x4_t_from([7, 8, 9, 10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_laneq_s32::<0>(create_int64x2_t_from([0, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[15, 19]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_s32::<0>(create_int64x2_t_from([0, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_laneq_s32::<0>(create_int64x2_t_from([100, 200]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[115, 220]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_s32::<0>(create_int64x2_t_from([100, 200]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_laneq_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-9223372036854775793, -9223372036854775788]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_laneq_s32::<0>(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-9223372036854775794, -9223372036854775789]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_s32::<0>(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_laneq_s32::<0>(create_int64x2_t_from([0, 0]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[15, 20]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_s32::<0>(create_int64x2_t_from([0, 0]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_laneq_s32::<0>(create_int64x2_t_from([-1, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[14, 19]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_s32::<0>(create_int64x2_t_from([-1, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_laneq_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-9223372036854775793, -9223372036854775789]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_s32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_laneq_s32::<1>(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x4_t_from([7, 8, 9, 10])));
        check_array_equality(&result, &[41, 50]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_s32::<1>(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x4_t_from([7, 8, 9, 10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_s32::<1>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_s32_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_laneq_s32::<3>(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x4_t_from([7, 8, 9, 10])));
        check_array_equality(&result, &[51, 62]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_s32::<3>(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x4_t_from([7, 8, 9, 10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_s32::<3>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_u16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_lane_u16::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x4_t_from([13, 14, 15, 16])));
        check_array_equality(&result, &[118, 132, 146, 160]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_u16::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x4_t_from([13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_u16::<0>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_lane_u16::<0>(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[45, 53, 65, 69]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_u16::<0>(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_u16::<0>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_lane_u16::<0>(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[145, 254, 363, 472]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_u16::<0>(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_u16::<0>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_lane_u16::<0>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[45, 54, 63, 72]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_u16::<0>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_u16::<0>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_lane_u16::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[44, 53, 62, 71]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_u16::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_u16::<0>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_lane_u16::<0>(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[45, 54, 63, 72]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_u16::<0>(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_u16::<0>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_lane_u16::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[44, 53, 62, 71]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_u16::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_u16::<0>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_lane_u16::<0>(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[45, 53, 63, 71]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_u16::<0>(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_u16::<0>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_u16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_lane_u16::<1>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x4_t_from([13, 14, 15, 16])));
        check_array_equality(&result, &[127, 142, 157, 172]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_u16::<1>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x4_t_from([13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_u16::<1>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_u16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_lane_u16::<3>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x4_t_from([13, 14, 15, 16])));
        check_array_equality(&result, &[145, 162, 179, 196]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_u16::<3>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x4_t_from([13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_u16::<3>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_u16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_laneq_u16::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[118, 132, 146, 160]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_u16::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_u16::<0>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_laneq_u16::<0>(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[45, 53, 65, 69]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_u16::<0>(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_u16::<0>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_laneq_u16::<0>(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[145, 254, 363, 472]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_u16::<0>(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_u16::<0>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_laneq_u16::<0>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[45, 54, 63, 72]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_u16::<0>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_u16::<0>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_laneq_u16::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[44, 53, 62, 71]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_u16::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_u16::<0>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_laneq_u16::<0>(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[45, 54, 63, 72]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_u16::<0>(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_u16::<0>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_laneq_u16::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[44, 53, 62, 71]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_u16::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_u16::<0>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_laneq_u16::<0>(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[45, 53, 63, 71]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_u16::<0>(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_u16::<0>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_u16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_laneq_u16::<1>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[127, 142, 157, 172]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_u16::<1>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_u16::<1>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_u16_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_laneq_u16::<7>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[181, 202, 223, 244]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_u16::<7>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_u16::<7>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_u16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_laneq_u16::<3>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[145, 162, 179, 196]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_u16::<3>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_u16::<3>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_lane_u32::<0>(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), create_uint32x2_t_from([7, 8])));
        check_array_equality(&result, &[36, 44]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_u32::<0>(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), create_uint32x2_t_from([7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_u32::<0>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_lane_u32::<0>(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x2_t_from([5, 6])));
        check_array_equality(&result, &[15, 19]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_u32::<0>(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_u32::<0>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_lane_u32::<0>(create_uint64x2_t_from([100, 200]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x2_t_from([5, 6])));
        check_array_equality(&result, &[115, 220]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_u32::<0>(create_uint64x2_t_from([100, 200]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_u32::<0>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_lane_u32::<0>(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x2_t_from([5, 6])));
        check_array_equality(&result, &[15, 20]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_u32::<0>(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_u32::<0>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_lane_u32::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x2_t_from([5, 6])));
        check_array_equality(&result, &[14, 19]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_u32::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_u32::<0>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_lane_u32::<0>(create_uint64x2_t_from([0, 0]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x2_t_from([5, 6])));
        check_array_equality(&result, &[15, 20]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_u32::<0>(create_uint64x2_t_from([0, 0]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_u32::<0>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_lane_u32::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x2_t_from([5, 6])));
        check_array_equality(&result, &[14, 19]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_u32::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_u32::<0>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_lane_u32::<0>(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x2_t_from([5, 6])));
        check_array_equality(&result, &[15, 19]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_u32::<0>(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_u32::<0>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_lane_u32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_lane_u32::<1>(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), create_uint32x2_t_from([7, 8])));
        check_array_equality(&result, &[41, 50]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_lane_u32::<1>(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), create_uint32x2_t_from([7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_lane_u32::<1>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_laneq_u32::<0>(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), create_uint32x4_t_from([7, 8, 9, 10])));
        check_array_equality(&result, &[36, 44]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_u32::<0>(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), create_uint32x4_t_from([7, 8, 9, 10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_u32::<0>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_laneq_u32::<0>(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[15, 19]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_u32::<0>(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_u32::<0>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_laneq_u32::<0>(create_uint64x2_t_from([100, 200]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[115, 220]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_u32::<0>(create_uint64x2_t_from([100, 200]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_u32::<0>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_laneq_u32::<0>(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[15, 20]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_u32::<0>(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_u32::<0>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_laneq_u32::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[14, 19]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_u32::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_u32::<0>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_laneq_u32::<0>(create_uint64x2_t_from([0, 0]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[15, 20]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_u32::<0>(create_uint64x2_t_from([0, 0]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_u32::<0>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_laneq_u32::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[14, 19]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_u32::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_u32::<0>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_laneq_u32::<0>(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[15, 19]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_u32::<0>(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_u32::<0>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_u32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_laneq_u32::<1>(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), create_uint32x4_t_from([7, 8, 9, 10])));
        check_array_equality(&result, &[41, 50]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_u32::<1>(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), create_uint32x4_t_from([7, 8, 9, 10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_u32::<1>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_laneq_u32_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_laneq_u32::<3>(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), create_uint32x4_t_from([7, 8, 9, 10])));
        check_array_equality(&result, &[51, 62]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_laneq_u32::<3>(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), create_uint32x4_t_from([7, 8, 9, 10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_laneq_u32::<3>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_n_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_n_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), 13i16));
        check_array_equality(&result, &[118, 132, 146, 160]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_n_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), 13i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_n_s16(create_random_int32x4_t(), create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_n_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_n_s16(create_int32x4_t_from([0, -1, 2, -3]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16));
        check_array_equality(&result, &[45, 53, 65, 69]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_n_s16(create_int32x4_t_from([0, -1, 2, -3]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_n_s16(create_random_int32x4_t(), create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_n_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_n_s16(create_int32x4_t_from([100, 200, 300, 400]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16));
        check_array_equality(&result, &[145, 254, 363, 472]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_n_s16(create_int32x4_t_from([100, 200, 300, 400]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_n_s16(create_random_int32x4_t(), create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_n_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_n_s16(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16));
        check_array_equality(&result, &[-2147483603, -2147483594, -2147483585, -2147483576]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_n_s16(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_n_s16(create_random_int32x4_t(), create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_n_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_n_s16(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16));
        check_array_equality(&result, &[-2147483604, -2147483595, -2147483586, -2147483577]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_n_s16(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_n_s16(create_random_int32x4_t(), create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_n_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_n_s16(create_int32x4_t_from([0, 0, 0, 0]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16));
        check_array_equality(&result, &[45, 54, 63, 72]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_n_s16(create_int32x4_t_from([0, 0, 0, 0]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_n_s16(create_random_int32x4_t(), create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_n_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_n_s16(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16));
        check_array_equality(&result, &[44, 53, 62, 71]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_n_s16(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_n_s16(create_random_int32x4_t(), create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_n_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_n_s16(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16));
        check_array_equality(&result, &[-2147483603, -2147483595, 63, 71]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_n_s16(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_n_s16(create_random_int32x4_t(), create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_n_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_n_s32(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), 7i32));
        check_array_equality(&result, &[36, 44]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_n_s32(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), 7i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_n_s32(create_random_int64x2_t(), create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_n_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_n_s32(create_int64x2_t_from([0, -1]), create_int32x4_t_from([1, 2, 3, 4]), 5i32));
        check_array_equality(&result, &[15, 19]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_n_s32(create_int64x2_t_from([0, -1]), create_int32x4_t_from([1, 2, 3, 4]), 5i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_n_s32(create_random_int64x2_t(), create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_n_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_n_s32(create_int64x2_t_from([100, 200]), create_int32x4_t_from([1, 2, 3, 4]), 5i32));
        check_array_equality(&result, &[115, 220]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_n_s32(create_int64x2_t_from([100, 200]), create_int32x4_t_from([1, 2, 3, 4]), 5i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_n_s32(create_random_int64x2_t(), create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_n_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_n_s32(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x4_t_from([1, 2, 3, 4]), 5i32));
        check_array_equality(&result, &[-9223372036854775793, -9223372036854775788]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_n_s32(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x4_t_from([1, 2, 3, 4]), 5i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_n_s32(create_random_int64x2_t(), create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_n_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_n_s32(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), 5i32));
        check_array_equality(&result, &[-9223372036854775794, -9223372036854775789]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_n_s32(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), 5i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_n_s32(create_random_int64x2_t(), create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_n_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_n_s32(create_int64x2_t_from([0, 0]), create_int32x4_t_from([1, 2, 3, 4]), 5i32));
        check_array_equality(&result, &[15, 20]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_n_s32(create_int64x2_t_from([0, 0]), create_int32x4_t_from([1, 2, 3, 4]), 5i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_n_s32(create_random_int64x2_t(), create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_n_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_n_s32(create_int64x2_t_from([-1, -1]), create_int32x4_t_from([1, 2, 3, 4]), 5i32));
        check_array_equality(&result, &[14, 19]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_n_s32(create_int64x2_t_from([-1, -1]), create_int32x4_t_from([1, 2, 3, 4]), 5i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_n_s32(create_random_int64x2_t(), create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_n_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_n_s32(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), 5i32));
        check_array_equality(&result, &[-9223372036854775793, -9223372036854775789]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_n_s32(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), 5i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_n_s32(create_random_int64x2_t(), create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_n_u16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_n_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), 13u16));
        check_array_equality(&result, &[118, 132, 146, 160]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_n_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), 13u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_n_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_n_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_n_u16(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9u16));
        check_array_equality(&result, &[45, 53, 65, 69]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_n_u16(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_n_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_n_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_n_u16(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9u16));
        check_array_equality(&result, &[145, 254, 363, 472]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_n_u16(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_n_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_n_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_n_u16(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9u16));
        check_array_equality(&result, &[45, 54, 63, 72]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_n_u16(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_n_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_n_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_n_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9u16));
        check_array_equality(&result, &[44, 53, 62, 71]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_n_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_n_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_n_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_n_u16(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9u16));
        check_array_equality(&result, &[45, 54, 63, 72]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_n_u16(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_n_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_n_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_n_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9u16));
        check_array_equality(&result, &[44, 53, 62, 71]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_n_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_n_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_n_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_n_u16(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9u16));
        check_array_equality(&result, &[45, 53, 63, 71]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_n_u16(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_n_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_n_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_n_u32(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), 7u32));
        check_array_equality(&result, &[36, 44]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_n_u32(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), 7u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_n_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_n_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_n_u32(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x4_t_from([1, 2, 3, 4]), 5u32));
        check_array_equality(&result, &[15, 19]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_n_u32(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x4_t_from([1, 2, 3, 4]), 5u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_n_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_n_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_n_u32(create_uint64x2_t_from([100, 200]), create_uint32x4_t_from([1, 2, 3, 4]), 5u32));
        check_array_equality(&result, &[115, 220]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_n_u32(create_uint64x2_t_from([100, 200]), create_uint32x4_t_from([1, 2, 3, 4]), 5u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_n_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_n_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_n_u32(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x4_t_from([1, 2, 3, 4]), 5u32));
        check_array_equality(&result, &[15, 20]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_n_u32(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x4_t_from([1, 2, 3, 4]), 5u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_n_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_n_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_n_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), 5u32));
        check_array_equality(&result, &[14, 19]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_n_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), 5u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_n_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_n_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_n_u32(create_uint64x2_t_from([0, 0]), create_uint32x4_t_from([1, 2, 3, 4]), 5u32));
        check_array_equality(&result, &[15, 20]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_n_u32(create_uint64x2_t_from([0, 0]), create_uint32x4_t_from([1, 2, 3, 4]), 5u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_n_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_n_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_n_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), 5u32));
        check_array_equality(&result, &[14, 19]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_n_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), 5u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_n_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_n_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_n_u32(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), 5u32));
        check_array_equality(&result, &[15, 19]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_n_u32(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), 5u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_n_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_s8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlal_high_s8(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]), create_int8x16_t_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40])));
        check_array_equality(&result, &[562, 614, 668, 724, 782, 842, 904, 968]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_s8(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]), create_int8x16_t_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_s8(create_random_int16x8_t(), create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_s8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlal_high_s8(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[225, 259, 299, 333, 381, 415, 471, 505]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_s8(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_s8(create_random_int16x8_t(), create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_s8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlal_high_s8(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[325, 460, 597, 736, 877, 1020, 1165, 1312]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_s8(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_s8(create_random_int16x8_t(), create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_s8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlal_high_s8(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[-32543, -32508, -32471, -32432, -32391, -32348, -32303, -32256]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_s8(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_s8(create_random_int16x8_t(), create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_s8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlal_high_s8(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[-32544, -32509, -32472, -32433, -32392, -32349, -32304, -32257]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_s8(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_s8(create_random_int16x8_t(), create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_s8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlal_high_s8(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[225, 260, 297, 336, 377, 420, 465, 512]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_s8(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_s8(create_random_int16x8_t(), create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_s8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlal_high_s8(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[224, 259, 296, 335, 376, 419, 464, 511]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_s8(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_s8(create_random_int16x8_t(), create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_s8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlal_high_s8(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[-32543, -32509, 297, 335, -32391, -32349, 465, 511]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_s8(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_s8(create_random_int16x8_t(), create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[154, 182, 212, 244]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_s16(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_s16(create_int32x4_t_from([0, -1, 2, -3]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[65, 83, 107, 125]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_s16(create_int32x4_t_from([0, -1, 2, -3]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_s16(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_s16(create_int32x4_t_from([100, 200, 300, 400]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[165, 284, 405, 528]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_s16(create_int32x4_t_from([100, 200, 300, 400]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_s16(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_s16(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-2147483583, -2147483564, -2147483543, -2147483520]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_s16(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_s16(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_s16(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-2147483584, -2147483565, -2147483544, -2147483521]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_s16(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_s16(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_s16(create_int32x4_t_from([0, 0, 0, 0]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[65, 84, 105, 128]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_s16(create_int32x4_t_from([0, 0, 0, 0]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_s16(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_s16(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[64, 83, 104, 127]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_s16(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_s16(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlal_high_s16(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-2147483583, -2147483565, 105, 127]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_s16(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_s16(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_s32(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x4_t_from([7, 8, 9, 10])));
        check_array_equality(&result, &[46, 62]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_s32(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x4_t_from([7, 8, 9, 10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_s32(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_s32(create_int64x2_t_from([0, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[21, 31]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_s32(create_int64x2_t_from([0, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_s32(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_s32(create_int64x2_t_from([100, 200]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[121, 232]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_s32(create_int64x2_t_from([100, 200]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_s32(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_s32(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-9223372036854775787, -9223372036854775776]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_s32(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_s32(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_s32(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-9223372036854775788, -9223372036854775777]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_s32(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_s32(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_s32(create_int64x2_t_from([0, 0]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[21, 32]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_s32(create_int64x2_t_from([0, 0]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_s32(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_s32(create_int64x2_t_from([-1, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[20, 31]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_s32(create_int64x2_t_from([-1, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_s32(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlal_high_s32(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-9223372036854775787, -9223372036854775777]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_s32(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_s32(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_u8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlal_high_u8(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]), create_uint8x16_t_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40])));
        check_array_equality(&result, &[562, 614, 668, 724, 782, 842, 904, 968]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_u8(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]), create_uint8x16_t_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_u8(create_random_uint16x8_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_u8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlal_high_u8(create_uint16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[225, 259, 299, 333, 381, 415, 471, 505]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_u8(create_uint16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_u8(create_random_uint16x8_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_u8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlal_high_u8(create_uint16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[325, 460, 597, 736, 877, 1020, 1165, 1312]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_u8(create_uint16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_u8(create_random_uint16x8_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_u8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlal_high_u8(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[225, 260, 297, 336, 377, 420, 465, 512]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_u8(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_u8(create_random_uint16x8_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_u8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlal_high_u8(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[224, 259, 296, 335, 376, 419, 464, 511]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_u8(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_u8(create_random_uint16x8_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_u8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlal_high_u8(create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[225, 260, 297, 336, 377, 420, 465, 512]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_u8(create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_u8(create_random_uint16x8_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_u8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlal_high_u8(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[224, 259, 296, 335, 376, 419, 464, 511]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_u8(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_u8(create_random_uint16x8_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_u8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlal_high_u8(create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[225, 259, 297, 335, 377, 419, 465, 511]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_u8(create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_u8(create_random_uint16x8_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_u16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[154, 182, 212, 244]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_u16(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[65, 83, 107, 125]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_u16(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_u16(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[165, 284, 405, 528]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_u16(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_u16(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[65, 84, 105, 128]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_u16(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[64, 83, 104, 127]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_u16(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[65, 84, 105, 128]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_u16(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[64, 83, 104, 127]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlal_high_u16(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[65, 83, 105, 127]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_u16(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_u32(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), create_uint32x4_t_from([7, 8, 9, 10])));
        check_array_equality(&result, &[46, 62]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_u32(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), create_uint32x4_t_from([7, 8, 9, 10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_u32(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[21, 31]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_u32(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_u32(create_uint64x2_t_from([100, 200]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[121, 232]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_u32(create_uint64x2_t_from([100, 200]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_u32(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[21, 32]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_u32(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[20, 31]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_u32(create_uint64x2_t_from([0, 0]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[21, 32]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_u32(create_uint64x2_t_from([0, 0]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[20, 31]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlal_high_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlal_high_u32(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[21, 31]).map_err(|e| crate::cpu::with_call(e, "vmlal_high_u32(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlal_high_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}
