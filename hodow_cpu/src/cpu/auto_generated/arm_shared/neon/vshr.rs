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

pub(super) fn test_arm_shared_neon_vshr_n_s8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vshr_n_s8::<1>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0, 1, 1, 2, 2, 3, 3, 4]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s8::<1>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s8::<1>(create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vshr_n_s8::<1>(create_int8x8_t_from([0, -1, 2, -3, 4, -5, 6, -7])));
        check_array_equality(&result, &[0, -1, 1, -2, 2, -3, 3, -4]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s8::<1>(create_int8x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s8::<1>(create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vshr_n_s8::<1>(create_int8x8_t_from([100, -56, 44, -112, -12, 88, -68, 32])));
        check_array_equality(&result, &[50, -28, 22, -56, -6, 44, -34, 16]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s8::<1>(create_int8x8_t_from([100, -56, 44, -112, -12, 88, -68, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s8::<1>(create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vshr_n_s8::<1>(create_int8x8_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-64, -64, -64, -64, -64, -64, -64, -64]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s8::<1>(create_int8x8_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s8::<1>(create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vshr_n_s8::<1>(create_int8x8_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[63, 63, 63, 63, 63, 63, 63, 63]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s8::<1>(create_int8x8_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s8::<1>(create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vshr_n_s8::<1>(create_int8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s8::<1>(create_int8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s8::<1>(create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vshr_n_s8::<1>(create_int8x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s8::<1>(create_int8x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s8::<1>(create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vshr_n_s8::<1>(create_int8x8_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-64, 63, 0, -1, -64, 63, 0, -1]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s8::<1>(create_int8x8_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s8::<1>(create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s8_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vshr_n_s8::<2>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0, 0, 0, 1, 1, 1, 1, 2]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s8::<2>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s8::<2>(create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s8_imm_8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vshr_n_s8::<8>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s8::<8>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s8::<8>(create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s8_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vshr_n_s8::<7>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s8::<7>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s8::<7>(create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s8_imm_4() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vshr_n_s8::<4>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s8::<4>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s8::<4>(create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vshr_n_s16::<1>(create_int16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 1, 1, 2]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s16::<1>(create_int16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s16::<1>(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vshr_n_s16::<1>(create_int16x4_t_from([0, -1, 2, -3])));
        check_array_equality(&result, &[0, -1, 1, -2]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s16::<1>(create_int16x4_t_from([0, -1, 2, -3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s16::<1>(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vshr_n_s16::<1>(create_int16x4_t_from([100, 200, 300, 400])));
        check_array_equality(&result, &[50, 100, 150, 200]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s16::<1>(create_int16x4_t_from([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s16::<1>(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vshr_n_s16::<1>(create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-16384, -16384, -16384, -16384]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s16::<1>(create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s16::<1>(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vshr_n_s16::<1>(create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[16383, 16383, 16383, 16383]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s16::<1>(create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s16::<1>(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vshr_n_s16::<1>(create_int16x4_t_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s16::<1>(create_int16x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s16::<1>(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vshr_n_s16::<1>(create_int16x4_t_from([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s16::<1>(create_int16x4_t_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s16::<1>(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vshr_n_s16::<1>(create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-16384, 16383, 0, -1]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s16::<1>(create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s16::<1>(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s16_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vshr_n_s16::<2>(create_int16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 0, 0, 1]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s16::<2>(create_int16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s16::<2>(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s16_imm_16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vshr_n_s16::<16>(create_int16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s16::<16>(create_int16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s16::<16>(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s16_imm_15() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vshr_n_s16::<15>(create_int16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s16::<15>(create_int16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s16::<15>(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s16_imm_8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vshr_n_s16::<8>(create_int16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s16::<8>(create_int16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s16::<8>(create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vshr_n_s32::<1>(create_int32x2_t_from([1, 2])));
        check_array_equality(&result, &[0, 1]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s32::<1>(create_int32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s32::<1>(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vshr_n_s32::<1>(create_int32x2_t_from([0, -1])));
        check_array_equality(&result, &[0, -1]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s32::<1>(create_int32x2_t_from([0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s32::<1>(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vshr_n_s32::<1>(create_int32x2_t_from([100, 200])));
        check_array_equality(&result, &[50, 100]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s32::<1>(create_int32x2_t_from([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s32::<1>(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vshr_n_s32::<1>(create_int32x2_t_from([i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-1073741824, -1073741824]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s32::<1>(create_int32x2_t_from([i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s32::<1>(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vshr_n_s32::<1>(create_int32x2_t_from([i32::MAX, i32::MAX])));
        check_array_equality(&result, &[1073741823, 1073741823]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s32::<1>(create_int32x2_t_from([i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s32::<1>(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vshr_n_s32::<1>(create_int32x2_t_from([0, 0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s32::<1>(create_int32x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s32::<1>(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vshr_n_s32::<1>(create_int32x2_t_from([-1, -1])));
        check_array_equality(&result, &[-1, -1]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s32::<1>(create_int32x2_t_from([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s32::<1>(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vshr_n_s32::<1>(create_int32x2_t_from([i32::MIN, i32::MAX])));
        check_array_equality(&result, &[-1073741824, 1073741823]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s32::<1>(create_int32x2_t_from([i32::MIN, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s32::<1>(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s32_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vshr_n_s32::<2>(create_int32x2_t_from([1, 2])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s32::<2>(create_int32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s32::<2>(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s32_imm_32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vshr_n_s32::<32>(create_int32x2_t_from([1, 2])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s32::<32>(create_int32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s32::<32>(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s32_imm_31() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vshr_n_s32::<31>(create_int32x2_t_from([1, 2])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s32::<31>(create_int32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s32::<31>(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s32_imm_16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vshr_n_s32::<16>(create_int32x2_t_from([1, 2])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s32::<16>(create_int32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s32::<16>(create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vshr_n_s64::<1>(create_int64x1_t_from([1])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s64::<1>(create_int64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s64::<1>(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vshr_n_s64::<1>(create_int64x1_t_from([0])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s64::<1>(create_int64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s64::<1>(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vshr_n_s64::<1>(create_int64x1_t_from([100])));
        check_array_equality(&result, &[50]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s64::<1>(create_int64x1_t_from([100]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s64::<1>(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vshr_n_s64::<1>(create_int64x1_t_from([i64::MIN])));
        check_array_equality(&result, &[-4611686018427387904]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s64::<1>(create_int64x1_t_from([i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s64::<1>(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vshr_n_s64::<1>(create_int64x1_t_from([i64::MAX])));
        check_array_equality(&result, &[4611686018427387903]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s64::<1>(create_int64x1_t_from([i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s64::<1>(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vshr_n_s64::<1>(create_int64x1_t_from([0])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s64::<1>(create_int64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s64::<1>(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vshr_n_s64::<1>(create_int64x1_t_from([-1])));
        check_array_equality(&result, &[-1]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s64::<1>(create_int64x1_t_from([-1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s64::<1>(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vshr_n_s64::<1>(create_int64x1_t_from([i64::MIN])));
        check_array_equality(&result, &[-4611686018427387904]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s64::<1>(create_int64x1_t_from([i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s64::<1>(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s64_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vshr_n_s64::<2>(create_int64x1_t_from([1])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s64::<2>(create_int64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s64::<2>(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s64_imm_64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vshr_n_s64::<64>(create_int64x1_t_from([1])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s64::<64>(create_int64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s64::<64>(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s64_imm_63() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vshr_n_s64::<63>(create_int64x1_t_from([1])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s64::<63>(create_int64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s64::<63>(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_s64_imm_32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vshr_n_s64::<32>(create_int64x1_t_from([1])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_s64::<32>(create_int64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_s64::<32>(create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vshr_n_u8::<1>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0, 1, 1, 2, 2, 3, 3, 4]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u8::<1>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u8::<1>(create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vshr_n_u8::<1>(create_uint8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249])));
        check_array_equality(&result, &[0, 127, 1, 126, 2, 125, 3, 124]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u8::<1>(create_uint8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u8::<1>(create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vshr_n_u8::<1>(create_uint8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32])));
        check_array_equality(&result, &[50, 100, 22, 72, 122, 44, 94, 16]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u8::<1>(create_uint8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u8::<1>(create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vshr_n_u8::<1>(create_uint8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u8::<1>(create_uint8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u8::<1>(create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vshr_n_u8::<1>(create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[127, 127, 127, 127, 127, 127, 127, 127]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u8::<1>(create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u8::<1>(create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vshr_n_u8::<1>(create_uint8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u8::<1>(create_uint8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u8::<1>(create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vshr_n_u8::<1>(create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[127, 127, 127, 127, 127, 127, 127, 127]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u8::<1>(create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u8::<1>(create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vshr_n_u8::<1>(create_uint8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX])));
        check_array_equality(&result, &[0, 127, 0, 127, 0, 127, 0, 127]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u8::<1>(create_uint8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u8::<1>(create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u8_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vshr_n_u8::<2>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0, 0, 0, 1, 1, 1, 1, 2]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u8::<2>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u8::<2>(create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u8_imm_8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vshr_n_u8::<8>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u8::<8>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u8::<8>(create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u8_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vshr_n_u8::<7>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u8::<7>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u8::<7>(create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u8_imm_4() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vshr_n_u8::<4>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u8::<4>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u8::<4>(create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vshr_n_u16::<1>(create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 1, 1, 2]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u16::<1>(create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u16::<1>(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vshr_n_u16::<1>(create_uint16x4_t_from([0, 65535, 2, 65533])));
        check_array_equality(&result, &[0, 32767, 1, 32766]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u16::<1>(create_uint16x4_t_from([0, 65535, 2, 65533]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u16::<1>(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vshr_n_u16::<1>(create_uint16x4_t_from([100, 200, 300, 400])));
        check_array_equality(&result, &[50, 100, 150, 200]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u16::<1>(create_uint16x4_t_from([100, 200, 300, 400]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u16::<1>(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vshr_n_u16::<1>(create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u16::<1>(create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u16::<1>(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vshr_n_u16::<1>(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u16::<1>(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u16::<1>(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vshr_n_u16::<1>(create_uint16x4_t_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u16::<1>(create_uint16x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u16::<1>(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vshr_n_u16::<1>(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u16::<1>(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u16::<1>(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vshr_n_u16::<1>(create_uint16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX])));
        check_array_equality(&result, &[0, 32767, 0, 32767]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u16::<1>(create_uint16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u16::<1>(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u16_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vshr_n_u16::<2>(create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 0, 0, 1]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u16::<2>(create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u16::<2>(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u16_imm_16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vshr_n_u16::<16>(create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u16::<16>(create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u16::<16>(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u16_imm_15() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vshr_n_u16::<15>(create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u16::<15>(create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u16::<15>(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u16_imm_8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vshr_n_u16::<8>(create_uint16x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u16::<8>(create_uint16x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u16::<8>(create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vshr_n_u32::<1>(create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[0, 1]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u32::<1>(create_uint32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u32::<1>(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vshr_n_u32::<1>(create_uint32x2_t_from([0, 4294967295])));
        check_array_equality(&result, &[0, 2147483647]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u32::<1>(create_uint32x2_t_from([0, 4294967295]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u32::<1>(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vshr_n_u32::<1>(create_uint32x2_t_from([100, 200])));
        check_array_equality(&result, &[50, 100]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u32::<1>(create_uint32x2_t_from([100, 200]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u32::<1>(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vshr_n_u32::<1>(create_uint32x2_t_from([u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u32::<1>(create_uint32x2_t_from([u32::MIN, u32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u32::<1>(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vshr_n_u32::<1>(create_uint32x2_t_from([u32::MAX, u32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u32::<1>(create_uint32x2_t_from([u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u32::<1>(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vshr_n_u32::<1>(create_uint32x2_t_from([0, 0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u32::<1>(create_uint32x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u32::<1>(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vshr_n_u32::<1>(create_uint32x2_t_from([u32::MAX, u32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u32::<1>(create_uint32x2_t_from([u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u32::<1>(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vshr_n_u32::<1>(create_uint32x2_t_from([u32::MIN, u32::MAX])));
        check_array_equality(&result, &[0, 2147483647]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u32::<1>(create_uint32x2_t_from([u32::MIN, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u32::<1>(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u32_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vshr_n_u32::<2>(create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u32::<2>(create_uint32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u32::<2>(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u32_imm_32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vshr_n_u32::<32>(create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u32::<32>(create_uint32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u32::<32>(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u32_imm_31() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vshr_n_u32::<31>(create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u32::<31>(create_uint32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u32::<31>(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u32_imm_16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vshr_n_u32::<16>(create_uint32x2_t_from([1, 2])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u32::<16>(create_uint32x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u32::<16>(create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vshr_n_u64::<1>(create_uint64x1_t_from([1])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u64::<1>(create_uint64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u64::<1>(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vshr_n_u64::<1>(create_uint64x1_t_from([0])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u64::<1>(create_uint64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u64::<1>(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vshr_n_u64::<1>(create_uint64x1_t_from([100])));
        check_array_equality(&result, &[50]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u64::<1>(create_uint64x1_t_from([100]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u64::<1>(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vshr_n_u64::<1>(create_uint64x1_t_from([u64::MIN])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u64::<1>(create_uint64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u64::<1>(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vshr_n_u64::<1>(create_uint64x1_t_from([u64::MAX])));
        check_array_equality(&result, &[9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u64::<1>(create_uint64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u64::<1>(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vshr_n_u64::<1>(create_uint64x1_t_from([0])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u64::<1>(create_uint64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u64::<1>(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vshr_n_u64::<1>(create_uint64x1_t_from([u64::MAX])));
        check_array_equality(&result, &[9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u64::<1>(create_uint64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u64::<1>(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vshr_n_u64::<1>(create_uint64x1_t_from([u64::MIN])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u64::<1>(create_uint64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u64::<1>(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u64_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vshr_n_u64::<2>(create_uint64x1_t_from([1])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u64::<2>(create_uint64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u64::<2>(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u64_imm_64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vshr_n_u64::<64>(create_uint64x1_t_from([1])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u64::<64>(create_uint64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u64::<64>(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u64_imm_63() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vshr_n_u64::<63>(create_uint64x1_t_from([1])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u64::<63>(create_uint64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u64::<63>(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vshr_n_u64_imm_32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vshr_n_u64::<32>(create_uint64x1_t_from([1])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vshr_n_u64::<32>(create_uint64x1_t_from([1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vshr_n_u64::<32>(create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}
