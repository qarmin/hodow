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

pub(super) fn test_arm_shared_neon_vcreate_f32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcreate_f32(1u64));
        check_float_array_equality(&result, &[1e-45, 0.0]).map_err(|e| crate::cpu::with_call(e, "vcreate_f32(1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcreate_f32(rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcreate_s8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vcreate_s8(1u64));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcreate_s8(1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcreate_s8(rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcreate_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vcreate_s16(1u64));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcreate_s16(1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcreate_s16(rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcreate_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcreate_s32(1u64));
        check_array_equality(&result, &[1, 0]).map_err(|e| crate::cpu::with_call(e, "vcreate_s32(1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcreate_s32(rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcreate_s64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcreate_s64(1u64));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "vcreate_s64(1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcreate_s64(rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcreate_u8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vcreate_u8(1u64));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcreate_u8(1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcreate_u8(rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcreate_u16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vcreate_u16(1u64));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcreate_u16(1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcreate_u16(rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcreate_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcreate_u32(1u64));
        check_array_equality(&result, &[1, 0]).map_err(|e| crate::cpu::with_call(e, "vcreate_u32(1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcreate_u32(rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcreate_u64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcreate_u64(1u64));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "vcreate_u64(1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcreate_u64(rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcreate_p8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vcreate_p8(1u64));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcreate_p8(1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcreate_p8(rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vcreate_p16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vcreate_p16(1u64));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcreate_p16(1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcreate_p16(rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}
