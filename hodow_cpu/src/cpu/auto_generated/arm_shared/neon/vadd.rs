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

pub(super) fn test_arm_shared_neon_vadd_f32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vadd_f32(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0])));
        check_float_array_equality(&result, &[4.0, 6.0]).map_err(|e| crate::cpu::with_call(e, "vadd_f32(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_f32(create_random_float32x2_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_f32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vadd_f32(create_float32x2_t_from([0.0f32, -1.0f32]), create_float32x2_t_from([10.0f32, 9.0f32])));
        check_float_array_equality(&result, &[10.0, 8.0]).map_err(|e| crate::cpu::with_call(e, "vadd_f32(create_float32x2_t_from([0.0f32, -1.0f32]), create_float32x2_t_from([10.0f32, 9.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_f32(create_random_float32x2_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_f32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vadd_f32(create_float32x2_t_from([100.0f32, 200.0f32]), create_float32x2_t_from([110.0f32, 210.0f32])));
        check_float_array_equality(&result, &[210.0, 410.0]).map_err(|e| crate::cpu::with_call(e, "vadd_f32(create_float32x2_t_from([100.0f32, 200.0f32]), create_float32x2_t_from([110.0f32, 210.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_f32(create_random_float32x2_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_f32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vadd_f32(create_float32x2_t_from([f32::MIN, f32::MIN]), create_float32x2_t_from([f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-f32::INFINITY, -f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vadd_f32(create_float32x2_t_from([f32::MIN, f32::MIN]), create_float32x2_t_from([f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_f32(create_random_float32x2_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_f32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vadd_f32(create_float32x2_t_from([f32::MAX, f32::MAX]), create_float32x2_t_from([f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vadd_f32(create_float32x2_t_from([f32::MAX, f32::MAX]), create_float32x2_t_from([f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_f32(create_random_float32x2_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_f32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vadd_f32(create_float32x2_t_from([0.0, 0.0]), create_float32x2_t_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vadd_f32(create_float32x2_t_from([0.0, 0.0]), create_float32x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_f32(create_random_float32x2_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_f32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vadd_f32(create_float32x2_t_from([f32::NAN, f32::NAN]), create_float32x2_t_from([f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "vadd_f32(create_float32x2_t_from([f32::NAN, f32::NAN]), create_float32x2_t_from([f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_f32(create_random_float32x2_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_f32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vadd_f32(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]), create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vadd_f32(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]), create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_f32(create_random_float32x2_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_f32_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vadd_f32(create_float32x2_t_from([f32::MIN, f32::MIN]), create_float32x2_t_from([f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vadd_f32(create_float32x2_t_from([f32::MIN, f32::MIN]), create_float32x2_t_from([f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_f32(create_random_float32x2_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_f32_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vadd_f32(create_float32x2_t_from([f32::MAX, f32::MAX]), create_float32x2_t_from([f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vadd_f32(create_float32x2_t_from([f32::MAX, f32::MAX]), create_float32x2_t_from([f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_f32(create_random_float32x2_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vadd_s16(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[6, 8, 10, 12]).map_err(|e| crate::cpu::with_call(e, "vadd_s16(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_s16(create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vadd_s16(create_int16x4_t_from([0, -1, 2, -3]), create_int16x4_t_from([10, 9, 12, 7])));
        check_array_equality(&result, &[10, 8, 14, 4]).map_err(|e| crate::cpu::with_call(e, "vadd_s16(create_int16x4_t_from([0, -1, 2, -3]), create_int16x4_t_from([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_s16(create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vadd_s16(create_int16x4_t_from([100, 200, 300, 400]), create_int16x4_t_from([110, 210, 310, 410])));
        check_array_equality(&result, &[210, 410, 610, 810]).map_err(|e| crate::cpu::with_call(e, "vadd_s16(create_int16x4_t_from([100, 200, 300, 400]), create_int16x4_t_from([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_s16(create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vadd_s16(create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vadd_s16(create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_s16(create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vadd_s16(create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-2, -2, -2, -2]).map_err(|e| crate::cpu::with_call(e, "vadd_s16(create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_s16(create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vadd_s16(create_int16x4_t_from([0, 0, 0, 0]), create_int16x4_t_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vadd_s16(create_int16x4_t_from([0, 0, 0, 0]), create_int16x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_s16(create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vadd_s16(create_int16x4_t_from([-1, -1, -1, -1]), create_int16x4_t_from([-1, -1, -1, -1])));
        check_array_equality(&result, &[-2, -2, -2, -2]).map_err(|e| crate::cpu::with_call(e, "vadd_s16(create_int16x4_t_from([-1, -1, -1, -1]), create_int16x4_t_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_s16(create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vadd_s16(create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1]), create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[0, -2, 0, -2]).map_err(|e| crate::cpu::with_call(e, "vadd_s16(create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1]), create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_s16(create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_s16_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vadd_s16(create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "vadd_s16(create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_s16(create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_s16_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vadd_s16(create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "vadd_s16(create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_s16(create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vadd_s32(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[4, 6]).map_err(|e| crate::cpu::with_call(e, "vadd_s32(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_s32(create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vadd_s32(create_int32x2_t_from([0, -1]), create_int32x2_t_from([10, 9])));
        check_array_equality(&result, &[10, 8]).map_err(|e| crate::cpu::with_call(e, "vadd_s32(create_int32x2_t_from([0, -1]), create_int32x2_t_from([10, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_s32(create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vadd_s32(create_int32x2_t_from([100, 200]), create_int32x2_t_from([110, 210])));
        check_array_equality(&result, &[210, 410]).map_err(|e| crate::cpu::with_call(e, "vadd_s32(create_int32x2_t_from([100, 200]), create_int32x2_t_from([110, 210]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_s32(create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vadd_s32(create_int32x2_t_from([i32::MIN, i32::MIN]), create_int32x2_t_from([i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vadd_s32(create_int32x2_t_from([i32::MIN, i32::MIN]), create_int32x2_t_from([i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_s32(create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vadd_s32(create_int32x2_t_from([i32::MAX, i32::MAX]), create_int32x2_t_from([i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-2, -2]).map_err(|e| crate::cpu::with_call(e, "vadd_s32(create_int32x2_t_from([i32::MAX, i32::MAX]), create_int32x2_t_from([i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_s32(create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vadd_s32(create_int32x2_t_from([0, 0]), create_int32x2_t_from([0, 0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vadd_s32(create_int32x2_t_from([0, 0]), create_int32x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_s32(create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vadd_s32(create_int32x2_t_from([-1, -1]), create_int32x2_t_from([-1, -1])));
        check_array_equality(&result, &[-2, -2]).map_err(|e| crate::cpu::with_call(e, "vadd_s32(create_int32x2_t_from([-1, -1]), create_int32x2_t_from([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_s32(create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vadd_s32(create_int32x2_t_from([i32::MIN, i32::MAX]), create_int32x2_t_from([i32::MIN, i32::MAX])));
        check_array_equality(&result, &[0, -2]).map_err(|e| crate::cpu::with_call(e, "vadd_s32(create_int32x2_t_from([i32::MIN, i32::MAX]), create_int32x2_t_from([i32::MIN, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_s32(create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_s32_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vadd_s32(create_int32x2_t_from([i32::MIN, i32::MIN]), create_int32x2_t_from([i32::MAX, i32::MAX])));
        check_array_equality(&result, &[-1, -1]).map_err(|e| crate::cpu::with_call(e, "vadd_s32(create_int32x2_t_from([i32::MIN, i32::MIN]), create_int32x2_t_from([i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_s32(create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_s32_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vadd_s32(create_int32x2_t_from([i32::MAX, i32::MAX]), create_int32x2_t_from([i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-1, -1]).map_err(|e| crate::cpu::with_call(e, "vadd_s32(create_int32x2_t_from([i32::MAX, i32::MAX]), create_int32x2_t_from([i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_s32(create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_s8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vadd_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[10, 12, 14, 16, 18, 20, 22, 24]).map_err(|e| crate::cpu::with_call(e, "vadd_s8(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_s8(create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_s8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vadd_s8(create_int8x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int8x8_t_from([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, 8, 14, 4, 18, 0, 22, -4]).map_err(|e| crate::cpu::with_call(e, "vadd_s8(create_int8x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int8x8_t_from([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_s8(create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_s8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vadd_s8(create_int8x8_t_from([100, -56, 44, -112, -12, 88, -68, 32]), create_int8x8_t_from([110, -46, 54, -102, -2, 98, -58, 42])));
        check_array_equality(&result, &[-46, -102, 98, 42, -14, -70, -126, 74]).map_err(|e| crate::cpu::with_call(e, "vadd_s8(create_int8x8_t_from([100, -56, 44, -112, -12, 88, -68, 32]), create_int8x8_t_from([110, -46, 54, -102, -2, 98, -58, 42]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_s8(create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_s8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vadd_s8(create_int8x8_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create_int8x8_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vadd_s8(create_int8x8_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create_int8x8_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_s8(create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_s8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vadd_s8(create_int8x8_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create_int8x8_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[-2, -2, -2, -2, -2, -2, -2, -2]).map_err(|e| crate::cpu::with_call(e, "vadd_s8(create_int8x8_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create_int8x8_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_s8(create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_s8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vadd_s8(create_int8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vadd_s8(create_int8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_s8(create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_s8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vadd_s8(create_int8x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int8x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-2, -2, -2, -2, -2, -2, -2, -2]).map_err(|e| crate::cpu::with_call(e, "vadd_s8(create_int8x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int8x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_s8(create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_s8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vadd_s8(create_int8x8_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create_int8x8_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[0, -2, 0, -2, 0, -2, 0, -2]).map_err(|e| crate::cpu::with_call(e, "vadd_s8(create_int8x8_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create_int8x8_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_s8(create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_s8_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vadd_s8(create_int8x8_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create_int8x8_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "vadd_s8(create_int8x8_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create_int8x8_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_s8(create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_s8_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vadd_s8(create_int8x8_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create_int8x8_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "vadd_s8(create_int8x8_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create_int8x8_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_s8(create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_u16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vadd_u16(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[6, 8, 10, 12]).map_err(|e| crate::cpu::with_call(e, "vadd_u16(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_u16(create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vadd_u16(create_uint16x4_t_from([0, 65535, 2, 65533]), create_uint16x4_t_from([10, 9, 12, 7])));
        check_array_equality(&result, &[10, 8, 14, 4]).map_err(|e| crate::cpu::with_call(e, "vadd_u16(create_uint16x4_t_from([0, 65535, 2, 65533]), create_uint16x4_t_from([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_u16(create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vadd_u16(create_uint16x4_t_from([100, 200, 300, 400]), create_uint16x4_t_from([110, 210, 310, 410])));
        check_array_equality(&result, &[210, 410, 610, 810]).map_err(|e| crate::cpu::with_call(e, "vadd_u16(create_uint16x4_t_from([100, 200, 300, 400]), create_uint16x4_t_from([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_u16(create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vadd_u16(create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vadd_u16(create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_u16(create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vadd_u16(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65534, 65534, 65534, 65534]).map_err(|e| crate::cpu::with_call(e, "vadd_u16(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_u16(create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vadd_u16(create_uint16x4_t_from([0, 0, 0, 0]), create_uint16x4_t_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vadd_u16(create_uint16x4_t_from([0, 0, 0, 0]), create_uint16x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_u16(create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vadd_u16(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65534, 65534, 65534, 65534]).map_err(|e| crate::cpu::with_call(e, "vadd_u16(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_u16(create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vadd_u16(create_uint16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]), create_uint16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX])));
        check_array_equality(&result, &[0, 65534, 0, 65534]).map_err(|e| crate::cpu::with_call(e, "vadd_u16(create_uint16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]), create_uint16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_u16(create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_u16_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vadd_u16(create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "vadd_u16(create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_u16(create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_u16_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vadd_u16(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "vadd_u16(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_u16(create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vadd_u32(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[4, 6]).map_err(|e| crate::cpu::with_call(e, "vadd_u32(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_u32(create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vadd_u32(create_uint32x2_t_from([0, 4294967295]), create_uint32x2_t_from([10, 9])));
        check_array_equality(&result, &[10, 8]).map_err(|e| crate::cpu::with_call(e, "vadd_u32(create_uint32x2_t_from([0, 4294967295]), create_uint32x2_t_from([10, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_u32(create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vadd_u32(create_uint32x2_t_from([100, 200]), create_uint32x2_t_from([110, 210])));
        check_array_equality(&result, &[210, 410]).map_err(|e| crate::cpu::with_call(e, "vadd_u32(create_uint32x2_t_from([100, 200]), create_uint32x2_t_from([110, 210]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_u32(create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vadd_u32(create_uint32x2_t_from([u32::MIN, u32::MIN]), create_uint32x2_t_from([u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vadd_u32(create_uint32x2_t_from([u32::MIN, u32::MIN]), create_uint32x2_t_from([u32::MIN, u32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_u32(create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vadd_u32(create_uint32x2_t_from([u32::MAX, u32::MAX]), create_uint32x2_t_from([u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967294, 4294967294]).map_err(|e| crate::cpu::with_call(e, "vadd_u32(create_uint32x2_t_from([u32::MAX, u32::MAX]), create_uint32x2_t_from([u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_u32(create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vadd_u32(create_uint32x2_t_from([0, 0]), create_uint32x2_t_from([0, 0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vadd_u32(create_uint32x2_t_from([0, 0]), create_uint32x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_u32(create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vadd_u32(create_uint32x2_t_from([u32::MAX, u32::MAX]), create_uint32x2_t_from([u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967294, 4294967294]).map_err(|e| crate::cpu::with_call(e, "vadd_u32(create_uint32x2_t_from([u32::MAX, u32::MAX]), create_uint32x2_t_from([u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_u32(create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vadd_u32(create_uint32x2_t_from([u32::MIN, u32::MAX]), create_uint32x2_t_from([u32::MIN, u32::MAX])));
        check_array_equality(&result, &[0, 4294967294]).map_err(|e| crate::cpu::with_call(e, "vadd_u32(create_uint32x2_t_from([u32::MIN, u32::MAX]), create_uint32x2_t_from([u32::MIN, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_u32(create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_u32_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vadd_u32(create_uint32x2_t_from([u32::MIN, u32::MIN]), create_uint32x2_t_from([u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967295, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vadd_u32(create_uint32x2_t_from([u32::MIN, u32::MIN]), create_uint32x2_t_from([u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_u32(create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_u32_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vadd_u32(create_uint32x2_t_from([u32::MAX, u32::MAX]), create_uint32x2_t_from([u32::MIN, u32::MIN])));
        check_array_equality(&result, &[4294967295, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vadd_u32(create_uint32x2_t_from([u32::MAX, u32::MAX]), create_uint32x2_t_from([u32::MIN, u32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_u32(create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_u8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vadd_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[10, 12, 14, 16, 18, 20, 22, 24]).map_err(|e| crate::cpu::with_call(e, "vadd_u8(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_u8(create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_u8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vadd_u8(create_uint8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249]), create_uint8x8_t_from([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, 8, 14, 4, 18, 0, 22, 252]).map_err(|e| crate::cpu::with_call(e, "vadd_u8(create_uint8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249]), create_uint8x8_t_from([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_u8(create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_u8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vadd_u8(create_uint8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32]), create_uint8x8_t_from([110, 210, 54, 154, 254, 98, 198, 42])));
        check_array_equality(&result, &[210, 154, 98, 42, 242, 186, 130, 74]).map_err(|e| crate::cpu::with_call(e, "vadd_u8(create_uint8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32]), create_uint8x8_t_from([110, 210, 54, 154, 254, 98, 198, 42]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_u8(create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_u8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vadd_u8(create_uint8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_uint8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vadd_u8(create_uint8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_uint8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_u8(create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_u8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vadd_u8(create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[254, 254, 254, 254, 254, 254, 254, 254]).map_err(|e| crate::cpu::with_call(e, "vadd_u8(create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_u8(create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_u8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vadd_u8(create_uint8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vadd_u8(create_uint8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_u8(create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_u8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vadd_u8(create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[254, 254, 254, 254, 254, 254, 254, 254]).map_err(|e| crate::cpu::with_call(e, "vadd_u8(create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_u8(create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_u8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vadd_u8(create_uint8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create_uint8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX])));
        check_array_equality(&result, &[0, 254, 0, 254, 0, 254, 0, 254]).map_err(|e| crate::cpu::with_call(e, "vadd_u8(create_uint8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create_uint8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_u8(create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_u8_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vadd_u8(create_uint8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "vadd_u8(create_uint8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_u8(create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_u8_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vadd_u8(create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "vadd_u8(create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_u8(create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_p8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vadd_p8(create_poly8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_poly8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[8, 8, 8, 8, 8, 8, 8, 24]).map_err(|e| crate::cpu::with_call(e, "vadd_p8(create_poly8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_poly8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_p8(create_random_poly8x8_t(), create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_p8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vadd_p8(create_poly8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249]), create_poly8x8_t_from([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, 246, 14, 250, 10, 254, 22, 250]).map_err(|e| crate::cpu::with_call(e, "vadd_p8(create_poly8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249]), create_poly8x8_t_from([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_p8(create_random_poly8x8_t(), create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_p8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vadd_p8(create_poly8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32]), create_poly8x8_t_from([110, 210, 54, 154, 254, 98, 198, 42])));
        check_array_equality(&result, &[10, 26, 26, 10, 10, 58, 122, 10]).map_err(|e| crate::cpu::with_call(e, "vadd_p8(create_poly8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32]), create_poly8x8_t_from([110, 210, 54, 154, 254, 98, 198, 42]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_p8(create_random_poly8x8_t(), create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_p8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vadd_p8(create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vadd_p8(create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_p8(create_random_poly8x8_t(), create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_p8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vadd_p8(create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vadd_p8(create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_p8(create_random_poly8x8_t(), create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_p8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vadd_p8(create_poly8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_poly8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vadd_p8(create_poly8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_poly8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_p8(create_random_poly8x8_t(), create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_p8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vadd_p8(create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vadd_p8(create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_p8(create_random_poly8x8_t(), create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_p8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vadd_p8(create_poly8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create_poly8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vadd_p8(create_poly8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create_poly8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_p8(create_random_poly8x8_t(), create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_p8_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vadd_p8(create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "vadd_p8(create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_p8(create_random_poly8x8_t(), create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_p8_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vadd_p8(create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "vadd_p8(create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_p8(create_random_poly8x8_t(), create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_p16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vadd_p16(create_poly16x4_t_from([1, 2, 3, 4]), create_poly16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[4, 4, 4, 12]).map_err(|e| crate::cpu::with_call(e, "vadd_p16(create_poly16x4_t_from([1, 2, 3, 4]), create_poly16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_p16(create_random_poly16x4_t(), create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_p16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vadd_p16(create_poly16x4_t_from([0, 65535, 2, 65533]), create_poly16x4_t_from([10, 9, 12, 7])));
        check_array_equality(&result, &[10, 65526, 14, 65530]).map_err(|e| crate::cpu::with_call(e, "vadd_p16(create_poly16x4_t_from([0, 65535, 2, 65533]), create_poly16x4_t_from([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_p16(create_random_poly16x4_t(), create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_p16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vadd_p16(create_poly16x4_t_from([100, 200, 300, 400]), create_poly16x4_t_from([110, 210, 310, 410])));
        check_array_equality(&result, &[10, 26, 26, 10]).map_err(|e| crate::cpu::with_call(e, "vadd_p16(create_poly16x4_t_from([100, 200, 300, 400]), create_poly16x4_t_from([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_p16(create_random_poly16x4_t(), create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_p16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vadd_p16(create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vadd_p16(create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_p16(create_random_poly16x4_t(), create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_p16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vadd_p16(create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vadd_p16(create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_p16(create_random_poly16x4_t(), create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_p16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vadd_p16(create_poly16x4_t_from([0, 0, 0, 0]), create_poly16x4_t_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vadd_p16(create_poly16x4_t_from([0, 0, 0, 0]), create_poly16x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_p16(create_random_poly16x4_t(), create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_p16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vadd_p16(create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vadd_p16(create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_p16(create_random_poly16x4_t(), create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_p16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vadd_p16(create_poly16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]), create_poly16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vadd_p16(create_poly16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]), create_poly16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_p16(create_random_poly16x4_t(), create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_p16_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vadd_p16(create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "vadd_p16(create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_p16(create_random_poly16x4_t(), create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_p16_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vadd_p16(create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "vadd_p16(create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_p16(create_random_poly16x4_t(), create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_p64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vadd_p64(create_poly64x1_t_from([1]), create_poly64x1_t_from([2])));
        check_array_equality(&result, &[3]).map_err(|e| crate::cpu::with_call(e, "vadd_p64(create_poly64x1_t_from([1]), create_poly64x1_t_from([2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_p64(create_random_poly64x1_t(), create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_p64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vadd_p64(create_poly64x1_t_from([0]), create_poly64x1_t_from([10])));
        check_array_equality(&result, &[10]).map_err(|e| crate::cpu::with_call(e, "vadd_p64(create_poly64x1_t_from([0]), create_poly64x1_t_from([10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_p64(create_random_poly64x1_t(), create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_p64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vadd_p64(create_poly64x1_t_from([100]), create_poly64x1_t_from([110])));
        check_array_equality(&result, &[10]).map_err(|e| crate::cpu::with_call(e, "vadd_p64(create_poly64x1_t_from([100]), create_poly64x1_t_from([110]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_p64(create_random_poly64x1_t(), create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_p64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vadd_p64(create_poly64x1_t_from([u64::MIN]), create_poly64x1_t_from([u64::MIN])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vadd_p64(create_poly64x1_t_from([u64::MIN]), create_poly64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_p64(create_random_poly64x1_t(), create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_p64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vadd_p64(create_poly64x1_t_from([u64::MAX]), create_poly64x1_t_from([u64::MAX])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vadd_p64(create_poly64x1_t_from([u64::MAX]), create_poly64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_p64(create_random_poly64x1_t(), create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_p64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vadd_p64(create_poly64x1_t_from([0]), create_poly64x1_t_from([0])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vadd_p64(create_poly64x1_t_from([0]), create_poly64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_p64(create_random_poly64x1_t(), create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_p64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vadd_p64(create_poly64x1_t_from([u64::MAX]), create_poly64x1_t_from([u64::MAX])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vadd_p64(create_poly64x1_t_from([u64::MAX]), create_poly64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_p64(create_random_poly64x1_t(), create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_p64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vadd_p64(create_poly64x1_t_from([u64::MIN]), create_poly64x1_t_from([u64::MIN])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vadd_p64(create_poly64x1_t_from([u64::MIN]), create_poly64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_p64(create_random_poly64x1_t(), create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_p64_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vadd_p64(create_poly64x1_t_from([u64::MIN]), create_poly64x1_t_from([u64::MAX])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vadd_p64(create_poly64x1_t_from([u64::MIN]), create_poly64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_p64(create_random_poly64x1_t(), create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vadd_p64_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vadd_p64(create_poly64x1_t_from([u64::MAX]), create_poly64x1_t_from([u64::MIN])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vadd_p64(create_poly64x1_t_from([u64::MAX]), create_poly64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vadd_p64(create_random_poly64x1_t(), create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}
