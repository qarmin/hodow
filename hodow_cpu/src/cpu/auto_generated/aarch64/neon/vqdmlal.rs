use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vqdmlal_high_lane_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_lane_s16::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x4_t_from([13, 14, 15, 16])));
        check_array_equality(&result, &[235, 262, 289, 316]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_lane_s16::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x4_t_from([13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_lane_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_lane_s16::<0>(create_int32x4_t_from([0, -1, 2, -3]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[90, 107, 128, 141]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_lane_s16::<0>(create_int32x4_t_from([0, -1, 2, -3]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_lane_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_lane_s16::<0>(create_int32x4_t_from([100, 200, 300, 400]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[190, 308, 426, 544]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_lane_s16::<0>(create_int32x4_t_from([100, 200, 300, 400]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_lane_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_lane_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[-2147483558, -2147483540, -2147483522, -2147483504]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_lane_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_lane_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_lane_s16::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_lane_s16::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_lane_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_lane_s16::<0>(create_int32x4_t_from([0, 0, 0, 0]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[90, 108, 126, 144]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_lane_s16::<0>(create_int32x4_t_from([0, 0, 0, 0]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_lane_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_lane_s16::<0>(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[89, 107, 125, 143]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_lane_s16::<0>(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_lane_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_lane_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[-2147483558, 2147483647, 126, 143]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_lane_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_lane_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_lane_s16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_lane_s16::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x4_t_from([13, 14, 15, 16])));
        check_array_equality(&result, &[253, 282, 311, 340]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_lane_s16::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x4_t_from([13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_lane_s16::<1>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_lane_s16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_lane_s16::<3>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x4_t_from([13, 14, 15, 16])));
        check_array_equality(&result, &[289, 322, 355, 388]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_lane_s16::<3>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x4_t_from([13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_lane_s16::<3>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_laneq_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_laneq_s16::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[235, 262, 289, 316]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_laneq_s16::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_laneq_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_laneq_s16::<0>(create_int32x4_t_from([0, -1, 2, -3]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[90, 107, 128, 141]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_laneq_s16::<0>(create_int32x4_t_from([0, -1, 2, -3]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_laneq_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_laneq_s16::<0>(create_int32x4_t_from([100, 200, 300, 400]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[190, 308, 426, 544]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_laneq_s16::<0>(create_int32x4_t_from([100, 200, 300, 400]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_laneq_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_laneq_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-2147483558, -2147483540, -2147483522, -2147483504]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_laneq_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_laneq_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_laneq_s16::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_laneq_s16::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_laneq_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_laneq_s16::<0>(create_int32x4_t_from([0, 0, 0, 0]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[90, 108, 126, 144]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_laneq_s16::<0>(create_int32x4_t_from([0, 0, 0, 0]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_laneq_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_laneq_s16::<0>(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[89, 107, 125, 143]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_laneq_s16::<0>(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_laneq_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_laneq_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-2147483558, 2147483647, 126, 143]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_laneq_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_laneq_s16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_laneq_s16::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[253, 282, 311, 340]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_laneq_s16::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_laneq_s16::<1>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_laneq_s16_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_laneq_s16::<7>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[361, 402, 443, 484]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_laneq_s16::<7>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_laneq_s16::<7>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_laneq_s16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_laneq_s16::<3>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[289, 322, 355, 388]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_laneq_s16::<3>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_laneq_s16::<3>(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_lane_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_high_lane_s32::<0>(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x2_t_from([7, 8])));
        check_array_equality(&result, &[71, 86]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_lane_s32::<0>(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x2_t_from([7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_lane_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_high_lane_s32::<0>(create_int64x2_t_from([0, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[30, 39]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_lane_s32::<0>(create_int64x2_t_from([0, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_lane_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_high_lane_s32::<0>(create_int64x2_t_from([100, 200]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[130, 240]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_lane_s32::<0>(create_int64x2_t_from([100, 200]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_lane_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_high_lane_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[-9223372036854775778, -9223372036854775768]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_lane_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_lane_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_high_lane_s32::<0>(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[9223372036854775807, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_lane_s32::<0>(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_lane_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_high_lane_s32::<0>(create_int64x2_t_from([0, 0]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[30, 40]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_lane_s32::<0>(create_int64x2_t_from([0, 0]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_lane_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_high_lane_s32::<0>(create_int64x2_t_from([-1, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[29, 39]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_lane_s32::<0>(create_int64x2_t_from([-1, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_lane_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_high_lane_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[-9223372036854775778, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_lane_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_lane_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_lane_s32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_high_lane_s32::<1>(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x2_t_from([7, 8])));
        check_array_equality(&result, &[81, 98]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_lane_s32::<1>(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x2_t_from([7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_lane_s32::<1>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_laneq_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_high_laneq_s32::<0>(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x4_t_from([7, 8, 9, 10])));
        check_array_equality(&result, &[71, 86]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_laneq_s32::<0>(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x4_t_from([7, 8, 9, 10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_laneq_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_high_laneq_s32::<0>(create_int64x2_t_from([0, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[30, 39]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_laneq_s32::<0>(create_int64x2_t_from([0, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_laneq_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_high_laneq_s32::<0>(create_int64x2_t_from([100, 200]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[130, 240]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_laneq_s32::<0>(create_int64x2_t_from([100, 200]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_laneq_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_high_laneq_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-9223372036854775778, -9223372036854775768]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_laneq_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_laneq_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_high_laneq_s32::<0>(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[9223372036854775807, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_laneq_s32::<0>(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_laneq_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_high_laneq_s32::<0>(create_int64x2_t_from([0, 0]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[30, 40]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_laneq_s32::<0>(create_int64x2_t_from([0, 0]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_laneq_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_high_laneq_s32::<0>(create_int64x2_t_from([-1, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[29, 39]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_laneq_s32::<0>(create_int64x2_t_from([-1, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_laneq_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_high_laneq_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-9223372036854775778, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_laneq_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_laneq_s32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_high_laneq_s32::<1>(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x4_t_from([7, 8, 9, 10])));
        check_array_equality(&result, &[81, 98]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_laneq_s32::<1>(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x4_t_from([7, 8, 9, 10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_laneq_s32::<1>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_laneq_s32_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_high_laneq_s32::<3>(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x4_t_from([7, 8, 9, 10])));
        check_array_equality(&result, &[101, 122]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_laneq_s32::<3>(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x4_t_from([7, 8, 9, 10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_laneq_s32::<3>(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_n_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_n_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), 13i16));
        check_array_equality(&result, &[235, 262, 289, 316]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_n_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), 13i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_n_s16(create_random_int32x4_t(), create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_n_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_n_s16(create_int32x4_t_from([0, -1, 2, -3]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16));
        check_array_equality(&result, &[90, 107, 128, 141]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_n_s16(create_int32x4_t_from([0, -1, 2, -3]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_n_s16(create_random_int32x4_t(), create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_n_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_n_s16(create_int32x4_t_from([100, 200, 300, 400]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16));
        check_array_equality(&result, &[190, 308, 426, 544]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_n_s16(create_int32x4_t_from([100, 200, 300, 400]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_n_s16(create_random_int32x4_t(), create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_n_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_n_s16(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16));
        check_array_equality(&result, &[-2147483558, -2147483540, -2147483522, -2147483504]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_n_s16(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_n_s16(create_random_int32x4_t(), create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_n_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_n_s16(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_n_s16(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_n_s16(create_random_int32x4_t(), create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_n_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_n_s16(create_int32x4_t_from([0, 0, 0, 0]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16));
        check_array_equality(&result, &[90, 108, 126, 144]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_n_s16(create_int32x4_t_from([0, 0, 0, 0]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_n_s16(create_random_int32x4_t(), create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_n_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_n_s16(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16));
        check_array_equality(&result, &[89, 107, 125, 143]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_n_s16(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_n_s16(create_random_int32x4_t(), create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_n_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_n_s16(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16));
        check_array_equality(&result, &[-2147483558, 2147483647, 126, 143]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_n_s16(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_n_s16(create_random_int32x4_t(), create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20])));
        check_array_equality(&result, &[307, 362, 421, 484]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_s16(create_int32x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]), create_int16x8_t_from([13, 14, 15, 16, 17, 18, 19, 20]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_s16(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_s16(create_int32x4_t_from([0, -1, 2, -3]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[130, 167, 212, 253]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_s16(create_int32x4_t_from([0, -1, 2, -3]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_s16(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_s16(create_int32x4_t_from([100, 200, 300, 400]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[230, 368, 510, 656]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_s16(create_int32x4_t_from([100, 200, 300, 400]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_s16(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_s16(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-2147483518, -2147483480, -2147483438, -2147483392]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_s16(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_s16(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_s16(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_s16(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_s16(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_s16(create_int32x4_t_from([0, 0, 0, 0]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[130, 168, 210, 256]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_s16(create_int32x4_t_from([0, 0, 0, 0]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_s16(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_s16(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[129, 167, 209, 255]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_s16(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_s16(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_high_s16(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-2147483518, 2147483647, 210, 255]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_s16(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_s16(create_random_int32x4_t(), create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_n_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_high_n_s32(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), 7i32));
        check_array_equality(&result, &[71, 86]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_n_s32(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), 7i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_n_s32(create_random_int64x2_t(), create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_n_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_high_n_s32(create_int64x2_t_from([0, -1]), create_int32x4_t_from([1, 2, 3, 4]), 5i32));
        check_array_equality(&result, &[30, 39]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_n_s32(create_int64x2_t_from([0, -1]), create_int32x4_t_from([1, 2, 3, 4]), 5i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_n_s32(create_random_int64x2_t(), create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_n_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_high_n_s32(create_int64x2_t_from([100, 200]), create_int32x4_t_from([1, 2, 3, 4]), 5i32));
        check_array_equality(&result, &[130, 240]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_n_s32(create_int64x2_t_from([100, 200]), create_int32x4_t_from([1, 2, 3, 4]), 5i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_n_s32(create_random_int64x2_t(), create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_n_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_high_n_s32(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x4_t_from([1, 2, 3, 4]), 5i32));
        check_array_equality(&result, &[-9223372036854775778, -9223372036854775768]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_n_s32(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x4_t_from([1, 2, 3, 4]), 5i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_n_s32(create_random_int64x2_t(), create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_n_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_high_n_s32(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), 5i32));
        check_array_equality(&result, &[9223372036854775807, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_n_s32(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), 5i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_n_s32(create_random_int64x2_t(), create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_n_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_high_n_s32(create_int64x2_t_from([0, 0]), create_int32x4_t_from([1, 2, 3, 4]), 5i32));
        check_array_equality(&result, &[30, 40]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_n_s32(create_int64x2_t_from([0, 0]), create_int32x4_t_from([1, 2, 3, 4]), 5i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_n_s32(create_random_int64x2_t(), create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_n_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_high_n_s32(create_int64x2_t_from([-1, -1]), create_int32x4_t_from([1, 2, 3, 4]), 5i32));
        check_array_equality(&result, &[29, 39]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_n_s32(create_int64x2_t_from([-1, -1]), create_int32x4_t_from([1, 2, 3, 4]), 5i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_n_s32(create_random_int64x2_t(), create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_n_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_high_n_s32(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), 5i32));
        check_array_equality(&result, &[-9223372036854775778, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_n_s32(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), 5i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_n_s32(create_random_int64x2_t(), create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_high_s32(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x4_t_from([7, 8, 9, 10])));
        check_array_equality(&result, &[91, 122]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_s32(create_int64x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]), create_int32x4_t_from([7, 8, 9, 10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_s32(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_high_s32(create_int64x2_t_from([0, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[42, 63]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_s32(create_int64x2_t_from([0, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_s32(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_high_s32(create_int64x2_t_from([100, 200]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[142, 264]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_s32(create_int64x2_t_from([100, 200]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_s32(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_high_s32(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-9223372036854775766, -9223372036854775744]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_s32(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_s32(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_high_s32(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[9223372036854775807, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_s32(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_s32(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_high_s32(create_int64x2_t_from([0, 0]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[42, 64]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_s32(create_int64x2_t_from([0, 0]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_s32(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_high_s32(create_int64x2_t_from([-1, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[41, 63]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_s32(create_int64x2_t_from([-1, -1]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_s32(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_high_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_high_s32(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-9223372036854775766, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_high_s32(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_high_s32(create_random_int64x2_t(), create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_laneq_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_laneq_s16::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[91, 110, 129, 148]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_laneq_s16::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_laneq_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_laneq_s16::<0>(create_int32x4_t_from([0, -1, 2, -3]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[10, 19, 32, 37]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_laneq_s16::<0>(create_int32x4_t_from([0, -1, 2, -3]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_laneq_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_laneq_s16::<0>(create_int32x4_t_from([100, 200, 300, 400]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[110, 220, 330, 440]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_laneq_s16::<0>(create_int32x4_t_from([100, 200, 300, 400]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_laneq_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_laneq_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[-2147483638, -2147483628, -2147483618, -2147483608]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_laneq_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_laneq_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_laneq_s16::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_laneq_s16::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_laneq_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_laneq_s16::<0>(create_int32x4_t_from([0, 0, 0, 0]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[10, 20, 30, 40]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_laneq_s16::<0>(create_int32x4_t_from([0, 0, 0, 0]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_laneq_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_laneq_s16::<0>(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[9, 19, 29, 39]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_laneq_s16::<0>(create_int32x4_t_from([-1, -1, -1, -1]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_laneq_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_laneq_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[-2147483638, 2147483647, 30, 39]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_laneq_s16::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_laneq_s16::<0>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_laneq_s16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_laneq_s16::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[101, 122, 143, 164]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_laneq_s16::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_laneq_s16::<1>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_laneq_s16_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_laneq_s16::<7>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[161, 194, 227, 260]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_laneq_s16::<7>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_laneq_s16::<7>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_laneq_s16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmlal_laneq_s16::<3>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[121, 146, 171, 196]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_laneq_s16::<3>(create_int32x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_laneq_s16::<3>(create_random_int32x4_t(), create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_laneq_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_laneq_s32::<0>(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[31, 42]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_laneq_s32::<0>(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_laneq_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_laneq_s32::<0>(create_int64x2_t_from([0, -1]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[6, 11]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_laneq_s32::<0>(create_int64x2_t_from([0, -1]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_laneq_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_laneq_s32::<0>(create_int64x2_t_from([100, 200]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[106, 212]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_laneq_s32::<0>(create_int64x2_t_from([100, 200]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_laneq_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_laneq_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[-9223372036854775802, -9223372036854775796]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_laneq_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_laneq_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_laneq_s32::<0>(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[9223372036854775807, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_laneq_s32::<0>(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_laneq_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_laneq_s32::<0>(create_int64x2_t_from([0, 0]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[6, 12]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_laneq_s32::<0>(create_int64x2_t_from([0, 0]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_laneq_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_laneq_s32::<0>(create_int64x2_t_from([-1, -1]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[5, 11]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_laneq_s32::<0>(create_int64x2_t_from([-1, -1]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_laneq_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_laneq_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[-9223372036854775802, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_laneq_s32::<0>(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_laneq_s32::<0>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_laneq_s32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_laneq_s32::<1>(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[37, 50]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_laneq_s32::<1>(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_laneq_s32::<1>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmlal_laneq_s32_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmlal_laneq_s32::<3>(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[49, 66]).map_err(|e| crate::cpu::with_call(e, "vqdmlal_laneq_s32::<3>(create_int64x2_t_from([1, 2]), create_int32x2_t_from([3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmlal_laneq_s32::<3>(create_random_int64x2_t(), create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}
