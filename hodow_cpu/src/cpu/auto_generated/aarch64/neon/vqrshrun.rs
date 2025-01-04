use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vqrshrun_high_n_s16::<1>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 5, 5, 6, 6, 7, 7, 8, 8]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s16::<1>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s16::<1>(create_random_uint8x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vqrshrun_high_n_s16::<1>(create_uint8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0, 255, 2, 253, 4, 251, 6, 249, 1, 1, 2, 2, 3, 3, 4, 4]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s16::<1>(create_uint8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s16::<1>(create_random_uint8x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vqrshrun_high_n_s16::<1>(create_uint8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[100, 200, 44, 144, 244, 88, 188, 32, 1, 1, 2, 2, 3, 3, 4, 4]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s16::<1>(create_uint8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s16::<1>(create_random_uint8x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vqrshrun_high_n_s16::<1>(create_uint8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s16::<1>(create_uint8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s16::<1>(create_random_uint8x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vqrshrun_high_n_s16::<1>(create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255, 1, 1, 2, 2, 3, 3, 4, 4]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s16::<1>(create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s16::<1>(create_random_uint8x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vqrshrun_high_n_s16::<1>(create_uint8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s16::<1>(create_uint8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s16::<1>(create_random_uint8x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vqrshrun_high_n_s16::<1>(create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255, 1, 1, 2, 2, 3, 3, 4, 4]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s16::<1>(create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s16::<1>(create_random_uint8x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vqrshrun_high_n_s16::<1>(create_uint8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0, 255, 0, 255, 0, 255, 0, 255, 1, 1, 2, 2, 3, 3, 4, 4]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s16::<1>(create_uint8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s16::<1>(create_random_uint8x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s16_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vqrshrun_high_n_s16::<2>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 2, 3, 3, 3, 3, 4, 4, 4]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s16::<2>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s16::<2>(create_random_uint8x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s16_imm_8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vqrshrun_high_n_s16::<8>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s16::<8>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s16::<8>(create_random_uint8x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s16_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vqrshrun_high_n_s16::<7>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s16::<7>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s16::<7>(create_random_uint8x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s16_imm_4() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vqrshrun_high_n_s16::<4>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1, 2, 3, 4, 5, 6, 7, 8, 1, 1, 1, 1, 1, 1, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s16::<4>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s16::<4>(create_random_uint8x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vqrshrun_high_n_s32::<1>(create_uint16x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 3, 3, 4, 4]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s32::<1>(create_uint16x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s32::<1>(create_random_uint16x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vqrshrun_high_n_s32::<1>(create_uint16x4_t_from([0, 65535, 2, 65533]), create_int32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 65535, 2, 65533, 1, 1, 2, 2]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s32::<1>(create_uint16x4_t_from([0, 65535, 2, 65533]), create_int32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s32::<1>(create_random_uint16x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vqrshrun_high_n_s32::<1>(create_uint16x4_t_from([100, 200, 300, 400]), create_int32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[100, 200, 300, 400, 1, 1, 2, 2]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s32::<1>(create_uint16x4_t_from([100, 200, 300, 400]), create_int32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s32::<1>(create_random_uint16x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vqrshrun_high_n_s32::<1>(create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_int32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 0, 0, 0, 1, 1, 2, 2]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s32::<1>(create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_int32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s32::<1>(create_random_uint16x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vqrshrun_high_n_s32::<1>(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_int32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 1, 1, 2, 2]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s32::<1>(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_int32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s32::<1>(create_random_uint16x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vqrshrun_high_n_s32::<1>(create_uint16x4_t_from([0, 0, 0, 0]), create_int32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 0, 0, 0, 1, 1, 2, 2]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s32::<1>(create_uint16x4_t_from([0, 0, 0, 0]), create_int32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s32::<1>(create_random_uint16x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vqrshrun_high_n_s32::<1>(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_int32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 1, 1, 2, 2]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s32::<1>(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_int32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s32::<1>(create_random_uint16x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vqrshrun_high_n_s32::<1>(create_uint16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]), create_int32x4_t_from([1, 2, 3, 4])));
        check_array_equality(&result, &[0, 65535, 0, 65535, 1, 1, 2, 2]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s32::<1>(create_uint16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]), create_int32x4_t_from([1, 2, 3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s32::<1>(create_random_uint16x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s32_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vqrshrun_high_n_s32::<2>(create_uint16x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 1, 2, 2, 2]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s32::<2>(create_uint16x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s32::<2>(create_random_uint16x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s32_imm_16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vqrshrun_high_n_s32::<16>(create_uint16x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s32::<16>(create_uint16x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s32::<16>(create_random_uint16x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s32_imm_15() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vqrshrun_high_n_s32::<15>(create_uint16x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s32::<15>(create_uint16x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s32::<15>(create_random_uint16x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s32_imm_8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vqrshrun_high_n_s32::<8>(create_uint16x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[1, 2, 3, 4, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s32::<8>(create_uint16x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s32::<8>(create_random_uint16x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vqrshrun_high_n_s64::<1>(create_uint32x2_t_from([1, 2]), create_int64x2_t_from([3, 4])));
        check_array_equality(&result, &[1, 2, 2, 2]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s64::<1>(create_uint32x2_t_from([1, 2]), create_int64x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s64::<1>(create_random_uint32x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vqrshrun_high_n_s64::<1>(create_uint32x2_t_from([0, 4294967295]), create_int64x2_t_from([1, 2])));
        check_array_equality(&result, &[0, 4294967295, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s64::<1>(create_uint32x2_t_from([0, 4294967295]), create_int64x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s64::<1>(create_random_uint32x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vqrshrun_high_n_s64::<1>(create_uint32x2_t_from([100, 200]), create_int64x2_t_from([1, 2])));
        check_array_equality(&result, &[100, 200, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s64::<1>(create_uint32x2_t_from([100, 200]), create_int64x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s64::<1>(create_random_uint32x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vqrshrun_high_n_s64::<1>(create_uint32x2_t_from([u32::MIN, u32::MIN]), create_int64x2_t_from([1, 2])));
        check_array_equality(&result, &[0, 0, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s64::<1>(create_uint32x2_t_from([u32::MIN, u32::MIN]), create_int64x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s64::<1>(create_random_uint32x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vqrshrun_high_n_s64::<1>(create_uint32x2_t_from([u32::MAX, u32::MAX]), create_int64x2_t_from([1, 2])));
        check_array_equality(&result, &[4294967295, 4294967295, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s64::<1>(create_uint32x2_t_from([u32::MAX, u32::MAX]), create_int64x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s64::<1>(create_random_uint32x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vqrshrun_high_n_s64::<1>(create_uint32x2_t_from([0, 0]), create_int64x2_t_from([1, 2])));
        check_array_equality(&result, &[0, 0, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s64::<1>(create_uint32x2_t_from([0, 0]), create_int64x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s64::<1>(create_random_uint32x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vqrshrun_high_n_s64::<1>(create_uint32x2_t_from([u32::MAX, u32::MAX]), create_int64x2_t_from([1, 2])));
        check_array_equality(&result, &[4294967295, 4294967295, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s64::<1>(create_uint32x2_t_from([u32::MAX, u32::MAX]), create_int64x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s64::<1>(create_random_uint32x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vqrshrun_high_n_s64::<1>(create_uint32x2_t_from([u32::MIN, u32::MAX]), create_int64x2_t_from([1, 2])));
        check_array_equality(&result, &[0, 4294967295, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s64::<1>(create_uint32x2_t_from([u32::MIN, u32::MAX]), create_int64x2_t_from([1, 2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s64::<1>(create_random_uint32x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s64_imm_2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vqrshrun_high_n_s64::<2>(create_uint32x2_t_from([1, 2]), create_int64x2_t_from([3, 4])));
        check_array_equality(&result, &[1, 2, 1, 1]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s64::<2>(create_uint32x2_t_from([1, 2]), create_int64x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s64::<2>(create_random_uint32x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s64_imm_32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vqrshrun_high_n_s64::<32>(create_uint32x2_t_from([1, 2]), create_int64x2_t_from([3, 4])));
        check_array_equality(&result, &[1, 2, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s64::<32>(create_uint32x2_t_from([1, 2]), create_int64x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s64::<32>(create_random_uint32x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s64_imm_31() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vqrshrun_high_n_s64::<31>(create_uint32x2_t_from([1, 2]), create_int64x2_t_from([3, 4])));
        check_array_equality(&result, &[1, 2, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s64::<31>(create_uint32x2_t_from([1, 2]), create_int64x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s64::<31>(create_random_uint32x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vqrshrun_high_n_s64_imm_16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vqrshrun_high_n_s64::<16>(create_uint32x2_t_from([1, 2]), create_int64x2_t_from([3, 4])));
        check_array_equality(&result, &[1, 2, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vqrshrun_high_n_s64::<16>(create_uint32x2_t_from([1, 2]), create_int64x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vqrshrun_high_n_s64::<16>(create_random_uint32x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}
