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

pub(super) fn test_arm_shared_neon_vqdmulhq_laneq_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqdmulhq_laneq_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_laneq_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_laneq_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_laneq_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqdmulhq_laneq_s16::<0>(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, -1, 0, -1, 0, -1, 0, -1]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_laneq_s16::<0>(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_laneq_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_laneq_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqdmulhq_laneq_s16::<0>(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_int16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[0, 0, 1, 1, 1, 2, 2, 2]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_laneq_s16::<0>(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_int16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_laneq_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_laneq_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqdmulhq_laneq_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_laneq_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_laneq_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_laneq_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqdmulhq_laneq_s16::<0>(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32766, 32766, 32766, 32766, 32766, 32766, 32766, 32766]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_laneq_s16::<0>(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_laneq_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_laneq_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqdmulhq_laneq_s16::<0>(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_laneq_s16::<0>(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_laneq_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_laneq_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqdmulhq_laneq_s16::<0>(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_laneq_s16::<0>(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_laneq_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_laneq_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqdmulhq_laneq_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[32767, -32767, 0, 1, 32767, -32767, 0, 1]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_laneq_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_laneq_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_laneq_s16_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqdmulhq_laneq_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-32767, -32767, -32767, -32767, -32767, -32767, -32767, -32767]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_laneq_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_laneq_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_laneq_s16_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqdmulhq_laneq_s16::<0>(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32767, -32767, -32767, -32767, -32767, -32767, -32767, -32767]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_laneq_s16::<0>(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_laneq_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_laneq_s16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqdmulhq_laneq_s16::<1>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_laneq_s16::<1>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_laneq_s16::<1>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_laneq_s16_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqdmulhq_laneq_s16::<7>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_laneq_s16::<7>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_laneq_s16::<7>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_laneq_s16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqdmulhq_laneq_s16::<3>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_laneq_s16::<3>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_laneq_s16::<3>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_laneq_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmulhq_laneq_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_laneq_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_laneq_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_laneq_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmulhq_laneq_s32::<0>(create_int32x4_t_from([0, -1, 2, -3]), create_int32x4_t_from([10, 9, 12, 7])));
        check_array_equality(&result, &[0, -1, 0, -1]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_laneq_s32::<0>(create_int32x4_t_from([0, -1, 2, -3]), create_int32x4_t_from([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_laneq_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_laneq_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmulhq_laneq_s32::<0>(create_int32x4_t_from([100, 200, 300, 400]), create_int32x4_t_from([110, 210, 310, 410])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_laneq_s32::<0>(create_int32x4_t_from([100, 200, 300, 400]), create_int32x4_t_from([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_laneq_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_laneq_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmulhq_laneq_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_laneq_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_laneq_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_laneq_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmulhq_laneq_s32::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483646, 2147483646, 2147483646, 2147483646]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_laneq_s32::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_laneq_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_laneq_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmulhq_laneq_s32::<0>(create_int32x4_t_from([0, 0, 0, 0]), create_int32x4_t_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_laneq_s32::<0>(create_int32x4_t_from([0, 0, 0, 0]), create_int32x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_laneq_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_laneq_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmulhq_laneq_s32::<0>(create_int32x4_t_from([-1, -1, -1, -1]), create_int32x4_t_from([-1, -1, -1, -1])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_laneq_s32::<0>(create_int32x4_t_from([-1, -1, -1, -1]), create_int32x4_t_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_laneq_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_laneq_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmulhq_laneq_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[2147483647, -2147483647, 0, 1]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_laneq_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_laneq_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_laneq_s32_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmulhq_laneq_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-2147483647, -2147483647, -2147483647, -2147483647]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_laneq_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_laneq_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_laneq_s32_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmulhq_laneq_s32::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483647, -2147483647, -2147483647, -2147483647]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_laneq_s32::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_laneq_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_laneq_s32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmulhq_laneq_s32::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_laneq_s32::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_laneq_s32::<1>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_laneq_s32_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmulhq_laneq_s32::<3>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_laneq_s32::<3>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_laneq_s32::<3>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_n_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqdmulhq_n_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_n_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), 9i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_n_s16(create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_n_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqdmulhq_n_s16(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), 1i16));
        check_array_equality(&result, &[0, -1, 0, -1, 0, -1, 0, -1]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_n_s16(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), 1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_n_s16(create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_n_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqdmulhq_n_s16(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), 1i16));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_n_s16(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), 1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_n_s16(create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_n_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqdmulhq_n_s16(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), 1i16));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_n_s16(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), 1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_n_s16(create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_n_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqdmulhq_n_s16(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), 1i16));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_n_s16(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), 1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_n_s16(create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_n_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqdmulhq_n_s16(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), 1i16));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_n_s16(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), 1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_n_s16(create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_n_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqdmulhq_n_s16(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), 1i16));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_n_s16(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), 1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_n_s16(create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_n_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqdmulhq_n_s16(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), 1i16));
        check_array_equality(&result, &[-1, 0, 0, -1, -1, 0, 0, -1]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_n_s16(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), 1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_n_s16(create_random_int16x8_t(), rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_n_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmulhq_n_s32(create_int32x4_t_from([1, 2, 3, 4]), 5i32));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_n_s32(create_int32x4_t_from([1, 2, 3, 4]), 5i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_n_s32(create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_n_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmulhq_n_s32(create_int32x4_t_from([0, -1, 2, -3]), 1i32));
        check_array_equality(&result, &[0, -1, 0, -1]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_n_s32(create_int32x4_t_from([0, -1, 2, -3]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_n_s32(create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_n_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmulhq_n_s32(create_int32x4_t_from([100, 200, 300, 400]), 1i32));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_n_s32(create_int32x4_t_from([100, 200, 300, 400]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_n_s32(create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_n_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmulhq_n_s32(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_n_s32(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_n_s32(create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_n_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmulhq_n_s32(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_n_s32(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_n_s32(create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_n_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmulhq_n_s32(create_int32x4_t_from([0, 0, 0, 0]), 1i32));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_n_s32(create_int32x4_t_from([0, 0, 0, 0]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_n_s32(create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_n_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmulhq_n_s32(create_int32x4_t_from([-1, -1, -1, -1]), 1i32));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_n_s32(create_int32x4_t_from([-1, -1, -1, -1]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_n_s32(create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_n_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmulhq_n_s32(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), 1i32));
        check_array_equality(&result, &[-1, 0, 0, -1]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_n_s32(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), 1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_n_s32(create_random_int32x4_t(), rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqdmulhq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_s16(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_s16(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqdmulhq_s16(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[0, -1, 0, -1, 0, -1, 0, -1]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_s16(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_s16(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqdmulhq_s16(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_int16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[0, 1, 2, 5, 7, 11, 15, 19]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_s16(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_int16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_s16(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqdmulhq_s16(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_s16(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_s16(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqdmulhq_s16(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32766, 32766, 32766, 32766, 32766, 32766, 32766, 32766]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_s16(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_s16(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqdmulhq_s16(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_s16(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_s16(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqdmulhq_s16(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_s16(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_s16(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqdmulhq_s16(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[32767, 32766, 0, 0, 32767, 32766, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_s16(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_s16(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_s16_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqdmulhq_s16(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-32767, -32767, -32767, -32767, -32767, -32767, -32767, -32767]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_s16(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_s16(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_s16_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vqdmulhq_s16(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32767, -32767, -32767, -32767, -32767, -32767, -32767, -32767]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_s16(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_s16(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmulhq_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_s32(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_s32(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmulhq_s32(create_int32x4_t_from([0, -1, 2, -3]), create_int32x4_t_from([10, 9, 12, 7])));
        check_array_equality(&result, &[0, -1, 0, -1]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_s32(create_int32x4_t_from([0, -1, 2, -3]), create_int32x4_t_from([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_s32(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmulhq_s32(create_int32x4_t_from([100, 200, 300, 400]), create_int32x4_t_from([110, 210, 310, 410])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_s32(create_int32x4_t_from([100, 200, 300, 400]), create_int32x4_t_from([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_s32(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmulhq_s32(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_s32(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_s32(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmulhq_s32(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483646, 2147483646, 2147483646, 2147483646]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_s32(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_s32(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmulhq_s32(create_int32x4_t_from([0, 0, 0, 0]), create_int32x4_t_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_s32(create_int32x4_t_from([0, 0, 0, 0]), create_int32x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_s32(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmulhq_s32(create_int32x4_t_from([-1, -1, -1, -1]), create_int32x4_t_from([-1, -1, -1, -1])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_s32(create_int32x4_t_from([-1, -1, -1, -1]), create_int32x4_t_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_s32(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmulhq_s32(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[2147483647, 2147483646, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_s32(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_s32(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_s32_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmulhq_s32(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-2147483647, -2147483647, -2147483647, -2147483647]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_s32(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_s32(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vqdmulhq_s32_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vqdmulhq_s32(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483647, -2147483647, -2147483647, -2147483647]).map_err(|e| crate::cpu::with_call(e, "vqdmulhq_s32(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqdmulhq_s32(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}
