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

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vqshrun_n_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vqshrun_n_s16::<1>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0, 1, 1, 2, 2, 3, 3, 4]).map_err(|e| crate::cpu::with_call(e, "vqshrun_n_s16::<1>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrun_n_s16::<1>(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vqshrun_n_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vqshrun_n_s16::<1>(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, 0, 1, 0, 2, 0, 3, 0]).map_err(|e| crate::cpu::with_call(e, "vqshrun_n_s16::<1>(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrun_n_s16::<1>(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vqshrun_n_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vqshrun_n_s16::<1>(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800])));
        check_array_equality(&result, &[50, 100, 150, 200, 250, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "vqshrun_n_s16::<1>(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrun_n_s16::<1>(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vqshrun_n_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vqshrun_n_s16::<1>(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqshrun_n_s16::<1>(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrun_n_s16::<1>(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vqshrun_n_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vqshrun_n_s16::<1>(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "vqshrun_n_s16::<1>(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrun_n_s16::<1>(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vqshrun_n_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vqshrun_n_s16::<1>(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqshrun_n_s16::<1>(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrun_n_s16::<1>(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vqshrun_n_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vqshrun_n_s16::<1>(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqshrun_n_s16::<1>(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrun_n_s16::<1>(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vqshrun_n_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vqshrun_n_s16::<1>(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[0, 255, 0, 0, 0, 255, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqshrun_n_s16::<1>(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrun_n_s16::<1>(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vqshrun_n_s16_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vqshrun_n_s16::<2>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0, 0, 0, 1, 1, 1, 1, 2]).map_err(|e| crate::cpu::with_call(e, "vqshrun_n_s16::<2>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrun_n_s16::<2>(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vqshrun_n_s16_imm_8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vqshrun_n_s16::<8>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqshrun_n_s16::<8>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrun_n_s16::<8>(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vqshrun_n_s16_imm_4() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vqshrun_n_s16::<4>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqshrun_n_s16::<4>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrun_n_s16::<4>(create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vqshrun_n_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vqshrun_n_s32::<1>(create_int32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 1, 1, 2]).map_err(|e| crate::cpu::with_call(e, "vqshrun_n_s32::<1>(create_int32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrun_n_s32::<1>(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vqshrun_n_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vqshrun_n_s32::<1>(create_int32x4_t_from([0, -1, 2, -3])));
        check_array_equality(&result, &[0, 0, 1, 0]).map_err(|e| crate::cpu::with_call(e, "vqshrun_n_s32::<1>(create_int32x4_t_from([0, -1, 2, -3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrun_n_s32::<1>(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vqshrun_n_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vqshrun_n_s32::<1>(create_int32x4_t_from([100, 200, 300, 400])));
        check_array_equality(&result, &[50, 100, 150, 200]).map_err(|e| crate::cpu::with_call(e, "vqshrun_n_s32::<1>(create_int32x4_t_from([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrun_n_s32::<1>(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vqshrun_n_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vqshrun_n_s32::<1>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqshrun_n_s32::<1>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrun_n_s32::<1>(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vqshrun_n_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vqshrun_n_s32::<1>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "vqshrun_n_s32::<1>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrun_n_s32::<1>(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vqshrun_n_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vqshrun_n_s32::<1>(create_int32x4_t_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqshrun_n_s32::<1>(create_int32x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrun_n_s32::<1>(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vqshrun_n_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vqshrun_n_s32::<1>(create_int32x4_t_from([-1, -1, -1, -1])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqshrun_n_s32::<1>(create_int32x4_t_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrun_n_s32::<1>(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vqshrun_n_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vqshrun_n_s32::<1>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[0, 65535, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqshrun_n_s32::<1>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrun_n_s32::<1>(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vqshrun_n_s32_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vqshrun_n_s32::<2>(create_int32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 0, 0, 1]).map_err(|e| crate::cpu::with_call(e, "vqshrun_n_s32::<2>(create_int32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrun_n_s32::<2>(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vqshrun_n_s32_imm_16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vqshrun_n_s32::<16>(create_int32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqshrun_n_s32::<16>(create_int32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrun_n_s32::<16>(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vqshrun_n_s32_imm_8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vqshrun_n_s32::<8>(create_int32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqshrun_n_s32::<8>(create_int32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrun_n_s32::<8>(create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vqshrun_n_s64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vqshrun_n_s64::<1>(create_int64x2_t_from([1, 2])));
        check_array_equality(&result, &[0, 1]).map_err(|e| crate::cpu::with_call(e, "vqshrun_n_s64::<1>(create_int64x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrun_n_s64::<1>(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vqshrun_n_s64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vqshrun_n_s64::<1>(create_int64x2_t_from([0, -1])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vqshrun_n_s64::<1>(create_int64x2_t_from([0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrun_n_s64::<1>(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vqshrun_n_s64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vqshrun_n_s64::<1>(create_int64x2_t_from([100, 200])));
        check_array_equality(&result, &[50, 100]).map_err(|e| crate::cpu::with_call(e, "vqshrun_n_s64::<1>(create_int64x2_t_from([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrun_n_s64::<1>(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vqshrun_n_s64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vqshrun_n_s64::<1>(create_int64x2_t_from([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vqshrun_n_s64::<1>(create_int64x2_t_from([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrun_n_s64::<1>(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vqshrun_n_s64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vqshrun_n_s64::<1>(create_int64x2_t_from([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[4294967295, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vqshrun_n_s64::<1>(create_int64x2_t_from([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrun_n_s64::<1>(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vqshrun_n_s64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vqshrun_n_s64::<1>(create_int64x2_t_from([0, 0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vqshrun_n_s64::<1>(create_int64x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrun_n_s64::<1>(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vqshrun_n_s64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vqshrun_n_s64::<1>(create_int64x2_t_from([-1, -1])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vqshrun_n_s64::<1>(create_int64x2_t_from([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrun_n_s64::<1>(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vqshrun_n_s64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vqshrun_n_s64::<1>(create_int64x2_t_from([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[0, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vqshrun_n_s64::<1>(create_int64x2_t_from([i64::MIN, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrun_n_s64::<1>(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vqshrun_n_s64_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vqshrun_n_s64::<2>(create_int64x2_t_from([1, 2])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vqshrun_n_s64::<2>(create_int64x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrun_n_s64::<2>(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vqshrun_n_s64_imm_32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vqshrun_n_s64::<32>(create_int64x2_t_from([1, 2])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vqshrun_n_s64::<32>(create_int64x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrun_n_s64::<32>(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

#[cfg(target_arch = "arm")]
pub(super) fn test_arm_shared_neon_vqshrun_n_s64_imm_16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vqshrun_n_s64::<16>(create_int64x2_t_from([1, 2])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vqshrun_n_s64::<16>(create_int64x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqshrun_n_s64::<16>(create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}
