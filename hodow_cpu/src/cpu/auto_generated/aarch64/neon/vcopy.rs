use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vcopy_lane_f32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcopy_lane_f32::<0, 0>(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0])));
        check_float_array_equality(&result, &[3.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_f32::<0, 0>(create_float32x2_t_from([1.0, 2.0]), create_float32x2_t_from([3.0, 4.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_f32::<0, 0>(create_random_float32x2_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_f32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcopy_lane_f32::<0, 0>(create_float32x2_t_from([0.0f32, -1.0f32]), create_float32x2_t_from([10.0f32, 9.0f32])));
        check_float_array_equality(&result, &[10.0, -1.0]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_f32::<0, 0>(create_float32x2_t_from([0.0f32, -1.0f32]), create_float32x2_t_from([10.0f32, 9.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_f32::<0, 0>(create_random_float32x2_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_f32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcopy_lane_f32::<0, 0>(create_float32x2_t_from([100.0f32, 200.0f32]), create_float32x2_t_from([110.0f32, 210.0f32])));
        check_float_array_equality(&result, &[110.0, 200.0]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_f32::<0, 0>(create_float32x2_t_from([100.0f32, 200.0f32]), create_float32x2_t_from([110.0f32, 210.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_f32::<0, 0>(create_random_float32x2_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_f32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcopy_lane_f32::<0, 0>(create_float32x2_t_from([f32::MIN, f32::MIN]), create_float32x2_t_from([f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_f32::<0, 0>(create_float32x2_t_from([f32::MIN, f32::MIN]), create_float32x2_t_from([f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_f32::<0, 0>(create_random_float32x2_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_f32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcopy_lane_f32::<0, 0>(create_float32x2_t_from([f32::MAX, f32::MAX]), create_float32x2_t_from([f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_f32::<0, 0>(create_float32x2_t_from([f32::MAX, f32::MAX]), create_float32x2_t_from([f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_f32::<0, 0>(create_random_float32x2_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_f32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcopy_lane_f32::<0, 0>(create_float32x2_t_from([0.0, 0.0]), create_float32x2_t_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_f32::<0, 0>(create_float32x2_t_from([0.0, 0.0]), create_float32x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_f32::<0, 0>(create_random_float32x2_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_f32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcopy_lane_f32::<0, 0>(create_float32x2_t_from([f32::NAN, f32::NAN]), create_float32x2_t_from([f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_f32::<0, 0>(create_float32x2_t_from([f32::NAN, f32::NAN]), create_float32x2_t_from([f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_f32::<0, 0>(create_random_float32x2_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_f32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcopy_lane_f32::<0, 0>(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]), create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_f32::<0, 0>(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]), create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_f32::<0, 0>(create_random_float32x2_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_f32_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcopy_lane_f32::<0, 0>(create_float32x2_t_from([f32::MIN, f32::MIN]), create_float32x2_t_from([f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, -3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_f32::<0, 0>(create_float32x2_t_from([f32::MIN, f32::MIN]), create_float32x2_t_from([f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_f32::<0, 0>(create_random_float32x2_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_f32_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcopy_lane_f32::<0, 0>(create_float32x2_t_from([f32::MAX, f32::MAX]), create_float32x2_t_from([f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, 3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_f32::<0, 0>(create_float32x2_t_from([f32::MAX, f32::MAX]), create_float32x2_t_from([f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_f32::<0, 0>(create_random_float32x2_t(), create_random_float32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vcopy_lane_s8::<0, 0>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s8::<0, 0>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s8::<0, 0>(create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vcopy_lane_s8::<0, 0>(create_int8x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int8x8_t_from([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, -1, 2, -3, 4, -5, 6, -7]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s8::<0, 0>(create_int8x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int8x8_t_from([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s8::<0, 0>(create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vcopy_lane_s8::<0, 0>(create_int8x8_t_from([100, -56, 44, -112, -12, 88, -68, 32]), create_int8x8_t_from([110, -46, 54, -102, -2, 98, -58, 42])));
        check_array_equality(&result, &[110, -56, 44, -112, -12, 88, -68, 32]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s8::<0, 0>(create_int8x8_t_from([100, -56, 44, -112, -12, 88, -68, 32]), create_int8x8_t_from([110, -46, 54, -102, -2, 98, -58, 42]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s8::<0, 0>(create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vcopy_lane_s8::<0, 0>(create_int8x8_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create_int8x8_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, -128, -128, -128, -128, -128, -128, -128]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s8::<0, 0>(create_int8x8_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create_int8x8_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s8::<0, 0>(create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vcopy_lane_s8::<0, 0>(create_int8x8_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create_int8x8_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, 127, 127, 127, 127, 127, 127, 127]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s8::<0, 0>(create_int8x8_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create_int8x8_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s8::<0, 0>(create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vcopy_lane_s8::<0, 0>(create_int8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s8::<0, 0>(create_int8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s8::<0, 0>(create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vcopy_lane_s8::<0, 0>(create_int8x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int8x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s8::<0, 0>(create_int8x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int8x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s8::<0, 0>(create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vcopy_lane_s8::<0, 0>(create_int8x8_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create_int8x8_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-128, 127, 0, -1, -128, 127, 0, -1]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s8::<0, 0>(create_int8x8_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create_int8x8_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s8::<0, 0>(create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s8_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vcopy_lane_s8::<0, 0>(create_int8x8_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create_int8x8_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, -128, -128, -128, -128, -128, -128, -128]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s8::<0, 0>(create_int8x8_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create_int8x8_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s8::<0, 0>(create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s8_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vcopy_lane_s8::<0, 0>(create_int8x8_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create_int8x8_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, 127, 127, 127, 127, 127, 127, 127]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s8::<0, 0>(create_int8x8_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create_int8x8_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s8::<0, 0>(create_random_int8x8_t(), create_random_int8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vcopy_lane_s16::<0, 0>(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 2, 3, 4]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s16::<0, 0>(create_int16x4_t_from([1, 2, 3, 4]), create_int16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s16::<0, 0>(create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vcopy_lane_s16::<0, 0>(create_int16x4_t_from([0, -1, 2, -3]), create_int16x4_t_from([10, 9, 12, 7])));
        check_array_equality(&result, &[10, -1, 2, -3]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s16::<0, 0>(create_int16x4_t_from([0, -1, 2, -3]), create_int16x4_t_from([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s16::<0, 0>(create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vcopy_lane_s16::<0, 0>(create_int16x4_t_from([100, 200, 300, 400]), create_int16x4_t_from([110, 210, 310, 410])));
        check_array_equality(&result, &[110, 200, 300, 400]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s16::<0, 0>(create_int16x4_t_from([100, 200, 300, 400]), create_int16x4_t_from([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s16::<0, 0>(create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vcopy_lane_s16::<0, 0>(create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s16::<0, 0>(create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s16::<0, 0>(create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vcopy_lane_s16::<0, 0>(create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s16::<0, 0>(create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s16::<0, 0>(create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vcopy_lane_s16::<0, 0>(create_int16x4_t_from([0, 0, 0, 0]), create_int16x4_t_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s16::<0, 0>(create_int16x4_t_from([0, 0, 0, 0]), create_int16x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s16::<0, 0>(create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vcopy_lane_s16::<0, 0>(create_int16x4_t_from([-1, -1, -1, -1]), create_int16x4_t_from([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s16::<0, 0>(create_int16x4_t_from([-1, -1, -1, -1]), create_int16x4_t_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s16::<0, 0>(create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vcopy_lane_s16::<0, 0>(create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1]), create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, 32767, 0, -1]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s16::<0, 0>(create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1]), create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s16::<0, 0>(create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s16_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vcopy_lane_s16::<0, 0>(create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, -32768, -32768, -32768]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s16::<0, 0>(create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s16::<0, 0>(create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s16_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vcopy_lane_s16::<0, 0>(create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, 32767, 32767, 32767]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s16::<0, 0>(create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s16::<0, 0>(create_random_int16x4_t(), create_random_int16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcopy_lane_s32::<0, 0>(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4])));
        check_array_equality(&result, &[3, 2]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s32::<0, 0>(create_int32x2_t_from([1, 2]), create_int32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s32::<0, 0>(create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcopy_lane_s32::<0, 0>(create_int32x2_t_from([0, -1]), create_int32x2_t_from([10, 9])));
        check_array_equality(&result, &[10, -1]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s32::<0, 0>(create_int32x2_t_from([0, -1]), create_int32x2_t_from([10, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s32::<0, 0>(create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcopy_lane_s32::<0, 0>(create_int32x2_t_from([100, 200]), create_int32x2_t_from([110, 210])));
        check_array_equality(&result, &[110, 200]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s32::<0, 0>(create_int32x2_t_from([100, 200]), create_int32x2_t_from([110, 210]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s32::<0, 0>(create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcopy_lane_s32::<0, 0>(create_int32x2_t_from([i32::MIN, i32::MIN]), create_int32x2_t_from([i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s32::<0, 0>(create_int32x2_t_from([i32::MIN, i32::MIN]), create_int32x2_t_from([i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s32::<0, 0>(create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcopy_lane_s32::<0, 0>(create_int32x2_t_from([i32::MAX, i32::MAX]), create_int32x2_t_from([i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s32::<0, 0>(create_int32x2_t_from([i32::MAX, i32::MAX]), create_int32x2_t_from([i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s32::<0, 0>(create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcopy_lane_s32::<0, 0>(create_int32x2_t_from([0, 0]), create_int32x2_t_from([0, 0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s32::<0, 0>(create_int32x2_t_from([0, 0]), create_int32x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s32::<0, 0>(create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcopy_lane_s32::<0, 0>(create_int32x2_t_from([-1, -1]), create_int32x2_t_from([-1, -1])));
        check_array_equality(&result, &[-1, -1]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s32::<0, 0>(create_int32x2_t_from([-1, -1]), create_int32x2_t_from([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s32::<0, 0>(create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcopy_lane_s32::<0, 0>(create_int32x2_t_from([i32::MIN, i32::MAX]), create_int32x2_t_from([i32::MIN, i32::MAX])));
        check_array_equality(&result, &[-2147483648, 2147483647]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s32::<0, 0>(create_int32x2_t_from([i32::MIN, i32::MAX]), create_int32x2_t_from([i32::MIN, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s32::<0, 0>(create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s32_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcopy_lane_s32::<0, 0>(create_int32x2_t_from([i32::MIN, i32::MIN]), create_int32x2_t_from([i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, -2147483648]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s32::<0, 0>(create_int32x2_t_from([i32::MIN, i32::MIN]), create_int32x2_t_from([i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s32::<0, 0>(create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s32_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcopy_lane_s32::<0, 0>(create_int32x2_t_from([i32::MAX, i32::MAX]), create_int32x2_t_from([i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, 2147483647]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s32::<0, 0>(create_int32x2_t_from([i32::MAX, i32::MAX]), create_int32x2_t_from([i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s32::<0, 0>(create_random_int32x2_t(), create_random_int32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vcopy_lane_u8::<0, 0>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u8::<0, 0>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u8::<0, 0>(create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vcopy_lane_u8::<0, 0>(create_uint8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249]), create_uint8x8_t_from([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, 255, 2, 253, 4, 251, 6, 249]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u8::<0, 0>(create_uint8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249]), create_uint8x8_t_from([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u8::<0, 0>(create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vcopy_lane_u8::<0, 0>(create_uint8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32]), create_uint8x8_t_from([110, 210, 54, 154, 254, 98, 198, 42])));
        check_array_equality(&result, &[110, 200, 44, 144, 244, 88, 188, 32]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u8::<0, 0>(create_uint8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32]), create_uint8x8_t_from([110, 210, 54, 154, 254, 98, 198, 42]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u8::<0, 0>(create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vcopy_lane_u8::<0, 0>(create_uint8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_uint8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u8::<0, 0>(create_uint8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_uint8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u8::<0, 0>(create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vcopy_lane_u8::<0, 0>(create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u8::<0, 0>(create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u8::<0, 0>(create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vcopy_lane_u8::<0, 0>(create_uint8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u8::<0, 0>(create_uint8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u8::<0, 0>(create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vcopy_lane_u8::<0, 0>(create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u8::<0, 0>(create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u8::<0, 0>(create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vcopy_lane_u8::<0, 0>(create_uint8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create_uint8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX])));
        check_array_equality(&result, &[0, 255, 0, 255, 0, 255, 0, 255]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u8::<0, 0>(create_uint8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create_uint8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u8::<0, 0>(create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u8_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vcopy_lane_u8::<0, 0>(create_uint8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[255, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u8::<0, 0>(create_uint8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u8::<0, 0>(create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u8_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vcopy_lane_u8::<0, 0>(create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[0, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u8::<0, 0>(create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u8::<0, 0>(create_random_uint8x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vcopy_lane_u16::<0, 0>(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 2, 3, 4]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u16::<0, 0>(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u16::<0, 0>(create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vcopy_lane_u16::<0, 0>(create_uint16x4_t_from([0, 65535, 2, 65533]), create_uint16x4_t_from([10, 9, 12, 7])));
        check_array_equality(&result, &[10, 65535, 2, 65533]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u16::<0, 0>(create_uint16x4_t_from([0, 65535, 2, 65533]), create_uint16x4_t_from([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u16::<0, 0>(create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vcopy_lane_u16::<0, 0>(create_uint16x4_t_from([100, 200, 300, 400]), create_uint16x4_t_from([110, 210, 310, 410])));
        check_array_equality(&result, &[110, 200, 300, 400]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u16::<0, 0>(create_uint16x4_t_from([100, 200, 300, 400]), create_uint16x4_t_from([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u16::<0, 0>(create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vcopy_lane_u16::<0, 0>(create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u16::<0, 0>(create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u16::<0, 0>(create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vcopy_lane_u16::<0, 0>(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u16::<0, 0>(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u16::<0, 0>(create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vcopy_lane_u16::<0, 0>(create_uint16x4_t_from([0, 0, 0, 0]), create_uint16x4_t_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u16::<0, 0>(create_uint16x4_t_from([0, 0, 0, 0]), create_uint16x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u16::<0, 0>(create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vcopy_lane_u16::<0, 0>(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u16::<0, 0>(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u16::<0, 0>(create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vcopy_lane_u16::<0, 0>(create_uint16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]), create_uint16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX])));
        check_array_equality(&result, &[0, 65535, 0, 65535]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u16::<0, 0>(create_uint16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]), create_uint16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u16::<0, 0>(create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u16_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vcopy_lane_u16::<0, 0>(create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u16::<0, 0>(create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u16::<0, 0>(create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u16_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vcopy_lane_u16::<0, 0>(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[0, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u16::<0, 0>(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u16::<0, 0>(create_random_uint16x4_t(), create_random_uint16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcopy_lane_u32::<0, 0>(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4])));
        check_array_equality(&result, &[3, 2]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u32::<0, 0>(create_uint32x2_t_from([1, 2]), create_uint32x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u32::<0, 0>(create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcopy_lane_u32::<0, 0>(create_uint32x2_t_from([0, 4294967295]), create_uint32x2_t_from([10, 9])));
        check_array_equality(&result, &[10, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u32::<0, 0>(create_uint32x2_t_from([0, 4294967295]), create_uint32x2_t_from([10, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u32::<0, 0>(create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcopy_lane_u32::<0, 0>(create_uint32x2_t_from([100, 200]), create_uint32x2_t_from([110, 210])));
        check_array_equality(&result, &[110, 200]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u32::<0, 0>(create_uint32x2_t_from([100, 200]), create_uint32x2_t_from([110, 210]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u32::<0, 0>(create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcopy_lane_u32::<0, 0>(create_uint32x2_t_from([u32::MIN, u32::MIN]), create_uint32x2_t_from([u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u32::<0, 0>(create_uint32x2_t_from([u32::MIN, u32::MIN]), create_uint32x2_t_from([u32::MIN, u32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u32::<0, 0>(create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcopy_lane_u32::<0, 0>(create_uint32x2_t_from([u32::MAX, u32::MAX]), create_uint32x2_t_from([u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967295, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u32::<0, 0>(create_uint32x2_t_from([u32::MAX, u32::MAX]), create_uint32x2_t_from([u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u32::<0, 0>(create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcopy_lane_u32::<0, 0>(create_uint32x2_t_from([0, 0]), create_uint32x2_t_from([0, 0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u32::<0, 0>(create_uint32x2_t_from([0, 0]), create_uint32x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u32::<0, 0>(create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcopy_lane_u32::<0, 0>(create_uint32x2_t_from([u32::MAX, u32::MAX]), create_uint32x2_t_from([u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967295, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u32::<0, 0>(create_uint32x2_t_from([u32::MAX, u32::MAX]), create_uint32x2_t_from([u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u32::<0, 0>(create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcopy_lane_u32::<0, 0>(create_uint32x2_t_from([u32::MIN, u32::MAX]), create_uint32x2_t_from([u32::MIN, u32::MAX])));
        check_array_equality(&result, &[0, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u32::<0, 0>(create_uint32x2_t_from([u32::MIN, u32::MAX]), create_uint32x2_t_from([u32::MIN, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u32::<0, 0>(create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u32_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcopy_lane_u32::<0, 0>(create_uint32x2_t_from([u32::MIN, u32::MIN]), create_uint32x2_t_from([u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967295, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u32::<0, 0>(create_uint32x2_t_from([u32::MIN, u32::MIN]), create_uint32x2_t_from([u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u32::<0, 0>(create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u32_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcopy_lane_u32::<0, 0>(create_uint32x2_t_from([u32::MAX, u32::MAX]), create_uint32x2_t_from([u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u32::<0, 0>(create_uint32x2_t_from([u32::MAX, u32::MAX]), create_uint32x2_t_from([u32::MIN, u32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u32::<0, 0>(create_random_uint32x2_t(), create_random_uint32x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_p8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vcopy_lane_p8::<0, 0>(create_poly8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_poly8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_p8::<0, 0>(create_poly8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_poly8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_p8::<0, 0>(create_random_poly8x8_t(), create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_p8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vcopy_lane_p8::<0, 0>(create_poly8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249]), create_poly8x8_t_from([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, 255, 2, 253, 4, 251, 6, 249]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_p8::<0, 0>(create_poly8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249]), create_poly8x8_t_from([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_p8::<0, 0>(create_random_poly8x8_t(), create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_p8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vcopy_lane_p8::<0, 0>(create_poly8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32]), create_poly8x8_t_from([110, 210, 54, 154, 254, 98, 198, 42])));
        check_array_equality(&result, &[110, 200, 44, 144, 244, 88, 188, 32]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_p8::<0, 0>(create_poly8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32]), create_poly8x8_t_from([110, 210, 54, 154, 254, 98, 198, 42]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_p8::<0, 0>(create_random_poly8x8_t(), create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_p8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vcopy_lane_p8::<0, 0>(create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_p8::<0, 0>(create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_p8::<0, 0>(create_random_poly8x8_t(), create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_p8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vcopy_lane_p8::<0, 0>(create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_p8::<0, 0>(create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_p8::<0, 0>(create_random_poly8x8_t(), create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_p8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vcopy_lane_p8::<0, 0>(create_poly8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_poly8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_p8::<0, 0>(create_poly8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_poly8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_p8::<0, 0>(create_random_poly8x8_t(), create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_p8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vcopy_lane_p8::<0, 0>(create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_p8::<0, 0>(create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_p8::<0, 0>(create_random_poly8x8_t(), create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_p8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vcopy_lane_p8::<0, 0>(create_poly8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create_poly8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX])));
        check_array_equality(&result, &[0, 255, 0, 255, 0, 255, 0, 255]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_p8::<0, 0>(create_poly8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create_poly8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_p8::<0, 0>(create_random_poly8x8_t(), create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_p8_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vcopy_lane_p8::<0, 0>(create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[255, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_p8::<0, 0>(create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_p8::<0, 0>(create_random_poly8x8_t(), create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_p8_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vcopy_lane_p8::<0, 0>(create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[0, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_p8::<0, 0>(create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_p8::<0, 0>(create_random_poly8x8_t(), create_random_poly8x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_p16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vcopy_lane_p16::<0, 0>(create_poly16x4_t_from([1, 2, 3, 4]), create_poly16x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 2, 3, 4]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_p16::<0, 0>(create_poly16x4_t_from([1, 2, 3, 4]), create_poly16x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_p16::<0, 0>(create_random_poly16x4_t(), create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_p16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vcopy_lane_p16::<0, 0>(create_poly16x4_t_from([0, 65535, 2, 65533]), create_poly16x4_t_from([10, 9, 12, 7])));
        check_array_equality(&result, &[10, 65535, 2, 65533]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_p16::<0, 0>(create_poly16x4_t_from([0, 65535, 2, 65533]), create_poly16x4_t_from([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_p16::<0, 0>(create_random_poly16x4_t(), create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_p16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vcopy_lane_p16::<0, 0>(create_poly16x4_t_from([100, 200, 300, 400]), create_poly16x4_t_from([110, 210, 310, 410])));
        check_array_equality(&result, &[110, 200, 300, 400]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_p16::<0, 0>(create_poly16x4_t_from([100, 200, 300, 400]), create_poly16x4_t_from([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_p16::<0, 0>(create_random_poly16x4_t(), create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_p16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vcopy_lane_p16::<0, 0>(create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_p16::<0, 0>(create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_p16::<0, 0>(create_random_poly16x4_t(), create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_p16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vcopy_lane_p16::<0, 0>(create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_p16::<0, 0>(create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_p16::<0, 0>(create_random_poly16x4_t(), create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_p16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vcopy_lane_p16::<0, 0>(create_poly16x4_t_from([0, 0, 0, 0]), create_poly16x4_t_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_p16::<0, 0>(create_poly16x4_t_from([0, 0, 0, 0]), create_poly16x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_p16::<0, 0>(create_random_poly16x4_t(), create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_p16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vcopy_lane_p16::<0, 0>(create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_p16::<0, 0>(create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_p16::<0, 0>(create_random_poly16x4_t(), create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_p16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vcopy_lane_p16::<0, 0>(create_poly16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]), create_poly16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX])));
        check_array_equality(&result, &[0, 65535, 0, 65535]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_p16::<0, 0>(create_poly16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]), create_poly16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_p16::<0, 0>(create_random_poly16x4_t(), create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_p16_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vcopy_lane_p16::<0, 0>(create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_p16::<0, 0>(create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_p16::<0, 0>(create_random_poly16x4_t(), create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_p16_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vcopy_lane_p16::<0, 0>(create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[0, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_p16::<0, 0>(create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_p16::<0, 0>(create_random_poly16x4_t(), create_random_poly16x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcopy_lane_f64::<0, 0>(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0])));
        check_float_array_equality(&result, &[2.0]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_f64::<0, 0>(create_float64x1_t_from([1.0]), create_float64x1_t_from([2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_f64::<0, 0>(create_random_float64x1_t(), create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcopy_lane_f64::<0, 0>(create_float64x1_t_from([0.0f64]), create_float64x1_t_from([10.0f64])));
        check_float_array_equality(&result, &[10.0]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_f64::<0, 0>(create_float64x1_t_from([0.0f64]), create_float64x1_t_from([10.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_f64::<0, 0>(create_random_float64x1_t(), create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcopy_lane_f64::<0, 0>(create_float64x1_t_from([100.0f64]), create_float64x1_t_from([110.0f64])));
        check_float_array_equality(&result, &[110.0]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_f64::<0, 0>(create_float64x1_t_from([100.0f64]), create_float64x1_t_from([110.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_f64::<0, 0>(create_random_float64x1_t(), create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcopy_lane_f64::<0, 0>(create_float64x1_t_from([f64::MIN]), create_float64x1_t_from([f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_f64::<0, 0>(create_float64x1_t_from([f64::MIN]), create_float64x1_t_from([f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_f64::<0, 0>(create_random_float64x1_t(), create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcopy_lane_f64::<0, 0>(create_float64x1_t_from([f64::MAX]), create_float64x1_t_from([f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_f64::<0, 0>(create_float64x1_t_from([f64::MAX]), create_float64x1_t_from([f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_f64::<0, 0>(create_random_float64x1_t(), create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcopy_lane_f64::<0, 0>(create_float64x1_t_from([0.0]), create_float64x1_t_from([0.0])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_f64::<0, 0>(create_float64x1_t_from([0.0]), create_float64x1_t_from([0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_f64::<0, 0>(create_random_float64x1_t(), create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcopy_lane_f64::<0, 0>(create_float64x1_t_from([f64::NAN]), create_float64x1_t_from([f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_f64::<0, 0>(create_float64x1_t_from([f64::NAN]), create_float64x1_t_from([f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_f64::<0, 0>(create_random_float64x1_t(), create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcopy_lane_f64::<0, 0>(create_float64x1_t_from([f64::INFINITY]), create_float64x1_t_from([f64::INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_f64::<0, 0>(create_float64x1_t_from([f64::INFINITY]), create_float64x1_t_from([f64::INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_f64::<0, 0>(create_random_float64x1_t(), create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_f64_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcopy_lane_f64::<0, 0>(create_float64x1_t_from([f64::MIN]), create_float64x1_t_from([f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_f64::<0, 0>(create_float64x1_t_from([f64::MIN]), create_float64x1_t_from([f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_f64::<0, 0>(create_random_float64x1_t(), create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_f64_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcopy_lane_f64::<0, 0>(create_float64x1_t_from([f64::MAX]), create_float64x1_t_from([f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_f64::<0, 0>(create_float64x1_t_from([f64::MAX]), create_float64x1_t_from([f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_f64::<0, 0>(create_random_float64x1_t(), create_random_float64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcopy_lane_s64::<0, 0>(create_int64x1_t_from([1]), create_int64x1_t_from([2])));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s64::<0, 0>(create_int64x1_t_from([1]), create_int64x1_t_from([2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s64::<0, 0>(create_random_int64x1_t(), create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcopy_lane_s64::<0, 0>(create_int64x1_t_from([0]), create_int64x1_t_from([10])));
        check_array_equality(&result, &[10]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s64::<0, 0>(create_int64x1_t_from([0]), create_int64x1_t_from([10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s64::<0, 0>(create_random_int64x1_t(), create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcopy_lane_s64::<0, 0>(create_int64x1_t_from([100]), create_int64x1_t_from([110])));
        check_array_equality(&result, &[110]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s64::<0, 0>(create_int64x1_t_from([100]), create_int64x1_t_from([110]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s64::<0, 0>(create_random_int64x1_t(), create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcopy_lane_s64::<0, 0>(create_int64x1_t_from([i64::MIN]), create_int64x1_t_from([i64::MIN])));
        check_array_equality(&result, &[-9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s64::<0, 0>(create_int64x1_t_from([i64::MIN]), create_int64x1_t_from([i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s64::<0, 0>(create_random_int64x1_t(), create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcopy_lane_s64::<0, 0>(create_int64x1_t_from([i64::MAX]), create_int64x1_t_from([i64::MAX])));
        check_array_equality(&result, &[9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s64::<0, 0>(create_int64x1_t_from([i64::MAX]), create_int64x1_t_from([i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s64::<0, 0>(create_random_int64x1_t(), create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcopy_lane_s64::<0, 0>(create_int64x1_t_from([0]), create_int64x1_t_from([0])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s64::<0, 0>(create_int64x1_t_from([0]), create_int64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s64::<0, 0>(create_random_int64x1_t(), create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcopy_lane_s64::<0, 0>(create_int64x1_t_from([-1]), create_int64x1_t_from([-1])));
        check_array_equality(&result, &[-1]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s64::<0, 0>(create_int64x1_t_from([-1]), create_int64x1_t_from([-1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s64::<0, 0>(create_random_int64x1_t(), create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcopy_lane_s64::<0, 0>(create_int64x1_t_from([i64::MIN]), create_int64x1_t_from([i64::MIN])));
        check_array_equality(&result, &[-9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s64::<0, 0>(create_int64x1_t_from([i64::MIN]), create_int64x1_t_from([i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s64::<0, 0>(create_random_int64x1_t(), create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s64_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcopy_lane_s64::<0, 0>(create_int64x1_t_from([i64::MIN]), create_int64x1_t_from([i64::MAX])));
        check_array_equality(&result, &[9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s64::<0, 0>(create_int64x1_t_from([i64::MIN]), create_int64x1_t_from([i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s64::<0, 0>(create_random_int64x1_t(), create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_s64_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcopy_lane_s64::<0, 0>(create_int64x1_t_from([i64::MAX]), create_int64x1_t_from([i64::MIN])));
        check_array_equality(&result, &[-9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_s64::<0, 0>(create_int64x1_t_from([i64::MAX]), create_int64x1_t_from([i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_s64::<0, 0>(create_random_int64x1_t(), create_random_int64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcopy_lane_u64::<0, 0>(create_uint64x1_t_from([1]), create_uint64x1_t_from([2])));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u64::<0, 0>(create_uint64x1_t_from([1]), create_uint64x1_t_from([2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u64::<0, 0>(create_random_uint64x1_t(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcopy_lane_u64::<0, 0>(create_uint64x1_t_from([0]), create_uint64x1_t_from([10])));
        check_array_equality(&result, &[10]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u64::<0, 0>(create_uint64x1_t_from([0]), create_uint64x1_t_from([10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u64::<0, 0>(create_random_uint64x1_t(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcopy_lane_u64::<0, 0>(create_uint64x1_t_from([100]), create_uint64x1_t_from([110])));
        check_array_equality(&result, &[110]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u64::<0, 0>(create_uint64x1_t_from([100]), create_uint64x1_t_from([110]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u64::<0, 0>(create_random_uint64x1_t(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcopy_lane_u64::<0, 0>(create_uint64x1_t_from([u64::MIN]), create_uint64x1_t_from([u64::MIN])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u64::<0, 0>(create_uint64x1_t_from([u64::MIN]), create_uint64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u64::<0, 0>(create_random_uint64x1_t(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcopy_lane_u64::<0, 0>(create_uint64x1_t_from([u64::MAX]), create_uint64x1_t_from([u64::MAX])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u64::<0, 0>(create_uint64x1_t_from([u64::MAX]), create_uint64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u64::<0, 0>(create_random_uint64x1_t(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcopy_lane_u64::<0, 0>(create_uint64x1_t_from([0]), create_uint64x1_t_from([0])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u64::<0, 0>(create_uint64x1_t_from([0]), create_uint64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u64::<0, 0>(create_random_uint64x1_t(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcopy_lane_u64::<0, 0>(create_uint64x1_t_from([u64::MAX]), create_uint64x1_t_from([u64::MAX])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u64::<0, 0>(create_uint64x1_t_from([u64::MAX]), create_uint64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u64::<0, 0>(create_random_uint64x1_t(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcopy_lane_u64::<0, 0>(create_uint64x1_t_from([u64::MIN]), create_uint64x1_t_from([u64::MIN])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u64::<0, 0>(create_uint64x1_t_from([u64::MIN]), create_uint64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u64::<0, 0>(create_random_uint64x1_t(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u64_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcopy_lane_u64::<0, 0>(create_uint64x1_t_from([u64::MIN]), create_uint64x1_t_from([u64::MAX])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u64::<0, 0>(create_uint64x1_t_from([u64::MIN]), create_uint64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u64::<0, 0>(create_random_uint64x1_t(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_u64_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcopy_lane_u64::<0, 0>(create_uint64x1_t_from([u64::MAX]), create_uint64x1_t_from([u64::MIN])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_u64::<0, 0>(create_uint64x1_t_from([u64::MAX]), create_uint64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_u64::<0, 0>(create_random_uint64x1_t(), create_random_uint64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_p64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vcopy_lane_p64::<0, 0>(create_poly64x1_t_from([1]), create_poly64x1_t_from([2])));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_p64::<0, 0>(create_poly64x1_t_from([1]), create_poly64x1_t_from([2]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_p64::<0, 0>(create_random_poly64x1_t(), create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_p64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vcopy_lane_p64::<0, 0>(create_poly64x1_t_from([0]), create_poly64x1_t_from([10])));
        check_array_equality(&result, &[10]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_p64::<0, 0>(create_poly64x1_t_from([0]), create_poly64x1_t_from([10]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_p64::<0, 0>(create_random_poly64x1_t(), create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_p64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vcopy_lane_p64::<0, 0>(create_poly64x1_t_from([100]), create_poly64x1_t_from([110])));
        check_array_equality(&result, &[110]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_p64::<0, 0>(create_poly64x1_t_from([100]), create_poly64x1_t_from([110]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_p64::<0, 0>(create_random_poly64x1_t(), create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_p64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vcopy_lane_p64::<0, 0>(create_poly64x1_t_from([u64::MIN]), create_poly64x1_t_from([u64::MIN])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_p64::<0, 0>(create_poly64x1_t_from([u64::MIN]), create_poly64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_p64::<0, 0>(create_random_poly64x1_t(), create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_p64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vcopy_lane_p64::<0, 0>(create_poly64x1_t_from([u64::MAX]), create_poly64x1_t_from([u64::MAX])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_p64::<0, 0>(create_poly64x1_t_from([u64::MAX]), create_poly64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_p64::<0, 0>(create_random_poly64x1_t(), create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_p64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vcopy_lane_p64::<0, 0>(create_poly64x1_t_from([0]), create_poly64x1_t_from([0])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_p64::<0, 0>(create_poly64x1_t_from([0]), create_poly64x1_t_from([0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_p64::<0, 0>(create_random_poly64x1_t(), create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_p64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vcopy_lane_p64::<0, 0>(create_poly64x1_t_from([u64::MAX]), create_poly64x1_t_from([u64::MAX])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_p64::<0, 0>(create_poly64x1_t_from([u64::MAX]), create_poly64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_p64::<0, 0>(create_random_poly64x1_t(), create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_p64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vcopy_lane_p64::<0, 0>(create_poly64x1_t_from([u64::MIN]), create_poly64x1_t_from([u64::MIN])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_p64::<0, 0>(create_poly64x1_t_from([u64::MIN]), create_poly64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_p64::<0, 0>(create_random_poly64x1_t(), create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_p64_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vcopy_lane_p64::<0, 0>(create_poly64x1_t_from([u64::MIN]), create_poly64x1_t_from([u64::MAX])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_p64::<0, 0>(create_poly64x1_t_from([u64::MIN]), create_poly64x1_t_from([u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_p64::<0, 0>(create_random_poly64x1_t(), create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_lane_p64_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vcopy_lane_p64::<0, 0>(create_poly64x1_t_from([u64::MAX]), create_poly64x1_t_from([u64::MIN])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vcopy_lane_p64::<0, 0>(create_poly64x1_t_from([u64::MAX]), create_poly64x1_t_from([u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_lane_p64::<0, 0>(create_random_poly64x1_t(), create_random_poly64x1_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_f32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcopy_laneq_f32::<0, 0>(create_float32x2_t_from([1.0, 2.0]), create_float32x4_t_from([3.0, 4.0, 5.0, 6.0])));
        check_float_array_equality(&result, &[3.0, 2.0]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_f32::<0, 0>(create_float32x2_t_from([1.0, 2.0]), create_float32x4_t_from([3.0, 4.0, 5.0, 6.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_f32::<0, 0>(create_random_float32x2_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_f32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcopy_laneq_f32::<0, 0>(create_float32x2_t_from([0.0f32, -1.0f32]), create_float32x4_t_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[10.0, -1.0]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_f32::<0, 0>(create_float32x2_t_from([0.0f32, -1.0f32]), create_float32x4_t_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_f32::<0, 0>(create_random_float32x2_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_f32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcopy_laneq_f32::<0, 0>(create_float32x2_t_from([100.0f32, 200.0f32]), create_float32x4_t_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[110.0, 200.0]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_f32::<0, 0>(create_float32x2_t_from([100.0f32, 200.0f32]), create_float32x4_t_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_f32::<0, 0>(create_random_float32x2_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_f32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcopy_laneq_f32::<0, 0>(create_float32x2_t_from([f32::MIN, f32::MIN]), create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_f32::<0, 0>(create_float32x2_t_from([f32::MIN, f32::MIN]), create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_f32::<0, 0>(create_random_float32x2_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_f32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcopy_laneq_f32::<0, 0>(create_float32x2_t_from([f32::MAX, f32::MAX]), create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_f32::<0, 0>(create_float32x2_t_from([f32::MAX, f32::MAX]), create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_f32::<0, 0>(create_random_float32x2_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_f32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcopy_laneq_f32::<0, 0>(create_float32x2_t_from([0.0, 0.0]), create_float32x4_t_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0, 0.0]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_f32::<0, 0>(create_float32x2_t_from([0.0, 0.0]), create_float32x4_t_from([0.0, 0.0, 0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_f32::<0, 0>(create_random_float32x2_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_f32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcopy_laneq_f32::<0, 0>(create_float32x2_t_from([f32::NAN, f32::NAN]), create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_f32::<0, 0>(create_float32x2_t_from([f32::NAN, f32::NAN]), create_float32x4_t_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_f32::<0, 0>(create_random_float32x2_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_f32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcopy_laneq_f32::<0, 0>(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]), create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_f32::<0, 0>(create_float32x2_t_from([f32::INFINITY, f32::NEG_INFINITY]), create_float32x4_t_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_f32::<0, 0>(create_random_float32x2_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_f32_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcopy_laneq_f32::<0, 0>(create_float32x2_t_from([f32::MIN, f32::MIN]), create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, -3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_f32::<0, 0>(create_float32x2_t_from([f32::MIN, f32::MIN]), create_float32x4_t_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_f32::<0, 0>(create_random_float32x2_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_f32_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float32x2_t_to_f32_array(vcopy_laneq_f32::<0, 0>(create_float32x2_t_from([f32::MAX, f32::MAX]), create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, 3.4028235e38]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_f32::<0, 0>(create_float32x2_t_from([f32::MAX, f32::MAX]), create_float32x4_t_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_f32::<0, 0>(create_random_float32x2_t(), create_random_float32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vcopy_laneq_s8::<0, 0>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[9, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s8::<0, 0>(create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s8::<0, 0>(create_random_int8x8_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vcopy_laneq_s8::<0, 0>(create_int8x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int8x16_t_from([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, -1, 2, -3, 4, -5, 6, -7]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s8::<0, 0>(create_int8x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int8x16_t_from([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s8::<0, 0>(create_random_int8x8_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vcopy_laneq_s8::<0, 0>(create_int8x8_t_from([100, -56, 44, -112, -12, 88, -68, 32]), create_int8x16_t_from([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74])));
        check_array_equality(&result, &[110, -56, 44, -112, -12, 88, -68, 32]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s8::<0, 0>(create_int8x8_t_from([100, -56, 44, -112, -12, 88, -68, 32]), create_int8x16_t_from([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s8::<0, 0>(create_random_int8x8_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vcopy_laneq_s8::<0, 0>(create_int8x8_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create_int8x16_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, -128, -128, -128, -128, -128, -128, -128]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s8::<0, 0>(create_int8x8_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create_int8x16_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s8::<0, 0>(create_random_int8x8_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vcopy_laneq_s8::<0, 0>(create_int8x8_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create_int8x16_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, 127, 127, 127, 127, 127, 127, 127]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s8::<0, 0>(create_int8x8_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create_int8x16_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s8::<0, 0>(create_random_int8x8_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vcopy_laneq_s8::<0, 0>(create_int8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s8::<0, 0>(create_int8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s8::<0, 0>(create_random_int8x8_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vcopy_laneq_s8::<0, 0>(create_int8x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int8x16_t_from([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s8::<0, 0>(create_int8x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int8x16_t_from([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s8::<0, 0>(create_random_int8x8_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vcopy_laneq_s8::<0, 0>(create_int8x8_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create_int8x16_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-128, 127, 0, -1, -128, 127, 0, -1]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s8::<0, 0>(create_int8x8_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create_int8x16_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s8::<0, 0>(create_random_int8x8_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s8_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vcopy_laneq_s8::<0, 0>(create_int8x8_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create_int8x16_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, -128, -128, -128, -128, -128, -128, -128]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s8::<0, 0>(create_int8x8_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create_int8x16_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s8::<0, 0>(create_random_int8x8_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s8_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x8_t_to_i8_array(vcopy_laneq_s8::<0, 0>(create_int8x8_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create_int8x16_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, 127, 127, 127, 127, 127, 127, 127]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s8::<0, 0>(create_int8x8_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create_int8x16_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s8::<0, 0>(create_random_int8x8_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vcopy_laneq_s16::<0, 0>(create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[5, 2, 3, 4]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s16::<0, 0>(create_int16x4_t_from([1, 2, 3, 4]), create_int16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s16::<0, 0>(create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vcopy_laneq_s16::<0, 0>(create_int16x4_t_from([0, -1, 2, -3]), create_int16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, -1, 2, -3]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s16::<0, 0>(create_int16x4_t_from([0, -1, 2, -3]), create_int16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s16::<0, 0>(create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vcopy_laneq_s16::<0, 0>(create_int16x4_t_from([100, 200, 300, 400]), create_int16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[110, 200, 300, 400]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s16::<0, 0>(create_int16x4_t_from([100, 200, 300, 400]), create_int16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s16::<0, 0>(create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vcopy_laneq_s16::<0, 0>(create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s16::<0, 0>(create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s16::<0, 0>(create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vcopy_laneq_s16::<0, 0>(create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s16::<0, 0>(create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s16::<0, 0>(create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vcopy_laneq_s16::<0, 0>(create_int16x4_t_from([0, 0, 0, 0]), create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s16::<0, 0>(create_int16x4_t_from([0, 0, 0, 0]), create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s16::<0, 0>(create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vcopy_laneq_s16::<0, 0>(create_int16x4_t_from([-1, -1, -1, -1]), create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s16::<0, 0>(create_int16x4_t_from([-1, -1, -1, -1]), create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s16::<0, 0>(create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vcopy_laneq_s16::<0, 0>(create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1]), create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, 32767, 0, -1]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s16::<0, 0>(create_int16x4_t_from([i16::MIN, i16::MAX, 0, -1]), create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s16::<0, 0>(create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s16_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vcopy_laneq_s16::<0, 0>(create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, -32768, -32768, -32768]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s16::<0, 0>(create_int16x4_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s16::<0, 0>(create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s16_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x4_t_to_i16_array(vcopy_laneq_s16::<0, 0>(create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, 32767, 32767, 32767]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s16::<0, 0>(create_int16x4_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s16::<0, 0>(create_random_int16x4_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcopy_laneq_s32::<0, 0>(create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[3, 2]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s32::<0, 0>(create_int32x2_t_from([1, 2]), create_int32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s32::<0, 0>(create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcopy_laneq_s32::<0, 0>(create_int32x2_t_from([0, -1]), create_int32x4_t_from([10, 9, 12, 7])));
        check_array_equality(&result, &[10, -1]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s32::<0, 0>(create_int32x2_t_from([0, -1]), create_int32x4_t_from([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s32::<0, 0>(create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcopy_laneq_s32::<0, 0>(create_int32x2_t_from([100, 200]), create_int32x4_t_from([110, 210, 310, 410])));
        check_array_equality(&result, &[110, 200]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s32::<0, 0>(create_int32x2_t_from([100, 200]), create_int32x4_t_from([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s32::<0, 0>(create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcopy_laneq_s32::<0, 0>(create_int32x2_t_from([i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s32::<0, 0>(create_int32x2_t_from([i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s32::<0, 0>(create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcopy_laneq_s32::<0, 0>(create_int32x2_t_from([i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s32::<0, 0>(create_int32x2_t_from([i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s32::<0, 0>(create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcopy_laneq_s32::<0, 0>(create_int32x2_t_from([0, 0]), create_int32x4_t_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s32::<0, 0>(create_int32x2_t_from([0, 0]), create_int32x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s32::<0, 0>(create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcopy_laneq_s32::<0, 0>(create_int32x2_t_from([-1, -1]), create_int32x4_t_from([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s32::<0, 0>(create_int32x2_t_from([-1, -1]), create_int32x4_t_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s32::<0, 0>(create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcopy_laneq_s32::<0, 0>(create_int32x2_t_from([i32::MIN, i32::MAX]), create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-2147483648, 2147483647]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s32::<0, 0>(create_int32x2_t_from([i32::MIN, i32::MAX]), create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s32::<0, 0>(create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s32_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcopy_laneq_s32::<0, 0>(create_int32x2_t_from([i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, -2147483648]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s32::<0, 0>(create_int32x2_t_from([i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s32::<0, 0>(create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s32_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x2_t_to_i32_array(vcopy_laneq_s32::<0, 0>(create_int32x2_t_from([i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, 2147483647]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s32::<0, 0>(create_int32x2_t_from([i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s32::<0, 0>(create_random_int32x2_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vcopy_laneq_u8::<0, 0>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[9, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u8::<0, 0>(create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u8::<0, 0>(create_random_uint8x8_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vcopy_laneq_u8::<0, 0>(create_uint8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249]), create_uint8x16_t_from([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, 255, 2, 253, 4, 251, 6, 249]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u8::<0, 0>(create_uint8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249]), create_uint8x16_t_from([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u8::<0, 0>(create_random_uint8x8_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vcopy_laneq_u8::<0, 0>(create_uint8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32]), create_uint8x16_t_from([110, 210, 54, 154, 254, 98, 198, 42, 142, 242, 86, 186, 30, 130, 230, 74])));
        check_array_equality(&result, &[110, 200, 44, 144, 244, 88, 188, 32]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u8::<0, 0>(create_uint8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32]), create_uint8x16_t_from([110, 210, 54, 154, 254, 98, 198, 42, 142, 242, 86, 186, 30, 130, 230, 74]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u8::<0, 0>(create_random_uint8x8_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vcopy_laneq_u8::<0, 0>(create_uint8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_uint8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u8::<0, 0>(create_uint8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_uint8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u8::<0, 0>(create_random_uint8x8_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vcopy_laneq_u8::<0, 0>(create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u8::<0, 0>(create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u8::<0, 0>(create_random_uint8x8_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vcopy_laneq_u8::<0, 0>(create_uint8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u8::<0, 0>(create_uint8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u8::<0, 0>(create_random_uint8x8_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vcopy_laneq_u8::<0, 0>(create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u8::<0, 0>(create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u8::<0, 0>(create_random_uint8x8_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vcopy_laneq_u8::<0, 0>(create_uint8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create_uint8x16_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX])));
        check_array_equality(&result, &[0, 255, 0, 255, 0, 255, 0, 255]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u8::<0, 0>(create_uint8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create_uint8x16_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u8::<0, 0>(create_random_uint8x8_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u8_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vcopy_laneq_u8::<0, 0>(create_uint8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[255, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u8::<0, 0>(create_uint8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u8::<0, 0>(create_random_uint8x8_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u8_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x8_t_to_u8_array(vcopy_laneq_u8::<0, 0>(create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[0, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u8::<0, 0>(create_uint8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u8::<0, 0>(create_random_uint8x8_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vcopy_laneq_u16::<0, 0>(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[5, 2, 3, 4]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u16::<0, 0>(create_uint16x4_t_from([1, 2, 3, 4]), create_uint16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u16::<0, 0>(create_random_uint16x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vcopy_laneq_u16::<0, 0>(create_uint16x4_t_from([0, 65535, 2, 65533]), create_uint16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, 65535, 2, 65533]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u16::<0, 0>(create_uint16x4_t_from([0, 65535, 2, 65533]), create_uint16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u16::<0, 0>(create_random_uint16x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vcopy_laneq_u16::<0, 0>(create_uint16x4_t_from([100, 200, 300, 400]), create_uint16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[110, 200, 300, 400]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u16::<0, 0>(create_uint16x4_t_from([100, 200, 300, 400]), create_uint16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u16::<0, 0>(create_random_uint16x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vcopy_laneq_u16::<0, 0>(create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u16::<0, 0>(create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u16::<0, 0>(create_random_uint16x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vcopy_laneq_u16::<0, 0>(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u16::<0, 0>(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u16::<0, 0>(create_random_uint16x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vcopy_laneq_u16::<0, 0>(create_uint16x4_t_from([0, 0, 0, 0]), create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u16::<0, 0>(create_uint16x4_t_from([0, 0, 0, 0]), create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u16::<0, 0>(create_random_uint16x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vcopy_laneq_u16::<0, 0>(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u16::<0, 0>(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u16::<0, 0>(create_random_uint16x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vcopy_laneq_u16::<0, 0>(create_uint16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]), create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX])));
        check_array_equality(&result, &[0, 65535, 0, 65535]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u16::<0, 0>(create_uint16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]), create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u16::<0, 0>(create_random_uint16x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u16_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vcopy_laneq_u16::<0, 0>(create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u16::<0, 0>(create_uint16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u16::<0, 0>(create_random_uint16x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u16_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x4_t_to_u16_array(vcopy_laneq_u16::<0, 0>(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[0, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u16::<0, 0>(create_uint16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u16::<0, 0>(create_random_uint16x4_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcopy_laneq_u32::<0, 0>(create_uint32x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6])));
        check_array_equality(&result, &[3, 2]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u32::<0, 0>(create_uint32x2_t_from([1, 2]), create_uint32x4_t_from([3, 4, 5, 6]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u32::<0, 0>(create_random_uint32x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcopy_laneq_u32::<0, 0>(create_uint32x2_t_from([0, 4294967295]), create_uint32x4_t_from([10, 9, 12, 7])));
        check_array_equality(&result, &[10, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u32::<0, 0>(create_uint32x2_t_from([0, 4294967295]), create_uint32x4_t_from([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u32::<0, 0>(create_random_uint32x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcopy_laneq_u32::<0, 0>(create_uint32x2_t_from([100, 200]), create_uint32x4_t_from([110, 210, 310, 410])));
        check_array_equality(&result, &[110, 200]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u32::<0, 0>(create_uint32x2_t_from([100, 200]), create_uint32x4_t_from([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u32::<0, 0>(create_random_uint32x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcopy_laneq_u32::<0, 0>(create_uint32x2_t_from([u32::MIN, u32::MIN]), create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u32::<0, 0>(create_uint32x2_t_from([u32::MIN, u32::MIN]), create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u32::<0, 0>(create_random_uint32x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcopy_laneq_u32::<0, 0>(create_uint32x2_t_from([u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967295, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u32::<0, 0>(create_uint32x2_t_from([u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u32::<0, 0>(create_random_uint32x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcopy_laneq_u32::<0, 0>(create_uint32x2_t_from([0, 0]), create_uint32x4_t_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u32::<0, 0>(create_uint32x2_t_from([0, 0]), create_uint32x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u32::<0, 0>(create_random_uint32x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcopy_laneq_u32::<0, 0>(create_uint32x2_t_from([u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967295, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u32::<0, 0>(create_uint32x2_t_from([u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u32::<0, 0>(create_random_uint32x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcopy_laneq_u32::<0, 0>(create_uint32x2_t_from([u32::MIN, u32::MAX]), create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX])));
        check_array_equality(&result, &[0, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u32::<0, 0>(create_uint32x2_t_from([u32::MIN, u32::MAX]), create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u32::<0, 0>(create_random_uint32x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u32_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcopy_laneq_u32::<0, 0>(create_uint32x2_t_from([u32::MIN, u32::MIN]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967295, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u32::<0, 0>(create_uint32x2_t_from([u32::MIN, u32::MIN]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u32::<0, 0>(create_random_uint32x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u32_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x2_t_to_u32_array(vcopy_laneq_u32::<0, 0>(create_uint32x2_t_from([u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u32::<0, 0>(create_uint32x2_t_from([u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u32::<0, 0>(create_random_uint32x2_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_p8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vcopy_laneq_p8::<0, 0>(create_poly8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_poly8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));
        check_array_equality(&result, &[9, 2, 3, 4, 5, 6, 7, 8]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_p8::<0, 0>(create_poly8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_poly8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_p8::<0, 0>(create_random_poly8x8_t(), create_random_poly8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_p8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vcopy_laneq_p8::<0, 0>(create_poly8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249]), create_poly8x16_t_from([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, 255, 2, 253, 4, 251, 6, 249]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_p8::<0, 0>(create_poly8x8_t_from([0, 255, 2, 253, 4, 251, 6, 249]), create_poly8x16_t_from([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_p8::<0, 0>(create_random_poly8x8_t(), create_random_poly8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_p8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vcopy_laneq_p8::<0, 0>(create_poly8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32]), create_poly8x16_t_from([110, 210, 54, 154, 254, 98, 198, 42, 142, 242, 86, 186, 30, 130, 230, 74])));
        check_array_equality(&result, &[110, 200, 44, 144, 244, 88, 188, 32]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_p8::<0, 0>(create_poly8x8_t_from([100, 200, 44, 144, 244, 88, 188, 32]), create_poly8x16_t_from([110, 210, 54, 154, 254, 98, 198, 42, 142, 242, 86, 186, 30, 130, 230, 74]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_p8::<0, 0>(create_random_poly8x8_t(), create_random_poly8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_p8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vcopy_laneq_p8::<0, 0>(create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_poly8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_p8::<0, 0>(create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_poly8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_p8::<0, 0>(create_random_poly8x8_t(), create_random_poly8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_p8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vcopy_laneq_p8::<0, 0>(create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_p8::<0, 0>(create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_p8::<0, 0>(create_random_poly8x8_t(), create_random_poly8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_p8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vcopy_laneq_p8::<0, 0>(create_poly8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_poly8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_p8::<0, 0>(create_poly8x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_poly8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_p8::<0, 0>(create_random_poly8x8_t(), create_random_poly8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_p8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vcopy_laneq_p8::<0, 0>(create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_p8::<0, 0>(create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_p8::<0, 0>(create_random_poly8x8_t(), create_random_poly8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_p8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vcopy_laneq_p8::<0, 0>(create_poly8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create_poly8x16_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX])));
        check_array_equality(&result, &[0, 255, 0, 255, 0, 255, 0, 255]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_p8::<0, 0>(create_poly8x8_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create_poly8x16_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_p8::<0, 0>(create_random_poly8x8_t(), create_random_poly8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_p8_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vcopy_laneq_p8::<0, 0>(create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[255, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_p8::<0, 0>(create_poly8x8_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_p8::<0, 0>(create_random_poly8x8_t(), create_random_poly8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_p8_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x8_t_to_u8_array(vcopy_laneq_p8::<0, 0>(create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[0, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_p8::<0, 0>(create_poly8x8_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_p8::<0, 0>(create_random_poly8x8_t(), create_random_poly8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_p16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vcopy_laneq_p16::<0, 0>(create_poly16x4_t_from([1, 2, 3, 4]), create_poly16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12])));
        check_array_equality(&result, &[5, 2, 3, 4]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_p16::<0, 0>(create_poly16x4_t_from([1, 2, 3, 4]), create_poly16x8_t_from([5, 6, 7, 8, 9, 10, 11, 12]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_p16::<0, 0>(create_random_poly16x4_t(), create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_p16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vcopy_laneq_p16::<0, 0>(create_poly16x4_t_from([0, 65535, 2, 65533]), create_poly16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, 65535, 2, 65533]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_p16::<0, 0>(create_poly16x4_t_from([0, 65535, 2, 65533]), create_poly16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_p16::<0, 0>(create_random_poly16x4_t(), create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_p16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vcopy_laneq_p16::<0, 0>(create_poly16x4_t_from([100, 200, 300, 400]), create_poly16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[110, 200, 300, 400]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_p16::<0, 0>(create_poly16x4_t_from([100, 200, 300, 400]), create_poly16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_p16::<0, 0>(create_random_poly16x4_t(), create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_p16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vcopy_laneq_p16::<0, 0>(create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_poly16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_p16::<0, 0>(create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_poly16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_p16::<0, 0>(create_random_poly16x4_t(), create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_p16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vcopy_laneq_p16::<0, 0>(create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_p16::<0, 0>(create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_p16::<0, 0>(create_random_poly16x4_t(), create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_p16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vcopy_laneq_p16::<0, 0>(create_poly16x4_t_from([0, 0, 0, 0]), create_poly16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_p16::<0, 0>(create_poly16x4_t_from([0, 0, 0, 0]), create_poly16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_p16::<0, 0>(create_random_poly16x4_t(), create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_p16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vcopy_laneq_p16::<0, 0>(create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_p16::<0, 0>(create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_p16::<0, 0>(create_random_poly16x4_t(), create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_p16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vcopy_laneq_p16::<0, 0>(create_poly16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]), create_poly16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX])));
        check_array_equality(&result, &[0, 65535, 0, 65535]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_p16::<0, 0>(create_poly16x4_t_from([u16::MIN, u16::MAX, 0, u16::MAX]), create_poly16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_p16::<0, 0>(create_random_poly16x4_t(), create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_p16_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vcopy_laneq_p16::<0, 0>(create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_p16::<0, 0>(create_poly16x4_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_p16::<0, 0>(create_random_poly16x4_t(), create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_p16_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x4_t_to_u16_array(vcopy_laneq_p16::<0, 0>(create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[0, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_p16::<0, 0>(create_poly16x4_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_p16::<0, 0>(create_random_poly16x4_t(), create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_f64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcopy_laneq_f64::<0, 0>(create_float64x1_t_from([1.0]), create_float64x2_t_from([2.0, 3.0])));
        check_float_array_equality(&result, &[2.0]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_f64::<0, 0>(create_float64x1_t_from([1.0]), create_float64x2_t_from([2.0, 3.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_f64::<0, 0>(create_random_float64x1_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_f64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcopy_laneq_f64::<0, 0>(create_float64x1_t_from([0.0f64]), create_float64x2_t_from([10.0f64, 9.0f64])));
        check_float_array_equality(&result, &[10.0]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_f64::<0, 0>(create_float64x1_t_from([0.0f64]), create_float64x2_t_from([10.0f64, 9.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_f64::<0, 0>(create_random_float64x1_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_f64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcopy_laneq_f64::<0, 0>(create_float64x1_t_from([100.0f64]), create_float64x2_t_from([110.0f64, 210.0f64])));
        check_float_array_equality(&result, &[110.0]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_f64::<0, 0>(create_float64x1_t_from([100.0f64]), create_float64x2_t_from([110.0f64, 210.0f64]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_f64::<0, 0>(create_random_float64x1_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_f64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcopy_laneq_f64::<0, 0>(create_float64x1_t_from([f64::MIN]), create_float64x2_t_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_f64::<0, 0>(create_float64x1_t_from([f64::MIN]), create_float64x2_t_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_f64::<0, 0>(create_random_float64x1_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_f64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcopy_laneq_f64::<0, 0>(create_float64x1_t_from([f64::MAX]), create_float64x2_t_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_f64::<0, 0>(create_float64x1_t_from([f64::MAX]), create_float64x2_t_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_f64::<0, 0>(create_random_float64x1_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_f64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcopy_laneq_f64::<0, 0>(create_float64x1_t_from([0.0]), create_float64x2_t_from([0.0, 0.0])));
        check_float_array_equality(&result, &[0.0]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_f64::<0, 0>(create_float64x1_t_from([0.0]), create_float64x2_t_from([0.0, 0.0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_f64::<0, 0>(create_random_float64x1_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_f64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcopy_laneq_f64::<0, 0>(create_float64x1_t_from([f64::NAN]), create_float64x2_t_from([f64::NAN, f64::NAN])));
        check_float_array_equality(&result, &[f64::NAN]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_f64::<0, 0>(create_float64x1_t_from([f64::NAN]), create_float64x2_t_from([f64::NAN, f64::NAN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_f64::<0, 0>(create_random_float64x1_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_f64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcopy_laneq_f64::<0, 0>(create_float64x1_t_from([f64::INFINITY]), create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY])));
        check_float_array_equality(&result, &[f64::INFINITY]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_f64::<0, 0>(create_float64x1_t_from([f64::INFINITY]), create_float64x2_t_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_f64::<0, 0>(create_random_float64x1_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_f64_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcopy_laneq_f64::<0, 0>(create_float64x1_t_from([f64::MIN]), create_float64x2_t_from([f64::MAX, f64::MAX])));
        check_float_array_equality(&result, &[1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_f64::<0, 0>(create_float64x1_t_from([f64::MIN]), create_float64x2_t_from([f64::MAX, f64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_f64::<0, 0>(create_random_float64x1_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_f64_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_float64x1_t_to_f64_array(vcopy_laneq_f64::<0, 0>(create_float64x1_t_from([f64::MAX]), create_float64x2_t_from([f64::MIN, f64::MIN])));
        check_float_array_equality(&result, &[-1.7976931348623157e308]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_f64::<0, 0>(create_float64x1_t_from([f64::MAX]), create_float64x2_t_from([f64::MIN, f64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_f64::<0, 0>(create_random_float64x1_t(), create_random_float64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcopy_laneq_s64::<0, 0>(create_int64x1_t_from([1]), create_int64x2_t_from([2, 3])));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s64::<0, 0>(create_int64x1_t_from([1]), create_int64x2_t_from([2, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s64::<0, 0>(create_random_int64x1_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcopy_laneq_s64::<0, 0>(create_int64x1_t_from([0]), create_int64x2_t_from([10, 9])));
        check_array_equality(&result, &[10]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s64::<0, 0>(create_int64x1_t_from([0]), create_int64x2_t_from([10, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s64::<0, 0>(create_random_int64x1_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcopy_laneq_s64::<0, 0>(create_int64x1_t_from([100]), create_int64x2_t_from([110, 210])));
        check_array_equality(&result, &[110]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s64::<0, 0>(create_int64x1_t_from([100]), create_int64x2_t_from([110, 210]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s64::<0, 0>(create_random_int64x1_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcopy_laneq_s64::<0, 0>(create_int64x1_t_from([i64::MIN]), create_int64x2_t_from([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s64::<0, 0>(create_int64x1_t_from([i64::MIN]), create_int64x2_t_from([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s64::<0, 0>(create_random_int64x1_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcopy_laneq_s64::<0, 0>(create_int64x1_t_from([i64::MAX]), create_int64x2_t_from([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s64::<0, 0>(create_int64x1_t_from([i64::MAX]), create_int64x2_t_from([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s64::<0, 0>(create_random_int64x1_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcopy_laneq_s64::<0, 0>(create_int64x1_t_from([0]), create_int64x2_t_from([0, 0])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s64::<0, 0>(create_int64x1_t_from([0]), create_int64x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s64::<0, 0>(create_random_int64x1_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcopy_laneq_s64::<0, 0>(create_int64x1_t_from([-1]), create_int64x2_t_from([-1, -1])));
        check_array_equality(&result, &[-1]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s64::<0, 0>(create_int64x1_t_from([-1]), create_int64x2_t_from([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s64::<0, 0>(create_random_int64x1_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcopy_laneq_s64::<0, 0>(create_int64x1_t_from([i64::MIN]), create_int64x2_t_from([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[-9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s64::<0, 0>(create_int64x1_t_from([i64::MIN]), create_int64x2_t_from([i64::MIN, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s64::<0, 0>(create_random_int64x1_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s64_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcopy_laneq_s64::<0, 0>(create_int64x1_t_from([i64::MIN]), create_int64x2_t_from([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s64::<0, 0>(create_int64x1_t_from([i64::MIN]), create_int64x2_t_from([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s64::<0, 0>(create_random_int64x1_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_s64_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x1_t_to_i64_array(vcopy_laneq_s64::<0, 0>(create_int64x1_t_from([i64::MAX]), create_int64x2_t_from([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_s64::<0, 0>(create_int64x1_t_from([i64::MAX]), create_int64x2_t_from([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_s64::<0, 0>(create_random_int64x1_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcopy_laneq_u64::<0, 0>(create_uint64x1_t_from([1]), create_uint64x2_t_from([2, 3])));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u64::<0, 0>(create_uint64x1_t_from([1]), create_uint64x2_t_from([2, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u64::<0, 0>(create_random_uint64x1_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcopy_laneq_u64::<0, 0>(create_uint64x1_t_from([0]), create_uint64x2_t_from([10, 9])));
        check_array_equality(&result, &[10]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u64::<0, 0>(create_uint64x1_t_from([0]), create_uint64x2_t_from([10, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u64::<0, 0>(create_random_uint64x1_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcopy_laneq_u64::<0, 0>(create_uint64x1_t_from([100]), create_uint64x2_t_from([110, 210])));
        check_array_equality(&result, &[110]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u64::<0, 0>(create_uint64x1_t_from([100]), create_uint64x2_t_from([110, 210]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u64::<0, 0>(create_random_uint64x1_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcopy_laneq_u64::<0, 0>(create_uint64x1_t_from([u64::MIN]), create_uint64x2_t_from([u64::MIN, u64::MIN])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u64::<0, 0>(create_uint64x1_t_from([u64::MIN]), create_uint64x2_t_from([u64::MIN, u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u64::<0, 0>(create_random_uint64x1_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcopy_laneq_u64::<0, 0>(create_uint64x1_t_from([u64::MAX]), create_uint64x2_t_from([u64::MAX, u64::MAX])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u64::<0, 0>(create_uint64x1_t_from([u64::MAX]), create_uint64x2_t_from([u64::MAX, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u64::<0, 0>(create_random_uint64x1_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcopy_laneq_u64::<0, 0>(create_uint64x1_t_from([0]), create_uint64x2_t_from([0, 0])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u64::<0, 0>(create_uint64x1_t_from([0]), create_uint64x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u64::<0, 0>(create_random_uint64x1_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcopy_laneq_u64::<0, 0>(create_uint64x1_t_from([u64::MAX]), create_uint64x2_t_from([u64::MAX, u64::MAX])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u64::<0, 0>(create_uint64x1_t_from([u64::MAX]), create_uint64x2_t_from([u64::MAX, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u64::<0, 0>(create_random_uint64x1_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcopy_laneq_u64::<0, 0>(create_uint64x1_t_from([u64::MIN]), create_uint64x2_t_from([u64::MIN, u64::MAX])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u64::<0, 0>(create_uint64x1_t_from([u64::MIN]), create_uint64x2_t_from([u64::MIN, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u64::<0, 0>(create_random_uint64x1_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u64_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcopy_laneq_u64::<0, 0>(create_uint64x1_t_from([u64::MIN]), create_uint64x2_t_from([u64::MAX, u64::MAX])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u64::<0, 0>(create_uint64x1_t_from([u64::MIN]), create_uint64x2_t_from([u64::MAX, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u64::<0, 0>(create_random_uint64x1_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_u64_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x1_t_to_u64_array(vcopy_laneq_u64::<0, 0>(create_uint64x1_t_from([u64::MAX]), create_uint64x2_t_from([u64::MIN, u64::MIN])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_u64::<0, 0>(create_uint64x1_t_from([u64::MAX]), create_uint64x2_t_from([u64::MIN, u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_u64::<0, 0>(create_random_uint64x1_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_p64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vcopy_laneq_p64::<0, 0>(create_poly64x1_t_from([1]), create_poly64x2_t_from([2, 3])));
        check_array_equality(&result, &[2]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_p64::<0, 0>(create_poly64x1_t_from([1]), create_poly64x2_t_from([2, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_p64::<0, 0>(create_random_poly64x1_t(), create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_p64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vcopy_laneq_p64::<0, 0>(create_poly64x1_t_from([0]), create_poly64x2_t_from([10, 9])));
        check_array_equality(&result, &[10]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_p64::<0, 0>(create_poly64x1_t_from([0]), create_poly64x2_t_from([10, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_p64::<0, 0>(create_random_poly64x1_t(), create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_p64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vcopy_laneq_p64::<0, 0>(create_poly64x1_t_from([100]), create_poly64x2_t_from([110, 210])));
        check_array_equality(&result, &[110]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_p64::<0, 0>(create_poly64x1_t_from([100]), create_poly64x2_t_from([110, 210]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_p64::<0, 0>(create_random_poly64x1_t(), create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_p64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vcopy_laneq_p64::<0, 0>(create_poly64x1_t_from([u64::MIN]), create_poly64x2_t_from([u64::MIN, u64::MIN])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_p64::<0, 0>(create_poly64x1_t_from([u64::MIN]), create_poly64x2_t_from([u64::MIN, u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_p64::<0, 0>(create_random_poly64x1_t(), create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_p64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vcopy_laneq_p64::<0, 0>(create_poly64x1_t_from([u64::MAX]), create_poly64x2_t_from([u64::MAX, u64::MAX])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_p64::<0, 0>(create_poly64x1_t_from([u64::MAX]), create_poly64x2_t_from([u64::MAX, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_p64::<0, 0>(create_random_poly64x1_t(), create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_p64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vcopy_laneq_p64::<0, 0>(create_poly64x1_t_from([0]), create_poly64x2_t_from([0, 0])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_p64::<0, 0>(create_poly64x1_t_from([0]), create_poly64x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_p64::<0, 0>(create_random_poly64x1_t(), create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_p64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vcopy_laneq_p64::<0, 0>(create_poly64x1_t_from([u64::MAX]), create_poly64x2_t_from([u64::MAX, u64::MAX])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_p64::<0, 0>(create_poly64x1_t_from([u64::MAX]), create_poly64x2_t_from([u64::MAX, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_p64::<0, 0>(create_random_poly64x1_t(), create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_p64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vcopy_laneq_p64::<0, 0>(create_poly64x1_t_from([u64::MIN]), create_poly64x2_t_from([u64::MIN, u64::MAX])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_p64::<0, 0>(create_poly64x1_t_from([u64::MIN]), create_poly64x2_t_from([u64::MIN, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_p64::<0, 0>(create_random_poly64x1_t(), create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_p64_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vcopy_laneq_p64::<0, 0>(create_poly64x1_t_from([u64::MIN]), create_poly64x2_t_from([u64::MAX, u64::MAX])));
        check_array_equality(&result, &[18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_p64::<0, 0>(create_poly64x1_t_from([u64::MIN]), create_poly64x2_t_from([u64::MAX, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_p64::<0, 0>(create_random_poly64x1_t(), create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vcopy_laneq_p64_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly64x1_t_to_u64_array(vcopy_laneq_p64::<0, 0>(create_poly64x1_t_from([u64::MAX]), create_poly64x2_t_from([u64::MIN, u64::MIN])));
        check_array_equality(&result, &[0]).map_err(|e| crate::cpu::with_call(e, "vcopy_laneq_p64::<0, 0>(create_poly64x1_t_from([u64::MAX]), create_poly64x2_t_from([u64::MIN, u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vcopy_laneq_p64::<0, 0>(create_random_poly64x1_t(), create_random_poly64x2_t());
        });
        Ok(Verdict::Checked)
    }
}
