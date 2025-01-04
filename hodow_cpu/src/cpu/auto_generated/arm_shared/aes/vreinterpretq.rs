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

pub(super) fn test_arm_shared_aes_vreinterpretq_s8_p128() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vreinterpretq_s8_p128(1u128));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s8_p128(1u128)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s8_p128(rand::random::<u128>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_aes_vreinterpretq_s16_p128() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vreinterpretq_s16_p128(1u128));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s16_p128(1u128)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s16_p128(rand::random::<u128>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_aes_vreinterpretq_s32_p128() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vreinterpretq_s32_p128(1u128));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s32_p128(1u128)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s32_p128(rand::random::<u128>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_aes_vreinterpretq_s64_p128() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vreinterpretq_s64_p128(1u128));
        check_array_equality(&result, &[1, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_s64_p128(1u128)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_s64_p128(rand::random::<u128>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_aes_vreinterpretq_u8_p128() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vreinterpretq_u8_p128(1u128));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u8_p128(1u128)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u8_p128(rand::random::<u128>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_aes_vreinterpretq_u16_p128() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vreinterpretq_u16_p128(1u128));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u16_p128(1u128)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u16_p128(rand::random::<u128>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_aes_vreinterpretq_u32_p128() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vreinterpretq_u32_p128(1u128));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u32_p128(1u128)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u32_p128(rand::random::<u128>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_aes_vreinterpretq_u64_p128() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vreinterpretq_u64_p128(1u128));
        check_array_equality(&result, &[1, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_u64_p128(1u128)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_u64_p128(rand::random::<u128>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_aes_vreinterpretq_p8_p128() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vreinterpretq_p8_p128(1u128));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p8_p128(1u128)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p8_p128(rand::random::<u128>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_aes_vreinterpretq_p16_p128() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vreinterpretq_p16_p128(1u128));
        check_array_equality(&result, &[1, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p16_p128(1u128)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p16_p128(rand::random::<u128>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_aes_vreinterpretq_p64_p128() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x2_t_to_u64_array(vreinterpretq_p64_p128(1u128));
        check_array_equality(&result, &[1, 0]).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p64_p128(1u128)"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p64_p128(rand::random::<u128>());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_arm_shared_aes_vreinterpretq_p128_p64() -> Result<Verdict, String> {
    unsafe {
        let result = vreinterpretq_p128_p64(create_poly64x2_t_from([1, 2]));
        check_int_equality(result, 36893488147419103233).map_err(|e| crate::cpu::with_call(e, "vreinterpretq_p128_p64(create_poly64x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vreinterpretq_p128_p64(create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}
