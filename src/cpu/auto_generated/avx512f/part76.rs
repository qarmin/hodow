use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::values::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm512_maskz_loadu_pd() -> Result<(), String> {
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [1.0f64; 1];
        let result = unpack__m512d_to_f64_array(_mm512_maskz_loadu_pd(k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0.0f64; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm256_mask_loadu_epi32() -> Result<(), String> {
    unsafe {
        let src = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [9i32; 1];
        let result = unpack__m256i_to_i32_array(_mm256_mask_loadu_epi32(src, k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_loadu_epi32() -> Result<(), String> {
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [1i32; 1];
        let result = unpack__m256i_to_i32_array(_mm256_maskz_loadu_epi32(k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm256_mask_loadu_epi64() -> Result<(), String> {
    unsafe {
        let src = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [9i64; 1];
        let result = unpack__m256i_to_i32_array(_mm256_mask_loadu_epi64(src, k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_loadu_epi64() -> Result<(), String> {
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [1i64; 1];
        let result = unpack__m256i_to_i32_array(_mm256_maskz_loadu_epi64(k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm256_mask_loadu_ps() -> Result<(), String> {
    unsafe {
        let src = create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [9.0f32; 1];
        let result = unpack__m256_to_f32_array(_mm256_mask_loadu_ps(src, k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0.0f32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_loadu_ps() -> Result<(), String> {
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [1.0f32; 1];
        let result = unpack__m256_to_f32_array(_mm256_maskz_loadu_ps(k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0.0f32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm256_mask_loadu_pd() -> Result<(), String> {
    unsafe {
        let src = create__m256d_from([1.0, 2.0, 3.0, 4.0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [5.0f64; 1];
        let result = unpack__m256d_to_f64_array(_mm256_mask_loadu_pd(src, k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0.0f64; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_loadu_pd() -> Result<(), String> {
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [1.0f64; 1];
        let result = unpack__m256d_to_f64_array(_mm256_maskz_loadu_pd(k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0.0f64; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_loadu_epi32() -> Result<(), String> {
    unsafe {
        let src = create__m128i_from_i32_array([1, 2, 3, 4]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [5i32; 1];
        let result = unpack__m128i_to_i32_array(_mm_mask_loadu_epi32(src, k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_maskz_loadu_epi32() -> Result<(), String> {
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [1i32; 1];
        let result = unpack__m128i_to_i32_array(_mm_maskz_loadu_epi32(k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_loadu_epi64() -> Result<(), String> {
    unsafe {
        let src = create__m128i_from_i32_array([1, 2, 3, 4]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [5i64; 1];
        let result = unpack__m128i_to_i32_array(_mm_mask_loadu_epi64(src, k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_maskz_loadu_epi64() -> Result<(), String> {
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [1i64; 1];
        let result = unpack__m128i_to_i32_array(_mm_maskz_loadu_epi64(k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_loadu_ps() -> Result<(), String> {
    unsafe {
        let src = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [5.0f32; 1];
        let result = unpack__m128_to_f32_array(_mm_mask_loadu_ps(src, k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0.0f32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_maskz_loadu_ps() -> Result<(), String> {
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [1.0f32; 1];
        let result = unpack__m128_to_f32_array(_mm_maskz_loadu_ps(k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0.0f32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_loadu_pd() -> Result<(), String> {
    unsafe {
        let src = create__m128d_from([1.0, 2.0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [3.0f64; 1];
        let result = unpack__m128d_to_f64_array(_mm_mask_loadu_pd(src, k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0.0f64; 2])?;
    }
    Ok(())
}

pub(super) fn test_mm_maskz_loadu_pd() -> Result<(), String> {
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [1.0f64; 1];
        let result = unpack__m128d_to_f64_array(_mm_maskz_loadu_pd(k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0.0f64; 2])?;
    }
    Ok(())
}

pub(super) fn test_mm512_mask_load_epi32() -> Result<(), String> {
    unsafe {
        let src = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = [17i32; 1];
        let result = unpack__m512i_to_i32_array(_mm512_mask_load_epi32(src, k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_load_epi32() -> Result<(), String> {
    unsafe {
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = [1i32; 1];
        let result = unpack__m512i_to_i32_array(_mm512_maskz_load_epi32(k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm512_mask_load_epi64() -> Result<(), String> {
    unsafe {
        let src = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [17i64; 1];
        let result = unpack__m512i_to_i32_array(_mm512_mask_load_epi64(src, k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_load_epi64() -> Result<(), String> {
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [1i64; 1];
        let result = unpack__m512i_to_i32_array(_mm512_maskz_load_epi64(k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm512_mask_load_ps() -> Result<(), String> {
    unsafe {
        let src = create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = [17.0f32; 1];
        let result = unpack__m512_to_f32_array(_mm512_mask_load_ps(src, k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0.0f32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_load_ps() -> Result<(), String> {
    unsafe {
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = [1.0f32; 1];
        let result = unpack__m512_to_f32_array(_mm512_maskz_load_ps(k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0.0f32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm512_mask_load_pd() -> Result<(), String> {
    unsafe {
        let src = create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [9.0f64; 1];
        let result = unpack__m512d_to_f64_array(_mm512_mask_load_pd(src, k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0.0f64; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_load_pd() -> Result<(), String> {
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [1.0f64; 1];
        let result = unpack__m512d_to_f64_array(_mm512_maskz_load_pd(k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0.0f64; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm256_mask_load_epi32() -> Result<(), String> {
    unsafe {
        let src = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [9i32; 1];
        let result = unpack__m256i_to_i32_array(_mm256_mask_load_epi32(src, k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_load_epi32() -> Result<(), String> {
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [1i32; 1];
        let result = unpack__m256i_to_i32_array(_mm256_maskz_load_epi32(k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm256_mask_load_epi64() -> Result<(), String> {
    unsafe {
        let src = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [9i64; 1];
        let result = unpack__m256i_to_i32_array(_mm256_mask_load_epi64(src, k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_load_epi64() -> Result<(), String> {
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [1i64; 1];
        let result = unpack__m256i_to_i32_array(_mm256_maskz_load_epi64(k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm256_mask_load_ps() -> Result<(), String> {
    unsafe {
        let src = create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [9.0f32; 1];
        let result = unpack__m256_to_f32_array(_mm256_mask_load_ps(src, k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0.0f32; 8])?;
    }
    Ok(())
}
