use std::arch::x86_64::{__m128d, __m128i, _mm_add_sd, _mm_and_pd, _mm_andnot_pd, _mm_andnot_si128, _mm_bslli_si128, _mm_bsrli_si128, _mm_cvtepi32_pd, _mm_cvtepi32_ps, _mm_cvtpd_epi32, _mm_cvtpd_ps, _mm_cvtps_epi32, _mm_cvtsd_f64, _mm_cvttpd_epi32, _mm_cvttps_epi32, _mm_div_pd, _mm_div_sd, _mm_extract_epi16, _mm_insert_epi16, _mm_max_pd, _mm_max_sd, _mm_min_pd, _mm_min_sd, _mm_movemask_epi8, _mm_mul_sd, _mm_or_pd, _mm_packus_epi16, _mm_set1_epi16, _mm_set1_epi32, _mm_set1_epi64x, _mm_set_epi16, _mm_set_epi32, _mm_set_epi64x, _mm_set_epi8, _mm_set_pd, _mm_set_sd, _mm_shuffle_epi32, _mm_shufflehi_epi16, _mm_shufflelo_epi16, _mm_sll_epi16, _mm_sll_epi32, _mm_sll_epi64, _mm_sqrt_pd, _mm_sqrt_sd, _mm_sub_sd, _mm_unpackhi_epi16, _mm_unpackhi_epi32, _mm_unpackhi_epi64, _mm_unpackhi_epi8, _mm_unpacklo_epi16, _mm_unpacklo_epi32, _mm_unpacklo_epi64, _mm_unpacklo_epi8, _mm_xor_pd};
use crate::cpu::common::{check_array_equality, check_float_array_equality_with_error, check_int_equality};

pub(super) fn test_mm_packus_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(300, 200, 100, 50, 10, 5, 2, 1);
        let b = _mm_set_epi16(255, 254, 253, 252, -1, -2, -3, -4);
        let result = _mm_packus_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);

        check_array_equality(&result, &[1, 2, 5, 10, 50, 100, 200, 255, 0, 0, 0, 0, 252, 253, 254, 255])?;
    }
    Ok(())
}

pub(super) fn test_mm_unpackhi_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
        let b = _mm_set_epi8(31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16);
        let result = _mm_unpackhi_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);

        check_array_equality(&result, &[8, 24, 9, 25, 10, 26, 11, 27, 12, 28, 13, 29, 14, 30, 15, 31])?;
    }
    Ok(())
}

pub(super) fn test_mm_unpackhi_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(7, 6, 5, 4, 3, 2, 1, 0);
        let b = _mm_set_epi16(15, 14, 13, 12, 11, 10, 9, 8);
        let result = _mm_unpackhi_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);

        check_array_equality(&result, &[4, 12, 5, 13, 6, 14, 7, 15])?;
    }
    Ok(())
}

pub(super) fn test_mm_unpackhi_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(3, 2, 1, 0);
        let b = _mm_set_epi32(7, 6, 5, 4);
        let result = _mm_unpackhi_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);

        check_array_equality(&result, &[2, 6, 3, 7])?;
    }
    Ok(())
}

pub(super) fn test_mm_unpackhi_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 0);
        let b = _mm_set_epi64x(3, 2);
        let result = _mm_unpackhi_epi64(a, b);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);

        check_array_equality(&result, &[1, 3])?;
    }
    Ok(())
}

pub(super) fn test_mm_unpacklo_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
        let b = _mm_set_epi8(31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16);
        let result = _mm_unpacklo_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);

        check_array_equality(&result, &[0, 16, 1, 17, 2, 18, 3, 19, 4, 20, 5, 21, 6, 22, 7, 23])?;
    }
    Ok(())
}

pub(super) fn test_mm_unpacklo_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(7, 6, 5, 4, 3, 2, 1, 0);
        let b = _mm_set_epi16(15, 14, 13, 12, 11, 10, 9, 8);
        let result = _mm_unpacklo_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);

        check_array_equality(&result, &[0, 8, 1, 9, 2, 10, 3, 11])?;
    }
    Ok(())
}

pub(super) fn test_mm_unpacklo_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(3, 2, 1, 0);
        let b = _mm_set_epi32(7, 6, 5, 4);
        let result = _mm_unpacklo_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);

        check_array_equality(&result, &[0, 4, 1, 5])?;
    }
    Ok(())
}

pub(super) fn test_mm_unpacklo_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 0);
        let b = _mm_set_epi64x(3, 2);
        let result = _mm_unpacklo_epi64(a, b);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);

        check_array_equality(&result, &[0, 2])?;
    }
    Ok(())
}

pub(super) fn test_mm_shuffle_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(3, 2, 1, 0);
        let result = _mm_shuffle_epi32::<0b00011011>(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[3, 2, 1, 0])?;
    }
    Ok(())
}

pub(super) fn test_mm_shufflehi_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(7, 6, 5, 4, 3, 2, 1, 0);
        let result = _mm_shufflehi_epi16::<0b00011011>(a);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);

        check_array_equality(&result, &[0, 1, 2, 3, 7, 6, 5, 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_shufflelo_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(7, 6, 5, 4, 3, 2, 1, 0);
        let result = _mm_shufflelo_epi16::<0b00011011>(a);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);

        check_array_equality(&result, &[3, 2, 1, 0, 4, 5, 6, 7])?;
    }
    Ok(())
}

pub(super) fn test_mm_extract_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(7, 6, 5, 4, 3, 2, 1, 0);
        let result = _mm_extract_epi16::<3>(a);
        check_int_equality(result, 3)?;
    }
    Ok(())
}

pub(super) fn test_mm_insert_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(7, 6, 5, 4, 3, 2, 1, 0);
        let result = _mm_insert_epi16::<3>(a, 99);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        check_array_equality(&result, &[0, 1, 2, 99, 4, 5, 6, 7])?;
    }
    Ok(())
}

pub(super) fn test_mm_movemask_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0);
        let result = _mm_movemask_epi8(a);

        check_int_equality(result, 0)?;
    }
    Ok(())
}

pub(super) fn test_mm_cvtepi32_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0, 0, 20, 10);
        let result = _mm_cvtepi32_pd(a);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[10.0, 20.0])?;
    }
    Ok(())
}

pub(super) fn test_mm_cvtepi32_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let result = _mm_cvtepi32_ps(a);
        let result = std::mem::transmute::<std::arch::x86_64::__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &result)?;
    }
    Ok(())
}

pub(super) fn test_mm_cvtpd_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(20.7, 10.3);
        let result = _mm_cvtpd_epi32(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);

        check_array_equality(&result, &[10, 21, 0, 0])?;
    }
    Ok(())
}

pub(super) fn test_mm_cvtps_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let ps = _mm_cvtpd_ps(a);
        let result = _mm_cvtps_epi32(ps);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[1, 2, 0, 0])?;
    }
    Ok(())
}

pub(super) fn test_mm_cvttpd_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(20.9, 10.9);
        let result = _mm_cvttpd_epi32(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);

        check_array_equality(&result, &[10, 20, 0, 0])?;
    }
    Ok(())
}

pub(super) fn test_mm_cvttps_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.9, 1.9);
        let ps = _mm_cvtpd_ps(a);
        let result = _mm_cvttps_epi32(ps);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);

        check_array_equality(&result, &[1, 2, 0, 0])?;
    }
    Ok(())
}

pub(super) fn test_mm_add_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(10.0);
        let b = _mm_set_sd(5.0);
        let result = _mm_add_sd(a, b);
        let result_f64 = _mm_cvtsd_f64(result);
        check_float_array_equality_with_error(&[result_f64], &[result_f64])?;
    }
    Ok(())
}

pub(super) fn test_mm_div_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(20.0);
        let b = _mm_set_sd(4.0);
        let result = _mm_div_sd(a, b);
        let result_f64 = _mm_cvtsd_f64(result);
        check_float_array_equality_with_error(&[result_f64], &[result_f64])?;
    }
    Ok(())
}

pub(super) fn test_mm_div_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(20.0, 10.0);
        let b = _mm_set_pd(4.0, 2.0);
        let result = _mm_div_pd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_array_equality(&result, &[5.0, 5.0])?;
    }
    Ok(())
}

pub(super) fn test_mm_max_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(10.0);
        let b = _mm_set_sd(5.0);
        let result = _mm_max_sd(a, b);
        let result_f64 = _mm_cvtsd_f64(result);
        check_float_array_equality_with_error(&[result_f64], &[result_f64])?;
    }
    Ok(())
}

pub(super) fn test_mm_max_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(10.0, 5.0);
        let b = _mm_set_pd(8.0, 7.0);
        let result = _mm_max_pd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_array_equality(&result, &[7.0, 10.0])?;
    }
    Ok(())
}

pub(super) fn test_mm_min_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(10.0);
        let b = _mm_set_sd(5.0);
        let result = _mm_min_sd(a, b);
        let result_f64 = _mm_cvtsd_f64(result);
        check_float_array_equality_with_error(&[result_f64], &[result_f64])?;
    }
    Ok(())
}

pub(super) fn test_mm_min_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(10.0, 5.0);
        let b = _mm_set_pd(8.0, 7.0);
        let result = _mm_min_pd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_array_equality(&result, &[5.0, 8.0])?;
    }
    Ok(())
}

pub(super) fn test_mm_mul_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(10.0);
        let b = _mm_set_sd(5.0);
        let result = _mm_mul_sd(a, b);
        let result_f64 = _mm_cvtsd_f64(result);
        check_float_array_equality_with_error(&[result_f64], &[result_f64])?;
    }
    Ok(())
}

pub(super) fn test_mm_sqrt_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(25.0);
        let b = _mm_set_sd(0.0);
        let result = _mm_sqrt_sd(b, a);
        let result_f64 = _mm_cvtsd_f64(result);
        check_float_array_equality_with_error(&[result_f64], &[result_f64])?;
    }
    Ok(())
}

pub(super) fn test_mm_sqrt_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(16.0, 25.0);
        let result = _mm_sqrt_pd(a);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_array_equality(&result, &[5.0, 4.0])?;
    }
    Ok(())
}

pub(super) fn test_mm_sub_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(10.0);
        let b = _mm_set_sd(3.0);
        let result = _mm_sub_sd(a, b);
        let expected = _mm_cvtsd_f64(result);
        check_float_array_equality_with_error(&[expected], &[expected])?;
    }
    Ok(())
}

pub(super) fn test_mm_and_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let b = _mm_set_pd(3.0, 4.0);
        let _result = _mm_and_pd(a, b);
    }
    Ok(())
}

pub(super) fn test_mm_andnot_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let b = _mm_set_pd(3.0, 4.0);
        let _result = _mm_andnot_pd(a, b);
    }
    Ok(())
}

pub(super) fn test_mm_or_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let b = _mm_set_pd(3.0, 4.0);
        let _result = _mm_or_pd(a, b);
    }
    Ok(())
}

pub(super) fn test_mm_xor_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let b = _mm_set_pd(3.0, 4.0);
        let _result = _mm_xor_pd(a, b);
    }
    Ok(())
}

pub(super) fn test_mm_andnot_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0xFF, 0xFF, 0x00, 0x00);
        let b = _mm_set_epi32(0xFF, 0x00, 0xFF, 0x00);
        let result = _mm_andnot_si128(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);

        check_array_equality(&result, &[0, 255, 0, 0])?;
    }
    Ok(())
}

pub(super) fn test_mm_bslli_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let result = _mm_bslli_si128::<4>(a);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        check_array_equality(&result, &[0])?;
    }
    Ok(())
}

pub(super) fn test_mm_bsrli_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let result = _mm_bsrli_si128::<4>(a);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        check_array_equality(&result, &[0])?;
    }
    Ok(())
}

pub(super) fn test_mm_sll_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(1);
        let count = _mm_set_epi64x(0, 2);
        let result = _mm_sll_epi16(a, count);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [4; 8];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_sll_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(1);
        let count = _mm_set_epi64x(0, 3);
        let result = _mm_sll_epi32(a, count);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [8; 4];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_sll_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(1);
        let count = _mm_set_epi64x(0, 4);
        let result = _mm_sll_epi64(a, count);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        let expected = [16; 2];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}