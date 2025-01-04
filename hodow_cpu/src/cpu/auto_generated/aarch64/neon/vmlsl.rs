use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vmlsl_high_lane_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_lane_s16::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x4_t_from([13, 14, 15, 16])));
        check_array_equality(&result, &[-116, -128, -140, -152]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_s16::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x4_t_from([13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_lane_s16::<0>(create_int32x4_t_from([0, -1, 2, -3]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[-45, -55, -61, -75]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_s16::<0>(create_int32x4_t_from([0, -1, 2, -3]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_lane_s16::<0>(create_int32x4_t_from([100, 200, 300, 400]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[55, 146, 237, 328]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_s16::<0>(create_int32x4_t_from([100, 200, 300, 400]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_lane_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[2147483603, 2147483594, 2147483585, 2147483576]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_lane_s16::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[2147483602, 2147483593, 2147483584, 2147483575]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_s16::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_lane_s16::<0>(create_int32x4_t_from([0, 0, 0, 0]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[-45, -54, -63, -72]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_s16::<0>(create_int32x4_t_from([0, 0, 0, 0]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_lane_s16::<0>(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[-46, -55, -64, -73]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_s16::<0>(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_lane_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[2147483603, 2147483593, -63, -73]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_s16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_lane_s16::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x4_t_from([13, 14, 15, 16])));
        check_array_equality(&result, &[-125, -138, -151, -164]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_s16::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x4_t_from([13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_s16::<1>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_s16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_lane_s16::<3>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x4_t_from([13, 14, 15, 16])));
        check_array_equality(&result, &[-143, -158, -173, -188]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_s16::<3>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x4_t_from([13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_s16::<3>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_laneq_s16::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[-116, -128, -140, -152]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_s16::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_laneq_s16::<0>(create_int32x4_t_from([0, -1, 2, -3]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-45, -55, -61, -75]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_s16::<0>(create_int32x4_t_from([0, -1, 2, -3]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_laneq_s16::<0>(create_int32x4_t_from([100, 200, 300, 400]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[55, 146, 237, 328]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_s16::<0>(create_int32x4_t_from([100, 200, 300, 400]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_laneq_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[2147483603, 2147483594, 2147483585, 2147483576]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_laneq_s16::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[2147483602, 2147483593, 2147483584, 2147483575]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_s16::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_laneq_s16::<0>(create_int32x4_t_from([0, 0, 0, 0]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-45, -54, -63, -72]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_s16::<0>(create_int32x4_t_from([0, 0, 0, 0]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_laneq_s16::<0>(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-46, -55, -64, -73]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_s16::<0>(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_laneq_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[2147483603, 2147483593, -63, -73]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_s16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_laneq_s16::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[-125, -138, -151, -164]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_s16::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_s16::<1>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_s16_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_laneq_s16::<7>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[-179, -198, -217, -236]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_s16::<7>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_s16::<7>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_s16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_laneq_s16::<3>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[-143, -158, -173, -188]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_s16::<3>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_s16::<3>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_lane_s32::<0>(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x2_t_from([7, 8])));
        check_array_equality(&result, &[-34, -40]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_s32::<0>(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x2_t_from([7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_lane_s32::<0>(create_int64x2_t_from([0, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[-15, -21]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_s32::<0>(create_int64x2_t_from([0, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_lane_s32::<0>(create_int64x2_t_from([100, 200]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[85, 180]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_s32::<0>(create_int64x2_t_from([100, 200]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_lane_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[9223372036854775793, 9223372036854775788]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_lane_s32::<0>(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[9223372036854775792, 9223372036854775787]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_s32::<0>(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_lane_s32::<0>(create_int64x2_t_from([0, 0]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[-15, -20]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_s32::<0>(create_int64x2_t_from([0, 0]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_lane_s32::<0>(create_int64x2_t_from([-1, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[-16, -21]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_s32::<0>(create_int64x2_t_from([-1, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_lane_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[9223372036854775793, 9223372036854775787]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_s32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_lane_s32::<1>(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x2_t_from([7, 8])));
        check_array_equality(&result, &[-39, -46]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_s32::<1>(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x2_t_from([7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_s32::<1>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_laneq_s32::<0>(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x4_t_from([7, 8, 9, 10])));
        check_array_equality(&result, &[-34, -40]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_s32::<0>(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x4_t_from([7, 8, 9, 10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_laneq_s32::<0>(create_int64x2_t_from([0, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-15, -21]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_s32::<0>(create_int64x2_t_from([0, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_laneq_s32::<0>(create_int64x2_t_from([100, 200]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[85, 180]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_s32::<0>(create_int64x2_t_from([100, 200]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_laneq_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[9223372036854775793, 9223372036854775788]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_laneq_s32::<0>(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[9223372036854775792, 9223372036854775787]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_s32::<0>(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_laneq_s32::<0>(create_int64x2_t_from([0, 0]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-15, -20]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_s32::<0>(create_int64x2_t_from([0, 0]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_laneq_s32::<0>(create_int64x2_t_from([-1, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-16, -21]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_s32::<0>(create_int64x2_t_from([-1, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_laneq_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[9223372036854775793, 9223372036854775787]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_s32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_laneq_s32::<1>(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x4_t_from([7, 8, 9, 10])));
        check_array_equality(&result, &[-39, -46]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_s32::<1>(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x4_t_from([7, 8, 9, 10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_s32::<1>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_s32_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_laneq_s32::<3>(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x4_t_from([7, 8, 9, 10])));
        check_array_equality(&result, &[-49, -58]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_s32::<3>(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x4_t_from([7, 8, 9, 10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_s32::<3>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_u16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_lane_u16::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x4_t_from([13, 14, 15, 16])));
        check_array_equality(&result, &[4294967180, 4294967168, 4294967156, 4294967144]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_u16::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x4_t_from([13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_u16::<0>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_lane_u16::<0>(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[4294967251, 4294967241, 4294967235, 4294967221]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_u16::<0>(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_u16::<0>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_lane_u16::<0>(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[55, 146, 237, 328]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_u16::<0>(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_u16::<0>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_lane_u16::<0>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[4294967251, 4294967242, 4294967233, 4294967224]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_u16::<0>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_u16::<0>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_lane_u16::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[4294967250, 4294967241, 4294967232, 4294967223]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_u16::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_u16::<0>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_lane_u16::<0>(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[4294967251, 4294967242, 4294967233, 4294967224]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_u16::<0>(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_u16::<0>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_lane_u16::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[4294967250, 4294967241, 4294967232, 4294967223]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_u16::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_u16::<0>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_lane_u16::<0>(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[4294967251, 4294967241, 4294967233, 4294967223]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_u16::<0>(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_u16::<0>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_u16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_lane_u16::<1>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x4_t_from([13, 14, 15, 16])));
        check_array_equality(&result, &[4294967171, 4294967158, 4294967145, 4294967132]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_u16::<1>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x4_t_from([13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_u16::<1>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_u16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_lane_u16::<3>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x4_t_from([13, 14, 15, 16])));
        check_array_equality(&result, &[4294967153, 4294967138, 4294967123, 4294967108]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_u16::<3>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x4_t_from([13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_u16::<3>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_u16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_laneq_u16::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[4294967180, 4294967168, 4294967156, 4294967144]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_u16::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_u16::<0>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_laneq_u16::<0>(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[4294967251, 4294967241, 4294967235, 4294967221]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_u16::<0>(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_u16::<0>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_laneq_u16::<0>(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[55, 146, 237, 328]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_u16::<0>(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_u16::<0>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_laneq_u16::<0>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[4294967251, 4294967242, 4294967233, 4294967224]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_u16::<0>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_u16::<0>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_laneq_u16::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[4294967250, 4294967241, 4294967232, 4294967223]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_u16::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_u16::<0>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_laneq_u16::<0>(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[4294967251, 4294967242, 4294967233, 4294967224]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_u16::<0>(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_u16::<0>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_laneq_u16::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[4294967250, 4294967241, 4294967232, 4294967223]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_u16::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_u16::<0>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_laneq_u16::<0>(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[4294967251, 4294967241, 4294967233, 4294967223]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_u16::<0>(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_u16::<0>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_u16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_laneq_u16::<1>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[4294967171, 4294967158, 4294967145, 4294967132]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_u16::<1>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_u16::<1>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_u16_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_laneq_u16::<7>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[4294967117, 4294967098, 4294967079, 4294967060]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_u16::<7>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_u16::<7>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_u16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_laneq_u16::<3>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[4294967153, 4294967138, 4294967123, 4294967108]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_u16::<3>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_u16::<3>(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_lane_u32::<0>(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), create_uint32x2_t_from([7, 8])));
        check_array_equality(&result, &[18446744073709551582, 18446744073709551576]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_u32::<0>(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), create_uint32x2_t_from([7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_u32::<0>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_lane_u32::<0>(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x2_t_from([5, 6])));
        check_array_equality(&result, &[18446744073709551601, 18446744073709551595]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_u32::<0>(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_u32::<0>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_lane_u32::<0>(create_uint64x2_t_from([100, 200]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x2_t_from([5, 6])));
        check_array_equality(&result, &[85, 180]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_u32::<0>(create_uint64x2_t_from([100, 200]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_u32::<0>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_lane_u32::<0>(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x2_t_from([5, 6])));
        check_array_equality(&result, &[18446744073709551601, 18446744073709551596]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_u32::<0>(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_u32::<0>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_lane_u32::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x2_t_from([5, 6])));
        check_array_equality(&result, &[18446744073709551600, 18446744073709551595]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_u32::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_u32::<0>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_lane_u32::<0>(create_uint64x2_t_from([0, 0]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x2_t_from([5, 6])));
        check_array_equality(&result, &[18446744073709551601, 18446744073709551596]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_u32::<0>(create_uint64x2_t_from([0, 0]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_u32::<0>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_lane_u32::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x2_t_from([5, 6])));
        check_array_equality(&result, &[18446744073709551600, 18446744073709551595]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_u32::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_u32::<0>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_lane_u32::<0>(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x2_t_from([5, 6])));
        check_array_equality(&result, &[18446744073709551601, 18446744073709551595]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_u32::<0>(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_u32::<0>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_lane_u32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_lane_u32::<1>(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), create_uint32x2_t_from([7, 8])));
        check_array_equality(&result, &[18446744073709551577, 18446744073709551570]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_lane_u32::<1>(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), create_uint32x2_t_from([7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_lane_u32::<1>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_laneq_u32::<0>(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), create_uint32x4_t_from([7, 8, 9, 10])));
        check_array_equality(&result, &[18446744073709551582, 18446744073709551576]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_u32::<0>(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), create_uint32x4_t_from([7, 8, 9, 10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_u32::<0>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_laneq_u32::<0>(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[18446744073709551601, 18446744073709551595]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_u32::<0>(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_u32::<0>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_laneq_u32::<0>(create_uint64x2_t_from([100, 200]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[85, 180]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_u32::<0>(create_uint64x2_t_from([100, 200]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_u32::<0>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_laneq_u32::<0>(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[18446744073709551601, 18446744073709551596]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_u32::<0>(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_u32::<0>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_laneq_u32::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[18446744073709551600, 18446744073709551595]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_u32::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_u32::<0>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_laneq_u32::<0>(create_uint64x2_t_from([0, 0]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[18446744073709551601, 18446744073709551596]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_u32::<0>(create_uint64x2_t_from([0, 0]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_u32::<0>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_laneq_u32::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[18446744073709551600, 18446744073709551595]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_u32::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_u32::<0>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_laneq_u32::<0>(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[18446744073709551601, 18446744073709551595]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_u32::<0>(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_u32::<0>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_u32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_laneq_u32::<1>(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), create_uint32x4_t_from([7, 8, 9, 10])));
        check_array_equality(&result, &[18446744073709551577, 18446744073709551570]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_u32::<1>(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), create_uint32x4_t_from([7, 8, 9, 10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_u32::<1>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_laneq_u32_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_laneq_u32::<3>(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), create_uint32x4_t_from([7, 8, 9, 10])));
        check_array_equality(&result, &[18446744073709551567, 18446744073709551558]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_laneq_u32::<3>(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), create_uint32x4_t_from([7, 8, 9, 10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_laneq_u32::<3>(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_n_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), 13i16));
        check_array_equality(&result, &[-116, -128, -140, -152]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_n_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), 13i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_n_s16(create_random_int32x4_t(), create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_n_s16(create_int32x4_t_from([0, -1, 2, -3]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16));
        check_array_equality(&result, &[-45, -55, -61, -75]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_n_s16(create_int32x4_t_from([0, -1, 2, -3]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_n_s16(create_random_int32x4_t(), create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_n_s16(create_int32x4_t_from([100, 200, 300, 400]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16));
        check_array_equality(&result, &[55, 146, 237, 328]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_n_s16(create_int32x4_t_from([100, 200, 300, 400]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_n_s16(create_random_int32x4_t(), create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_n_s16(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16));
        check_array_equality(&result, &[2147483603, 2147483594, 2147483585, 2147483576]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_n_s16(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_n_s16(create_random_int32x4_t(), create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_n_s16(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16));
        check_array_equality(&result, &[2147483602, 2147483593, 2147483584, 2147483575]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_n_s16(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_n_s16(create_random_int32x4_t(), create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_n_s16(create_int32x4_t_from([0, 0, 0, 0]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16));
        check_array_equality(&result, &[-45, -54, -63, -72]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_n_s16(create_int32x4_t_from([0, 0, 0, 0]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_n_s16(create_random_int32x4_t(), create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_n_s16(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16));
        check_array_equality(&result, &[-46, -55, -64, -73]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_n_s16(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_n_s16(create_random_int32x4_t(), create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_n_s16(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16));
        check_array_equality(&result, &[2147483603, 2147483593, -63, -73]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_n_s16(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_n_s16(create_random_int32x4_t(), create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_n_s32(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), 7i32));
        check_array_equality(&result, &[-34, -40]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_n_s32(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), 7i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_n_s32(create_random_int64x2_t(), create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_n_s32(create_int64x2_t_from([0, -1]), create_int32x4_t_from([1, 2, 3, 4]), 5i32));
        check_array_equality(&result, &[-15, -21]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_n_s32(create_int64x2_t_from([0, -1]), create_int32x4_t_from([1, 2, 3, 4]), 5i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_n_s32(create_random_int64x2_t(), create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_n_s32(create_int64x2_t_from([100, 200]), create_int32x4_t_from([1, 2, 3, 4]), 5i32));
        check_array_equality(&result, &[85, 180]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_n_s32(create_int64x2_t_from([100, 200]), create_int32x4_t_from([1, 2, 3, 4]), 5i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_n_s32(create_random_int64x2_t(), create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_n_s32(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x4_t_from([1, 2, 3, 4]), 5i32));
        check_array_equality(&result, &[9223372036854775793, 9223372036854775788]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_n_s32(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x4_t_from([1, 2, 3, 4]), 5i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_n_s32(create_random_int64x2_t(), create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_n_s32(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), 5i32));
        check_array_equality(&result, &[9223372036854775792, 9223372036854775787]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_n_s32(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), 5i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_n_s32(create_random_int64x2_t(), create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_n_s32(create_int64x2_t_from([0, 0]), create_int32x4_t_from([1, 2, 3, 4]), 5i32));
        check_array_equality(&result, &[-15, -20]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_n_s32(create_int64x2_t_from([0, 0]), create_int32x4_t_from([1, 2, 3, 4]), 5i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_n_s32(create_random_int64x2_t(), create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_n_s32(create_int64x2_t_from([-1, -1]), create_int32x4_t_from([1, 2, 3, 4]), 5i32));
        check_array_equality(&result, &[-16, -21]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_n_s32(create_int64x2_t_from([-1, -1]), create_int32x4_t_from([1, 2, 3, 4]), 5i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_n_s32(create_random_int64x2_t(), create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_n_s32(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), 5i32));
        check_array_equality(&result, &[9223372036854775793, 9223372036854775787]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_n_s32(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), 5i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_n_s32(create_random_int64x2_t(), create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_u16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_n_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), 13u16));
        check_array_equality(&result, &[4294967180, 4294967168, 4294967156, 4294967144]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_n_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), 13u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_n_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_n_u16(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9u16));
        check_array_equality(&result, &[4294967251, 4294967241, 4294967235, 4294967221]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_n_u16(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_n_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_n_u16(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9u16));
        check_array_equality(&result, &[55, 146, 237, 328]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_n_u16(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_n_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_n_u16(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9u16));
        check_array_equality(&result, &[4294967251, 4294967242, 4294967233, 4294967224]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_n_u16(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_n_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_n_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9u16));
        check_array_equality(&result, &[4294967250, 4294967241, 4294967232, 4294967223]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_n_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_n_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_n_u16(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9u16));
        check_array_equality(&result, &[4294967251, 4294967242, 4294967233, 4294967224]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_n_u16(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_n_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_n_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9u16));
        check_array_equality(&result, &[4294967250, 4294967241, 4294967232, 4294967223]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_n_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_n_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_n_u16(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9u16));
        check_array_equality(&result, &[4294967251, 4294967241, 4294967233, 4294967223]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_n_u16(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_n_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_n_u32(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), 7u32));
        check_array_equality(&result, &[18446744073709551582, 18446744073709551576]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_n_u32(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), 7u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_n_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_n_u32(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x4_t_from([1, 2, 3, 4]), 5u32));
        check_array_equality(&result, &[18446744073709551601, 18446744073709551595]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_n_u32(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x4_t_from([1, 2, 3, 4]), 5u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_n_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_n_u32(create_uint64x2_t_from([100, 200]), create_uint32x4_t_from([1, 2, 3, 4]), 5u32));
        check_array_equality(&result, &[85, 180]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_n_u32(create_uint64x2_t_from([100, 200]), create_uint32x4_t_from([1, 2, 3, 4]), 5u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_n_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_n_u32(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x4_t_from([1, 2, 3, 4]), 5u32));
        check_array_equality(&result, &[18446744073709551601, 18446744073709551596]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_n_u32(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x4_t_from([1, 2, 3, 4]), 5u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_n_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_n_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), 5u32));
        check_array_equality(&result, &[18446744073709551600, 18446744073709551595]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_n_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), 5u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_n_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_n_u32(create_uint64x2_t_from([0, 0]), create_uint32x4_t_from([1, 2, 3, 4]), 5u32));
        check_array_equality(&result, &[18446744073709551601, 18446744073709551596]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_n_u32(create_uint64x2_t_from([0, 0]), create_uint32x4_t_from([1, 2, 3, 4]), 5u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_n_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_n_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), 5u32));
        check_array_equality(&result, &[18446744073709551600, 18446744073709551595]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_n_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), 5u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_n_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_n_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_n_u32(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), 5u32));
        check_array_equality(&result, &[18446744073709551601, 18446744073709551595]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_n_u32(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), 5u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_n_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_s8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsl_high_s8(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]), create_int8x16_t_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40])));
        check_array_equality(&result, &[-560, -610, -662, -716, -772, -830, -890, -952]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_s8(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]), create_int8x16_t_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_s8(create_random_int16x8_t(), create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_s8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsl_high_s8(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[-225, -261, -295, -339, -373, -425, -459, -519]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_s8(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_s8(create_random_int16x8_t(), create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_s8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsl_high_s8(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[-125, -60, 3, 64, 123, 180, 235, 288]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_s8(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_s8(create_random_int16x8_t(), create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_s8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsl_high_s8(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[32543, 32508, 32471, 32432, 32391, 32348, 32303, 32256]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_s8(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_s8(create_random_int16x8_t(), create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_s8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsl_high_s8(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[32542, 32507, 32470, 32431, 32390, 32347, 32302, 32255]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_s8(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_s8(create_random_int16x8_t(), create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_s8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsl_high_s8(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[-225, -260, -297, -336, -377, -420, -465, -512]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_s8(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_s8(create_random_int16x8_t(), create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_s8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsl_high_s8(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[-226, -261, -298, -337, -378, -421, -466, -513]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_s8(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_s8(create_random_int16x8_t(), create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_s8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vmlsl_high_s8(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[32543, 32507, -297, -337, 32391, 32347, -465, -513]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_s8(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_s8(create_random_int16x8_t(), create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[-152, -178, -206, -236]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_s16(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_s16(create_int32x4_t_from([0, -1, 2, -3]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-65, -85, -103, -131]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_s16(create_int32x4_t_from([0, -1, 2, -3]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_s16(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_s16(create_int32x4_t_from([100, 200, 300, 400]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[35, 116, 195, 272]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_s16(create_int32x4_t_from([100, 200, 300, 400]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_s16(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_s16(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[2147483583, 2147483564, 2147483543, 2147483520]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_s16(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_s16(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_s16(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[2147483582, 2147483563, 2147483542, 2147483519]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_s16(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_s16(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_s16(create_int32x4_t_from([0, 0, 0, 0]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-65, -84, -105, -128]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_s16(create_int32x4_t_from([0, 0, 0, 0]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_s16(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_s16(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-66, -85, -106, -129]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_s16(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_s16(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vmlsl_high_s16(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[2147483583, 2147483563, -105, -129]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_s16(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_s16(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_s32(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x4_t_from([7, 8, 9, 10])));
        check_array_equality(&result, &[-44, -58]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_s32(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x4_t_from([7, 8, 9, 10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_s32(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_s32(create_int64x2_t_from([0, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-21, -33]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_s32(create_int64x2_t_from([0, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_s32(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_s32(create_int64x2_t_from([100, 200]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[79, 168]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_s32(create_int64x2_t_from([100, 200]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_s32(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_s32(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[9223372036854775787, 9223372036854775776]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_s32(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_s32(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_s32(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[9223372036854775786, 9223372036854775775]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_s32(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_s32(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_s32(create_int64x2_t_from([0, 0]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-21, -32]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_s32(create_int64x2_t_from([0, 0]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_s32(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_s32(create_int64x2_t_from([-1, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-22, -33]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_s32(create_int64x2_t_from([-1, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_s32(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vmlsl_high_s32(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[9223372036854775787, 9223372036854775775]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_s32(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_s32(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_u8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsl_high_u8(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]), create_uint8x16_t_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40])));
        check_array_equality(&result, &[64976, 64926, 64874, 64820, 64764, 64706, 64646, 64584]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_u8(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]), create_uint8x16_t_from([25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_u8(create_random_uint16x8_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_u8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsl_high_u8(create_uint16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[65311, 65275, 65241, 65197, 65163, 65111, 65077, 65017]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_u8(create_uint16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_u8(create_random_uint16x8_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_u8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsl_high_u8(create_uint16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[65411, 65476, 3, 64, 123, 180, 235, 288]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_u8(create_uint16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_u8(create_random_uint16x8_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_u8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsl_high_u8(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[65311, 65276, 65239, 65200, 65159, 65116, 65071, 65024]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_u8(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_u8(create_random_uint16x8_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_u8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsl_high_u8(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[65310, 65275, 65238, 65199, 65158, 65115, 65070, 65023]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_u8(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_u8(create_random_uint16x8_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_u8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsl_high_u8(create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[65311, 65276, 65239, 65200, 65159, 65116, 65071, 65024]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_u8(create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_u8(create_random_uint16x8_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_u8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsl_high_u8(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[65310, 65275, 65238, 65199, 65158, 65115, 65070, 65023]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_u8(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_u8(create_random_uint16x8_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_u8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vmlsl_high_u8(create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[65311, 65275, 65239, 65199, 65159, 65115, 65071, 65023]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_u8(create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_u8(create_random_uint16x8_t(), create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_u16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[4294967144, 4294967118, 4294967090, 4294967060]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_u16(create_uint32x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_uint16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_u16(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[4294967231, 4294967211, 4294967193, 4294967165]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_u16(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_u16(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[35, 116, 195, 272]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_u16(create_uint32x4_t_from([100, 200, 300, 400]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_u16(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[4294967231, 4294967212, 4294967191, 4294967168]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_u16(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[4294967230, 4294967211, 4294967190, 4294967167]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_u16(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[4294967231, 4294967212, 4294967191, 4294967168]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_u16(create_uint32x4_t_from([0, 0, 0, 0]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[4294967230, 4294967211, 4294967190, 4294967167]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_u16(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vmlsl_high_u16(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[4294967231, 4294967211, 4294967191, 4294967167]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_u16(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_u16(create_random_uint32x4_t(), create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_u32(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), create_uint32x4_t_from([7, 8, 9, 10])));
        check_array_equality(&result, &[18446744073709551572, 18446744073709551558]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_u32(create_uint64x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]), create_uint32x4_t_from([7, 8, 9, 10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_u32(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[18446744073709551595, 18446744073709551583]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_u32(create_uint64x2_t_from([0, 18446744073709551615]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_u32(create_uint64x2_t_from([100, 200]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[79, 168]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_u32(create_uint64x2_t_from([100, 200]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_u32(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[18446744073709551595, 18446744073709551584]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_u32(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[18446744073709551594, 18446744073709551583]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_u32(create_uint64x2_t_from([0, 0]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[18446744073709551595, 18446744073709551584]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_u32(create_uint64x2_t_from([0, 0]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[18446744073709551594, 18446744073709551583]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_u32(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vmlsl_high_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vmlsl_high_u32(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[18446744073709551595, 18446744073709551583]).map_err(|e| crate::cpu::with_call(e, "vmlsl_high_u32(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmlsl_high_u32(create_random_uint64x2_t(), create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}
