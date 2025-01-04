use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vqdmull_high_lane_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_lane_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[90, 108, 126, 144]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_lane_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_lane_s16::<0>(create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_lane_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_lane_s16::<0>(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int16x4_t_from([10, 9, 12, 7])));
        check_array_equality(&result, &[80, -100, 120, -140]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_lane_s16::<0>(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int16x4_t_from([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_lane_s16::<0>(create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_lane_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_lane_s16::<0>(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_int16x4_t_from([110, 210, 310, 410])));
        check_array_equality(&result, &[110000, 132000, 154000, 176000]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_lane_s16::<0>(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_int16x4_t_from([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_lane_s16::<0>(create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_lane_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_lane_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_lane_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_lane_s16::<0>(create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_lane_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_lane_s16::<0>(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[2147352578, 2147352578, 2147352578, 2147352578]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_lane_s16::<0>(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_lane_s16::<0>(create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_lane_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_lane_s16::<0>(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int16x4_t_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_lane_s16::<0>(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int16x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_lane_s16::<0>(create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_lane_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_lane_s16::<0>(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int16x4_t_from([-1, -1, -1, -1])));
        check_array_equality(&result, &[2, 2, 2, 2]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_lane_s16::<0>(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int16x4_t_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_lane_s16::<0>(create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_lane_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_lane_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[2147483647, -2147418112, 0, 65536]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_lane_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_lane_s16::<0>(create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_lane_s16_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_lane_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-2147418112, -2147418112, -2147418112, -2147418112]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_lane_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_lane_s16::<0>(create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_lane_s16_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_lane_s16::<0>(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-2147418112, -2147418112, -2147418112, -2147418112]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_lane_s16::<0>(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_lane_s16::<0>(create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_lane_s16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_lane_s16::<1>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[100, 120, 140, 160]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_lane_s16::<1>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_lane_s16::<1>(create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_lane_s16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_lane_s16::<3>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12])));
        check_array_equality(&result, &[120, 144, 168, 192]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_lane_s16::<3>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x4_t_from([9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_lane_s16::<3>(create_random_int16x8_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_laneq_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_laneq_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[30, 40]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_laneq_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_laneq_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_laneq_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_laneq_s32::<0>(create_int32x4_t_from([0, -1, 2, -3]), create_int32x4_t_from([10, 9, 12, 7])));
        check_array_equality(&result, &[40, -60]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_laneq_s32::<0>(create_int32x4_t_from([0, -1, 2, -3]), create_int32x4_t_from([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_laneq_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_laneq_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_laneq_s32::<0>(create_int32x4_t_from([100, 200, 300, 400]), create_int32x4_t_from([110, 210, 310, 410])));
        check_array_equality(&result, &[66000, 88000]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_laneq_s32::<0>(create_int32x4_t_from([100, 200, 300, 400]), create_int32x4_t_from([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_laneq_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_laneq_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_laneq_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[9223372036854775807, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_laneq_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_laneq_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_laneq_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_laneq_s32::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[9223372028264841218, 9223372028264841218]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_laneq_s32::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_laneq_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_laneq_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_laneq_s32::<0>(create_int32x4_t_from([0, 0, 0, 0]), create_int32x4_t_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_laneq_s32::<0>(create_int32x4_t_from([0, 0, 0, 0]), create_int32x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_laneq_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_laneq_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_laneq_s32::<0>(create_int32x4_t_from([-1, -1, -1, -1]), create_int32x4_t_from([-1, -1, -1, -1])));
        check_array_equality(&result, &[2, 2]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_laneq_s32::<0>(create_int32x4_t_from([-1, -1, -1, -1]), create_int32x4_t_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_laneq_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_laneq_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_laneq_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 4294967296]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_laneq_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_laneq_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_laneq_s32_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_laneq_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-9223372032559808512, -9223372032559808512]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_laneq_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_laneq_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_laneq_s32_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_laneq_s32::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-9223372032559808512, -9223372032559808512]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_laneq_s32::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_laneq_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_laneq_s32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_laneq_s32::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[36, 48]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_laneq_s32::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_laneq_s32::<1>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_laneq_s32_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_laneq_s32::<3>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[48, 64]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_laneq_s32::<3>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_laneq_s32::<3>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_lane_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_lane_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[30, 40]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_lane_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_lane_s32::<0>(create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_lane_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_lane_s32::<0>(create_int32x4_t_from([0, -1, 2, -3]), create_int32x2_t_from([10, 9])));
        check_array_equality(&result, &[40, -60]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_lane_s32::<0>(create_int32x4_t_from([0, -1, 2, -3]), create_int32x2_t_from([10, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_lane_s32::<0>(create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_lane_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_lane_s32::<0>(create_int32x4_t_from([100, 200, 300, 400]), create_int32x2_t_from([110, 210])));
        check_array_equality(&result, &[66000, 88000]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_lane_s32::<0>(create_int32x4_t_from([100, 200, 300, 400]), create_int32x2_t_from([110, 210]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_lane_s32::<0>(create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_lane_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_lane_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x2_t_from([i32::MIN, i32::MIN])));
        check_array_equality(&result, &[9223372036854775807, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_lane_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x2_t_from([i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_lane_s32::<0>(create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_lane_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_lane_s32::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x2_t_from([i32::MAX, i32::MAX])));
        check_array_equality(&result, &[9223372028264841218, 9223372028264841218]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_lane_s32::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x2_t_from([i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_lane_s32::<0>(create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_lane_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_lane_s32::<0>(create_int32x4_t_from([0, 0, 0, 0]), create_int32x2_t_from([0, 0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_lane_s32::<0>(create_int32x4_t_from([0, 0, 0, 0]), create_int32x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_lane_s32::<0>(create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_lane_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_lane_s32::<0>(create_int32x4_t_from([-1, -1, -1, -1]), create_int32x2_t_from([-1, -1])));
        check_array_equality(&result, &[2, 2]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_lane_s32::<0>(create_int32x4_t_from([-1, -1, -1, -1]), create_int32x2_t_from([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_lane_s32::<0>(create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_lane_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_lane_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int32x2_t_from([i32::MIN, i32::MAX])));
        check_array_equality(&result, &[0, 4294967296]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_lane_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int32x2_t_from([i32::MIN, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_lane_s32::<0>(create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_lane_s32_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_lane_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x2_t_from([i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-9223372032559808512, -9223372032559808512]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_lane_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x2_t_from([i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_lane_s32::<0>(create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_lane_s32_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_lane_s32::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x2_t_from([i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-9223372032559808512, -9223372032559808512]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_lane_s32::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x2_t_from([i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_lane_s32::<0>(create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_lane_s32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_lane_s32::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6])));
        check_array_equality(&result, &[36, 48]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_lane_s32::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x2_t_from([5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_lane_s32::<1>(create_random_int32x4_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_laneq_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_laneq_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[90, 108, 126, 144]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_laneq_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_laneq_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_laneq_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_laneq_s16::<0>(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[80, -100, 120, -140]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_laneq_s16::<0>(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_laneq_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_laneq_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_laneq_s16::<0>(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_int16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[110000, 132000, 154000, 176000]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_laneq_s16::<0>(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_int16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_laneq_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_laneq_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_laneq_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_laneq_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_laneq_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_laneq_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_laneq_s16::<0>(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[2147352578, 2147352578, 2147352578, 2147352578]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_laneq_s16::<0>(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_laneq_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_laneq_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_laneq_s16::<0>(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_laneq_s16::<0>(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_laneq_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_laneq_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_laneq_s16::<0>(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[2, 2, 2, 2]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_laneq_s16::<0>(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_laneq_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_laneq_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_laneq_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[2147483647, -2147418112, 0, 65536]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_laneq_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_laneq_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_laneq_s16_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_laneq_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-2147418112, -2147418112, -2147418112, -2147418112]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_laneq_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_laneq_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_laneq_s16_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_laneq_s16::<0>(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-2147418112, -2147418112, -2147418112, -2147418112]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_laneq_s16::<0>(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_laneq_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_laneq_s16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_laneq_s16::<1>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[100, 120, 140, 160]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_laneq_s16::<1>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_laneq_s16::<1>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_laneq_s16_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_laneq_s16::<7>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[160, 192, 224, 256]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_laneq_s16::<7>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_laneq_s16::<7>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_laneq_s16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_laneq_s16::<3>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[120, 144, 168, 192]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_laneq_s16::<3>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_laneq_s16::<3>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_n_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_n_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16));
        check_array_equality(&result, &[90, 108, 126, 144]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_n_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_n_s16(create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_n_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_n_s16(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), 1i16));
        check_array_equality(&result, &[8, -10, 12, -14]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_n_s16(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), 1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_n_s16(create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_n_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_n_s16(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), 1i16));
        check_array_equality(&result, &[1000, 1200, 1400, 1600]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_n_s16(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), 1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_n_s16(create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_n_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_n_s16(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), 1i16));
        check_array_equality(&result, &[-65536, -65536, -65536, -65536]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_n_s16(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), 1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_n_s16(create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_n_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_n_s16(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), 1i16));
        check_array_equality(&result, &[65534, 65534, 65534, 65534]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_n_s16(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), 1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_n_s16(create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_n_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_n_s16(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), 1i16));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_n_s16(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), 1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_n_s16(create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_n_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_n_s16(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), 1i16));
        check_array_equality(&result, &[-2, -2, -2, -2]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_n_s16(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), 1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_n_s16(create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_n_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_n_s16(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), 1i16));
        check_array_equality(&result, &[-65536, 65534, 0, -2]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_n_s16(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), 1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_n_s16(create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_n_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_n_s32(create_int32x4_t_from([1, 2, 3, 4]), 5i32));
        check_array_equality(&result, &[30, 40]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_n_s32(create_int32x4_t_from([1, 2, 3, 4]), 5i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_n_s32(create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_n_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_n_s32(create_int32x4_t_from([0, -1, 2, -3]), 1i32));
        check_array_equality(&result, &[4, -6]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_n_s32(create_int32x4_t_from([0, -1, 2, -3]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_n_s32(create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_n_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_n_s32(create_int32x4_t_from([100, 200, 300, 400]), 1i32));
        check_array_equality(&result, &[600, 800]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_n_s32(create_int32x4_t_from([100, 200, 300, 400]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_n_s32(create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_n_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_n_s32(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32));
        check_array_equality(&result, &[-4294967296, -4294967296]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_n_s32(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_n_s32(create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_n_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_n_s32(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32));
        check_array_equality(&result, &[4294967294, 4294967294]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_n_s32(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_n_s32(create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_n_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_n_s32(create_int32x4_t_from([0, 0, 0, 0]), 1i32));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_n_s32(create_int32x4_t_from([0, 0, 0, 0]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_n_s32(create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_n_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_n_s32(create_int32x4_t_from([-1, -1, -1, -1]), 1i32));
        check_array_equality(&result, &[-2, -2]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_n_s32(create_int32x4_t_from([-1, -1, -1, -1]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_n_s32(create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_n_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_n_s32(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), 1i32));
        check_array_equality(&result, &[0, -2]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_n_s32(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_n_s32(create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[130, 168, 210, 256]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_s16(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_s16(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[112, -50, 192, -42]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_s16(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_s16(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_s16(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_int16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[510000, 732000, 994000, 1296000]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_s16(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_int16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_s16(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_s16(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_s16(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_s16(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_s16(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[2147352578, 2147352578, 2147352578, 2147352578]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_s16(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_s16(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_s16(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_s16(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_s16(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_s16(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[2, 2, 2, 2]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_s16(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_s16(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_s16(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[2147483647, 2147352578, 0, 2]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_s16(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_s16(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_s16_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_s16(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-2147418112, -2147418112, -2147418112, -2147418112]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_s16(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_s16(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_s16_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_high_s16(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-2147418112, -2147418112, -2147418112, -2147418112]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_s16(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_s16(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[42, 64]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_s32(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_s32(create_int32x4_t_from([0, -1, 2, -3]), create_int32x4_t_from([10, 9, 12, 7])));
        check_array_equality(&result, &[48, -42]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_s32(create_int32x4_t_from([0, -1, 2, -3]), create_int32x4_t_from([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_s32(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_s32(create_int32x4_t_from([100, 200, 300, 400]), create_int32x4_t_from([110, 210, 310, 410])));
        check_array_equality(&result, &[186000, 328000]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_s32(create_int32x4_t_from([100, 200, 300, 400]), create_int32x4_t_from([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_s32(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_s32(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[9223372036854775807, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_s32(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_s32(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_s32(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[9223372028264841218, 9223372028264841218]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_s32(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_s32(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_s32(create_int32x4_t_from([0, 0, 0, 0]), create_int32x4_t_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_s32(create_int32x4_t_from([0, 0, 0, 0]), create_int32x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_s32(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_s32(create_int32x4_t_from([-1, -1, -1, -1]), create_int32x4_t_from([-1, -1, -1, -1])));
        check_array_equality(&result, &[2, 2]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_s32(create_int32x4_t_from([-1, -1, -1, -1]), create_int32x4_t_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_s32(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_s32(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 2]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_s32(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_s32(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_s32_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_s32(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-9223372032559808512, -9223372032559808512]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_s32(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_s32(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_high_s32_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_high_s32(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-9223372032559808512, -9223372032559808512]).map_err(|e| crate::cpu::with_call(e, "vqdmull_high_s32(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_high_s32(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_laneq_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_laneq_s16::<0>(create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[10, 20, 30, 40]).map_err(|e| crate::cpu::with_call(e, "vqdmull_laneq_s16::<0>(create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_laneq_s16::<0>(create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_laneq_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_laneq_s16::<0>(create_int16x4_t_from([0, -1, 2, -3]), create_int16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, -20, 40, -60]).map_err(|e| crate::cpu::with_call(e, "vqdmull_laneq_s16::<0>(create_int16x4_t_from([0, -1, 2, -3]), create_int16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_laneq_s16::<0>(create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_laneq_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_laneq_s16::<0>(create_int16x4_t_from([100, 200, 300, 400]), create_int16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[22000, 44000, 66000, 88000]).map_err(|e| crate::cpu::with_call(e, "vqdmull_laneq_s16::<0>(create_int16x4_t_from([100, 200, 300, 400]), create_int16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_laneq_s16::<0>(create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_laneq_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_laneq_s16::<0>(create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "vqdmull_laneq_s16::<0>(create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_laneq_s16::<0>(create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_laneq_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_laneq_s16::<0>(create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[2147352578, 2147352578, 2147352578, 2147352578]).map_err(|e| crate::cpu::with_call(e, "vqdmull_laneq_s16::<0>(create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_laneq_s16::<0>(create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_laneq_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_laneq_s16::<0>(create_int16x4_t_from([0, 0, 0, 0]), create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmull_laneq_s16::<0>(create_int16x4_t_from([0, 0, 0, 0]), create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_laneq_s16::<0>(create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_laneq_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_laneq_s16::<0>(create_int16x4_t_from([-1, -1, -1, -1]), create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[2, 2, 2, 2]).map_err(|e| crate::cpu::with_call(e, "vqdmull_laneq_s16::<0>(create_int16x4_t_from([-1, -1, -1, -1]), create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_laneq_s16::<0>(create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_laneq_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_laneq_s16::<0>(create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1]), create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[2147483647, -2147418112, 0, 65536]).map_err(|e| crate::cpu::with_call(e, "vqdmull_laneq_s16::<0>(create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1]), create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_laneq_s16::<0>(create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_laneq_s16_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_laneq_s16::<0>(create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-2147418112, -2147418112, -2147418112, -2147418112]).map_err(|e| crate::cpu::with_call(e, "vqdmull_laneq_s16::<0>(create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_laneq_s16::<0>(create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_laneq_s16_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_laneq_s16::<0>(create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-2147418112, -2147418112, -2147418112, -2147418112]).map_err(|e| crate::cpu::with_call(e, "vqdmull_laneq_s16::<0>(create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_laneq_s16::<0>(create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_laneq_s16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_laneq_s16::<1>(create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[12, 24, 36, 48]).map_err(|e| crate::cpu::with_call(e, "vqdmull_laneq_s16::<1>(create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_laneq_s16::<1>(create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_laneq_s16_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_laneq_s16::<7>(create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[24, 48, 72, 96]).map_err(|e| crate::cpu::with_call(e, "vqdmull_laneq_s16::<7>(create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_laneq_s16::<7>(create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_laneq_s16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmull_laneq_s16::<3>(create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[16, 32, 48, 64]).map_err(|e| crate::cpu::with_call(e, "vqdmull_laneq_s16::<3>(create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_laneq_s16::<3>(create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_laneq_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_laneq_s32::<0>(create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[6, 12]).map_err(|e| crate::cpu::with_call(e, "vqdmull_laneq_s32::<0>(create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_laneq_s32::<0>(create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_laneq_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_laneq_s32::<0>(create_int32x2_t_from([0, -1]), create_int32x4_t_from([10, 9, 12, 7])));
        check_array_equality(&result, &[0, -20]).map_err(|e| crate::cpu::with_call(e, "vqdmull_laneq_s32::<0>(create_int32x2_t_from([0, -1]), create_int32x4_t_from([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_laneq_s32::<0>(create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_laneq_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_laneq_s32::<0>(create_int32x2_t_from([100, 200]), create_int32x4_t_from([110, 210, 310, 410])));
        check_array_equality(&result, &[22000, 44000]).map_err(|e| crate::cpu::with_call(e, "vqdmull_laneq_s32::<0>(create_int32x2_t_from([100, 200]), create_int32x4_t_from([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_laneq_s32::<0>(create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_laneq_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_laneq_s32::<0>(create_int32x2_t_from([i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[9223372036854775807, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vqdmull_laneq_s32::<0>(create_int32x2_t_from([i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_laneq_s32::<0>(create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_laneq_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_laneq_s32::<0>(create_int32x2_t_from([i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[9223372028264841218, 9223372028264841218]).map_err(|e| crate::cpu::with_call(e, "vqdmull_laneq_s32::<0>(create_int32x2_t_from([i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_laneq_s32::<0>(create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_laneq_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_laneq_s32::<0>(create_int32x2_t_from([0, 0]), create_int32x4_t_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmull_laneq_s32::<0>(create_int32x2_t_from([0, 0]), create_int32x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_laneq_s32::<0>(create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_laneq_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_laneq_s32::<0>(create_int32x2_t_from([-1, -1]), create_int32x4_t_from([-1, -1, -1, -1])));
        check_array_equality(&result, &[2, 2]).map_err(|e| crate::cpu::with_call(e, "vqdmull_laneq_s32::<0>(create_int32x2_t_from([-1, -1]), create_int32x4_t_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_laneq_s32::<0>(create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_laneq_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_laneq_s32::<0>(create_int32x2_t_from([i32::MIN, i32::MAX]), create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[9223372036854775807, -9223372032559808512]).map_err(|e| crate::cpu::with_call(e, "vqdmull_laneq_s32::<0>(create_int32x2_t_from([i32::MIN, i32::MAX]), create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_laneq_s32::<0>(create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_laneq_s32_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_laneq_s32::<0>(create_int32x2_t_from([i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-9223372032559808512, -9223372032559808512]).map_err(|e| crate::cpu::with_call(e, "vqdmull_laneq_s32::<0>(create_int32x2_t_from([i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_laneq_s32::<0>(create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_laneq_s32_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_laneq_s32::<0>(create_int32x2_t_from([i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-9223372032559808512, -9223372032559808512]).map_err(|e| crate::cpu::with_call(e, "vqdmull_laneq_s32::<0>(create_int32x2_t_from([i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_laneq_s32::<0>(create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_laneq_s32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_laneq_s32::<1>(create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[8, 16]).map_err(|e| crate::cpu::with_call(e, "vqdmull_laneq_s32::<1>(create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_laneq_s32::<1>(create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqdmull_laneq_s32_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vqdmull_laneq_s32::<3>(create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[12, 24]).map_err(|e| crate::cpu::with_call(e, "vqdmull_laneq_s32::<3>(create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmull_laneq_s32::<3>(create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}
