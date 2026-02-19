use std::arch::x86_64::*;

use crate::cpu::common::values::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm256_hsubs_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_hsubs_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_hsubs_epi16(create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_i32gather_epi32() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1i32; 1];
        let offsets = create__m128i_from_i32_array([1, 2, 3, 4]);
        let result = unpack__m128i_to_i32_array(_mm_i32gather_epi32::<1>(ptr_slice.as_ptr(), offsets));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_i32gather_epi32() -> Result<(), String> {
    unsafe {
        let src = create__m128i_from_i32_array([1, 2, 3, 4]);
        let ptr_slice = [1i32; 1];
        let offsets = create__m128i_from_i32_array([1, 2, 3, 4]);
        let mask = create__m128i_from_i32_array([1, 2, 3, 4]);
        let result = unpack__m128i_to_i32_array(_mm_mask_i32gather_epi32::<1>(src, ptr_slice.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm256_i32gather_epi32() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1i32; 1];
        let offsets = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let result = unpack__m256i_to_i32_array(_mm256_i32gather_epi32::<1>(ptr_slice.as_ptr(), offsets));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm256_mask_i32gather_epi32() -> Result<(), String> {
    unsafe {
        let src = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let ptr_slice = [1i32; 1];
        let offsets = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let mask = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let result = unpack__m256i_to_i32_array(_mm256_mask_i32gather_epi32::<1>(src, ptr_slice.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm_i32gather_ps() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1.0f32; 1];
        let offsets = create__m128i_from_i32_array([1, 2, 3, 4]);
        let result = unpack__m128_to_f32_array(_mm_i32gather_ps::<1>(ptr_slice.as_ptr(), offsets));
        check_array_equality(&result, &[0.0f32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_i32gather_ps() -> Result<(), String> {
    unsafe {
        let src = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        let ptr_slice = [1.0f32; 1];
        let offsets = create__m128i_from_i32_array([1, 2, 3, 4]);
        let mask = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        let result = unpack__m128_to_f32_array(_mm_mask_i32gather_ps::<1>(src, ptr_slice.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0.0f32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm256_i32gather_ps() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1.0f32; 1];
        let offsets = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let result = unpack__m256_to_f32_array(_mm256_i32gather_ps::<1>(ptr_slice.as_ptr(), offsets));
        check_array_equality(&result, &[0.0f32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm256_mask_i32gather_ps() -> Result<(), String> {
    unsafe {
        let src = create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        let ptr_slice = [1.0f32; 1];
        let offsets = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let mask = create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        let result = unpack__m256_to_f32_array(_mm256_mask_i32gather_ps::<1>(src, ptr_slice.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0.0f32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm_i32gather_epi64() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1i64; 1];
        let offsets = create__m128i_from_i32_array([1, 2, 3, 4]);
        let result = unpack__m128i_to_i32_array(_mm_i32gather_epi64::<1>(ptr_slice.as_ptr(), offsets));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_i32gather_epi64() -> Result<(), String> {
    unsafe {
        let src = create__m128i_from_i32_array([1, 2, 3, 4]);
        let ptr_slice = [1i64; 1];
        let offsets = create__m128i_from_i32_array([1, 2, 3, 4]);
        let mask = create__m128i_from_i32_array([1, 2, 3, 4]);
        let result = unpack__m128i_to_i32_array(_mm_mask_i32gather_epi64::<1>(src, ptr_slice.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm256_i32gather_epi64() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1i64; 1];
        let offsets = create__m128i_from_i32_array([1, 2, 3, 4]);
        let result = unpack__m256i_to_i32_array(_mm256_i32gather_epi64::<1>(ptr_slice.as_ptr(), offsets));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm256_mask_i32gather_epi64() -> Result<(), String> {
    unsafe {
        let src = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let ptr_slice = [1i64; 1];
        let offsets = create__m128i_from_i32_array([1, 2, 3, 4]);
        let mask = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let result = unpack__m256i_to_i32_array(_mm256_mask_i32gather_epi64::<1>(src, ptr_slice.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm_i32gather_pd() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1.0f64; 1];
        let offsets = create__m128i_from_i32_array([1, 2, 3, 4]);
        let result = unpack__m128d_to_f64_array(_mm_i32gather_pd::<1>(ptr_slice.as_ptr(), offsets));
        check_array_equality(&result, &[0.0f64; 2])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_i32gather_pd() -> Result<(), String> {
    unsafe {
        let src = create__m128d_from([1.0, 2.0]);
        let ptr_slice = [1.0f64; 1];
        let offsets = create__m128i_from_i32_array([1, 2, 3, 4]);
        let mask = create__m128d_from([1.0, 2.0]);
        let result = unpack__m128d_to_f64_array(_mm_mask_i32gather_pd::<1>(src, ptr_slice.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0.0f64; 2])?;
    }
    Ok(())
}

pub(super) fn test_mm256_i32gather_pd() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1.0f64; 1];
        let offsets = create__m128i_from_i32_array([1, 2, 3, 4]);
        let result = unpack__m256d_to_f64_array(_mm256_i32gather_pd::<1>(ptr_slice.as_ptr(), offsets));
        check_array_equality(&result, &[0.0f64; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm256_mask_i32gather_pd() -> Result<(), String> {
    unsafe {
        let src = create__m256d_from([1.0, 2.0, 3.0, 4.0]);
        let ptr_slice = [1.0f64; 1];
        let offsets = create__m128i_from_i32_array([1, 2, 3, 4]);
        let mask = create__m256d_from([1.0, 2.0, 3.0, 4.0]);
        let result = unpack__m256d_to_f64_array(_mm256_mask_i32gather_pd::<1>(src, ptr_slice.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0.0f64; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_i64gather_epi32() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1i32; 1];
        let offsets = create__m128i_from_i32_array([1, 2, 3, 4]);
        let result = unpack__m128i_to_i32_array(_mm_i64gather_epi32::<1>(ptr_slice.as_ptr(), offsets));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_i64gather_epi32() -> Result<(), String> {
    unsafe {
        let src = create__m128i_from_i32_array([1, 2, 3, 4]);
        let ptr_slice = [1i32; 1];
        let offsets = create__m128i_from_i32_array([1, 2, 3, 4]);
        let mask = create__m128i_from_i32_array([1, 2, 3, 4]);
        let result = unpack__m128i_to_i32_array(_mm_mask_i64gather_epi32::<1>(src, ptr_slice.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm256_i64gather_epi32() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1i32; 1];
        let offsets = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let result = unpack__m128i_to_i32_array(_mm256_i64gather_epi32::<1>(ptr_slice.as_ptr(), offsets));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm256_mask_i64gather_epi32() -> Result<(), String> {
    unsafe {
        let src = create__m128i_from_i32_array([1, 2, 3, 4]);
        let ptr_slice = [1i32; 1];
        let offsets = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let mask = create__m128i_from_i32_array([1, 2, 3, 4]);
        let result = unpack__m128i_to_i32_array(_mm256_mask_i64gather_epi32::<1>(src, ptr_slice.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_i64gather_ps() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1.0f32; 1];
        let offsets = create__m128i_from_i32_array([1, 2, 3, 4]);
        let result = unpack__m128_to_f32_array(_mm_i64gather_ps::<1>(ptr_slice.as_ptr(), offsets));
        check_array_equality(&result, &[0.0f32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_i64gather_ps() -> Result<(), String> {
    unsafe {
        let src = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        let ptr_slice = [1.0f32; 1];
        let offsets = create__m128i_from_i32_array([1, 2, 3, 4]);
        let mask = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        let result = unpack__m128_to_f32_array(_mm_mask_i64gather_ps::<1>(src, ptr_slice.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0.0f32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm256_i64gather_ps() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1.0f32; 1];
        let offsets = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let result = unpack__m128_to_f32_array(_mm256_i64gather_ps::<1>(ptr_slice.as_ptr(), offsets));
        check_array_equality(&result, &[0.0f32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm256_mask_i64gather_ps() -> Result<(), String> {
    unsafe {
        let src = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        let ptr_slice = [1.0f32; 1];
        let offsets = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let mask = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        let result = unpack__m128_to_f32_array(_mm256_mask_i64gather_ps::<1>(src, ptr_slice.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0.0f32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_i64gather_epi64() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1i64; 1];
        let offsets = create__m128i_from_i32_array([1, 2, 3, 4]);
        let result = unpack__m128i_to_i32_array(_mm_i64gather_epi64::<1>(ptr_slice.as_ptr(), offsets));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_i64gather_epi64() -> Result<(), String> {
    unsafe {
        let src = create__m128i_from_i32_array([1, 2, 3, 4]);
        let ptr_slice = [1i64; 1];
        let offsets = create__m128i_from_i32_array([1, 2, 3, 4]);
        let mask = create__m128i_from_i32_array([1, 2, 3, 4]);
        let result = unpack__m128i_to_i32_array(_mm_mask_i64gather_epi64::<1>(src, ptr_slice.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm256_i64gather_epi64() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1i64; 1];
        let offsets = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let result = unpack__m256i_to_i32_array(_mm256_i64gather_epi64::<1>(ptr_slice.as_ptr(), offsets));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm256_mask_i64gather_epi64() -> Result<(), String> {
    unsafe {
        let src = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let ptr_slice = [1i64; 1];
        let offsets = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let mask = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let result = unpack__m256i_to_i32_array(_mm256_mask_i64gather_epi64::<1>(src, ptr_slice.as_ptr(), offsets, mask));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm_i64gather_pd() -> Result<(), String> {
    unsafe {
        let ptr_slice = [1.0f64; 1];
        let offsets = create__m128i_from_i32_array([1, 2, 3, 4]);
        let result = unpack__m128d_to_f64_array(_mm_i64gather_pd::<1>(ptr_slice.as_ptr(), offsets));
        check_array_equality(&result, &[0.0f64; 2])?;
    }
    Ok(())
}
