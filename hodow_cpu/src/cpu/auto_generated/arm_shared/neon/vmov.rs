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

pub(super) fn test_arm_shared_neon_vmov_n_f32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vmov_n_f32(1.0f32));
        check_float_array_equality(&result, &[1.0, 1.0]).map_err(|e| crate::cpu::with_call(e, "vmov_n_f32(1.0f32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmov_n_f32(rand::random::<f32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmov_n_p16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vmov_n_p16(1u16));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vmov_n_p16(1u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmov_n_p16(rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmov_n_p8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vmov_n_p8(1u8));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vmov_n_p8(1u8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmov_n_p8(rand::random::<u8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmov_n_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vmov_n_s16(1i16));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vmov_n_s16(1i16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmov_n_s16(rand::random::<i16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmov_n_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vmov_n_s32(1i32));
        check_array_equality(&result, &[1, 1]).map_err(|e| crate::cpu::with_call(e, "vmov_n_s32(1i32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmov_n_s32(rand::random::<i32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmov_n_s64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vmov_n_s64(1i64));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "vmov_n_s64(1i64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmov_n_s64(rand::random::<i64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmov_n_s8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vmov_n_s8(1i8));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vmov_n_s8(1i8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmov_n_s8(rand::random::<i8>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmov_n_u16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vmov_n_u16(1u16));
        check_array_equality(&result, &[1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vmov_n_u16(1u16)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmov_n_u16(rand::random::<u16>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmov_n_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vmov_n_u32(1u32));
        check_array_equality(&result, &[1, 1]).map_err(|e| crate::cpu::with_call(e, "vmov_n_u32(1u32)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmov_n_u32(rand::random::<u32>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmov_n_u64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vmov_n_u64(1u64));
        check_array_equality(&result, &[1]).map_err(|e| crate::cpu::with_call(e, "vmov_n_u64(1u64)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmov_n_u64(rand::random::<u64>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_neon_vmov_n_u8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vmov_n_u8(1u8));
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vmov_n_u8(1u8)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vmov_n_u8(rand::random::<u8>());
        });
        Ok(Verdict::Checked)
    }
}
