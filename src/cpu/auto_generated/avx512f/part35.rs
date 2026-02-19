use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm512_set_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_set_epi8(1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8, 1i8));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_set_epi8(rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_set_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_set_epi16(1i16, 1i16, 1i16, 1i16, 1i16, 1i16, 1i16, 1i16, 1i16, 1i16, 1i16, 1i16, 1i16, 1i16, 1i16, 1i16, 1i16, 1i16, 1i16, 1i16, 1i16, 1i16, 1i16, 1i16, 1i16, 1i16, 1i16, 1i16, 1i16, 1i16, 1i16, 1i16));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_set_epi16(rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_set4_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_set4_epi32(1i32, 1i32, 1i32, 1i32));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_set4_epi32(rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_set4_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_set4_ps(1.0f32, 1.0f32, 1.0f32, 1.0f32));
        check_array_equality(&result, &[0.0f32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_set4_ps(rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_set4_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_set4_pd(1.0f64, 1.0f64, 1.0f64, 1.0f64));
        check_array_equality(&result, &[0.0f64; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_set4_pd(rand::random::<f64>(), rand::random::<f64>(), rand::random::<f64>(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_setr4_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_setr4_epi32(1i32, 1i32, 1i32, 1i32));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_setr4_epi32(rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_setr4_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_setr4_ps(1.0f32, 1.0f32, 1.0f32, 1.0f32));
        check_array_equality(&result, &[0.0f32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_setr4_ps(rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>(), rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_setr4_pd() -> Result<(), String> {
    unsafe {
        let result = unpack__m512d_to_f64_array(_mm512_setr4_pd(1.0f64, 1.0f64, 1.0f64, 1.0f64));
        check_array_equality(&result, &[0.0f64; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_setr4_pd(rand::random::<f64>(), rand::random::<f64>(), rand::random::<f64>(), rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_set_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_set_epi64(1i64, 1i64, 1i64, 1i64, 1i64, 1i64, 1i64, 1i64));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_set_epi64(rand::random::<i64>(), rand::random::<i64>(), rand::random::<i64>(), rand::random::<i64>(), rand::random::<i64>(), rand::random::<i64>(), rand::random::<i64>(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_setr_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_setr_epi64(1i64, 1i64, 1i64, 1i64, 1i64, 1i64, 1i64, 1i64));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_setr_epi64(rand::random::<i64>(), rand::random::<i64>(), rand::random::<i64>(), rand::random::<i64>(), rand::random::<i64>(), rand::random::<i64>(), rand::random::<i64>(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_i32gather_pd() -> Result<(), String> {
    unsafe {
        let offsets = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let ptr_slice = [1.0f64; 1];
        let result = unpack__m512d_to_f64_array(_mm512_i32gather_pd::<0>(offsets, ptr_slice.as_ptr()));
        check_array_equality(&result, &[0.0f64; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm512_mask_i32gather_pd() -> Result<(), String> {
    unsafe {
        let src = create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        let mask = create__mmask8_from(0b01010101);
        let offsets = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let ptr_slice = [1.0f64; 1];
        let result = unpack__m512d_to_f64_array(_mm512_mask_i32gather_pd::<0>(src, mask, offsets, ptr_slice.as_ptr()));
        check_array_equality(&result, &[0.0f64; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm512_i64gather_pd() -> Result<(), String> {
    unsafe {
        let offsets = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let ptr_slice = [1.0f64; 1];
        let result = unpack__m512d_to_f64_array(_mm512_i64gather_pd::<0>(offsets, ptr_slice.as_ptr()));
        check_array_equality(&result, &[0.0f64; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm512_mask_i64gather_pd() -> Result<(), String> {
    unsafe {
        let src = create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        let mask = create__mmask8_from(0b01010101);
        let offsets = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let ptr_slice = [1.0f64; 1];
        let result = unpack__m512d_to_f64_array(_mm512_mask_i64gather_pd::<0>(src, mask, offsets, ptr_slice.as_ptr()));
        check_array_equality(&result, &[0.0f64; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm512_i64gather_ps() -> Result<(), String> {
    unsafe {
        let offsets = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let ptr_slice = [1.0f32; 1];
        let result = unpack__m256_to_f32_array(_mm512_i64gather_ps::<0>(offsets, ptr_slice.as_ptr()));
        check_array_equality(&result, &[0.0f32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm512_mask_i64gather_ps() -> Result<(), String> {
    unsafe {
        let src = create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        let mask = create__mmask8_from(0b01010101);
        let offsets = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let ptr_slice = [1.0f32; 1];
        let result = unpack__m256_to_f32_array(_mm512_mask_i64gather_ps::<0>(src, mask, offsets, ptr_slice.as_ptr()));
        check_array_equality(&result, &[0.0f32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm512_i32gather_ps() -> Result<(), String> {
    unsafe {
        let offsets = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let ptr_slice = [1.0f32; 1];
        let result = unpack__m512_to_f32_array(_mm512_i32gather_ps::<0>(offsets, ptr_slice.as_ptr()));
        check_array_equality(&result, &[0.0f32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm512_mask_i32gather_ps() -> Result<(), String> {
    unsafe {
        let src = create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]);
        let mask = create__mmask16_from(0b0101010101010101);
        let offsets = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let ptr_slice = [1.0f32; 1];
        let result = unpack__m512_to_f32_array(_mm512_mask_i32gather_ps::<0>(src, mask, offsets, ptr_slice.as_ptr()));
        check_array_equality(&result, &[0.0f32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm512_i32gather_epi32() -> Result<(), String> {
    unsafe {
        let offsets = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let ptr_slice = [1i32; 1];
        let result = unpack__m512i_to_i32_array(_mm512_i32gather_epi32::<0>(offsets, ptr_slice.as_ptr()));
        check_array_equality(&result, &[0i32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm512_mask_i32gather_epi32() -> Result<(), String> {
    unsafe {
        let src = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let mask = create__mmask16_from(0b0101010101010101);
        let offsets = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let ptr_slice = [1i32; 1];
        let result = unpack__m512i_to_i32_array(_mm512_mask_i32gather_epi32::<0>(src, mask, offsets, ptr_slice.as_ptr()));
        check_array_equality(&result, &[0i32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm512_i32gather_epi64() -> Result<(), String> {
    unsafe {
        let offsets = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let ptr_slice = [1i64; 1];
        let result = unpack__m512i_to_i32_array(_mm512_i32gather_epi64::<0>(offsets, ptr_slice.as_ptr()));
        check_array_equality(&result, &[0i32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm512_mask_i32gather_epi64() -> Result<(), String> {
    unsafe {
        let src = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let mask = create__mmask8_from(0b01010101);
        let offsets = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let ptr_slice = [1i64; 1];
        let result = unpack__m512i_to_i32_array(_mm512_mask_i32gather_epi64::<0>(src, mask, offsets, ptr_slice.as_ptr()));
        check_array_equality(&result, &[0i32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm512_i64gather_epi64() -> Result<(), String> {
    unsafe {
        let offsets = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let ptr_slice = [1i64; 1];
        let result = unpack__m512i_to_i32_array(_mm512_i64gather_epi64::<0>(offsets, ptr_slice.as_ptr()));
        check_array_equality(&result, &[0i32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm512_mask_i64gather_epi64() -> Result<(), String> {
    unsafe {
        let src = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let mask = create__mmask8_from(0b01010101);
        let offsets = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let ptr_slice = [1i64; 1];
        let result = unpack__m512i_to_i32_array(_mm512_mask_i64gather_epi64::<0>(src, mask, offsets, ptr_slice.as_ptr()));
        check_array_equality(&result, &[0i32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm512_i64gather_epi32() -> Result<(), String> {
    unsafe {
        let offsets = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let ptr_slice = [1i32; 1];
        let result = unpack__m256i_to_i32_array(_mm512_i64gather_epi32::<0>(offsets, ptr_slice.as_ptr()));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm512_mask_i64gather_epi32() -> Result<(), String> {
    unsafe {
        let src = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let mask = create__mmask8_from(0b01010101);
        let offsets = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let ptr_slice = [1i32; 1];
        let result = unpack__m256i_to_i32_array(_mm512_mask_i64gather_epi32::<0>(src, mask, offsets, ptr_slice.as_ptr()));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm512_i32scatter_pd() -> Result<(), String> {
    unsafe {
        let mut ptr_slice = [1.0f64; 1];
        let offsets = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let src = create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        _mm512_i32scatter_pd::<0>(ptr_slice.as_mut_ptr(), offsets, src);
    }
    Ok(())
}

pub(super) fn test_mm512_mask_i32scatter_pd() -> Result<(), String> {
    unsafe {
        let mut ptr_slice = [1.0f64; 1];
        let mask = create__mmask8_from(0b01010101);
        let offsets = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let src = create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        _mm512_mask_i32scatter_pd::<0>(ptr_slice.as_mut_ptr(), mask, offsets, src);
    }
    Ok(())
}

pub(super) fn test_mm512_i64scatter_pd() -> Result<(), String> {
    unsafe {
        let mut ptr_slice = [1.0f64; 1];
        let offsets = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let src = create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        _mm512_i64scatter_pd::<0>(ptr_slice.as_mut_ptr(), offsets, src);
    }
    Ok(())
}

pub(super) fn test_mm512_mask_i64scatter_pd() -> Result<(), String> {
    unsafe {
        let mut ptr_slice = [1.0f64; 1];
        let mask = create__mmask8_from(0b01010101);
        let offsets = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let src = create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        _mm512_mask_i64scatter_pd::<0>(ptr_slice.as_mut_ptr(), mask, offsets, src);
    }
    Ok(())
}
