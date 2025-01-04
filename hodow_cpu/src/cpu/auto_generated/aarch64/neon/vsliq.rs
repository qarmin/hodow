use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_neon_vsliq_n_s8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vsliq_n_s8::<0>(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s8::<0>(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s8::<0>(create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vsliq_n_s8::<0>(create_int8x16_t_from([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create_int8x16_t_from([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s8::<0>(create_int8x16_t_from([0, -1, 2, -3, 4, -5, 6, -7, 0, -1, 2, -3, 4, -5, 6, -7]), create_int8x16_t_from([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s8::<0>(create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vsliq_n_s8::<0>(create_int8x16_t_from([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), create_int8x16_t_from([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74])));
        check_array_equality(&result, &[110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s8::<0>(create_int8x16_t_from([100, -56, 44, -112, -12, 88, -68, 32, -124, -24, 76, -80, 20, 120, -36, 64]), create_int8x16_t_from([110, -46, 54, -102, -2, 98, -58, 42, -114, -14, 86, -70, 30, -126, -26, 74]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s8::<0>(create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vsliq_n_s8::<0>(create_int8x16_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create_int8x16_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s8::<0>(create_int8x16_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create_int8x16_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s8::<0>(create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vsliq_n_s8::<0>(create_int8x16_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create_int8x16_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s8::<0>(create_int8x16_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create_int8x16_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s8::<0>(create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vsliq_n_s8::<0>(create_int8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create_int8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s8::<0>(create_int8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create_int8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s8::<0>(create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vsliq_n_s8::<0>(create_int8x16_t_from([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create_int8x16_t_from([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s8::<0>(create_int8x16_t_from([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]), create_int8x16_t_from([-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s8::<0>(create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vsliq_n_s8::<0>(create_int8x16_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create_int8x16_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1])));
        check_array_equality(&result, &[-128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1, -128, 127, 0, -1]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s8::<0>(create_int8x16_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]), create_int8x16_t_from([i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1, i8::MIN, i8::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s8::<0>(create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s8_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vsliq_n_s8::<0>(create_int8x16_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create_int8x16_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX])));
        check_array_equality(&result, &[127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s8::<0>(create_int8x16_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]), create_int8x16_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s8::<0>(create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s8_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vsliq_n_s8::<0>(create_int8x16_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create_int8x16_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN])));
        check_array_equality(&result, &[-128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128, -128]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s8::<0>(create_int8x16_t_from([i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX, i8::MAX]), create_int8x16_t_from([i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN, i8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s8::<0>(create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s8_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vsliq_n_s8::<1>(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[35, 36, 39, 40, 43, 44, 47, 48, 51, 52, 55, 56, 59, 60, 63, 64]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s8::<1>(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s8::<1>(create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s8_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vsliq_n_s8::<7>(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[-127, 2, -125, 4, -123, 6, -121, 8, -119, 10, -117, 12, -115, 14, -113, 16]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s8::<7>(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s8::<7>(create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s8_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vsliq_n_s8::<3>(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[-119, -110, -101, -92, -83, -74, -65, -64, -55, -46, -37, -28, -19, -10, -1, 0]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s8::<3>(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_int8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s8::<3>(create_random_int8x16_t(), create_random_int8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vsliq_n_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vsliq_n_s16::<0>(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, 9, 12, 7, 14, 5, 16, 3]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s16::<0>(create_int16x8_t_from([0, -1, 2, -3, 4, -5, 6, -7]), create_int16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vsliq_n_s16::<0>(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_int16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[110, 210, 310, 410, 510, 610, 710, 810]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s16::<0>(create_int16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_int16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vsliq_n_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vsliq_n_s16::<0>(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s16::<0>(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vsliq_n_s16::<0>(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s16::<0>(create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_int16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vsliq_n_s16::<0>(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1, -1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s16::<0>(create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]), create_int16x8_t_from([-1, -1, -1, -1, -1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vsliq_n_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1])));
        check_array_equality(&result, &[-32768, 32767, 0, -1, -32768, 32767, 0, -1]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]), create_int16x8_t_from([i16::MIN, i16::MAX, 0, -1, i16::MIN, i16::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s16_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vsliq_n_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX])));
        check_array_equality(&result, &[32767, 32767, 32767, 32767, 32767, 32767, 32767, 32767]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s16::<0>(create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]), create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s16_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vsliq_n_s16::<0>(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN])));
        check_array_equality(&result, &[-32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s16::<0>(create_int16x8_t_from([i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX, i16::MAX]), create_int16x8_t_from([i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN, i16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s16::<0>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vsliq_n_s16::<1>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[19, 20, 23, 24, 27, 28, 31, 32]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s16::<1>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s16::<1>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s16_imm_15() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vsliq_n_s16::<15>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[-32767, 2, -32765, 4, -32763, 6, -32761, 8]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s16::<15>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s16::<15>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s16_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vsliq_n_s16::<7>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1153, 1282, 1411, 1540, 1669, 1798, 1927, 2056]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s16::<7>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_int16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s16::<7>(create_random_int16x8_t(), create_random_int16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vsliq_n_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 6, 7, 8]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s32::<0>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vsliq_n_s32::<0>(create_int32x4_t_from([0, -1, 2, -3]), create_int32x4_t_from([10, 9, 12, 7])));
        check_array_equality(&result, &[10, 9, 12, 7]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s32::<0>(create_int32x4_t_from([0, -1, 2, -3]), create_int32x4_t_from([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vsliq_n_s32::<0>(create_int32x4_t_from([100, 200, 300, 400]), create_int32x4_t_from([110, 210, 310, 410])));
        check_array_equality(&result, &[110, 210, 310, 410]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s32::<0>(create_int32x4_t_from([100, 200, 300, 400]), create_int32x4_t_from([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vsliq_n_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vsliq_n_s32::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s32::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vsliq_n_s32::<0>(create_int32x4_t_from([0, 0, 0, 0]), create_int32x4_t_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s32::<0>(create_int32x4_t_from([0, 0, 0, 0]), create_int32x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vsliq_n_s32::<0>(create_int32x4_t_from([-1, -1, -1, -1]), create_int32x4_t_from([-1, -1, -1, -1])));
        check_array_equality(&result, &[-1, -1, -1, -1]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s32::<0>(create_int32x4_t_from([-1, -1, -1, -1]), create_int32x4_t_from([-1, -1, -1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vsliq_n_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1])));
        check_array_equality(&result, &[-2147483648, 2147483647, 0, -1]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]), create_int32x4_t_from([i32::MIN, i32::MAX, 0, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s32_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vsliq_n_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX])));
        check_array_equality(&result, &[2147483647, 2147483647, 2147483647, 2147483647]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s32::<0>(create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]), create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s32_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vsliq_n_s32::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN])));
        check_array_equality(&result, &[-2147483648, -2147483648, -2147483648, -2147483648]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s32::<0>(create_int32x4_t_from([i32::MAX, i32::MAX, i32::MAX, i32::MAX]), create_int32x4_t_from([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s32::<0>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vsliq_n_s32::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[11, 12, 15, 16]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s32::<1>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s32::<1>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s32_imm_31() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vsliq_n_s32::<31>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[-2147483647, 2, -2147483645, 4]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s32::<31>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s32::<31>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s32_imm_15() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int32x4_t_to_i32_array(vsliq_n_s32::<15>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[163841, 196610, 229379, 262148]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s32::<15>(create_int32x4_t_from([1, 2, 3, 4]), create_int32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s32::<15>(create_random_int32x4_t(), create_random_int32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vsliq_n_s64::<0>(create_int64x2_t_from([1, 2]), create_int64x2_t_from([3, 4])));
        check_array_equality(&result, &[3, 4]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s64::<0>(create_int64x2_t_from([1, 2]), create_int64x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s64::<0>(create_random_int64x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vsliq_n_s64::<0>(create_int64x2_t_from([0, -1]), create_int64x2_t_from([10, 9])));
        check_array_equality(&result, &[10, 9]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s64::<0>(create_int64x2_t_from([0, -1]), create_int64x2_t_from([10, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s64::<0>(create_random_int64x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vsliq_n_s64::<0>(create_int64x2_t_from([100, 200]), create_int64x2_t_from([110, 210])));
        check_array_equality(&result, &[110, 210]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s64::<0>(create_int64x2_t_from([100, 200]), create_int64x2_t_from([110, 210]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s64::<0>(create_random_int64x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vsliq_n_s64::<0>(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int64x2_t_from([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-9223372036854775808, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s64::<0>(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int64x2_t_from([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s64::<0>(create_random_int64x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vsliq_n_s64::<0>(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int64x2_t_from([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[9223372036854775807, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s64::<0>(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int64x2_t_from([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s64::<0>(create_random_int64x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vsliq_n_s64::<0>(create_int64x2_t_from([0, 0]), create_int64x2_t_from([0, 0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s64::<0>(create_int64x2_t_from([0, 0]), create_int64x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s64::<0>(create_random_int64x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vsliq_n_s64::<0>(create_int64x2_t_from([-1, -1]), create_int64x2_t_from([-1, -1])));
        check_array_equality(&result, &[-1, -1]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s64::<0>(create_int64x2_t_from([-1, -1]), create_int64x2_t_from([-1, -1]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s64::<0>(create_random_int64x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vsliq_n_s64::<0>(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int64x2_t_from([i64::MIN, i64::MAX])));
        check_array_equality(&result, &[-9223372036854775808, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s64::<0>(create_int64x2_t_from([i64::MIN, i64::MAX]), create_int64x2_t_from([i64::MIN, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s64::<0>(create_random_int64x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s64_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vsliq_n_s64::<0>(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int64x2_t_from([i64::MAX, i64::MAX])));
        check_array_equality(&result, &[9223372036854775807, 9223372036854775807]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s64::<0>(create_int64x2_t_from([i64::MIN, i64::MIN]), create_int64x2_t_from([i64::MAX, i64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s64::<0>(create_random_int64x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s64_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vsliq_n_s64::<0>(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int64x2_t_from([i64::MIN, i64::MIN])));
        check_array_equality(&result, &[-9223372036854775808, -9223372036854775808]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s64::<0>(create_int64x2_t_from([i64::MAX, i64::MAX]), create_int64x2_t_from([i64::MIN, i64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s64::<0>(create_random_int64x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s64_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vsliq_n_s64::<1>(create_int64x2_t_from([1, 2]), create_int64x2_t_from([3, 4])));
        check_array_equality(&result, &[7, 8]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s64::<1>(create_int64x2_t_from([1, 2]), create_int64x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s64::<1>(create_random_int64x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s64_imm_63() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vsliq_n_s64::<63>(create_int64x2_t_from([1, 2]), create_int64x2_t_from([3, 4])));
        check_array_equality(&result, &[-9223372036854775807, 2]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s64::<63>(create_int64x2_t_from([1, 2]), create_int64x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s64::<63>(create_random_int64x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_s64_imm_31() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int64x2_t_to_i64_array(vsliq_n_s64::<31>(create_int64x2_t_from([1, 2]), create_int64x2_t_from([3, 4])));
        check_array_equality(&result, &[6442450945, 8589934594]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_s64::<31>(create_int64x2_t_from([1, 2]), create_int64x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_s64::<31>(create_random_int64x2_t(), create_random_int64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vsliq_n_u8::<0>(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u8::<0>(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u8::<0>(create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vsliq_n_u8::<0>(create_uint8x16_t_from([0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249]), create_uint8x16_t_from([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u8::<0>(create_uint8x16_t_from([0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249]), create_uint8x16_t_from([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u8::<0>(create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vsliq_n_u8::<0>(create_uint8x16_t_from([100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64]), create_uint8x16_t_from([110, 210, 54, 154, 254, 98, 198, 42, 142, 242, 86, 186, 30, 130, 230, 74])));
        check_array_equality(&result, &[110, 210, 54, 154, 254, 98, 198, 42, 142, 242, 86, 186, 30, 130, 230, 74]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u8::<0>(create_uint8x16_t_from([100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64]), create_uint8x16_t_from([110, 210, 54, 154, 254, 98, 198, 42, 142, 242, 86, 186, 30, 130, 230, 74]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u8::<0>(create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vsliq_n_u8::<0>(create_uint8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_uint8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u8::<0>(create_uint8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_uint8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u8::<0>(create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vsliq_n_u8::<0>(create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u8::<0>(create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u8::<0>(create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vsliq_n_u8::<0>(create_uint8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create_uint8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u8::<0>(create_uint8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create_uint8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u8::<0>(create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vsliq_n_u8::<0>(create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u8::<0>(create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u8::<0>(create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vsliq_n_u8::<0>(create_uint8x16_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create_uint8x16_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX])));
        check_array_equality(&result, &[0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u8::<0>(create_uint8x16_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create_uint8x16_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u8::<0>(create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u8_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vsliq_n_u8::<0>(create_uint8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u8::<0>(create_uint8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u8::<0>(create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u8_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vsliq_n_u8::<0>(create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u8::<0>(create_uint8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_uint8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u8::<0>(create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u8_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vsliq_n_u8::<1>(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[35, 36, 39, 40, 43, 44, 47, 48, 51, 52, 55, 56, 59, 60, 63, 64]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u8::<1>(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u8::<1>(create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u8_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vsliq_n_u8::<7>(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[129, 2, 131, 4, 133, 6, 135, 8, 137, 10, 139, 12, 141, 14, 143, 16]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u8::<7>(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u8::<7>(create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u8_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vsliq_n_u8::<3>(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[137, 146, 155, 164, 173, 182, 191, 192, 201, 210, 219, 228, 237, 246, 255, 0]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u8::<3>(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u8::<3>(create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vsliq_n_u16::<0>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u16::<0>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u16::<0>(create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vsliq_n_u16::<0>(create_uint16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]), create_uint16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, 9, 12, 7, 14, 5, 16, 3]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u16::<0>(create_uint16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]), create_uint16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u16::<0>(create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vsliq_n_u16::<0>(create_uint16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_uint16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[110, 210, 310, 410, 510, 610, 710, 810]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u16::<0>(create_uint16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_uint16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u16::<0>(create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vsliq_n_u16::<0>(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u16::<0>(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u16::<0>(create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vsliq_n_u16::<0>(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u16::<0>(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u16::<0>(create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vsliq_n_u16::<0>(create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u16::<0>(create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_uint16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u16::<0>(create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vsliq_n_u16::<0>(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u16::<0>(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u16::<0>(create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vsliq_n_u16::<0>(create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX])));
        check_array_equality(&result, &[0, 65535, 0, 65535, 0, 65535, 0, 65535]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u16::<0>(create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create_uint16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u16::<0>(create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u16_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vsliq_n_u16::<0>(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u16::<0>(create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u16::<0>(create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u16_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vsliq_n_u16::<0>(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u16::<0>(create_uint16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_uint16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u16::<0>(create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vsliq_n_u16::<1>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[19, 20, 23, 24, 27, 28, 31, 32]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u16::<1>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u16::<1>(create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u16_imm_15() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vsliq_n_u16::<15>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[32769, 2, 32771, 4, 32773, 6, 32775, 8]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u16::<15>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u16::<15>(create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u16_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vsliq_n_u16::<7>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1153, 1282, 1411, 1540, 1669, 1798, 1927, 2056]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u16::<7>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u16::<7>(create_random_uint16x8_t(), create_random_uint16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u32() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vsliq_n_u32::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[5, 6, 7, 8]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u32::<0>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u32::<0>(create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u32_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vsliq_n_u32::<0>(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint32x4_t_from([10, 9, 12, 7])));
        check_array_equality(&result, &[10, 9, 12, 7]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u32::<0>(create_uint32x4_t_from([0, 4294967295, 2, 4294967293]), create_uint32x4_t_from([10, 9, 12, 7]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u32::<0>(create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u32_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vsliq_n_u32::<0>(create_uint32x4_t_from([100, 200, 300, 400]), create_uint32x4_t_from([110, 210, 310, 410])));
        check_array_equality(&result, &[110, 210, 310, 410]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u32::<0>(create_uint32x4_t_from([100, 200, 300, 400]), create_uint32x4_t_from([110, 210, 310, 410]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u32::<0>(create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u32_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vsliq_n_u32::<0>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u32::<0>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u32::<0>(create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u32_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vsliq_n_u32::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u32::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u32::<0>(create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u32_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vsliq_n_u32::<0>(create_uint32x4_t_from([0, 0, 0, 0]), create_uint32x4_t_from([0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u32::<0>(create_uint32x4_t_from([0, 0, 0, 0]), create_uint32x4_t_from([0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u32::<0>(create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u32_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vsliq_n_u32::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u32::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u32::<0>(create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u32_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vsliq_n_u32::<0>(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX])));
        check_array_equality(&result, &[0, 4294967295, 0, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u32::<0>(create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]), create_uint32x4_t_from([u32::MIN, u32::MAX, 0, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u32::<0>(create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u32_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vsliq_n_u32::<0>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX])));
        check_array_equality(&result, &[4294967295, 4294967295, 4294967295, 4294967295]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u32::<0>(create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]), create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u32::<0>(create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u32_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vsliq_n_u32::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u32::<0>(create_uint32x4_t_from([u32::MAX, u32::MAX, u32::MAX, u32::MAX]), create_uint32x4_t_from([u32::MIN, u32::MIN, u32::MIN, u32::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u32::<0>(create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u32_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vsliq_n_u32::<1>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[11, 12, 15, 16]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u32::<1>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u32::<1>(create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u32_imm_31() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vsliq_n_u32::<31>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[2147483649, 2, 2147483651, 4]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u32::<31>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u32::<31>(create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u32_imm_15() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint32x4_t_to_u32_array(vsliq_n_u32::<15>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8])));
        check_array_equality(&result, &[163841, 196610, 229379, 262148]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u32::<15>(create_uint32x4_t_from([1, 2, 3, 4]), create_uint32x4_t_from([5, 6, 7, 8]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u32::<15>(create_random_uint32x4_t(), create_random_uint32x4_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u64() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vsliq_n_u64::<0>(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4])));
        check_array_equality(&result, &[3, 4]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u64::<0>(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u64::<0>(create_random_uint64x2_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u64_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vsliq_n_u64::<0>(create_uint64x2_t_from([0, 18446744073709551615]), create_uint64x2_t_from([10, 9])));
        check_array_equality(&result, &[10, 9]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u64::<0>(create_uint64x2_t_from([0, 18446744073709551615]), create_uint64x2_t_from([10, 9]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u64::<0>(create_random_uint64x2_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u64_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vsliq_n_u64::<0>(create_uint64x2_t_from([100, 200]), create_uint64x2_t_from([110, 210])));
        check_array_equality(&result, &[110, 210]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u64::<0>(create_uint64x2_t_from([100, 200]), create_uint64x2_t_from([110, 210]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u64::<0>(create_random_uint64x2_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u64_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vsliq_n_u64::<0>(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint64x2_t_from([u64::MIN, u64::MIN])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u64::<0>(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint64x2_t_from([u64::MIN, u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u64::<0>(create_random_uint64x2_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u64_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vsliq_n_u64::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint64x2_t_from([u64::MAX, u64::MAX])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u64::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint64x2_t_from([u64::MAX, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u64::<0>(create_random_uint64x2_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u64_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vsliq_n_u64::<0>(create_uint64x2_t_from([0, 0]), create_uint64x2_t_from([0, 0])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u64::<0>(create_uint64x2_t_from([0, 0]), create_uint64x2_t_from([0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u64::<0>(create_random_uint64x2_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u64_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vsliq_n_u64::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint64x2_t_from([u64::MAX, u64::MAX])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u64::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint64x2_t_from([u64::MAX, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u64::<0>(create_random_uint64x2_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u64_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vsliq_n_u64::<0>(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint64x2_t_from([u64::MIN, u64::MAX])));
        check_array_equality(&result, &[0, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u64::<0>(create_uint64x2_t_from([u64::MIN, u64::MAX]), create_uint64x2_t_from([u64::MIN, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u64::<0>(create_random_uint64x2_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u64_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vsliq_n_u64::<0>(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint64x2_t_from([u64::MAX, u64::MAX])));
        check_array_equality(&result, &[18446744073709551615, 18446744073709551615]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u64::<0>(create_uint64x2_t_from([u64::MIN, u64::MIN]), create_uint64x2_t_from([u64::MAX, u64::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u64::<0>(create_random_uint64x2_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u64_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vsliq_n_u64::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint64x2_t_from([u64::MIN, u64::MIN])));
        check_array_equality(&result, &[0, 0]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u64::<0>(create_uint64x2_t_from([u64::MAX, u64::MAX]), create_uint64x2_t_from([u64::MIN, u64::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u64::<0>(create_random_uint64x2_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u64_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vsliq_n_u64::<1>(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4])));
        check_array_equality(&result, &[7, 8]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u64::<1>(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u64::<1>(create_random_uint64x2_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u64_imm_63() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vsliq_n_u64::<63>(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4])));
        check_array_equality(&result, &[9223372036854775809, 2]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u64::<63>(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u64::<63>(create_random_uint64x2_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_u64_imm_31() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint64x2_t_to_u64_array(vsliq_n_u64::<31>(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4])));
        check_array_equality(&result, &[6442450945, 8589934594]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_u64::<31>(create_uint64x2_t_from([1, 2]), create_uint64x2_t_from([3, 4]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_u64::<31>(create_random_uint64x2_t(), create_random_uint64x2_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_p8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vsliq_n_p8::<0>(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_poly8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_p8::<0>(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_poly8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_p8::<0>(create_random_poly8x16_t(), create_random_poly8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_p8_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vsliq_n_p8::<0>(create_poly8x16_t_from([0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249]), create_poly8x16_t_from([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_p8::<0>(create_poly8x16_t_from([0, 255, 2, 253, 4, 251, 6, 249, 0, 255, 2, 253, 4, 251, 6, 249]), create_poly8x16_t_from([10, 9, 12, 7, 14, 5, 16, 3, 10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_p8::<0>(create_random_poly8x16_t(), create_random_poly8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_p8_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vsliq_n_p8::<0>(create_poly8x16_t_from([100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64]), create_poly8x16_t_from([110, 210, 54, 154, 254, 98, 198, 42, 142, 242, 86, 186, 30, 130, 230, 74])));
        check_array_equality(&result, &[110, 210, 54, 154, 254, 98, 198, 42, 142, 242, 86, 186, 30, 130, 230, 74]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_p8::<0>(create_poly8x16_t_from([100, 200, 44, 144, 244, 88, 188, 32, 132, 232, 76, 176, 20, 120, 220, 64]), create_poly8x16_t_from([110, 210, 54, 154, 254, 98, 198, 42, 142, 242, 86, 186, 30, 130, 230, 74]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_p8::<0>(create_random_poly8x16_t(), create_random_poly8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_p8_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vsliq_n_p8::<0>(create_poly8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_poly8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_p8::<0>(create_poly8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_poly8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_p8::<0>(create_random_poly8x16_t(), create_random_poly8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_p8_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vsliq_n_p8::<0>(create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_p8::<0>(create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_p8::<0>(create_random_poly8x16_t(), create_random_poly8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_p8_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vsliq_n_p8::<0>(create_poly8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create_poly8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_p8::<0>(create_poly8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]), create_poly8x16_t_from([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_p8::<0>(create_random_poly8x16_t(), create_random_poly8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_p8_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vsliq_n_p8::<0>(create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_p8::<0>(create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_p8::<0>(create_random_poly8x16_t(), create_random_poly8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_p8_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vsliq_n_p8::<0>(create_poly8x16_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create_poly8x16_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX])));
        check_array_equality(&result, &[0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_p8::<0>(create_poly8x16_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]), create_poly8x16_t_from([u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX, u8::MIN, u8::MAX, 0, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_p8::<0>(create_random_poly8x16_t(), create_random_poly8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_p8_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vsliq_n_p8::<0>(create_poly8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX])));
        check_array_equality(&result, &[255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_p8::<0>(create_poly8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]), create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_p8::<0>(create_random_poly8x16_t(), create_random_poly8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_p8_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vsliq_n_p8::<0>(create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_p8::<0>(create_poly8x16_t_from([u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX, u8::MAX]), create_poly8x16_t_from([u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN, u8::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_p8::<0>(create_random_poly8x16_t(), create_random_poly8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_p8_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vsliq_n_p8::<1>(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_poly8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[35, 36, 39, 40, 43, 44, 47, 48, 51, 52, 55, 56, 59, 60, 63, 64]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_p8::<1>(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_poly8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_p8::<1>(create_random_poly8x16_t(), create_random_poly8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_p8_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vsliq_n_p8::<7>(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_poly8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[129, 2, 131, 4, 133, 6, 135, 8, 137, 10, 139, 12, 141, 14, 143, 16]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_p8::<7>(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_poly8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_p8::<7>(create_random_poly8x16_t(), create_random_poly8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_p8_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vsliq_n_p8::<3>(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_poly8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));
        check_array_equality(&result, &[137, 146, 155, 164, 173, 182, 191, 192, 201, 210, 219, 228, 237, 246, 255, 0]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_p8::<3>(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_poly8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_p8::<3>(create_random_poly8x16_t(), create_random_poly8x16_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_p16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vsliq_n_p16::<0>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_poly16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[9, 10, 11, 12, 13, 14, 15, 16]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_p16::<0>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_poly16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_p16::<0>(create_random_poly16x8_t(), create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_p16_normal2() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vsliq_n_p16::<0>(create_poly16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]), create_poly16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3])));
        check_array_equality(&result, &[10, 9, 12, 7, 14, 5, 16, 3]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_p16::<0>(create_poly16x8_t_from([0, 65535, 2, 65533, 4, 65531, 6, 65529]), create_poly16x8_t_from([10, 9, 12, 7, 14, 5, 16, 3]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_p16::<0>(create_random_poly16x8_t(), create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_p16_normal3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vsliq_n_p16::<0>(create_poly16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_poly16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810])));
        check_array_equality(&result, &[110, 210, 310, 410, 510, 610, 710, 810]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_p16::<0>(create_poly16x8_t_from([100, 200, 300, 400, 500, 600, 700, 800]), create_poly16x8_t_from([110, 210, 310, 410, 510, 610, 710, 810]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_p16::<0>(create_random_poly16x8_t(), create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_p16_boundary_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vsliq_n_p16::<0>(create_poly16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_poly16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_p16::<0>(create_poly16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_poly16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_p16::<0>(create_random_poly16x8_t(), create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_p16_boundary_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vsliq_n_p16::<0>(create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_p16::<0>(create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_p16::<0>(create_random_poly16x8_t(), create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_p16_boundary_zero() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vsliq_n_p16::<0>(create_poly16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_poly16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_p16::<0>(create_poly16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]), create_poly16x8_t_from([0, 0, 0, 0, 0, 0, 0, 0]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_p16::<0>(create_random_poly16x8_t(), create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_p16_boundary_allones() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vsliq_n_p16::<0>(create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_p16::<0>(create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_p16::<0>(create_random_poly16x8_t(), create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_p16_boundary_mixed() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vsliq_n_p16::<0>(create_poly16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create_poly16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX])));
        check_array_equality(&result, &[0, 65535, 0, 65535, 0, 65535, 0, 65535]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_p16::<0>(create_poly16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]), create_poly16x8_t_from([u16::MIN, u16::MAX, 0, u16::MAX, u16::MIN, u16::MAX, 0, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_p16::<0>(create_random_poly16x8_t(), create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_p16_asym_min_max() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vsliq_n_p16::<0>(create_poly16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX])));
        check_array_equality(&result, &[65535, 65535, 65535, 65535, 65535, 65535, 65535, 65535]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_p16::<0>(create_poly16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]), create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_p16::<0>(create_random_poly16x8_t(), create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_p16_asym_max_min() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vsliq_n_p16::<0>(create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN])));
        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_p16::<0>(create_poly16x8_t_from([u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX, u16::MAX]), create_poly16x8_t_from([u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN, u16::MIN]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_p16::<0>(create_random_poly16x8_t(), create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_p16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vsliq_n_p16::<1>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_poly16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[19, 20, 23, 24, 27, 28, 31, 32]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_p16::<1>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_poly16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_p16::<1>(create_random_poly16x8_t(), create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_p16_imm_15() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vsliq_n_p16::<15>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_poly16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[32769, 2, 32771, 4, 32773, 6, 32775, 8]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_p16::<15>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_poly16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_p16::<15>(create_random_poly16x8_t(), create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}

pub(super) fn test_aarch64_neon_vsliq_n_p16_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vsliq_n_p16::<7>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_poly16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[1153, 1282, 1411, 1540, 1669, 1798, 1927, 2056]).map_err(|e| crate::cpu::with_call(e, "vsliq_n_p16::<7>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_poly16x8_t_from([9, 10, 11, 12, 13, 14, 15, 16]))"))?;

        crate::cpu::fuzz(&mut || {
            let _ = vsliq_n_p16::<7>(create_random_poly16x8_t(), create_random_poly16x8_t());
        });
        Ok(Verdict::Checked)
    }
}
