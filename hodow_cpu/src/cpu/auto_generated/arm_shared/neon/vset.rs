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

pub(super) fn test_arm_shared_neon_vset_lane_f32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vset_lane_f32::<0>(1.0f32, create_float32x2_t_from([2.0, 3.0])));
        check_float_array_equality(&result, &[1.0, 3.0]).map_err(|e| crate::cpu::with_call(e, "vset_lane_f32::<0>(1.0f32, create_float32x2_t_from([2.0, 3.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_f32::<0>(rand::random::<f32>(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_f32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vset_lane_f32::<0>(1.0f32, create_float32x2_t_from([0.0f32, -1.0f32])));
        check_float_array_equality(&result, &[1.0, -1.0]).map_err(|e| crate::cpu::with_call(e, "vset_lane_f32::<0>(1.0f32, create_float32x2_t_from([0.0f32, -1.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_f32::<0>(rand::random::<f32>(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_f32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vset_lane_f32::<0>(1.0f32, create_float32x2_t_from([100.0f32, 200.0f32])));
        check_float_array_equality(&result, &[1.0, 200.0]).map_err(|e| crate::cpu::with_call(e, "vset_lane_f32::<0>(1.0f32, create_float32x2_t_from([100.0f32, 200.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_f32::<0>(rand::random::<f32>(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_f32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vset_lane_f32::<0>(1.0f32, create_float32x2_t_from([f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[1.0, -3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "vset_lane_f32::<0>(1.0f32, create_float32x2_t_from([f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_f32::<0>(rand::random::<f32>(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_f32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vset_lane_f32::<0>(1.0f32, create_float32x2_t_from([f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[1.0, 3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "vset_lane_f32::<0>(1.0f32, create_float32x2_t_from([f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_f32::<0>(rand::random::<f32>(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_f32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vset_lane_f32::<0>(1.0f32, create_float32x2_t_from([0.0, 0.0])));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vset_lane_f32::<0>(1.0f32, create_float32x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_f32::<0>(rand::random::<f32>(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_f32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vset_lane_f32::<0>(1.0f32, create_float32x2_t_from([f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[1.0, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "vset_lane_f32::<0>(1.0f32, create_float32x2_t_from([f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_f32::<0>(rand::random::<f32>(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_f32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vset_lane_f32::<0>(1.0f32, create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY])));
        check_float_array_equality(&result, &[1.0, -f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vset_lane_f32::<0>(1.0f32, create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_f32::<0>(rand::random::<f32>(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_f32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vset_lane_f32::<1>(1.0f32, create_float32x2_t_from([2.0, 3.0])));
        check_float_array_equality(&result, &[2.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "vset_lane_f32::<1>(1.0f32, create_float32x2_t_from([2.0, 3.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_f32::<1>(rand::random::<f32>(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vset_lane_s8::<0>(1i8, create_int8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9])));
        check_array_equality(&result, &[1, 3, 4, 5, 6, 7, 8, 9]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s8::<0>(1i8, create_int8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s8::<0>(rand::random::<i8>(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vset_lane_s8::<0>(1i8, create_int8x8_t_from([0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[1, -1, 2, -3, 4, -5, 6, -7]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s8::<0>(1i8, create_int8x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s8::<0>(rand::random::<i8>(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vset_lane_s8::<0>(1i8, create_int8x8_t_from([100, -56, 44, -112, -12, 88, -68, 32])));
        check_array_equality(&result, &[1, -56, 44, -112, -12, 88, -68, 32]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s8::<0>(1i8, create_int8x8_t_from([100, -56, 44, -112, -12, 88, -68, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s8::<0>(rand::random::<i8>(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vset_lane_s8::<0>(1i8, create_int8x8_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[1, -128, -128, -128, -128, -128, -128, -128]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s8::<0>(1i8, create_int8x8_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s8::<0>(rand::random::<i8>(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vset_lane_s8::<0>(1i8, create_int8x8_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[1, 127, 127, 127, 127, 127, 127, 127]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s8::<0>(1i8, create_int8x8_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s8::<0>(rand::random::<i8>(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vset_lane_s8::<0>(1i8, create_int8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s8::<0>(1i8, create_int8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s8::<0>(rand::random::<i8>(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vset_lane_s8::<0>(1i8, create_int8x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s8::<0>(1i8, create_int8x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s8::<0>(rand::random::<i8>(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vset_lane_s8::<0>(1i8, create_int8x8_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[1, 127, 0, -1, -128, 127, 0, -1]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s8::<0>(1i8, create_int8x8_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s8::<0>(rand::random::<i8>(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s8_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vset_lane_s8::<1>(1i8, create_int8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9])));
        check_array_equality(&result, &[2, 1, 4, 5, 6, 7, 8, 9]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s8::<1>(1i8, create_int8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s8::<1>(rand::random::<i8>(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s8_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vset_lane_s8::<7>(1i8, create_int8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9])));
        check_array_equality(&result, &[2, 3, 4, 5, 6, 7, 8, 1]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s8::<7>(1i8, create_int8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s8::<7>(rand::random::<i8>(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s8_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vset_lane_s8::<3>(1i8, create_int8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9])));
        check_array_equality(&result, &[2, 3, 4, 1, 6, 7, 8, 9]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s8::<3>(1i8, create_int8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s8::<3>(rand::random::<i8>(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vset_lane_s16::<0>(1i16, create_int16x4_t_from([2, 3, 4, 5])));
        check_array_equality(&result, &[1, 3, 4, 5]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s16::<0>(1i16, create_int16x4_t_from([2, 3, 4, 5]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s16::<0>(rand::random::<i16>(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vset_lane_s16::<0>(1i16, create_int16x4_t_from([0, -1, 2, -3])));
        check_array_equality(&result, &[1, -1, 2, -3]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s16::<0>(1i16, create_int16x4_t_from([0, -1, 2, -3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s16::<0>(rand::random::<i16>(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vset_lane_s16::<0>(1i16, create_int16x4_t_from([100, 200, 300, 400])));
        check_array_equality(&result, &[1, 200, 300, 400]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s16::<0>(1i16, create_int16x4_t_from([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s16::<0>(rand::random::<i16>(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vset_lane_s16::<0>(1i16, create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[1, -32768, -32768, -32768]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s16::<0>(1i16, create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s16::<0>(rand::random::<i16>(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vset_lane_s16::<0>(1i16, create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[1, 32767, 32767, 32767]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s16::<0>(1i16, create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s16::<0>(rand::random::<i16>(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vset_lane_s16::<0>(1i16, create_int16x4_t_from([0, 0, 0, 0])));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s16::<0>(1i16, create_int16x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s16::<0>(rand::random::<i16>(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vset_lane_s16::<0>(1i16, create_int16x4_t_from([-1, -1, -1, -1])));
        check_array_equality(&result, &[1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s16::<0>(1i16, create_int16x4_t_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s16::<0>(rand::random::<i16>(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vset_lane_s16::<0>(1i16, create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[1, 32767, 0, -1]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s16::<0>(1i16, create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s16::<0>(rand::random::<i16>(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vset_lane_s16::<1>(1i16, create_int16x4_t_from([2, 3, 4, 5])));
        check_array_equality(&result, &[2, 1, 4, 5]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s16::<1>(1i16, create_int16x4_t_from([2, 3, 4, 5]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s16::<1>(rand::random::<i16>(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vset_lane_s16::<3>(1i16, create_int16x4_t_from([2, 3, 4, 5])));
        check_array_equality(&result, &[2, 3, 4, 1]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s16::<3>(1i16, create_int16x4_t_from([2, 3, 4, 5]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s16::<3>(rand::random::<i16>(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vset_lane_s32::<0>(1i32, create_int32x2_t_from([2, 3])));
        check_array_equality(&result, &[1, 3]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s32::<0>(1i32, create_int32x2_t_from([2, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s32::<0>(rand::random::<i32>(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vset_lane_s32::<0>(1i32, create_int32x2_t_from([0, -1])));
        check_array_equality(&result, &[1, -1]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s32::<0>(1i32, create_int32x2_t_from([0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s32::<0>(rand::random::<i32>(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vset_lane_s32::<0>(1i32, create_int32x2_t_from([100, 200])));
        check_array_equality(&result, &[1, 200]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s32::<0>(1i32, create_int32x2_t_from([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s32::<0>(rand::random::<i32>(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vset_lane_s32::<0>(1i32, create_int32x2_t_from([i32::MIN, i32::MIN])));
        check_array_equality(&result, &[1, -2147483648]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s32::<0>(1i32, create_int32x2_t_from([i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s32::<0>(rand::random::<i32>(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vset_lane_s32::<0>(1i32, create_int32x2_t_from([i32::MAX, i32::MAX])));
        check_array_equality(&result, &[1, 2147483647]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s32::<0>(1i32, create_int32x2_t_from([i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s32::<0>(rand::random::<i32>(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vset_lane_s32::<0>(1i32, create_int32x2_t_from([0, 0])));
        check_array_equality(&result, &[1, 0]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s32::<0>(1i32, create_int32x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s32::<0>(rand::random::<i32>(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vset_lane_s32::<0>(1i32, create_int32x2_t_from([-1, -1])));
        check_array_equality(&result, &[1, -1]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s32::<0>(1i32, create_int32x2_t_from([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s32::<0>(rand::random::<i32>(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vset_lane_s32::<0>(1i32, create_int32x2_t_from([i32::MIN, i32::MAX])));
        check_array_equality(&result, &[1, 2147483647]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s32::<0>(1i32, create_int32x2_t_from([i32::MIN, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s32::<0>(rand::random::<i32>(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vset_lane_s32::<1>(1i32, create_int32x2_t_from([2, 3])));
        check_array_equality(&result, &[2, 1]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s32::<1>(1i32, create_int32x2_t_from([2, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s32::<1>(rand::random::<i32>(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vset_lane_u8::<0>(1u8, create_uint8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9])));
        check_array_equality(&result, &[1, 3, 4, 5, 6, 7, 8, 9]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u8::<0>(1u8, create_uint8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u8::<0>(rand::random::<u8>(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vset_lane_u8::<0>(1u8, create_uint8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249])));
        check_array_equality(&result, &[1, 255, 2, 253, 4, 251, 6, 249]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u8::<0>(1u8, create_uint8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u8::<0>(rand::random::<u8>(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vset_lane_u8::<0>(1u8, create_uint8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32])));
        check_array_equality(&result, &[1, 200, 44, 144, 244, 88, 188, 32]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u8::<0>(1u8, create_uint8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u8::<0>(rand::random::<u8>(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vset_lane_u8::<0>(1u8, create_uint8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u8::<0>(1u8, create_uint8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u8::<0>(rand::random::<u8>(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vset_lane_u8::<0>(1u8, create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[1, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u8::<0>(1u8, create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u8::<0>(rand::random::<u8>(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vset_lane_u8::<0>(1u8, create_uint8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u8::<0>(1u8, create_uint8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u8::<0>(rand::random::<u8>(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vset_lane_u8::<0>(1u8, create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[1, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u8::<0>(1u8, create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u8::<0>(rand::random::<u8>(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vset_lane_u8::<0>(1u8, create_uint8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX])));
        check_array_equality(&result, &[1, 255, 0, 255, 0, 255, 0, 255]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u8::<0>(1u8, create_uint8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u8::<0>(rand::random::<u8>(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u8_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vset_lane_u8::<1>(1u8, create_uint8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9])));
        check_array_equality(&result, &[2, 1, 4, 5, 6, 7, 8, 9]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u8::<1>(1u8, create_uint8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u8::<1>(rand::random::<u8>(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u8_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vset_lane_u8::<7>(1u8, create_uint8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9])));
        check_array_equality(&result, &[2, 3, 4, 5, 6, 7, 8, 1]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u8::<7>(1u8, create_uint8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u8::<7>(rand::random::<u8>(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u8_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vset_lane_u8::<3>(1u8, create_uint8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9])));
        check_array_equality(&result, &[2, 3, 4, 1, 6, 7, 8, 9]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u8::<3>(1u8, create_uint8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u8::<3>(rand::random::<u8>(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vset_lane_u16::<0>(1u16, create_uint16x4_t_from([2, 3, 4, 5])));
        check_array_equality(&result, &[1, 3, 4, 5]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u16::<0>(1u16, create_uint16x4_t_from([2, 3, 4, 5]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u16::<0>(rand::random::<u16>(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vset_lane_u16::<0>(1u16, create_uint16x4_t_from([0, 65535, 2, 65533])));
        check_array_equality(&result, &[1, 65535, 2, 65533]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u16::<0>(1u16, create_uint16x4_t_from([0, 65535, 2, 65533]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u16::<0>(rand::random::<u16>(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vset_lane_u16::<0>(1u16, create_uint16x4_t_from([100, 200, 300, 400])));
        check_array_equality(&result, &[1, 200, 300, 400]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u16::<0>(1u16, create_uint16x4_t_from([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u16::<0>(rand::random::<u16>(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vset_lane_u16::<0>(1u16, create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u16::<0>(1u16, create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u16::<0>(rand::random::<u16>(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vset_lane_u16::<0>(1u16, create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[1, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u16::<0>(1u16, create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u16::<0>(rand::random::<u16>(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vset_lane_u16::<0>(1u16, create_uint16x4_t_from([0, 0, 0, 0])));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u16::<0>(1u16, create_uint16x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u16::<0>(rand::random::<u16>(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vset_lane_u16::<0>(1u16, create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[1, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u16::<0>(1u16, create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u16::<0>(rand::random::<u16>(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vset_lane_u16::<0>(1u16, create_uint16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX])));
        check_array_equality(&result, &[1, 65535, 0, 65535]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u16::<0>(1u16, create_uint16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u16::<0>(rand::random::<u16>(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vset_lane_u16::<1>(1u16, create_uint16x4_t_from([2, 3, 4, 5])));
        check_array_equality(&result, &[2, 1, 4, 5]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u16::<1>(1u16, create_uint16x4_t_from([2, 3, 4, 5]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u16::<1>(rand::random::<u16>(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vset_lane_u16::<3>(1u16, create_uint16x4_t_from([2, 3, 4, 5])));
        check_array_equality(&result, &[2, 3, 4, 1]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u16::<3>(1u16, create_uint16x4_t_from([2, 3, 4, 5]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u16::<3>(rand::random::<u16>(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vset_lane_u32::<0>(1u32, create_uint32x2_t_from([2, 3])));
        check_array_equality(&result, &[1, 3]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u32::<0>(1u32, create_uint32x2_t_from([2, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u32::<0>(rand::random::<u32>(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vset_lane_u32::<0>(1u32, create_uint32x2_t_from([0, 4294967295])));
        check_array_equality(&result, &[1, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u32::<0>(1u32, create_uint32x2_t_from([0, 4294967295]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u32::<0>(rand::random::<u32>(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vset_lane_u32::<0>(1u32, create_uint32x2_t_from([100, 200])));
        check_array_equality(&result, &[1, 200]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u32::<0>(1u32, create_uint32x2_t_from([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u32::<0>(rand::random::<u32>(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vset_lane_u32::<0>(1u32, create_uint32x2_t_from([u32::MIN, u32::MIN])));
        check_array_equality(&result, &[1, 0]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u32::<0>(1u32, create_uint32x2_t_from([u32::MIN, u32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u32::<0>(rand::random::<u32>(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vset_lane_u32::<0>(1u32, create_uint32x2_t_from([u32::MAX, u32::MAX])));
        check_array_equality(&result, &[1, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u32::<0>(1u32, create_uint32x2_t_from([u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u32::<0>(rand::random::<u32>(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vset_lane_u32::<0>(1u32, create_uint32x2_t_from([0, 0])));
        check_array_equality(&result, &[1, 0]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u32::<0>(1u32, create_uint32x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u32::<0>(rand::random::<u32>(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vset_lane_u32::<0>(1u32, create_uint32x2_t_from([u32::MAX, u32::MAX])));
        check_array_equality(&result, &[1, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u32::<0>(1u32, create_uint32x2_t_from([u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u32::<0>(rand::random::<u32>(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vset_lane_u32::<0>(1u32, create_uint32x2_t_from([u32::MIN, u32::MAX])));
        check_array_equality(&result, &[1, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u32::<0>(1u32, create_uint32x2_t_from([u32::MIN, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u32::<0>(rand::random::<u32>(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vset_lane_u32::<1>(1u32, create_uint32x2_t_from([2, 3])));
        check_array_equality(&result, &[2, 1]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u32::<1>(1u32, create_uint32x2_t_from([2, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u32::<1>(rand::random::<u32>(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_p8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vset_lane_p8::<0>(1u8, create_poly8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9])));
        check_array_equality(&result, &[1, 3, 4, 5, 6, 7, 8, 9]).map_err(|e| crate::cpu::with_call(e, "vset_lane_p8::<0>(1u8, create_poly8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_p8::<0>(rand::random::<u8>(), create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_p8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vset_lane_p8::<0>(1u8, create_poly8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249])));
        check_array_equality(&result, &[1, 255, 2, 253, 4, 251, 6, 249]).map_err(|e| crate::cpu::with_call(e, "vset_lane_p8::<0>(1u8, create_poly8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_p8::<0>(rand::random::<u8>(), create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_p8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vset_lane_p8::<0>(1u8, create_poly8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32])));
        check_array_equality(&result, &[1, 200, 44, 144, 244, 88, 188, 32]).map_err(|e| crate::cpu::with_call(e, "vset_lane_p8::<0>(1u8, create_poly8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_p8::<0>(rand::random::<u8>(), create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_p8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vset_lane_p8::<0>(1u8, create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vset_lane_p8::<0>(1u8, create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_p8::<0>(rand::random::<u8>(), create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_p8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vset_lane_p8::<0>(1u8, create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[1, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "vset_lane_p8::<0>(1u8, create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_p8::<0>(rand::random::<u8>(), create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_p8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vset_lane_p8::<0>(1u8, create_poly8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vset_lane_p8::<0>(1u8, create_poly8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_p8::<0>(rand::random::<u8>(), create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_p8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vset_lane_p8::<0>(1u8, create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[1, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "vset_lane_p8::<0>(1u8, create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_p8::<0>(rand::random::<u8>(), create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_p8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vset_lane_p8::<0>(1u8, create_poly8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX])));
        check_array_equality(&result, &[1, 255, 0, 255, 0, 255, 0, 255]).map_err(|e| crate::cpu::with_call(e, "vset_lane_p8::<0>(1u8, create_poly8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_p8::<0>(rand::random::<u8>(), create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_p8_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vset_lane_p8::<1>(1u8, create_poly8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9])));
        check_array_equality(&result, &[2, 1, 4, 5, 6, 7, 8, 9]).map_err(|e| crate::cpu::with_call(e, "vset_lane_p8::<1>(1u8, create_poly8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_p8::<1>(rand::random::<u8>(), create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_p8_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vset_lane_p8::<7>(1u8, create_poly8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9])));
        check_array_equality(&result, &[2, 3, 4, 5, 6, 7, 8, 1]).map_err(|e| crate::cpu::with_call(e, "vset_lane_p8::<7>(1u8, create_poly8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_p8::<7>(rand::random::<u8>(), create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_p8_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vset_lane_p8::<3>(1u8, create_poly8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9])));
        check_array_equality(&result, &[2, 3, 4, 1, 6, 7, 8, 9]).map_err(|e| crate::cpu::with_call(e, "vset_lane_p8::<3>(1u8, create_poly8x8_t_from([2, 3, 4, 5, 6, 7, 8, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_p8::<3>(rand::random::<u8>(), create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_p16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vset_lane_p16::<0>(1u16, create_poly16x4_t_from([2, 3, 4, 5])));
        check_array_equality(&result, &[1, 3, 4, 5]).map_err(|e| crate::cpu::with_call(e, "vset_lane_p16::<0>(1u16, create_poly16x4_t_from([2, 3, 4, 5]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_p16::<0>(rand::random::<u16>(), create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_p16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vset_lane_p16::<0>(1u16, create_poly16x4_t_from([0, 65535, 2, 65533])));
        check_array_equality(&result, &[1, 65535, 2, 65533]).map_err(|e| crate::cpu::with_call(e, "vset_lane_p16::<0>(1u16, create_poly16x4_t_from([0, 65535, 2, 65533]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_p16::<0>(rand::random::<u16>(), create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_p16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vset_lane_p16::<0>(1u16, create_poly16x4_t_from([100, 200, 300, 400])));
        check_array_equality(&result, &[1, 200, 300, 400]).map_err(|e| crate::cpu::with_call(e, "vset_lane_p16::<0>(1u16, create_poly16x4_t_from([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_p16::<0>(rand::random::<u16>(), create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_p16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vset_lane_p16::<0>(1u16, create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vset_lane_p16::<0>(1u16, create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_p16::<0>(rand::random::<u16>(), create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_p16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vset_lane_p16::<0>(1u16, create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[1, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "vset_lane_p16::<0>(1u16, create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_p16::<0>(rand::random::<u16>(), create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_p16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vset_lane_p16::<0>(1u16, create_poly16x4_t_from([0, 0, 0, 0])));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vset_lane_p16::<0>(1u16, create_poly16x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_p16::<0>(rand::random::<u16>(), create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_p16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vset_lane_p16::<0>(1u16, create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[1, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "vset_lane_p16::<0>(1u16, create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_p16::<0>(rand::random::<u16>(), create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_p16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vset_lane_p16::<0>(1u16, create_poly16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX])));
        check_array_equality(&result, &[1, 65535, 0, 65535]).map_err(|e| crate::cpu::with_call(e, "vset_lane_p16::<0>(1u16, create_poly16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_p16::<0>(rand::random::<u16>(), create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_p16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vset_lane_p16::<1>(1u16, create_poly16x4_t_from([2, 3, 4, 5])));
        check_array_equality(&result, &[2, 1, 4, 5]).map_err(|e| crate::cpu::with_call(e, "vset_lane_p16::<1>(1u16, create_poly16x4_t_from([2, 3, 4, 5]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_p16::<1>(rand::random::<u16>(), create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_p16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vset_lane_p16::<3>(1u16, create_poly16x4_t_from([2, 3, 4, 5])));
        check_array_equality(&result, &[2, 3, 4, 1]).map_err(|e| crate::cpu::with_call(e, "vset_lane_p16::<3>(1u16, create_poly16x4_t_from([2, 3, 4, 5]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_p16::<3>(rand::random::<u16>(), create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vset_lane_s64::<0>(1i64, create_int64x1_t_from([2])));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s64::<0>(1i64, create_int64x1_t_from([2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s64::<0>(rand::random::<i64>(), create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vset_lane_s64::<0>(1i64, create_int64x1_t_from([0])));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s64::<0>(1i64, create_int64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s64::<0>(rand::random::<i64>(), create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vset_lane_s64::<0>(1i64, create_int64x1_t_from([100])));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s64::<0>(1i64, create_int64x1_t_from([100]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s64::<0>(rand::random::<i64>(), create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vset_lane_s64::<0>(1i64, create_int64x1_t_from([i64::MIN])));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s64::<0>(1i64, create_int64x1_t_from([i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s64::<0>(rand::random::<i64>(), create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vset_lane_s64::<0>(1i64, create_int64x1_t_from([i64::MAX])));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s64::<0>(1i64, create_int64x1_t_from([i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s64::<0>(rand::random::<i64>(), create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vset_lane_s64::<0>(1i64, create_int64x1_t_from([0])));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s64::<0>(1i64, create_int64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s64::<0>(rand::random::<i64>(), create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vset_lane_s64::<0>(1i64, create_int64x1_t_from([-1])));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s64::<0>(1i64, create_int64x1_t_from([-1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s64::<0>(rand::random::<i64>(), create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_s64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vset_lane_s64::<0>(1i64, create_int64x1_t_from([i64::MIN])));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "vset_lane_s64::<0>(1i64, create_int64x1_t_from([i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_s64::<0>(rand::random::<i64>(), create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vset_lane_u64::<0>(1u64, create_uint64x1_t_from([2])));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u64::<0>(1u64, create_uint64x1_t_from([2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u64::<0>(rand::random::<u64>(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vset_lane_u64::<0>(1u64, create_uint64x1_t_from([0])));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u64::<0>(1u64, create_uint64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u64::<0>(rand::random::<u64>(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vset_lane_u64::<0>(1u64, create_uint64x1_t_from([100])));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u64::<0>(1u64, create_uint64x1_t_from([100]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u64::<0>(rand::random::<u64>(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vset_lane_u64::<0>(1u64, create_uint64x1_t_from([u64::MIN])));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u64::<0>(1u64, create_uint64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u64::<0>(rand::random::<u64>(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vset_lane_u64::<0>(1u64, create_uint64x1_t_from([u64::MAX])));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u64::<0>(1u64, create_uint64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u64::<0>(rand::random::<u64>(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vset_lane_u64::<0>(1u64, create_uint64x1_t_from([0])));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u64::<0>(1u64, create_uint64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u64::<0>(rand::random::<u64>(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vset_lane_u64::<0>(1u64, create_uint64x1_t_from([u64::MAX])));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u64::<0>(1u64, create_uint64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u64::<0>(rand::random::<u64>(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vset_lane_u64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vset_lane_u64::<0>(1u64, create_uint64x1_t_from([u64::MIN])));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "vset_lane_u64::<0>(1u64, create_uint64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vset_lane_u64::<0>(rand::random::<u64>(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}
