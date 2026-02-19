use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::values::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm512_set_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_set_epi8(1i8, 2i8, 3i8, 4i8, 5i8, 6i8, 7i8, 8i8, 9i8, 10i8, 11i8, 12i8, 13i8, 14i8, 15i8, 16i8, 17i8, 18i8, 19i8, 20i8, 21i8, 22i8, 23i8, 24i8, 25i8, 26i8, 27i8, 28i8, 29i8, 30i8, 31i8, 32i8, 33i8, 34i8, 35i8, 36i8, 37i8, 38i8, 39i8, 40i8, 41i8, 42i8, 43i8, 44i8, 45i8, 46i8, 47i8, 48i8, 49i8, 50i8, 51i8, 52i8, 53i8, 54i8, 55i8, 56i8, 57i8, 58i8, 59i8, 60i8, 61i8, 62i8, 63i8, 64i8));
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
        let result = unpack__m512i_to_i32_array(_mm512_set_epi16(1i16, 2i16, 3i16, 4i16, 5i16, 6i16, 7i16, 8i16, 9i16, 10i16, 11i16, 12i16, 13i16, 14i16, 15i16, 16i16, 17i16, 18i16, 19i16, 20i16, 21i16, 22i16, 23i16, 24i16, 25i16, 26i16, 27i16, 28i16, 29i16, 30i16, 31i16, 32i16));
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
        let result = unpack__m512i_to_i32_array(_mm512_set4_epi32(1i32, 2i32, 3i32, 4i32));
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
        let result = unpack__m512_to_f32_array(_mm512_set4_ps(1.0f32, 2.0f32, 3.0f32, 4.0f32));
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
        let result = unpack__m512d_to_f64_array(_mm512_set4_pd(1.0f64, 2.0f64, 3.0f64, 4.0f64));
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
        let result = unpack__m512i_to_i32_array(_mm512_setr4_epi32(1i32, 2i32, 3i32, 4i32));
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
        let result = unpack__m512_to_f32_array(_mm512_setr4_ps(1.0f32, 2.0f32, 3.0f32, 4.0f32));
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
        let result = unpack__m512d_to_f64_array(_mm512_setr4_pd(1.0f64, 2.0f64, 3.0f64, 4.0f64));
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
        let result = unpack__m512i_to_i32_array(_mm512_set_epi64(1i64, 2i64, 3i64, 4i64, 5i64, 6i64, 7i64, 8i64));
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
        let result = unpack__m512i_to_i32_array(_mm512_setr_epi64(1i64, 2i64, 3i64, 4i64, 5i64, 6i64, 7i64, 8i64));
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
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = [1.0f64; 64];
        let result = unpack__m512d_to_f64_array(_mm512_i32gather_pd::<1>(offsets, ptr_slice.as_ptr()));
        check_array_equality(&result, &[0.0f64; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm512_mask_i32gather_pd() -> Result<(), String> {
    unsafe {
        let src = create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        let mask = create__mmask8_from(0b01010101);
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = [1.0f64; 64];
        let result = unpack__m512d_to_f64_array(_mm512_mask_i32gather_pd::<1>(src, mask, offsets, ptr_slice.as_ptr()));
        check_array_equality(&result, &[0.0f64; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm512_i64gather_pd() -> Result<(), String> {
    unsafe {
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = [1.0f64; 64];
        let result = unpack__m512d_to_f64_array(_mm512_i64gather_pd::<1>(offsets, ptr_slice.as_ptr()));
        check_array_equality(&result, &[0.0f64; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm512_mask_i64gather_pd() -> Result<(), String> {
    unsafe {
        let src = create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        let mask = create__mmask8_from(0b01010101);
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = [1.0f64; 64];
        let result = unpack__m512d_to_f64_array(_mm512_mask_i64gather_pd::<1>(src, mask, offsets, ptr_slice.as_ptr()));
        check_array_equality(&result, &[0.0f64; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm512_i64gather_ps() -> Result<(), String> {
    unsafe {
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = [1.0f32; 64];
        let result = unpack__m256_to_f32_array(_mm512_i64gather_ps::<1>(offsets, ptr_slice.as_ptr()));
        check_array_equality(&result, &[0.0f32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm512_mask_i64gather_ps() -> Result<(), String> {
    unsafe {
        let src = create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        let mask = create__mmask8_from(0b01010101);
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = [1.0f32; 64];
        let result = unpack__m256_to_f32_array(_mm512_mask_i64gather_ps::<1>(src, mask, offsets, ptr_slice.as_ptr()));
        check_array_equality(&result, &[0.0f32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm512_i32gather_ps() -> Result<(), String> {
    unsafe {
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = [1.0f32; 64];
        let result = unpack__m512_to_f32_array(_mm512_i32gather_ps::<1>(offsets, ptr_slice.as_ptr()));
        check_array_equality(&result, &[0.0f32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm512_mask_i32gather_ps() -> Result<(), String> {
    unsafe {
        let src = create__m512_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]);
        let mask = create__mmask16_from(0b0101010101010101);
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = [1.0f32; 64];
        let result = unpack__m512_to_f32_array(_mm512_mask_i32gather_ps::<1>(src, mask, offsets, ptr_slice.as_ptr()));
        check_array_equality(&result, &[0.0f32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm512_i32gather_epi32() -> Result<(), String> {
    unsafe {
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = [1i32; 64];
        let result = unpack__m512i_to_i32_array(_mm512_i32gather_epi32::<1>(offsets, ptr_slice.as_ptr()));
        check_array_equality(&result, &[0i32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm512_mask_i32gather_epi32() -> Result<(), String> {
    unsafe {
        let src = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let mask = create__mmask16_from(0b0101010101010101);
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = [1i32; 64];
        let result = unpack__m512i_to_i32_array(_mm512_mask_i32gather_epi32::<1>(src, mask, offsets, ptr_slice.as_ptr()));
        check_array_equality(&result, &[0i32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm512_i32gather_epi64() -> Result<(), String> {
    unsafe {
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = [1i64; 64];
        let result = unpack__m512i_to_i32_array(_mm512_i32gather_epi64::<1>(offsets, ptr_slice.as_ptr()));
        check_array_equality(&result, &[0i32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm512_mask_i32gather_epi64() -> Result<(), String> {
    unsafe {
        let src = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let mask = create__mmask8_from(0b01010101);
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = [1i64; 64];
        let result = unpack__m512i_to_i32_array(_mm512_mask_i32gather_epi64::<1>(src, mask, offsets, ptr_slice.as_ptr()));
        check_array_equality(&result, &[0i32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm512_i64gather_epi64() -> Result<(), String> {
    unsafe {
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = [1i64; 64];
        let result = unpack__m512i_to_i32_array(_mm512_i64gather_epi64::<1>(offsets, ptr_slice.as_ptr()));
        check_array_equality(&result, &[0i32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm512_mask_i64gather_epi64() -> Result<(), String> {
    unsafe {
        let src = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let mask = create__mmask8_from(0b01010101);
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = [1i64; 64];
        let result = unpack__m512i_to_i32_array(_mm512_mask_i64gather_epi64::<1>(src, mask, offsets, ptr_slice.as_ptr()));
        check_array_equality(&result, &[0i32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm512_i64gather_epi32() -> Result<(), String> {
    unsafe {
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = [1i32; 64];
        let result = unpack__m256i_to_i32_array(_mm512_i64gather_epi32::<1>(offsets, ptr_slice.as_ptr()));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm512_mask_i64gather_epi32() -> Result<(), String> {
    unsafe {
        let src = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let mask = create__mmask8_from(0b01010101);
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let ptr_slice = [1i32; 64];
        let result = unpack__m256i_to_i32_array(_mm512_mask_i64gather_epi32::<1>(src, mask, offsets, ptr_slice.as_ptr()));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm512_i32scatter_pd() -> Result<(), String> {
    unsafe {
        let mut ptr_slice = [1.0f64; 64];
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let src = create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        _mm512_i32scatter_pd::<1>(ptr_slice.as_mut_ptr(), offsets, src);
    }
    Ok(())
}

pub(super) fn test_mm512_mask_i32scatter_pd() -> Result<(), String> {
    unsafe {
        let mut ptr_slice = [1.0f64; 64];
        let mask = create__mmask8_from(0b01010101);
        let offsets = create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0]);
        let src = create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        _mm512_mask_i32scatter_pd::<1>(ptr_slice.as_mut_ptr(), mask, offsets, src);
    }
    Ok(())
}

pub(super) fn test_mm512_i64scatter_pd() -> Result<(), String> {
    unsafe {
        let mut ptr_slice = [1.0f64; 64];
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let src = create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        _mm512_i64scatter_pd::<1>(ptr_slice.as_mut_ptr(), offsets, src);
    }
    Ok(())
}

pub(super) fn test_mm512_mask_i64scatter_pd() -> Result<(), String> {
    unsafe {
        let mut ptr_slice = [1.0f64; 64];
        let mask = create__mmask8_from(0b01010101);
        let offsets = create__m512i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        let src = create__m512d_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        _mm512_mask_i64scatter_pd::<1>(ptr_slice.as_mut_ptr(), mask, offsets, src);
    }
    Ok(())
}
