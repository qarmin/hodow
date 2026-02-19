use std::arch::x86_64::*;

use crate::cpu::common::values::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm512_i32scatter_ps() -> Result<(), String> {
    unsafe {
        let mut ptr_slice = [1.0f32; 1];
        let offsets = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let src = create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]);
        _mm512_i32scatter_ps::<1>(ptr_slice.as_mut_ptr(), offsets, src);
    }
    Ok(())
}

pub(super) fn test_mm512_mask_i32scatter_ps() -> Result<(), String> {
    unsafe {
        let mut ptr_slice = [1.0f32; 1];
        let mask = create__mmask16_from(0b0101010101010101);
        let offsets = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let src = create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]);
        _mm512_mask_i32scatter_ps::<1>(ptr_slice.as_mut_ptr(), mask, offsets, src);
    }
    Ok(())
}

pub(super) fn test_mm512_i64scatter_ps() -> Result<(), String> {
    unsafe {
        let mut ptr_slice = [1.0f32; 1];
        let offsets = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let src = create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        _mm512_i64scatter_ps::<1>(ptr_slice.as_mut_ptr(), offsets, src);
    }
    Ok(())
}

pub(super) fn test_mm512_mask_i64scatter_ps() -> Result<(), String> {
    unsafe {
        let mut ptr_slice = [1.0f32; 1];
        let mask = create__mmask8_from(0b01010101);
        let offsets = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let src = create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        _mm512_mask_i64scatter_ps::<1>(ptr_slice.as_mut_ptr(), mask, offsets, src);
    }
    Ok(())
}

pub(super) fn test_mm512_i32scatter_epi64() -> Result<(), String> {
    unsafe {
        let mut ptr_slice = [1i64; 1];
        let offsets = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let src = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        _mm512_i32scatter_epi64::<1>(ptr_slice.as_mut_ptr(), offsets, src);
    }
    Ok(())
}

pub(super) fn test_mm512_mask_i32scatter_epi64() -> Result<(), String> {
    unsafe {
        let mut ptr_slice = [1i64; 1];
        let mask = create__mmask8_from(0b01010101);
        let offsets = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let src = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        _mm512_mask_i32scatter_epi64::<1>(ptr_slice.as_mut_ptr(), mask, offsets, src);
    }
    Ok(())
}

pub(super) fn test_mm512_i64scatter_epi64() -> Result<(), String> {
    unsafe {
        let mut ptr_slice = [1i64; 1];
        let offsets = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let src = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        _mm512_i64scatter_epi64::<1>(ptr_slice.as_mut_ptr(), offsets, src);
    }
    Ok(())
}

pub(super) fn test_mm512_mask_i64scatter_epi64() -> Result<(), String> {
    unsafe {
        let mut ptr_slice = [1i64; 1];
        let mask = create__mmask8_from(0b01010101);
        let offsets = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let src = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        _mm512_mask_i64scatter_epi64::<1>(ptr_slice.as_mut_ptr(), mask, offsets, src);
    }
    Ok(())
}

pub(super) fn test_mm512_i32scatter_epi32() -> Result<(), String> {
    unsafe {
        let mut ptr_slice = [1i32; 1];
        let offsets = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let src = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        _mm512_i32scatter_epi32::<1>(ptr_slice.as_mut_ptr(), offsets, src);
    }
    Ok(())
}

pub(super) fn test_mm512_mask_i32scatter_epi32() -> Result<(), String> {
    unsafe {
        let mut ptr_slice = [1i32; 1];
        let mask = create__mmask16_from(0b0101010101010101);
        let offsets = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let src = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        _mm512_mask_i32scatter_epi32::<1>(ptr_slice.as_mut_ptr(), mask, offsets, src);
    }
    Ok(())
}

pub(super) fn test_mm512_i64scatter_epi32() -> Result<(), String> {
    unsafe {
        let mut ptr_slice = [1i32; 1];
        let offsets = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let src = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        _mm512_i64scatter_epi32::<1>(ptr_slice.as_mut_ptr(), offsets, src);
    }
    Ok(())
}

pub(super) fn test_mm512_mask_i64scatter_epi32() -> Result<(), String> {
    unsafe {
        let mut ptr_slice = [1i32; 1];
        let mask = create__mmask8_from(0b01010101);
        let offsets = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let src = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        _mm512_mask_i64scatter_epi32::<1>(ptr_slice.as_mut_ptr(), mask, offsets, src);
    }
    Ok(())
}

pub(super) fn test_mm512_i32logather_epi64() -> Result<(), String> {
    unsafe {
        let vindex = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let ptr_base_addr = [1i64; 1];
        let result = unpack__m512i_to_i32_array(_mm512_i32logather_epi64::<1>(vindex, ptr_base_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm512_mask_i32logather_epi64() -> Result<(), String> {
    unsafe {
        let src = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let ptr_base_addr = [1i64; 1];
        let result = unpack__m512i_to_i32_array(_mm512_mask_i32logather_epi64::<1>(src, k, vindex, ptr_base_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm512_i32logather_pd() -> Result<(), String> {
    unsafe {
        let vindex = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let ptr_base_addr = [1.0f64; 1];
        let result = unpack__m512d_to_f64_array(_mm512_i32logather_pd::<1>(vindex, ptr_base_addr.as_ptr()));
        check_array_equality(&result, &[0.0f64; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm512_mask_i32logather_pd() -> Result<(), String> {
    unsafe {
        let src = create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let ptr_base_addr = [1.0f64; 1];
        let result = unpack__m512d_to_f64_array(_mm512_mask_i32logather_pd::<1>(src, k, vindex, ptr_base_addr.as_ptr()));
        check_array_equality(&result, &[0.0f64; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm512_i32loscatter_epi64() -> Result<(), String> {
    unsafe {
        let mut ptr_base_addr = [1i64; 1];
        let vindex = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        _mm512_i32loscatter_epi64::<1>(ptr_base_addr.as_mut_ptr(), vindex, a);
    }
    Ok(())
}

pub(super) fn test_mm512_mask_i32loscatter_epi64() -> Result<(), String> {
    unsafe {
        let mut ptr_base_addr = [1i64; 1];
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        _mm512_mask_i32loscatter_epi64::<1>(ptr_base_addr.as_mut_ptr(), k, vindex, a);
    }
    Ok(())
}

pub(super) fn test_mm512_i32loscatter_pd() -> Result<(), String> {
    unsafe {
        let mut ptr_base_addr = [1.0f64; 1];
        let vindex = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let a = create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        _mm512_i32loscatter_pd::<1>(ptr_base_addr.as_mut_ptr(), vindex, a);
    }
    Ok(())
}

pub(super) fn test_mm512_mask_i32loscatter_pd() -> Result<(), String> {
    unsafe {
        let mut ptr_base_addr = [1.0f64; 1];
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let a = create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        _mm512_mask_i32loscatter_pd::<1>(ptr_base_addr.as_mut_ptr(), k, vindex, a);
    }
    Ok(())
}

pub(super) fn test_mm256_i32scatter_epi32() -> Result<(), String> {
    unsafe {
        let mut ptr_base_addr = [1i32; 1];
        let vindex = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        _mm256_i32scatter_epi32::<1>(ptr_base_addr.as_mut_ptr(), vindex, a);
    }
    Ok(())
}

pub(super) fn test_mm256_mask_i32scatter_epi32() -> Result<(), String> {
    unsafe {
        let mut ptr_base_addr = [1i32; 1];
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        _mm256_mask_i32scatter_epi32::<1>(ptr_base_addr.as_mut_ptr(), k, vindex, a);
    }
    Ok(())
}

pub(super) fn test_mm256_i32scatter_epi64() -> Result<(), String> {
    unsafe {
        let mut ptr_slice = [1i64; 1];
        let offsets = create__m128i_from_i32_array([1, 2, 3, 4]);
        let src = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        _mm256_i32scatter_epi64::<1>(ptr_slice.as_mut_ptr(), offsets, src);
    }
    Ok(())
}

pub(super) fn test_mm256_mask_i32scatter_epi64() -> Result<(), String> {
    unsafe {
        let mut ptr_base_addr = [1i64; 1];
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m128i_from_i32_array([1, 2, 3, 4]);
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        _mm256_mask_i32scatter_epi64::<1>(ptr_base_addr.as_mut_ptr(), k, vindex, a);
    }
    Ok(())
}

pub(super) fn test_mm256_i32scatter_pd() -> Result<(), String> {
    unsafe {
        let mut ptr_base_addr = [1.0f64; 1];
        let vindex = create__m128i_from_i32_array([1, 2, 3, 4]);
        let a = create__m256d_from([1.0, 2.0, 3.0, 4.0]);
        _mm256_i32scatter_pd::<1>(ptr_base_addr.as_mut_ptr(), vindex, a);
    }
    Ok(())
}

pub(super) fn test_mm256_mask_i32scatter_pd() -> Result<(), String> {
    unsafe {
        let mut ptr_base_addr = [1.0f64; 1];
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m128i_from_i32_array([1, 2, 3, 4]);
        let a = create__m256d_from([1.0, 2.0, 3.0, 4.0]);
        _mm256_mask_i32scatter_pd::<1>(ptr_base_addr.as_mut_ptr(), k, vindex, a);
    }
    Ok(())
}

pub(super) fn test_mm256_i32scatter_ps() -> Result<(), String> {
    unsafe {
        let mut ptr_base_addr = [1.0f32; 1];
        let vindex = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let a = create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        _mm256_i32scatter_ps::<1>(ptr_base_addr.as_mut_ptr(), vindex, a);
    }
    Ok(())
}

pub(super) fn test_mm256_mask_i32scatter_ps() -> Result<(), String> {
    unsafe {
        let mut ptr_base_addr = [1.0f32; 1];
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let a = create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        _mm256_mask_i32scatter_ps::<1>(ptr_base_addr.as_mut_ptr(), k, vindex, a);
    }
    Ok(())
}

pub(super) fn test_mm256_i64scatter_epi32() -> Result<(), String> {
    unsafe {
        let mut ptr_base_addr = [1i32; 1];
        let vindex = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm256_i64scatter_epi32::<1>(ptr_base_addr.as_mut_ptr(), vindex, a);
    }
    Ok(())
}

pub(super) fn test_mm256_mask_i64scatter_epi32() -> Result<(), String> {
    unsafe {
        let mut ptr_base_addr = [1i32; 1];
        let k = create__mmask8_from(0b01010101);
        let vindex = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm256_mask_i64scatter_epi32::<1>(ptr_base_addr.as_mut_ptr(), k, vindex, a);
    }
    Ok(())
}
