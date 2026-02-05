use std::arch::x86_64::{__m128i, _mm_cmpeq_epi16, _mm_cmpeq_epi8, _mm_cmpgt_epi16, _mm_cmpgt_epi32, _mm_cmpgt_epi8, _mm_cmplt_epi16, _mm_cmplt_epi32, _mm_cmplt_epi8, _mm_load_si128, _mm_loadl_epi64, _mm_loadu_si128, _mm_packs_epi16, _mm_packs_epi32, _mm_sad_epu8, _mm_set1_epi16, _mm_set1_epi32, _mm_set1_epi64x, _mm_set1_epi8, _mm_set_epi16, _mm_set_epi32, _mm_set_epi64x, _mm_set_epi8, _mm_setr_epi16, _mm_setr_epi32, _mm_setr_epi8, _mm_slli_epi16, _mm_slli_epi32, _mm_slli_epi64, _mm_slli_si128, _mm_srai_epi16, _mm_srai_epi32, _mm_srli_epi16, _mm_srli_epi32, _mm_srli_epi64, _mm_srli_si128, _mm_store_si128, _mm_storel_epi64, _mm_storeu_si128};
use crate::cpu::common::check_array_equality;

pub(super) fn test_mm_sad_epu8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(10);
        let b = _mm_set1_epi8(5);
        let result = _mm_sad_epu8(a, b);
        let result = std::mem::transmute::<__m128i, [u16; 8]>(result);

        check_array_equality(&result, &[40, 0, 0, 0, 40, 0, 0, 0])?;
    }
    Ok(())
}

pub(super) fn test_mm_slli_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0x04030201, 0x08070605, 0x0C0B0A09, 0x100F0E0D);
        let result = _mm_slli_si128::<4>(a);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);

        check_array_equality(&result, &[0, 0, 0, 0, 13, 14, 15, 16, 9, 10, 11, 12, 5, 6, 7, 8])?;
    }
    Ok(())
}

pub(super) fn test_mm_srli_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0x04030201, 0x08070605, 0x0C0B0A09, 0x100F0E0D);
        let result = _mm_srli_si128::<4>(a);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);

        check_array_equality(&result, &[9, 10, 11, 12, 5, 6, 7, 8, 1, 2, 3, 4, 0, 0, 0, 0])?;
    }
    Ok(())
}

pub(super) fn test_mm_slli_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(1);
        let result = _mm_slli_epi16::<2>(a);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [4; 8];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_slli_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(1);
        let result = _mm_slli_epi32::<3>(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [8; 4];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_slli_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(1);
        let result = _mm_slli_epi64::<4>(a);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        let expected = [16; 2];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_srai_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(-16);
        let result = _mm_srai_epi16::<2>(a);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [-4; 8];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_srai_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(-32);
        let result = _mm_srai_epi32::<3>(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [-4; 4];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_srli_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(16);
        let result = _mm_srli_epi16::<2>(a);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [4; 8];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_srli_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(32);
        let result = _mm_srli_epi32::<3>(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [4; 4];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_srli_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(64);
        let result = _mm_srli_epi64::<4>(a);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        let expected = [4; 2];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_cmpeq_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(42);
        let b = _mm_set1_epi8(42);
        let result = _mm_cmpeq_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        let expected = [-1; 16];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_cmpeq_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(42);
        let b = _mm_set1_epi16(42);
        let result = _mm_cmpeq_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [-1; 8];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_cmpgt_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(10);
        let b = _mm_set1_epi8(5);
        let result = _mm_cmpgt_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        let expected = [-1; 16];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_cmpgt_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(100);
        let b = _mm_set1_epi16(50);
        let result = _mm_cmpgt_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [-1; 8];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_cmpgt_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(1000);
        let b = _mm_set1_epi32(500);
        let result = _mm_cmpgt_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [-1; 4];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_cmplt_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(5);
        let b = _mm_set1_epi8(10);
        let result = _mm_cmplt_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        let expected = [-1; 16];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_cmplt_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(50);
        let b = _mm_set1_epi16(100);
        let result = _mm_cmplt_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [-1; 8];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_cmplt_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(500);
        let b = _mm_set1_epi32(1000);
        let result = _mm_cmplt_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [-1; 4];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_set_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        let expected = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_set_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm_set_epi16(7, 6, 5, 4, 3, 2, 1, 0);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [0, 1, 2, 3, 4, 5, 6, 7];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_set_epi64x() -> Result<(), String> {
    unsafe {
        let result = _mm_set_epi64x(100, 200);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&result, &[200, 100])?;
    }
    Ok(())
}

pub(super) fn test_mm_set1_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm_set1_epi8(42);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        let expected = [42; 16];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_set1_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm_set1_epi16(42);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [42; 8];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_set1_epi64x() -> Result<(), String> {
    unsafe {
        let result = _mm_set1_epi64x(42);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        let expected = [42; 2];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_setr_epi8() -> Result<(), String> {
    unsafe {
        let result = _mm_setr_epi8(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        let expected = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_setr_epi16() -> Result<(), String> {
    unsafe {
        let result = _mm_setr_epi16(0, 1, 2, 3, 4, 5, 6, 7);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [0, 1, 2, 3, 4, 5, 6, 7];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_setr_epi32() -> Result<(), String> {
    unsafe {
        let result = _mm_setr_epi32(0, 1, 2, 3);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [0, 1, 2, 3];
        check_array_equality(&result, &expected)?;
    }
    Ok(())
}

pub(super) fn test_mm_loadl_epi64() -> Result<(), String> {
    unsafe {
        let data: [i64; 2] = [42, 100];
        let result = _mm_loadl_epi64(data.as_ptr() as *const __m128i);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&result, &[42, 0])?;
    }
    Ok(())
}

pub(super) fn test_mm_load_si128() -> Result<(), String> {
    // Ensure the data is 16-byte aligned so we can safely use _mm_load_si128
    #[repr(align(16))]
    struct Aligned([i32; 4]);

    unsafe {
        let data = Aligned([1, 2, 3, 4]);
        let result = _mm_load_si128(data.0.as_ptr() as *const __m128i);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[1, 2, 3, 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_loadu_si128() -> Result<(), String> {
    unsafe {
        let data: [i32; 4] = [10, 20, 30, 40];
        let result = _mm_loadu_si128(data.as_ptr() as *const __m128i);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[10, 20, 30, 40])?;
    }
    Ok(())
}

pub(super) fn test_mm_store_si128() -> Result<(), String> {
    // Ensure the destination is 16-byte aligned so _mm_store_si128 is valid
    #[repr(align(16))]
    struct Aligned([i32; 4]);

    unsafe {
        let mut data = Aligned([0; 4]);
        let vec = _mm_set_epi32(4, 3, 2, 1);
        _mm_store_si128(data.0.as_mut_ptr() as *mut __m128i, vec);
        check_array_equality(&data.0, &data.0)?;
    }
    Ok(())
}

pub(super) fn test_mm_storeu_si128() -> Result<(), String> {
    unsafe {
        let mut data: [i32; 4] = [0; 4];
        let vec = _mm_set_epi32(40, 30, 20, 10);
        _mm_storeu_si128(data.as_mut_ptr() as *mut __m128i, vec);
        check_array_equality(&data, &data)?;
    }
    Ok(())
}

pub(super) fn test_mm_storel_epi64() -> Result<(), String> {
    unsafe {
        let mut data: [i64; 2] = [0; 2];
        let vec = _mm_set_epi64x(100, 42);
        _mm_storel_epi64(data.as_mut_ptr() as *mut __m128i, vec);
        check_array_equality(&data, &data)?;
    }
    Ok(())
}

pub(super) fn test_mm_packs_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(200, 150, 100, 50, 10, -10, -50, -100);
        let b = _mm_set_epi16(127, 126, 125, 124, -128, -127, -126, -125);
        let result = _mm_packs_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);

        check_array_equality(&result, &[-100, -50, -10, 10, 50, 100, 127, 127, -125, -126, -127, -128, 124, 125, 126, 127])?;
    }
    Ok(())
}

pub(super) fn test_mm_packs_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(40000, 30000, 10, -10);
        let b = _mm_set_epi32(32767, 32766, -32768, -32767);
        let result = _mm_packs_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);

        check_array_equality(&result, &[-10, 10, 30000, 32767, -32767, -32768, 32766, 32767])?;
    }
    Ok(())
}